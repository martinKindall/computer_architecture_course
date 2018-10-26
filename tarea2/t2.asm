.eqv SIZE 40

.data 
	fp1: .float 10.0
	fp2: .float 1.0
	fp3: .float 10000.0

	buffer:	.space SIZE

	floatA: .space 4
	floatB: .space 4

	saltoLinea: .asciiz "\n" # string con terminacion 

	ingresarA: .asciiz "Ingrese A en Punto Flotante: " # string con terminacion 
	ingresarB: .asciiz "Ingrese B en Punto Flotante: " # string con terminacion 
	ingresarC: .asciiz "Ingrese C en Punto Flotante: " # string con terminacion 

	mostrarA: .asciiz "Numero A en decimal normalizado: " # string con terminacion 
	mostrarB: .asciiz "Numero B en decimal normalizado: " # string con terminacion 
	mostrarC: .asciiz "Numero C en decimal normalizado: " # string con terminacion 

.text

la $a1, ingresarA   	# guardar direccion de ingresarA en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

jal readStr  			# llamamos a procedimiento para leer strings del teclado

la $a2, floatA
jal strToFloat

la $a1, ingresarB   	# guardar direccion de ingresarA en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

jal readStr  			# llamamos a procedimiento para leer strings del teclado

la $a2, floatB
jal strToFloat

li $v0, 2
la $t0, floatA
l.s $f12, 0($t0)
syscall

la $a1, saltoLinea   	# guardar direccion de ingresarA en $a1
jal printStr  

li $v0, 2
la $t0, floatB
l.s $f12, 0($t0)
l.s $f11, fp1

#add $t1, $zero, $zero

c.lt.s $f11, $f12
bc1t normalizarHigh

ret1:

syscall

j exit 					# salir del programa


normalizarHigh:
	l.s $f11, fp3
	div.s $f12, $f12, $f11

	j ret1


printStr: 
	add $a0, $a1, $zero	# mover $a1 a $a0
	li $v0, 4			# guardar entero 4 en $v0
	syscall				# llamada al sistema, 4 significa print str
	jr $ra 				# retornar


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


exit: 