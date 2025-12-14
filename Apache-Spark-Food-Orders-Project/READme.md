# Apache Spark Food Orders Analysis

## Overview
Big data analysis of restaurant orders using Apache Spark (RDD + DataFrame APIs) and Delta Lake.

## Data
Data files are stored in [Food-Orders-Analysis-Project](https://github.com/sa111nt/Food-Orders-Analysis-Project):
- Orders: 100 CSV files (~1M records)
- Restaurants: 200 restaurants

## Implementation

### Part 1: RDD API
- Filter completed orders
- Group by restaurant + payment type
- Calculate order count and average price
- Save to HDFS in Pickle format (`/tmp/output1`)

### Part 2: DataFrame API
- Join orders with restaurants
- Aggregate by country + cuisine
- Rank cuisines within each country
- Save to Delta Lake (`/tmp/delta/output2`)

## Technology
- Apache Spark 3.5.3 (PySpark)
- Delta Lake 3.3.0
- YARN cluster on Google Cloud Dataproc

## Results
- Stage 1: 600 groups (restaurant, payment_type)
- Stage 2: 194 combinations (country, cuisine) with rankings
