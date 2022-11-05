#!/bin/bash

max=4
count=100000
for i in `seq 1 $max`
do
    echo "Test $i"
    echo "~~~ASM-program~~~"
    ./asm.exe $count 4 0 tests/test$i.in output
    echo "~~~~C-program~~~~"
    ./c.exe $count 4 0 tests/test$i.in output
    echo
done
