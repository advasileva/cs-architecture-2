make-asm: # Лучше не запускать, потому что будет обновлена ассемблерная программа
	bash ./scripts/make-asm.sh main
	bash ./scripts/make-asm.sh find

test.asm:
	make compile.asm
	bash ./scripts/test-asm.sh

test.c:
	make compile.c
	bash ./scripts/test-c.sh

test:
	echo "Test ASM"
	make test.asm
	echo "Test C"
	make test.c

compile.asm:
	bash ./scripts/compile-asm.sh
	echo "ASM compiled"

compile.c:
	bash ./scripts/compile-c.sh
	echo "C compiled"

compile:
	make compile.asm
	make compile.c

compare:
	make compile
	bash ./scripts/compare.sh

rand.asm:
	echo "Test ASM"
	bash ./scripts/rand-asm.sh $n $(size)

rand.c:
	echo "Test C"
	bash ./scripts/rand-c.sh $n $(size)

optimize:
	bash ./scripts/optimize.sh

compare.opt:
	bash ./scripts/compare-opt.sh
