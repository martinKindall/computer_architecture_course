.eqv SIZE 40

.data 
	fp1: .float 10.0
	fp2: .float 1.0
	fp3: .float 10000.0

	buffer:	.space SIZE

	floatA: .space 4
	floatB: .space 4
	floatC: .space 4

	floatAny:.space 4

	saltoLinea: .asciiz "\n" # string con terminacion 
	exponente: .asciiz " E" # string con terminacion 

	ingresarA: .asciiz "Ingrese A en Punto Flotante: " # string con terminacion 
	ingresarB: .asciiz "Ingrese B en Punto Flotante: " # string con terminacion 
	ingresarC: .asciiz "Ingrese C en Punto Flotante: " # string con terminacion 

	mostrarA: .asciiz "Numero A en decimal normalizado: " # string con terminacion 
	mostrarB: .asciiz "Numero B en decimal normalizado: " # string con terminacion 
	mostrarC: .asciiz "Numero C en decimal normalizado: " # string con terminacion 

	resu1Normalizado: .asciiz "A · (B + C) en decimal normalizado: " # string con terminacion
	resu1Flotante: .asciiz "A · (B + C) en Punto Flotante : " # string con terminacion

.text

la $a1, ingresarA   	# guardar direccion de ingresarA en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

jal readStr  			# llamamos a procedimiento para leer strings del teclado

la $a2, floatA			# guardamos la direccion de floatA en $a2
jal strToFloat			# procedimiento que transforma de string a float

la $a1, ingresarB   	# guardar direccion de ingresarB en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

jal readStr  			# llamamos a procedimiento para leer strings del teclado

la $a2, floatB			# guardamos la direccion de floatB en $a2
jal strToFloat			# procedimiento que transforma de string a float

la $a1, ingresarC   	# guardar direccion de ingresarC en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

jal readStr  			# llamamos a procedimiento para leer strings del teclado

la $a2, floatC			# guardamos la direccion de floatC en $a2
jal strToFloat			# procedimiento que transforma de string a float

la $a1, saltoLinea   	# guardar direccion de ingresarA en $a1
jal printStr 

# respuesta del programa 

# normalizando a decimal

la $a1, mostrarA	   	# guardar direccion de mostrarA en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

l.s $f12, floatA
jal printFloat

la $a1, mostrarB	   	# guardar direccion de mostrarB en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

l.s $f12, floatB
jal printFloat

la $a1, mostrarC	   	# guardar direccion de mostrarC en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

l.s $f12, floatC
jal printFloat

la $a1, saltoLinea   	# guardar direccion de ingresarA en $a1
jal printStr 

# A · (B + C)

l.s $f1, floatA			# guardamos floatA en $f1
l.s $f2, floatB			# guardamos floatB en $f2
l.s $f3, floatC			# guardamos floatC en $f3

add.s $f2, $f2, $f3 	# f2 = B + C
mul.s $f1, $f2, $f1 	# f1 = A * (B+C)

la $a1, resu1Flotante	# guardar direccion de resu1Flotante en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

mov.s $f12, $f1
jal floatToStr

la $a1, buffer			# guardar direccion de buffer en $a1
jal printStr 

la $a1, saltoLinea   	# guardar direccion de ingresarA en $a1
jal printStr 

la $a1, resu1Normalizado	# guardar direccion de resu1Normalizado en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

mov.s $f12, $f1
jal printFloat


j exit 					# salir del programa


printStr: 
	add $a0, $a1, $zero	# mover $a1 a $a0
	li $v0, 4			# guardar entero 4 en $v0
	syscall				# llamada al sistema, 4 significa print str
	jr $ra 				# retornar


printInt:
	li $v0, 1			# guardamos entero 1 en $v0
	syscall				# llamada al sistema, 1 es print int
	jr $ra


