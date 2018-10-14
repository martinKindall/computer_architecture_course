.data
	nombre:	.space	100
	mens1:	.asciiz	"Ingrese su nombre: "
	mens2:	.asciiz "Su nombre es: "
	mens3:	.asciiz	"Cantidad de caracteres: "

.text

#Mostrar mensaje 1
	la $a0, mens1	#Cargar msg1 en registro
	li $v0, 4	#
	syscall

#Ingresar nombre
	la $a0, nombre
	li $a1, 100
	li $v0, 8
	syscall

#Imprimir mensaje 2
	la $a0, mens2
	li $v0, 4
	syscall

#Imprimir nombre
	la $a0, nombre
	li $v0, 4
	syscall

#imprimir msg3
	la $a0, mens3
	li $v0, 4
	syscall

#calc num caracteres en nombre
	la $t2, nombre
	li $t1,0

sigCar:		lb $t0, ($t2)
		beq $t0, 0x20,salEsp
		beqz $t0, finString
		add $t1,$t1,1
	
salEsp: 	add $t2,$t2,1
		j sigCar

finString:	subi $t1,$t1,1
	  	add $a0, $t1,$zero
	   	li $v0, 1
	  	syscall

		li $v0,10
		syscall	
