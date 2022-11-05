# Архитектура вычислительных систем ИДЗ 2

0. [**Задание**](#задание)
0. [**Отчёт**](#отчёт)
    + [*4 балла*](#4-балла)
    + [*5 баллов*](#5-баллов)
    + [*6 баллов*](#6-баллов)
    + [*7 баллов*](#7-баллов)
    + [*8 баллов*](#8-баллов)
    + [*9 баллов*](#9-баллов)
0. [**Дерево проекта**](#дерево-проекта)
0. [**Инструкции по запуску**](#инструкции-по-запуску)

## Задание

*ASCII-строка — строка, содержащая символы таблицы кодировки ASCII. (https://ru.wikipedia.org/wiki/ASCII). Размер строки может быть достаточно большим, чтобы вмещать многостраничные тексты, например, главы из книг, если задача связана с использованием файлов или строк, порождаемых генератором случайных чисел. Тексты при этом могут не нести смыслового содержания. Для обработки в программе предлагается использовать данные, содержащие символы только из первой половины таблицы (коды в диапазоне 0–127), что связано с использованием кодировки UTF-8 в ОС Linux в качестве основной. Символы, содержащие коды выше 127, должны отсутствовать во входных данных кроме оговоренных специально случаев.*

*Вариант 2. Разработать программу, находящую в заданной ASCII–строке первую при обходе от конца к началу последовательность N символов, каждый элемент которой определяется по условию «больше предшествующего» (N вводится в качестве параметра)*

Задача эквивалентна поиску последней убывающей последовательности из N символов

## Отчёт

**Делала на оценку 9 баллов**

Для удобства проверки структурировала отчёт по критериям

### 4 балла

+ *Приведено решение задачи на C.*

    Код на C находится в `main.c` и `find.c`

    Скомпилированная программа на C находится в `c.exe`

+ *В полученную ассемблерную программу, откомпилированную без оптимизирующих и отладочных опций, добавлены комментарии, поясняющие эквивалентное представление переменных в программе на C.*

    Полностью прокомментированная ассемблерная программа находится в `main.s` и `find.s`

    Скомпилированная ассемблерная программа находится в `asm.exe`

    Пример комментария, поясняющего эквивалентное представление переменных:
    ```
	mov	r15d, edi					# записываем в регистр: n (int - 4 byte)
	mov	r13, rsi					# записываем в регистр: A (int* - 8 byte)
	mov	r14, rdx					# записываем в регистр: B (int* - 8 byte)
	mov	r12d, 0						# записываем в регистр: i = 0 (int - 4 byte)
    ```

+ *Из ассемблерной программы убраны лишние макросы за счет использования соответствующих аргументов командной строки и/или за счет ручного редактирования исходного текста ассемблерной программы.*

    Ассемблерная программа сразу после получения ассемблера находится в `stages/main.bare.s` и `stages/find.bare.s`

    Использованы соответствующие аргументы командной строки, которые указаны в `scripts/make-asm.sh`

    За счёт ручного редактирования ассемблерной программы размер `main.s` сократился с 243 строк до 204

    Примеры удалённого из `main.s`:
    ```
    .file	"main.c"
    ```
    ```
	.type	main, @function
    ```
    ```
	cdqe                            # знаковое расширение, входило 5 раз
    ```
    ```
    mov	QWORD PTR -8[rbp], rax      # и много подобных конструкций
	mov	rax, QWORD PTR -8[rbp]
    ```
    ```
    .size	timeDelta, .-timeDelta
    ```
    ```
	mov	rdi, r9
    ```
    ```
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits
    ```

    Примеры удалённого из `find.s`:
    ```
    .file	"find.c"
    ```
    ```
	.type	find, @function
    ```
    ```
	cdqe                            # знаковое расширение, входило 6 раз
    ```
    ```
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits
    ```

    Примеры оптимизации в `main.s`

    +   Было:
        ```
        mov	rax, QWORD PTR [rax]
        mov	rdi, rax
        ```
        Стало:
        ```
        mov	rdi, QWORD PTR [rax]
        ```

    +   Было:
        ```
        mov	r8, rdi
        mov	rsi, r8
        ```
        Стало:
        ```
        mov	rsi, rdi
        ```
    +   Было:
        ```
        mov	rax, QWORD PTR -80[rbp]
        mov	rdx, QWORD PTR -72[rbp]
        mov	rdi, QWORD PTR -96[rbp]
        mov	rsi, QWORD PTR -88[rbp]
        mov	rcx, rdx
        mov	rdx, rax
        ```
        Стало:
        ```
        mov	rdx, QWORD PTR -80[rbp]		# получаем start.tv_sec со стека
        mov	rcx, QWORD PTR -72[rbp]		# получаем start.tv_nsec со стека
        mov	rdi, QWORD PTR -96[rbp]		# получаем finish.tv_sec со стека
        mov	rsi, QWORD PTR -88[rbp]		# получаем finish.tv_nsec со стека
        ```

+ *Модифицированная ассемблерная программа отдельно откомпилирована и скомпонована без использования опций отладки.*

    Скомпилированная ассемблерная программа находится в `asm.exe`

+ *Представлено полное тестовое покрытие, дающее одинаковый результат на обоих программах. Приведены результаты тестовых прогонов для обоих программ, демонстрирующие эквивалентность функционирования.*

    Тесты находятся в `tests/`. Их 4, размеры соответственно 5, 10, 1000 и 2000 чисел в массиве. Последние два теста сгенерированы моей же программой на ассемблере с помощью генератора рандомных чисел

    Результаты прогонов (в скрипте есть печать diff, поэтому результаты работы программ на С и на ассемблере идентичны и совпадают с эталонным ответом)
    ```
    $ make test
    echo "Test ASM"
    Test ASM
    make test.asm
    bash ./scripts/test-asm.sh
    Test 1
    Time delta: 30573650 ns


    Test 2
    Time delta: 65420753 ns


    Test 3
    Time delta: 6087599994 ns


    Test 4
    Time delta: 10279693573 ns


    echo "Test C"
    Test C
    make test.c
    bash ./scripts/test-c.sh
    Test 1
    Time delta: 58242082 ns


    Test 2
    Time delta: 89953778 ns


    Test 3
    Time delta: 6184423906 ns


    Test 4
    Time delta: 14661388234 ns
    ```

+ *Сформировать отчет, описывающий результаты тестовых прогонов и используемых опций компиляции и/или описания проведенных модификаций.*

    Отчёт сформирован

### 5 баллов

+ *В реализованной программе использовать функции с передачей данных через параметры.*

    Функция `find(int n, int *A, int *B)` использует передачу данных через параметры, в ассемблерной программе эта функция работает аналогично

+ *Использовать локальные переменные.*

    Пример использования локальной переменной в `main.c`:
    ```
    int count = 1000000;
    ```
    и её же в `main.s`:
    ```
    mov	DWORD PTR -28[rbp], 1000000	# кладём на стек: count = 10000 (int - 4 byte)
    ```

+ *В ассемблерную программу при вызове функции добавить комментарии, описывающие передачу фактических параметров и перенос возвращаемого результата.*

    Полностью прокомментированная ассемблерная программа находится в `main.s` и `find.s`

    Пример комментария, описывающего передачу фактических параметров:
    ```
    mov	edi, DWORD PTR -60[rbp]		# получаем n со стека
	mov	rdx, QWORD PTR -48[rbp]		# получаем B со стека
	mov	rsi, QWORD PTR -40[rbp]		# получаем A со стека
	call	find@PLT			# вызов find()
    ```
    Пример комментария, описывающего перенос возвращаемого результата:
    ```
	call	fopen@PLT               # вызываем fopen()
	mov	QWORD PTR -24[rbp], rax     # output = fopen(argv[3], "w");
    ```

+ *В функциях для формальных параметров добавить комментарии, описывающие связь между параметрами языка Си и регистрами (стеком).*

    Полностью прокомментированная ассемблерная программа находится в `main.s` и `find.s`

    Пример комментария, описывающего связь между параметрами языка Си и регистрами (стеком):
    ```
    mov	rdx, QWORD PTR -80[rbp]		# получаем start.tv_sec со стека
	mov	rcx, QWORD PTR -72[rbp]		# получаем start.tv_nsec со стека
	mov	rdi, QWORD PTR -96[rbp]		# получаем finish.tv_sec со стека
	mov	rsi, QWORD PTR -88[rbp]		# получаем finish.tv_nsec со стека
    ```

+ *Информацию о проведенных изменениях отобразить в отчете.*

    Информация добавлена в отчёт

### 6 баллов

+ *Рефакторинг программы на ассемблере за счет оптимизации использования регистров процессора. Или написание ассемблерной программы с нуля, используя собственное распределение регистров.*

    Так как в основной программе многократно вызывает функция `find`, то использование регистров процессора было сделано в ней, а именно были произведены следующие замены:
    ```
    rbp[-4]  -> r12d
    rbp[-32] -> r13
    rbp[-40] -> r14
    rbp[-20] -> r15d
    ```
    В результате вместо
    ```
    mov	DWORD PTR -20[rbp], edi
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -40[rbp], rdx
	mov	DWORD PTR -4[rbp], 0
    ```
    получили
    ```
    mov	r15d, edi					# записываем в регистр: n (int - 4 byte)
	mov	r13, rsi					# записываем в регистр: A (int* - 8 byte)
	mov	r14, rdx					# записываем в регистр: B (int* - 8 byte)
	mov	r12d, 0						# записываем в регистр: i = 0 (int - 4 byte)
    ```

    Программа после рефакторинга находится в `main.s` и `find.s`

    Исходная ассемблерная программа находится в `stages/main.bare.s` и `stages/find.bare.s`

+ *Добавление комментариев в разработанную программу, поясняющих эквивалентное использование регистров вместо переменных исходной программы на C.*

    Полностью прокомментированная ассемблерная программа находится в `main.s` и `find.s`

    Пример комментария, описывающего эквивалентное использование регистров вместо переменных исходной программы на C:
    ```
    mov	r15d, edi					# записываем в регистр: n (int - 4 byte)
	mov	r13, rsi					# записываем в регистр: A (int* - 8 byte)
	mov	r14, rdx					# записываем в регистр: B (int* - 8 byte)
	mov	r12d, 0						# записываем в регистр: i = 0 (int - 4 byte)
    ```

+ *Представление результатов тестовых прогонов для разработанной программы. Оценка корректности ее выполнения на основе сравнения тестовых прогонов результатами тестирования программы, разработанной на языке C.*

    Результат тестового прогона (diff ничего не вывел - всё хорошо):
    ```
    $ make test.asm
    bash ./scripts/test-asm.sh
    Test 1
    Time delta: 26114418 ns


    Test 2
    Time delta: 72934853 ns


    Test 3
    Time delta: 3852277533 ns


    Test 4
    Time delta: 9534220042 ns
    ```

+ *Сопоставление размеров программы на ассемблере, полученной после компиляции с языка C с модифицированной программой, использующей регистры.*

    TBA

+ *Добавление информации о проведенных изменениях в отчет.*

    Информация добавлена в отчёт

### 7 баллов

+ *Реализация программы на ассемблере в виде двух или более единиц компиляции (программу на языке C разделять допускается, но не обязательно)*

    Использованы две единицы компиляции:
    + `main.s`
    + `find.s`

+ *Использование файлов с исходными данными и файлов для вывода результатов. Имена файлов задаются с использованием аргументов командной строки. Командная строка проверяется на корректность числа аргументов и корректное открытие файлов.*

    Использованы аргументы командной строки для задания входного и выходного файлов:
    ```
    input = fopen(argv[2], "r");
    output = fopen(argv[3], "w");
    fscanf(input, "%d", &n);
    ```

+ *Подготовка нескольких файлов, обеспечивающих тестовое покрытие разработанной программы.*

    Информация добавлена в отчёт

+ *Добавление в отчет информации о проведенном функциональном расширении, формате входных файлов, формате командной строки и результатах работы с тестовыми файлами.*

    Информация добавлена в отчёт

### 8 баллов

+ *Использование в разрабатываемых программах генератора случайных наборов данных, расширяющих возможности тестирования.*

    Вариант ввода данных выбирается с помощью первого аргумента командной строки:
    + `0` - ввод из указанного во втором аргументе файла, вывод в указанный третьим аргументом файл
    + `1` - ввод с помощью генератора, количество чисел в массиве задаётся вторым аргументом, сгенерированный массив А выводится в `input`, сформированный массив В выводится в `output`
 
    Получение размера массива:
    ```
    if (atoi(argv[1]) == 0) {
        input = fopen(argv[2], "r");
        output = fopen(argv[3], "w");
        fscanf(input, "%d", &n);
    } else {
        input = fopen("input", "w");
        output = fopen("output", "w");
        n = atoi(argv[2]);
    }
    ```

    Ввод массива А:
    ```
    if (atoi(argv[1]) == 0) {
        for(i = 0; i < n; i++) {
            fscanf(input, "%d", &A[i]);
        }
    } else {
        for(i = 0; i < n; i++) {
            A[i] = rand() % 200 - 100;
            fprintf(input, "%d ", A[i]);
    }
    ```

+ *Изменение формата командной строки с учетом выбора ввода из файлов или с использованием генератора.*

    Описано в предыдущем пункте

+ *Включение в программы функций, обеспечивающих замеры времени для проведения сравнения на производительность. Необходимо добавить замеры во времени, которые не учитывают время ввода и вывода данных. Для увеличения времени работы минимум до 1 секунды, в зависимости от особенностей программы, можно либо выбирать соответствующие размеры исходных данных, либо зацикливать для многократного выполнения ту часть программы, которая выполняет вычисления. В последнем случае можно использовать соответствующую опцию командной строки, задающей количество повторений.*

    Замер времени выполнения без ввода-вывода:
    ```
    clock_gettime(CLOCK_MONOTONIC, &start);

    for(i = 0; i < COUNT; i++) {
        find(n, A, B);
    }

    clock_gettime(CLOCK_MONOTONIC, &finish);

    time_delta = timeDelta(finish, start);
    printf("Time delta: %ld ns\n", time_delta);
    ```

    Вычисления программы выполняются `count = 1000000` раз

    Результат тестового прогона со сравнением работы программы на C и ассемблерной программы
    ```
    $ make compare
    bash ./scripts/compare.sh
    Test 1
    ~~~ASM-program~~~
    Time delta: 27926987 ns
    ~~~~C-program~~~~
    Time delta: 26356725 ns

    Test 2
    ~~~ASM-program~~~
    Time delta: 61166692 ns
    ~~~~C-program~~~~
    Time delta: 57593824 ns

    Test 3
    ~~~ASM-program~~~
    Time delta: 4857051526 ns
    ~~~~C-program~~~~
    Time delta: 5896887238 ns

    Test 4
    ~~~ASM-program~~~
    Time delta: 9537902233 ns
    ~~~~C-program~~~~
    Time delta: 11996438916 ns
    ```
    Видим, что ассемблерная программа работает быстрее на больших входных данных (массив А 1000-2000 элементов)

+ *Представить полученные временные данные в отчете для разных вариантов тестовых прогонов (наряду с другими данными, полученные при выполнении ранее описанных требований).*

    Информация добавлена в отчёт


### 9 баллов

+ *Используя опции оптимизации по скорости, сформировать из модифицированной программы на C исходный код ассемблере. Провести сравнительный анализ с предыдущими ассемблерными программами по размеру ассемблерного кода, размеру исполняемого файла и производительности. Сопоставить эти программы с собственной программой, разработанной на ассемблере, в которой вместо переменных максимально возможно используются регистры.*

    Для оптимизации по скорости использовались флаги `-O0` `-O1` `-O2` `-O3` `-Ofast`, также для сравнения представлены программа, скомпилированная без флагов оптимизации и опитимизированная мной программа (последняя версия с комментариями)

    Скрипт для формирования программ с использованием опций оптимизации находится в `scripts/optimize.sh`

    Результат сравнительного анализа:
    ```
    $ make compare.opt
    bash ./scripts/compare-opt.sh
    ~~~Test non-optimization~~~
    Number of lines: 350
    Size in bytes: 6118
    Time delta: 17538259543 ns

    ~~~Test o0-optimization~~~
    Number of lines: 350
    Size in bytes: 6118
    Time delta: 16984224436 ns

    ~~~Test o1-optimization~~~
    Number of lines: 251
    Size in bytes: 4285
    Time delta: 2960131342 ns

    ~~~Test o2-optimization~~~
    Number of lines: 268
    Size in bytes: 4638
    Time delta: 2640930718 ns

    ~~~Test o3-optimization~~~
    Number of lines: 379
    Size in bytes: 6382
    Time delta: 1562916418 ns

    ~~~Test ofast-optimization~~~
    Number of lines: 379
    Size in bytes: 6382
    Time delta: 1507756943 ns

    ~~~Test os-optimization~~~
    Number of lines: 234
    Size in bytes: 3999
    Time delta: 14576964971 ns

    ~~~Test my-optimization~~~
    Number of lines: 267
    Size in bytes: 18120
    Time delta: 8290021364 ns
    ```

    Вывод: моя программа работает быстрее, чем программы без оптимизации и с флагами `-00`, `-Os`

+ *Аналогично, используя опции оптимизации по размеру, сформировать код на ассемблере. Провести сравнительный анализ с неоптимизированной программой по размеру ассемблерного кода, размеру исполняемого файла и производительности. Сопоставить эти программы с собственной программой, разработанной на ассемблере, в которой вместо переменных максимально возможно используются регистры.*

    Для оптимизации по размеру использовалась опция `-0s`, полный отчёт представлен в предыдущем пункте

    Вывод: моя программа уступает всем по размеру файла, но короче по количеству строк всех, кроме программ с `-O1` и `-Os` опциями

+ *Представить в отчете полученные результаты, дополнив данные, представленные в предыдущем по предыдующим требованиям.*

    Результаты представлены в отчёте

## Дерево проекта

```
TBA
```

## Инструкции по запуску

Чтобы не заниматься копированием команд из блокнота в консоль, написала Makefile

Тестирование (работает долго, потому что прогоняется на больших тестах):
+ обеих программ:
    ```
    make test
    ```
+ ассемблерной прогрммы:
    ```
    make test.asm
    ```
+ программы на С:
    ```
    make test.c
    ```  

Компиляция (программы уже скомпилированы):
+ обеих программ:
    ```
    make compile
    ```
+ ассемблерной прогрммы:
    ```
    make compile.asm
    ```
+ программы на С:
    ```
    make compile.c
    ```  

Cравнение скорости работы программ на С и на ассемблере
```
make compare
``` 

Запуск с помощью генератора (не имеет смысла запускать обе, потому что они используют одни и те же файлы):
+ ассемблерной прогрммы:
    ```
    make rand.asm n=100
    ```
+ программы на С:
    ```
    make rand.c n=100
    ```  

Получение программ с помощью разных опций оптимизации (в директории `optimization/`):
```
make optimize
```

Сравнение программ с различными опциями оптимизации (работает долго, потому что прогоняется на больших тестах):
```
make compare.opt
```
