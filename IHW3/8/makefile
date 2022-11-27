separated-program-assembler: aprogram.o afunctions.o
	gcc -o separated-program-assembler aprogram.o afunctions.o -lm
aprogram.o:
	as --gstabs -o aprogram.o compiled-program.s
afunctions.o:
	as --gstabs -o afunctions.o functions.s
