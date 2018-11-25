.data 
	mensajeA: .asciiz "Ingrese variable a: " # string con terminacion 
	mensajeB: .asciiz "Ingrese variable b: " # string con terminacion 

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

	jal mcd

	add $s1, $v0, $zero

	la $a0, resultado # guardar direccion de resultado en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall    # llamada al sistema

	add $a0, $s1, $zero
	li $v0, 1	# mostrar el entero guardado en $a0
	syscall # llamada al sistema que imprime enteros en $a0

	j exit

mcd:
	addi, $sp, $sp, -4
	sw $ra, 0($sp)

	beq $s4, $zero, F1

	add $t1, $s4, $zero
	rem $s4, $s3, $s4
	add $s3, $t1, $zero
	
	jal mcd
	lw $ra, 0($sp)
	addi, $sp, $sp, 4
	jr $ra

	F1:
		add $v0, $s3, $zero
		addi, $sp, $sp, 4
		jr $ra

exit: