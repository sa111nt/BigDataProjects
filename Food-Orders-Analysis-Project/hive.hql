-- Dane wejściowe: wynik MapReduce + restaurants.csv
-- Dane wyjściowe: JSON z country, cuisine, total_orders, avg_total_price, rank_in_country

-- Usuwamy stare tabele jeśli istnieją
DROP TABLE IF EXISTS orders_stats;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS result_json;

-- Tworzymy EXTERNAL tabelę dla wyniku MapReduce
CREATE EXTERNAL TABLE orders_stats(
  restaurant_id STRING,
  payment_type STRING,
  orders_count INT,
  avg_total_price DOUBLE
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '\t'
LOCATION '${hiveconf:INPUT_DIR3}';

-- Tworzymy EXTERNAL tabelę dla restaurants
CREATE EXTERNAL TABLE restaurants(
  restaurant_id STRING,
  name STRING,
  city STRING,
  country STRING,
  cuisine STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = "\""
)
LOCATION '${hiveconf:INPUT_DIR4}'
TBLPROPERTIES ("skip.header.line.count"="1");

-- Tworzymy managed tabelę dla wyniku w formacie JSON
CREATE TABLE result_json(
  country STRING,
  cuisine STRING,
  total_orders INT,
  avg_total_price DOUBLE,
  rank_in_country INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.JsonSerDe'
STORED AS TEXTFILE
LOCATION '${hiveconf:OUTPUT_DIR6}';

-- Wstawiamy wynik z JOIN, agregacją i rankingiem
INSERT OVERWRITE TABLE result_json
SELECT 
  country,
  cuisine,
  total_orders,
  avg_total_price,
  rank_in_country
FROM (
  SELECT 
    r.country,
    r.cuisine,
    SUM(o.orders_count) AS total_orders,
    AVG(o.avg_total_price) AS avg_total_price,
    RANK() OVER (PARTITION BY r.country ORDER BY SUM(o.orders_count) DESC) AS rank_in_country
  FROM orders_stats o
  JOIN restaurants r ON o.restaurant_id = r.restaurant_id
  GROUP BY r.country, r.cuisine
) ranked_data
ORDER BY country, rank_in_country;