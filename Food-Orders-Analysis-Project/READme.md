## Project Overview

This project analyzes food order data from restaurants using MapReduce and Hive with Apache Airflow orchestration. The goal is to generate insights about order statistics by payment type, country, and cuisine.

## Data Sources

- Orders dataset (order_id, restaurant_id, order date, number of items, total price, payment type, status)
- Restaurants dataset (restaurant_id, name, city, country, type of cuisine)

## Methodology

- MapReduce processes the orders dataset to calculate the number of orders and average order value grouped by restaurant and payment type.  
- Hive queries join MapReduce results with restaurant data to produce aggregated order statistics by country and cuisine, including cuisine ranking within countries.

## Objective

To provide actionable insights into customer ordering behavior, payment preferences, and popular cuisines across different regions for business analytics and decision-making.
