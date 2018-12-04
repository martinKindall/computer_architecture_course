.data 
	mensajeA: .asciiz "Ingrese variable a: " # string con terminacion 
	mensajeB: .asciiz "Ingrese variable b: " # string con terminacion 

	recursion: .asciiz "Llamada recursiva\n" #string con terminacion

	estadoA: .asciiz "a = " #string con terminacion
	estadoB: .asciiz "b = " #string con terminacion

	saltoLinea: .asciiz "\n" # string con terminacion 

	resultado: .asciiz "MCD(a,b) = " # string con terminacion 

.text
	la $a0, mensajeA # guardar direccion de mensajeA en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall    # llamada al sistema

# ingresar A
	li $v0, 5 # guardar entero 5 en $v0
	syscall # llamada al sistema, el 5 es para recibir input entero

	add $s3, $v0, $zero # guardar $v0 en $s3

	la $a0, mensajeB # guardar direccion de mensajeB en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall  #llamada al sistema

# ingresar B
	li $v0, 5 # guardar entero 5 en $v0
	syscall # llamada al sistema, el 5 es para recibir input entero

	add $s4, $v0, $zero # guardar $v0 en $s4

# salto de linea
	la $a0, saltoLinea # guardar direccion de saltoLinea en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall #llamada al sistema para imprimir en pantalla el contenido de la direccion $a0

	jal mcd # se llama al procedimiento mcd

	add $s1, $v0, $zero # se guarda el resultado de mcd en $s1

	la $a0, resultado # guardar direccion de resultado en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall    # llamada al sistema

	add $a0, $s1, $zero # se guarda $s1 en $a0
	li $v0, 1	# mostrar el entero guardado en $a0
	syscall # llamada al sistema que imprime enteros en $a0

	j exit # salto a rutina exit (fin del programa)

mcd:
	addi, $sp, $sp, -4	# se agranda stack en 4 bytes 
	sw $ra, 0($sp)		# se guarda direccion de retorno en stack

	beq $s4, $zero, F1 	# s4 == 0 saltar a F1

	add $t1, $s4, $zero # t1 = s4
	rem $s4, $s3, $s4 	# s4 = s3 % s4
	add $s3, $t1, $zero	# s3 = t1
	
	la $a0, recursion # guardar direccion del string recursion en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall    # llamada al sistema para mostrar strings en pantalla

	la $a0, estadoA # guardar direccion del string estadoA en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall    # llamada al sistema para mostrar strings en pantalla

	add $a0, $s3, $zero # a0 = s3
	li $v0, 1	# cargar 1 en v0
	syscall		# llamada al sistema, print integer

	la $a0, saltoLinea # guardar direccion del string saltoLinea en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall    # llamada al sistema para mostrar strings en pantalla

	la $a0, estadoB # guardar direccion del string estadoB en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall    # llamada al sistema para mostrar strings en pantalla

	add $a0, $s4, $zero # a0 = s4
	li $v0, 1 	# cargar 1 en v0
	syscall 	# llamada al sistema, print integer

	la $a0, saltoLinea # guardar direccion del string saltoLinea en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall    # llamada al sistema para mostrar strings en pantalla

	la $a0, saltoLinea # guardar direccion del string saltoLinea en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall    # llamada al sistema para mostrar strings en pantalla

	jal mcd  		# realizamos llamado recursivo a mcd
	lw $ra, 0($sp)	# una vez retorna la recursion, cargamos el punto de
					# retorno previamente guardado en el stack
	addi, $sp, $sp, 4	# modificamos tamaño de stack a su tamaño anterior
	jr $ra 			# salto al punto de retorno

	F1: 			# caso base de la recursion
		add $v0, $s3, $zero 	# v0 = s3
		addi, $sp, $sp, 4 		# modificamos tamaño de stack a su tamaño anterior
		jr $ra 					# salto al punto de retorno

exit:  		# fin del programa