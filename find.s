	.intel_syntax noprefix			# указание интеловского синтаксиса
	.text							# начало секции
	.globl	find					# метка глобальности для линкера
find:								# метка функции "find"
	push	rbp						# (пролог) сохраняем rbp на стек
	mov	rbp, rsp					# записываем rsp в rbp
	mov	r13d, edi					# записываем в регистр: n (int - 4 byte)
	mov	r14d, esi					# записываем в регистр: size (int - 4 byte)
	mov	r15, rdx					# записываем в регистр: str (char* - 8 byte)
	mov	eax, r14d					# получаем size
	sub	eax, r13d					# получаем n и вычисляем size-n
	mov	r12d, eax					# записываем в регистр: i = 0 (int - 4 byte)
	jmp	.L2							# переходим к .L2
.L9:								# метка ".L9" - начало внешнего цикла
	mov	DWORD PTR -4[rbp], 1		# flag = 1;
	mov	DWORD PTR -12[rbp], 0		# j = 0;
	jmp	.L3							# переходим к .L3
.L6:								# метка ".L6" - тело внутреннего цикла
	mov	edx, r12d					# получаем i
	mov	eax, DWORD PTR -12[rbp]		# получаем j
	add	eax, edx					# вычисляем i+j
	movsx	rdx, eax				# записываем i+j в rdx
	mov	rax, r15					# получаем указатель на строку
	add	rax, rdx					# переходим к i+j символу
	movzx	edx, BYTE PTR [rax]		# получаем str[i+j]
	mov	ecx, r12d					# получаем i
	mov	eax, DWORD PTR -12[rbp]		# получаем j
	add	eax, ecx					# вычисляем i+j
	lea	rcx, 1[rax]					# записываем i+j+1 в rcx
	mov	rax, r15					# получаем указатель на строку
	add	rax, rcx					# переходим к i+j+1 символу
	movzx	eax, BYTE PTR [rax]		# получаем str[i+j+1]
	cmp	dl, al						# проверяем, что str[i+j] <= str[i+j+1]
	jg	.L4							# переходим к .L4
	mov	DWORD PTR -4[rbp], 0		# обнуляем flag
	jmp	.L5							# переходим к .L5
.L4:								# метка ".L4" - окончание внутреннего цикла
	add	DWORD PTR -12[rbp], 1		# инкрементируем j
.L3:								# метка ".L3" - условие внутреннего цикла
	mov	eax, r13d					# получаем n
	sub	eax, 1						# вычисляем n - 1
	cmp	DWORD PTR -12[rbp], eax		# проверяем, что j < n - 1
	jl	.L6							# переходим к .L6
.L5:								# метка ".L5" - окончание внешнего цикла
	cmp	DWORD PTR -4[rbp], 1		# проверяем, что flag == 1
	jne	.L7							# переходим к .L7
	mov	eax, r12d					# возвращаем i
	jmp	.L8							# переходим к .L8
.L7:								# метка ".L7" - декремент внешнего цикла
	sub	r12d, 1						# деккрементируем i
.L2:								# метка ".L2" - условие внешнего цикла
	cmp	r12d, 0						# проверяем i >= 0
	jns	.L9							# переходим к .L9
	mov	eax, -1						# возращаем -1
.L8:								# метка ".L8" - выход из функции
	pop	rbp							# (эпилог)
	ret								# выход из функции
