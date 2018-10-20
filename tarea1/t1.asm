.data 
	mensajeA: .asciiz "Ingrese variable A: " # string con terminacion 
	mensajeB: .asciiz "Ingrese variable B: " # string con terminacion 
	mensajeC: .asciiz "Ingrese variable C: " # string con terminacion 

	saltoLinea: .asciiz "\n" # string con terminacion 

	resultadoX: .asciiz "Resultado para X: " # string con terminacion 
	resultadoY: .asciiz "Resultado para Y: " # string con terminacion 
	resultadoZ: .asciiz "Resultado para Z: " # string con terminacion 


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

	la $a0, mensajeC # guardar direccion de mensajeC en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall  #llamada al sistema

	li $v0, 5 # guardar entero 5 en $v0
	syscall # llamada al sistema, el 5 es para recibir input entero

	add $s5, $v0, $zero # guardar $v0 en $s5

# salto de linea
	la $a0, saltoLinea # guardar direccion de saltoLinea en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall #llamada al sistema para imprimir en pantalla el contenido de la direccion $a0

	la $a0, resultadoX # guardar direccion de resultadoX en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall  #llamada al sistema para imprimir en pantalla el contenido de la direccion $a0 

	jal rutinaX  # llamada a rutinaX

	add $s0, $v0, $zero  # guardar $v0 en $s0
	add $a0, $v0, $zero  # guardar $v0 en $a0
	li $v0, 1		# print int
	syscall #llamada al sistema para imprimir en pantalla el contenido de $a0 (entero)

# salto de linea
	la $a0, saltoLinea # guardar direccion de saltoLinea en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall #llamada al sistema para imprimir en pantalla el contenido de la direccion $a0 

	la $a0, resultadoY # guardar direccion de resultadoY en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall #llamada al sistema para imprimir en pantalla el contenido de la direccion $a0 

	jal rutinaY # llamada a rutinaY

	add $s1, $v0, $zero # guardar $v0 en $s1
	add $a0, $v0, $zero # guardar $v0 en $a0
	li $v0, 1		# print int
	syscall #llamada al sistema para imprimir en pantalla el contenido de $a0 (entero)

# salto de linea
	la $a0, saltoLinea # guardar direccion de saltoLinea en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall #llamada al sistema para imprimir en pantalla el contenido de la direccion $a0 

	la $a0, resultadoZ # guardar direccion de resultadoZ en $a0
	li $v0, 4	# guardar entero 4 en $v0
	syscall #llamada al sistema para imprimir en pantalla el contenido de la direccion $a0 

	jal rutinaZ # llamada a rutinaZ

	add $s2, $v0, $zero # guardar $v0 en $s2
	add $a0, $v0, $zero # guardar $v0 en $a0
	li $v0, 1		# print int
	syscall #llamada al sistema para imprimir en pantalla el contenido de $a0 (entero)

	j exit # llamada a exit (fin del programa)


rutinaX:	sll $t0, $s3, 1 # usando shift left, multiplicar $s3 por 2 y guardarlo en $t0
			sll $t1, $s4, 3 # usando shift left, multiplicar $s4 por 8 y guardarlo en $t1
			sll $t2, $s5, 2 # usando shift left, multiplicar $s5 por 4 y guardarlo en $t2

			#complemento de 4C
			nor $t2, $t2, $zero # equivalente a negar $t2 bit a bit, complemento de 1
			addi $t2, $t2, 1 # sumar 1 a $t2 y guardarlo en $t2 (complemento 2)

			add $v0, $t0, $t1 # sumar $t0 con $t1 y guardarlo en $v0
			add $v0, $v0, $t2 # sumar $v0 con $t2 y guardarlo en $v0

			jr $ra # retornar


rutinaY:	sll $t0, $s3, 2 # usando shift left, multiplicar $s3 por 4 y guardarlo en $t0
			sll $t1, $s4, 5 # usando shift left, multiplicar $s4 por 32 y guardarlo en $t1
			sll $t2, $s5, 3 # usando shift left, multiplicar $s5 por 8 y guardarlo en $t2

			#complemento de 32B
			nor $t1, $t1, $zero # equivalente a negar $t1 bit a bit, complemento de 1
			addi $t1, $t1, 1 # sumar 1 a $t1 y guardarlo en $t1 (complemento 2)

			add $v0, $t0, $t1 # sumar $t0 con $t1 y guardarlo en $v0
			add $v0, $v0, $t2 # sumar $v0 con $t2 y guardarlo en $v0

			jr $ra # retornar


rutinaZ:	sll $t0, $s3, 3 # usando shift left, multiplicar $s3 por 8 y guardarlo en $t0
			sll $t1, $s4, 4 # usando shift left, multiplicar $s4 por 16 y guardarlo en $t1
			sll $t2, $s5, 5 # usando shift left, multiplicar $s5 por 32 y guardarlo en $t2

			#complemento de 32C
			nor $t2, $t2, $zero # equivalente a negar $t2 bit a bit, complemento de 1
			addi $t2, $t2, 1 # sumar 1 a $t2 y guardarlo en $t2 (complemento 2)

			add $v0, $t0, $t1 # sumar $t0 con $t1 y guardarlo en $v0
			add $v0, $v0, $t2 # sumar $v0 con $t2 y guardarlo en $v0

			jr $ra # retornar

# fin del programa
exit: