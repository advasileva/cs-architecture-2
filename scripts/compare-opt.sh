#!/bin/bash

declare -a arr=("non" "o0" "o1" "o2" "o3" "ofast" "os" "my")

for i in "${arr[@]}"
do
    echo "~~~Test $i-optimization~~~"
    main_lines=$(wc -l < optimization/main_$i.s)
    form_array_lines=$(wc -l < optimization/form_array_$i.s)
    sum_lines=$(expr $main_lines + $form_array_lines)
    echo "Number of lines: $sum_lines"
    main_size=$(stat --printf="%s\n" optimization/main_$i.s)
    form_array_size=$(stat --printf="%s\n" optimization/form_array_$i.s)
    sum_size=$(expr $main_size + $form_array_size)
    echo "Size in bytes: $sum_size"
    ./optimization/$i.exe 0 tests/test4.in output
    echo
done
