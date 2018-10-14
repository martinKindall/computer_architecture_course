.data 
	mensajeA: .asciiz "Ingrese variable A: "
	mensajeB: .asciiz "Ingrese variable B: "
	mensajeC: .asciiz "Ingrese variable C: "

	saltoLinea: .asciiz "\n"

	resultadoX: .asciiz "Resultado para X: "
	resultadoY: .asciiz "Resultado para Y: "
	resultadoZ: .asciiz "Resultado para Z: "


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

# salto de linea
	la $a0, saltoLinea
	li $v0, 4		# print string
	syscall

	la $a0, resultadoX
	li $v0, 4		# print string
	syscall

	jal rutinaX

	add $a0, $v0, $zero
	li $v0, 1		# print int
	syscall

# salto de linea
	la $a0, saltoLinea
	li $v0, 4		# print string
	syscall

	la $a0, resultadoY
	li $v0, 4		# print string
	syscall

	jal rutinaY

	add $a0, $v0, $zero
	li $v0, 1		# print int
	syscall

# salto de linea
	la $a0, saltoLinea
	li $v0, 4		# print string
	syscall

	la $a0, resultadoZ
	li $v0, 4		# print string
	syscall

	jal rutinaZ

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


rutinaY:	sll $t0, $s3, 2
			sll $t1, $s4, 5
			sll $t2, $s5, 3

			#complemento de 32B
			nor $t1, $t1, $zero
			addi $t1, $t1, 1

			add $v0, $t0, $t1
			add $v0, $v0, $t2

			jr $ra


rutinaZ:	sll $t0, $s3, 3
			sll $t1, $s4, 4
			sll $t2, $s5, 5

			#complemento de 32B
			nor $t2, $t2, $zero
			addi $t2, $t2, 1

			add $v0, $t0, $t1
			add $v0, $v0, $t2

			jr $ra


exit: