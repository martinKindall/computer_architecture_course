.data 
	mensaje: .asciiz "Hello world!"


.text
	la $a0, mensaje
	li $v0, 4		# print string
	syscall