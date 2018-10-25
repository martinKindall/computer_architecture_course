.eqv SIZE 40

.data 
	buffer:	.space SIZE

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

jal strToFloat

j exit 					# salir del programa


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
	add $t1, $zero, $zero
	add $t4, $zero, $zero  	# en $t4 guardaremos el exponente

	lbu $t2, 0($t0)   		# guardamos el signo del numero en $t2
	addi $v0, $t2, -48  	# al restar 48 estamos transformando un digito ascii
							# a un int, guardamos el signo int en $v0

	L1: 
		addi $t1, $t1, 1

		beq $t1, 9, L2

		add $t2, $t0, $t1

		lbu $t3, 0($t2)   	# guardamos el bit actual en $t3

		addi $t3, $t3, -48  # de ascii a int

		sll $t4, $t4, 1		# un shift left para hacer espacio para el siguiente

		add $t4, $t4, $t3

		j L1

	L2: 
		add $v1, $t4, $zero
		jr $ra


exit: 