.data 
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

j exit 					# salir del programa


printStr: 
	add $a0, $a1, $zero	# mover $a1 a $a0
	li $v0, 4			# guardar entero 4 en $v0
	syscall				# llamada al sistema, 4 significa print str
	jr $ra 				# retornar


exit: 