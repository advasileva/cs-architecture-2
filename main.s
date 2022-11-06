	.intel_syntax noprefix			# указание интеловского синтаксиса
	.text							# начало секции
	.globl	timeDelta				# метка глобальности для линкера
timeDelta:							# метка функции "timeDelta"
	push	rbp						# (пролог) сохраняем rbp на стек
	mov	rbp, rsp					# записываем rsp в rbp
	mov	rax, rsi					# меняем регистры, чтобы положить переменные на стек
	mov	rsi, rdi					# входными параметрами функции являются структуры из 2 полей,
	mov	rdi, rax					# поэтому нам нужно 2*2=4 ячейки по 8 байт
	mov	QWORD PTR -32[rbp], rsi		# кладём на стек: finish.tv_sec
	mov	QWORD PTR -24[rbp], rdi		# кладём на стек: finish.tv_nsec
	mov	QWORD PTR -48[rbp], rdx		# кладём на стек: start.tv_sec
	mov	QWORD PTR -40[rbp], rcx		# кладём на стек: start.tv_nsec
	mov	rax, QWORD PTR -48[rbp]		# rax = start.tv_sec
	imul	rax, rax, 1000000000	# nsecStart *= 1000000000;
	mov	QWORD PTR -8[rbp], rax		# rbp[-8] = nsecStart
	mov	rax, QWORD PTR -40[rbp]		# rax = start.tv_nsec
	add	QWORD PTR -8[rbp], rax		# nsecStart += start.tv_nsec;
	mov	rax, QWORD PTR -32[rbp]		# rax = finish.tv_sec
	imul	rax, rax, 1000000000	# nsecFinish *= 1000000000;
	mov	QWORD PTR -16[rbp], rax		# rbp[-16] = nsecFinish
	mov	rax, QWORD PTR -24[rbp]		# rax = finish.tv_nsec
	add	QWORD PTR -16[rbp], rax		# nsecFinish += finish.tv_nsec
	mov	rax, QWORD PTR -16[rbp]		# rax = nsecFinish
	sub	rax, QWORD PTR -8[rbp]		# nsecFinish - nsecStart;
	pop	rbp							# (эпилог)
	ret								# выход из функции
	.section	.rodata				# .rodata
.LC0:								# метка ".LC0"
	.string	"Incorrect input"		# строковая константа для сообщения об ошибке
.LC1:								# метка ".LC1"
	.string	"r"						# строковая константа для флага открытия файла на чтение
.LC2:								# метка ".LC2"
	.string	"w"						# строковая константа для флага открытия файла на запись
.LC3:								# метка ".LC3"
	.string	"input"					# строковая константа для названия дефолтного входного файла
.LC4:								# метка ".LC4"
	.string	"output"				# строковая константа для названия дефолтного выходного файла
.LC5:								# метка ".LC5"
	.string	"Time delta: %ld ns\n"	# строковая константа для формата вывода результата замера времени
	.text							# начало секции
	.globl	main					# секция с кодом
main:								# метка функции "main"
	push	rbp						# (пролог) сохраняем rbp на стек
	mov	rbp, rsp					# записываем rsp в rbp
	sub	rsp, 136					# сдвигаем rsp на 8 байт
	mov	DWORD PTR -132[rbp], edi	# кладём на стек: rdi - argc (4 byte)
	mov	QWORD PTR -144[rbp], rsi	# кладём на стек: rsi - argv (8 byte)
	mov	DWORD PTR -44[rbp], 1000000	# кладём на стек: max = 10000 (int - 4 byte)
	mov	eax, DWORD PTR -44[rbp]		# получаем значение max
	add	eax, 1						# прибавляем 1
	movsx	rdx, eax				# записываем значение в rdx
	mov	ecx, 16						# /
	mov	edx, 0						# начало
	div	rcx							# резервирования
	imul	rax, rax, 16			# памяти
	mov	rcx, rax					# для
	and	rcx, -4096					# строки
	mov	rdx, rsp					# str
	sub	rdx, rcx					# \
.L4:								# метка ".L4" - продолжение резервирования памяти для строки
	cmp	rsp, rdx					# сравниваем rsp и rdx
	je	.L6							# переходим к .L4
	sub	rsp, 4096					# продолжаем резервирование
	jmp	.L4							# переходим к .L4
