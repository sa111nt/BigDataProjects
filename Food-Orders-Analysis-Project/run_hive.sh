#!/bin/bash

# Parametry: input_dir3 input_dir4 output_dir6

INPUT_DIR3=$1
INPUT_DIR4=$2
OUTPUT_DIR6=$3

if [ -z "$INPUT_DIR3" ] || [ -z "$INPUT_DIR4" ] || [ -z "$OUTPUT_DIR6" ]; then
    echo "Użycie: $0 <input_dir3> <input_dir4> <output_dir6>"
    exit 1
fi

# Usuwamy katalog output, jeśli istnieje
echo "Czyszczenie katalogu output"
hadoop fs -rm -r -f $OUTPUT_DIR6

# Uruchamiamy Hive
echo "Uruchamianie zadania Hive"
beeline -u jdbc:hive2://localhost:10000/default \
  --hiveconf INPUT_DIR3=$INPUT_DIR3 \
  --hiveconf INPUT_DIR4=$INPUT_DIR4 \
  --hiveconf OUTPUT_DIR6=$OUTPUT_DIR6 \
  -f hive.hql

# Sprawdzanie wyniku
if [ $? -eq 0 ]; then
    echo "Zadanie Hive zakończone pomyślnie"
    echo "Lokalizacja wyniku: $OUTPUT_DIR6"
else
    echo "Zadanie Hive nie powiodło się"
    exit 1
fi
