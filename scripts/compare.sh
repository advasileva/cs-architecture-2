#!/bin/bash

max=4
for i in `seq 1 $max`
do
    echo "Test $i"
    echo "~~~ASM-program~~~"
    ./asm.exe 0 tests/test$i.in output
    echo "~~~~C-program~~~~"
    ./c.exe 0 tests/test$i.in output
    echo
done