.L6:								# метка ".L6" - продолжение программы
	mov	QWORD PTR -64[rbp], rsp		# кладём на стек: указатель на str[max + 1] (8 byte)
	cmp	DWORD PTR -132[rbp], 3		# проверяем, что argc < 4
	jg	.L7							# продолжаем работу
	lea	rdi, .LC0[rip]				# загружаем строку "Incorrect input"
	call	puts@PLT				# вывод строки
	mov	eax, 0						# обнуляем eax
	jmp	.L8							# переходим к выходу из программы
.L7:								# метка ".L7" - начало ввода строки из файла
	mov	rax, QWORD PTR -144[rbp]	# получаем указатель на argv в памяти
	add	rax, 8						# переходим к argv[1]
	mov	rdi, QWORD PTR [rax]		# помещаем значение argv[1] в rdi
	call	atoi@PLT				# вызываем atoi()
	mov	DWORD PTR -68[rbp], eax		# помещаем результат приведения argv[1] к int в count
	mov	rax, QWORD PTR -144[rbp]	# получаем указатель на argv в памяти
	add	rax, 16						# переходим к argv[2]
	mov	rdi, QWORD PTR [rax]		# помещаем значение argv[2] в rdi
	call	atoi@PLT				# вызываем atoi()
	mov	DWORD PTR -72[rbp], eax		# помещаем результат приведения argv[2] к int в n
	mov	rax, QWORD PTR -144[rbp]	# получаем указатель на argv в памяти
	add	rax, 24						# переходим к argv[3]
	mov	rdi, QWORD PTR [rax]		# помещаем значение argv[3] в rdi
	call	atoi@PLT				# вызываем atoi()
	test	eax, eax				# хитро проверяем, что после приведения к int у нас получился 0
	jne	.L9							# если не 0, то переходим к вводу с помощью генератора (else-ветка)
	cmp	DWORD PTR -132[rbp], 4		# проверяем, что argc < 5
	jle	.L10						# переходим к выводу ошибки
	mov	rax, QWORD PTR -144[rbp]	# получаем указатель на argv в памяти
	add	rax, 32						# переходим к argv[4]
	mov	rdi, QWORD PTR [rax]		# помещаем значение argv[4] в rdi
	mov	esi, 0						# обнуляем esi
	call	access@PLT				# вызываем access()
	test	eax, eax				# хитро проверяем, что после приведения к int у нас получился 0
	je	.L11						# продолжаем работу
.L10:								# метка ".L10" - вывод ошибки
	lea	rdi, .LC0[rip]				# загружаем строку "Incorrect input"
	call	puts@PLT				# вывод строки
	mov	eax, 0						# обнуляем eax
	jmp	.L8							# переходим к выходу из программы
.L11:								# метка ".L11" - продолжение ввода строки из файла
	mov	rax, QWORD PTR -144[rbp]	# получаем указатель на argv в памяти
	add	rax, 32						# переходим к argv[4]
	mov	rdi, QWORD PTR [rax]		# помещаем значение argv[4] в rdi
	lea	rsi, .LC1[rip]				# загружаем строку "r"
	call	fopen@PLT				# вызываем fopen()
	mov	QWORD PTR -80[rbp], rax		# input = fopen(argv[4], "r");
	mov	rax, QWORD PTR -144[rbp]	# получаем указатель на argv в памяти
	add	rax, 40						# переходим к argv[5]
	mov	rdi, QWORD PTR [rax]		# помещаем значение argv[5] в rdi
	lea	rsi, .LC2[rip]				# загружаем строку "w"
	call	fopen@PLT				# вызываем fopen()
	mov	QWORD PTR -40[rbp], rax		# output = fopen(argv[5], "w");
	mov	DWORD PTR -28[rbp], 0		# size = 0;
.L13:								# метка ".L13" - проверка на размер вводимой строки
	mov	eax, DWORD PTR -28[rbp]		# получаем size со стека
	cmp	eax, DWORD PTR -44[rbp]		# получаем max со стека и проверяем, что size > max
	jle	.L12						# продолжаем работу
	lea	rdi, .LC0[rip]				# загружаем строку "Incorrect input"
	call	puts@PLT				# вывод строки
	mov	eax, 0						# обнуляем eax
	jmp	.L8							# переходим к выходу из программы
