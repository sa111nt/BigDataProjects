#!/usr/bin/env python3
import sys

# Dane wejściowe: restaurant_id\tpayment_type\tprice\t1
# Dane wyjściowe: restaurant_id\tpayment_type\torders_count\tavg_total_price

current_key = None
current_restaurant_id = None
current_payment_type = None
total_price_sum = 0.0
orders_count = 0

for line in sys.stdin:
    line = line.strip()
    
    try:
        parts = line.split('\t')
        restaurant_id = parts[0]
        payment_type = parts[1]
        price = float(parts[2])
        count = int(parts[3])
        
        key = f"{restaurant_id}\t{payment_type}"
        
        # Ten sam klucz - akumulujemy
        if key == current_key:
            total_price_sum += price
            orders_count += count
        else:
            # Nowy klucz - wypisujemy wynik dla poprzedniego
            if current_key is not None:
                avg_total_price = total_price_sum / orders_count
                print(f"{current_restaurant_id}\t{current_payment_type}\t{orders_count}\t{avg_total_price:.2f}")
            
            # Nowa grupa
            current_key = key
            current_restaurant_id = restaurant_id
            current_payment_type = payment_type
            total_price_sum = price
            orders_count = count
            
    except Exception as e:
        continue

# Ostatnia grupa
if current_key is not None:
    avg_total_price = total_price_sum / orders_count
    print(f"{current_restaurant_id}\t{current_payment_type}\t{orders_count}\t{avg_total_price:.2f}")
