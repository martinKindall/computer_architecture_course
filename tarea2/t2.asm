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


exit: 