.L12:								# метка ".L12" - посимвольный ввод строки
	mov	rdi, QWORD PTR -80[rbp]		# получаем input со стека
	call	fgetc@PLT				# вызываем fgetc()
	mov	BYTE PTR -81[rbp], al		# помещаем результат в ch
	mov	eax, DWORD PTR -28[rbp]		# загружаем size
	lea	edx, 1[rax]					# инкрементируем size
	mov	DWORD PTR -28[rbp], edx		# записываем результат size++
	mov	rdx, QWORD PTR -64[rbp]		# получаем указатель на str со стека
	movzx	ecx, BYTE PTR -81[rbp]	# получаем ch со стека
	mov	BYTE PTR [rdx+rax], cl		# str[size++] = ch;
	cmp	BYTE PTR -81[rbp], -1		# проверяем, что ch != -1
	jne	.L13						# переходим к следующей итерации цикла
	sub	DWORD PTR -28[rbp], 1		# декрементируем size
	mov	rdx, QWORD PTR -64[rbp]		# получаем указатель на str со стека
	mov	eax, DWORD PTR -28[rbp]		# получаем size со стека
	mov	BYTE PTR [rdx+rax], 0		# str[size] = '\0';
	jmp	.L14						# переход к .L14
.L9:								# метка ".L9" - начало цикла ввода строки с помощью генератора
	lea	rsi, .LC2[rip]				# загружаем строку "w"
	lea	rdi, .LC3[rip]				# загружаем строку "input"
	call	fopen@PLT				# вызываем fopen()
	mov	QWORD PTR -80[rbp], rax		# input = fopen("input", "w");
	lea	rsi, .LC2[rip]				# загружаем строку "w"
	lea	rdi, .LC4[rip]				# загружаем строку "output"
	call	fopen@PLT				# вызываем fopen()
	mov	QWORD PTR -40[rbp], rax		# output = fopen("output", "w");
	mov	rax, QWORD PTR -144[rbp]	# получаем указатель на argv в памяти
	add	rax, 32						# переходим к argv[4]
	mov	rdi, QWORD PTR [rax]		# помещаем значение argv[4] в rdi
	call	atoi@PLT				# вызываем atoi()
	mov	DWORD PTR -28[rbp], eax		# помещаем результат приведения argv[4] к int в size
	mov	eax, DWORD PTR -28[rbp]		# получаем size со стека
	cmp	eax, DWORD PTR -44[rbp]		# получаем max со стека и проверяем, что size > max
	jle	.L15						# переходим к продолжению работы
	lea	rdi, .LC0[rip]				# загружаем строку "Incorrect input"
	call	puts@PLT				# вывод строки
	mov	eax, 0						# обнуляем eax
	jmp	.L8							# переходим к выходу из программы
.L15:								# метка ".L15" - ввод строки с помощью генератора
	mov	DWORD PTR -20[rbp], 0		# обнуляем rbp[-20] - итератор цикла
	jmp	.L16						# переход к .L16
.L17:								# метка ".L17" - генерация случайного символа
	call	rand@PLT				# вызываем rand()
	cdq								# хитро берём
	shr	edx, 25						# остаток от деления
	add	eax, edx					# результата rand()
	and	eax, 127					# на
	sub	eax, edx					# 128
	mov	ecx, eax					# сохраняем полученный остаток
	mov	rdx, QWORD PTR -64[rbp]		# получаем указатель на str со стека
	mov	eax, DWORD PTR -20[rbp]		# получаем значение итератора
	mov	BYTE PTR [rdx+rax], cl		# str[i] = rand() % 128;
	mov	rdx, QWORD PTR -64[rbp]		# получаем указатель на str со стека
	mov	eax, DWORD PTR -20[rbp]		# получаем i со стека
	movzx	eax, BYTE PTR [rdx+rax]	# переходим к str[i]
	movsx	eax, al					# получаем значение str[i]
	mov	rsi, QWORD PTR -80[rbp]		# получаем input со стека
	mov	edi, eax					# записываем str[i] в edi
	call	fputc@PLT				# вызываем fprintf()
	add	DWORD PTR -20[rbp], 1		# инкрементируем итератор
