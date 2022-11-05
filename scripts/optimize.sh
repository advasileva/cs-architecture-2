#!/bin/bash


gcc main.c -S -o optimization/main_non.s
gcc form_array.c -S -o optimization/form_array_non.s
gcc ./optimization/main_non.s ./optimization/form_array_non.s -o ./optimization/non.exe

gcc -O0 main.c -S -o optimization/main_o0.s
gcc -O0 form_array.c -S -o optimization/form_array_o0.s
gcc ./optimization/main_o0.s ./optimization/form_array_o0.s -o ./optimization/o0.exe

gcc -O1 main.c -S -o optimization/main_o1.s
gcc -O1 form_array.c -S -o optimization/form_array_o1.s
gcc ./optimization/main_o1.s ./optimization/form_array_o1.s -o ./optimization/o1.exe

gcc -O2 main.c -S -o optimization/main_o2.s
gcc -O2 form_array.c -S -o optimization/form_array_o2.s
gcc ./optimization/main_o2.s ./optimization/form_array_o2.s -o ./optimization/o2.exe

gcc -O3 main.c -S -o optimization/main_o3.s
gcc -O3 form_array.c -S -o optimization/form_array_o3.s
gcc ./optimization/main_o3.s ./optimization/form_array_o3.s -o ./optimization/o3.exe

gcc -Ofast main.c -S -o optimization/main_ofast.s
gcc -Ofast form_array.c -S -o optimization/form_array_ofast.s
gcc ./optimization/main_ofast.s ./optimization/form_array_ofast.s -o ./optimization/ofast.exe

gcc -Os main.c -S -o optimization/main_os.s
gcc -Os form_array.c -S -o optimization/form_array_os.s
gcc ./optimization/main_os.s ./optimization/form_array_os.s -o ./optimization/os.exe