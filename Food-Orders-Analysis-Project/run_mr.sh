#!/bin/bash

# Parametry: input_dir output_dir

INPUT_DIR=$1
OUTPUT_DIR=$2

if [ -z "$INPUT_DIR" ] || [ -z "$OUTPUT_DIR" ]; then
    echo "Użycie: $0 <input_dir> <output_dir>"
    exit 1
fi

# Usuwamy katalog output, jeśli istnieje
echo "Czyszczenie katalogu output"
hadoop fs -rm -r -f $OUTPUT_DIR

# Uruchamiamy Hadoop Streaming
echo "Uruchamianie zadania MapReduce"
mapred streaming \
  -files mapper.py,reducer.py \
  -input $INPUT_DIR/datasource1 \
  -output $OUTPUT_DIR \
  -mapper mapper.py \
  -reducer reducer.py

# Sprawdzanie wyniku
if [ $? -eq 0 ]; then
    echo "Zadanie MapReduce zakończone pomyślnie"
    echo "Lokalizacja wyniku: $OUTPUT_DIR"
else
    echo "Zadanie MapReduce nie powiodło się"
    exit 1
fi
