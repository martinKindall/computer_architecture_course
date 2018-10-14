.data 
	mensajeA: .asciiz "Ingrese variable A: "
	mensajeB: .asciiz "Ingrese variable B: "
	mensajeC: .asciiz "Ingrese variable C: "

	resultadoX: .asciiz "Resultado para X: "


.text
	la $a0, mensajeA
	li $v0, 4		# print string
	syscall

# ingresar A
	li $v0, 5
	syscall

# guardar A en $s3
	add $s3, $v0, $zero

	la $a0, mensajeB
	li $v0, 4		# print string
	syscall

# ingresar B
	li $v0, 5
	syscall

# guardar B en $s4
	add $s4, $v0, $zero

	la $a0, mensajeC
	li $v0, 4		# print string
	syscall

# ingresar C
	li $v0, 5
	syscall

# guardar C en $s5
	add $s5, $v0, $zero

	la $a0, resultadoX
	li $v0, 4		# print string
	syscall

	jal rutinaX

	add $a0, $v0, $zero
	li $v0, 1		# print int
	syscall

	j exit


rutinaX:	sll $t0, $s3, 1
			sll $t1, $s4, 3
			sll $t2, $s5, 2

			#complemento de 4C
			nor $t2, $t2, $zero
			addi $t2, $t2, 1

			add $v0, $t0, $t1
			add $v0, $v0, $t2

			jr $ra

exit: 