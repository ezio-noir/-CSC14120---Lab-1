#!/bin/bash

exec="./P1"
if ! [[ -f "$exec" && -x "$exec" ]]; then
    echo "File $exec does not exist, or is not executable."
    exit 1
fi

input_file="in.pnm"
if ! [[ -f "$input_file" ]]; then
    echo "Input image file $input_file does not exist."
    exit 1
fi

sizes=(
    "16,16"
    "32,32"
    "64,64"
)

for size in "${sizes[@]}"; do
    IFS=',' read -r size_x size_y <<< "$size"
    echo -e "\n\n>>>> Running on block size $size_x x $size_y <<<<"
    output=$("$exec" "$input_file" output.pnm "$size_x" "$size_y")
    exit_val=$?
    printf "%s\n" "$output"
    if [[ $exit_val -eq 0 ]]; then
        echo ">>>> SUCCESS"
    else
        echo ">>>> FAIL"
    fi
done