.L16:								# метка ".L16" - проверка условия цикла ввода с помощью генератора
	mov	eax, DWORD PTR -20[rbp]		# получаем i со стека
	cmp	eax, DWORD PTR -28[rbp]		# получаем size со стека и проверяем, что i < size
	jl	.L17						# переходим к следующей итерации
.L14:								# метка ".L14" - после if-else
	lea	rsi, -112[rbp]				# получаем ссылку на start
	mov	edi, 1						# записываем время отсчёта
	call	clock_gettime@PLT		# вызываем clock_gettime()
	mov	DWORD PTR -20[rbp], 0		# обнуляем итератор
	jmp	.L18						# переходим к .L18
.L19:								# метка ".L19" - тело цикла поиска подпоследовательности
	mov	rdx, QWORD PTR -64[rbp]		# получаем str со стека
	mov	esi, DWORD PTR -28[rbp]		# получаем size со стека
	mov	edi, DWORD PTR -72[rbp]		# получаем n со стека
	call	find@PLT				# вызываем find()
	mov	DWORD PTR -24[rbp], eax		# записываем результат в result
	add	DWORD PTR -20[rbp], 1		# инкрементируем i
.L18:								# метка ".L18" - цикл поиска подпоследовательности
	mov	eax, DWORD PTR -20[rbp]		# получаем i со стека
	cmp	eax, DWORD PTR -68[rbp]		# получаем count со стека и проверяем, что i < count
	jl	.L19						# переходим к следующей итерации
	lea	rsi, -128[rbp]				# получаем ссылку на finish
	mov	edi, 1						# записываем время отсчёта
	call	clock_gettime@PLT		# вызов clock_gettime()
	mov	rdx, QWORD PTR -112[rbp]	# получаем start.tv_sec со стека
	mov	rcx, QWORD PTR -104[rbp]	# получаем start.tv_nsec со стека
	mov	rdi, QWORD PTR -128[rbp]	# получаем finish.tv_sec со стека
	mov	rsi, QWORD PTR -120[rbp]	# получаем finish.tv_nsec со стека
	call	timeDelta				# вызываем timeDelta()
	mov	QWORD PTR -96[rbp], rax		# записываем результат в time_delta
	mov	rsi, QWORD PTR -96[rbp]		# получаем time_delta
	lea	rdi, .LC5[rip]				# загрузка строки "Time delta: %ld ns\n"
	mov	eax, 0						# обнуляем eax
	call	printf@PLT				# вызываем printf()
	cmp	DWORD PTR -24[rbp], -1		# получаем max со стека и проверяем, что result != -1
	je	.L8							# переходим к выходу из программы
	mov	DWORD PTR -20[rbp], 0		# обнуляем i
	jmp	.L21						# переходим к .L21
.L22:								# метка ".L22" - тело цикла вывода строки в output
	mov	edx, DWORD PTR -24[rbp]		# получаем result со стека
	mov	eax, DWORD PTR -20[rbp]		# получаем i со стека
	add	eax, edx					# вычисляем result+i
	mov	rdx, QWORD PTR -64[rbp]		# получаем указатель на str со стека
	movzx	eax, BYTE PTR [rdx+rax]	# переходим к str[result+i]
	movsx	eax, al					# получаем значение str[result+i]
	mov	rsi, QWORD PTR -40[rbp]		# получаем output со стека
	mov	edi, eax					# записываем str[result+i] в edi
	call	fputc@PLT				# вызываем printf()
	add	DWORD PTR -20[rbp], 1		# инкрементируем i
.L21:								# метка ".L21" - начало цикла вывода строки в output
	mov	eax, DWORD PTR -20[rbp]		# получаем i со стека
	cmp	eax, DWORD PTR -72[rbp]		# получаем n со стека и проверяем, что i < n
	jl	.L22						# переходим к следующей итерации
.L8:								# метка ".L8" - выход из программы 
	leave							# (эпилог)
	ret								# выход из функции