printFloat:
	addi $sp, $sp, -4		# aumentamos el stack en 4 bytes
	sw $ra, 0($sp)			# guardamos el punto de retorno
	l.s $f11, fp1			# guardamos 10.0 en $f11
	add $s0, $zero, $zero	# inicializamos exponente en 0
	abs.s $f10, $f12		# $f10 = |$f12| valor absoluto
	c.lt.s $f11, $f10		# 10.0 < $f10 ? 
	bc1t normalizarHigh		# true
	l.s $f9, fp2			# guardamos 1.0 en $f11
	c.lt.s $f10, $f9		# 1.0 > $f10 ? 
	bc1t normalizarLow		# true

	ret1:
		li $v0, 2
		syscall

		la $a1, exponente   	# guardar direccion de exponente en $a1
		jal printStr 

		add $a0, $s0, $zero
		jal printInt

		la $a1, saltoLinea   	# guardar direccion de ingresarA en $a1
		jal printStr 

		lw $ra, 0($sp)			# restauramos el punto de retorno
		addi $sp, $sp, 4		# se reduce el stack en 4 bytes
		jr $ra

	normalizarHigh:
		addi $s0, $s0, 1	# exponente positivo
		div.s $f12, $f12, $f11
		abs.s $f10, $f12		# $f10 = |$f12| valor absoluto
		c.lt.s $f11, $f10
		bc1t normalizarHigh
		j ret1

	normalizarLow:
		addi $s0, $s0, -1	# exponente positivo
		mul.s $f12, $f12, $f11
		abs.s $f10, $f12		# $f10 = |$f12| valor absoluto
		c.lt.s $f10, $f9
		bc1t normalizarLow
		j ret1


readStr:
	la $a0, buffer		# guardamos la direccion del buffer en $a0
	li $a1, SIZE		# definimos el tamaño del string a leer
	li $v0, 8			# guardamos entero 8 en $v0
	syscall				# llamada al sistema, 8 significa read string
	jr $ra


strToFloat: 
	la $t0, buffer
	add $t1, $zero, $zero	# i = 0
	addi $t5, $zero, 8		# j = 9
	add $t4, $zero, $zero  	# en $t4 guardaremos el exponente

	addi $t6, $zero, 1  	# en $t6 guardamos 1, se setea en 0
							# cuando ya tenemos el exponente


	lbu $t2, 0($t0)   		# guardamos el signo del numero en $t2
	addi $v0, $t2, -48  	# al restar 48 estamos transformando un digito ascii
							# a un int, guardamos el signo int en $v0

	L1: 
		beq $t1, $t5, L2		# i == j 
		
		addi $t1, $t1, 1	# i = i + 1

		add $t2, $t0, $t1

		lbu $t3, 0($t2)   	# guardamos el bit actual en $t3

		addi $t3, $t3, -48  # de ascii a int

		sll $t4, $t4, 1		# un shift left para hacer espacio para el siguiente

		add $t4, $t4, $t3

		j L1
	L2: 
		beq $t6, $zero, L3

		add $t6, $zero, $zero

		add $v1, $t4, $zero	# guardamos el exponente en $v1

		# mantisa

		add $t4, $zero, $zero 	# en $t4 guardaremos la mantisa

		add $t1, $zero, $zero	# i = 0
		addi $t5, $zero, 23		# j = 23

		addi $t0, $t0, 8

		j L1
	L3:
		add $s0, $t4, $zero	# guardamos la mantisa en $s0

		add $t7, $zero, $v0	# guardamos el signo en $t7
		sll $t7, $t7, 8		# hacemos espacio para el exponente
		add $t7, $t7, $v1	# juntamos el signo y el exponente
		sll $t7, $t7, 23 	# hacemos espacio para la mantisa
		add $t7, $t7, $s0	# agregmos la mantisa 

		sw $t7, 0($a2)

		jr $ra


floatToStr:
	add $t0, $zero, $zero
	la $t1, buffer
	addiu $t2, $zero, 0x80000000	# mascara de 1 bit en pos. 31
	swc1 $f12, floatAny
	lw $t4, floatAny

	L4:
		beq $t0, 32, L5
		and $t3, $t2, $t4
		sne $t5, $t3, 0		# t5 = 1 si t3 != 0, sino 0
		addi $t5, $t5, 48	# convertirmos de bit a ascii
		sb $t5, 0($t1)
		addi $t0, $t0, 1
		addi $t1, $t1, 1
		srl $t2, $t2, 1
		j L4

	L5:
		sb $zero, 0($t1)
		jr $ra

exit: 
