#!/usr/bin/env python3
import sys
import csv

# Dane wejściowe: order_id,restaurant_id,order_date,items_count,total_price_usd,payment_type,status
# Dane wyjściowe: restaurant_id\tpayment_type\ttotal_price_usd\t1

for line in sys.stdin:
    line = line.strip()
    
    if line.startswith('order_id'):
        continue
    
    try:
        reader = csv.reader([line])
        row = next(reader)
        
        # row[0] = order_id
        # row[1] = restaurant_id
        # row[2] = order_date
        # row[3] = items_count
        # row[4] = total_price_usd
        # row[5] = payment_type
        # row[6] = status
        
        restaurant_id = row[1]
        total_price_usd = row[4]
        payment_type = row[5]
        
        # Klucz: restaurant_id + payment_type
        # Wartość: total_price_usd + licznik (1)
        print(f"{restaurant_id}\t{payment_type}\t{total_price_usd}\t1")
        
    except Exception as e:
        continue
