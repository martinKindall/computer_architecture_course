.eqv SIZE 40

.data 
	fp1: .float 10.0	# numero precision simple
	fp2: .float 1.0		# numero precision simple
	fp3: .float 0.0		# numero precision simple

	buffer:	.space SIZE	# espacio reservado en memoria

	floatA: .space 4	# espacio reservado en memoria
	floatB: .space 4	# espacio reservado en memoria
	floatC: .space 4	# espacio reservado en memoria

	floatAny:.space 4	# espacio reservado en memoria

	saltoLinea: .asciiz "\n" # string con terminacion 
	exponente: .asciiz " E" # string con terminacion 

	ingresarA: .asciiz "Ingrese A en Punto Flotante: " # string con terminacion 
	ingresarB: .asciiz "Ingrese B en Punto Flotante: " # string con terminacion 
	ingresarC: .asciiz "Ingrese C en Punto Flotante: " # string con terminacion 

	mostrarA: .asciiz "Numero A en decimal normalizado: " # string con terminacion 
	mostrarB: .asciiz "Numero B en decimal normalizado: " # string con terminacion 
	mostrarC: .asciiz "Numero C en decimal normalizado: " # string con terminacion 

	resu1Normalizado: .asciiz "A · (B + C) en decimal normalizado: " # string con terminacion
	resu1Flotante: .asciiz "A · (B + C) en Punto Flotante: " # string con terminacion

	resu2Normalizado: .asciiz "(A · B) + (A · C) decimal normalizado: " # string con terminacion
	resu2Flotante: .asciiz "(A · B) + (A · C) en Punto Flotante: " # string con terminacion

	signoMas: .asciiz "Signo (+ / -) : +" # string con terminacion
	signoMen: .asciiz "Signo (+ / -) : -" # string con terminacion

	exponenteReal: .asciiz "Exponente Real en Decimal: " # string con terminacion
	mantisaDec: .asciiz "Mantisa en Decimal: " # string con terminacion

	guardBit: .asciiz "Guard bit: " # string con terminacion
	roundBit: .asciiz "Round bit: " # string con terminacion
	stickyBit: .asciiz "Sticky bit: " # string con terminacion

	overFlow: .asciiz "Overflow (S/N): " # string con terminacion
	underFlow: .asciiz "Underflow (S/N): " # string con terminacion

	afirmar: .asciiz "S" # string con terminacion
	negar: .asciiz "N" # string con terminacion


.text

la $a1, ingresarA   	# guardar direccion de ingresarA en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

jal readStr  			# llamamos a procedimiento para leer strings del teclado

la $a2, floatA			# guardamos la direccion de floatA en $a2
jal strToFloat			# procedimiento que transforma de string a float

la $a1, ingresarB   	# guardar direccion de ingresarB en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

jal readStr  			# llamamos a procedimiento para leer strings del teclado

la $a2, floatB			# guardamos la direccion de floatB en $a2
jal strToFloat			# procedimiento que transforma de string a float

la $a1, ingresarC   	# guardar direccion de ingresarC en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

jal readStr  			# llamamos a procedimiento para leer strings del teclado

la $a2, floatC			# guardamos la direccion de floatC en $a2
jal strToFloat			# procedimiento que transforma de string a float

la $a1, saltoLinea   	# guardar direccion de ingresarA en $a1
jal printStr 

# respuesta del programa 

# normalizando a decimal

la $a1, mostrarA	   	# guardar direccion de mostrarA en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

l.s $f12, floatA 		# se guarda el espacio de memoria floatA en el registro f12
jal printFloat			# se llama a rutina para printear floats

la $a1, mostrarB	   	# guardar direccion de mostrarB en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

l.s $f12, floatB		# se guarda el espacio de memoria floatB en el registro f12
jal printFloat			# se llama a rutina para printear floats

la $a1, mostrarC	   	# guardar direccion de mostrarC en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

l.s $f12, floatC		# se guarda el espacio de memoria floatC en el registro f12
jal printFloat			# se llama a rutina para printear floats

la $a1, saltoLinea   	# guardar direccion de ingresarA en $a1
jal printStr 			# llamamos a procedimiento para imprimir strings

# A · (B + C)

l.s $f0, floatA			# guardamos floatA en $f0
l.s $f2, floatB			# guardamos floatB en $f2
l.s $f4, floatC			# guardamos floatC en $f4

# convertir a doble presicion

cvt.d.s $f0, $f0 		# convierte f0 a doble precisión
cvt.d.s $f2, $f2 		# convierte f2 a doble precisión
cvt.d.s $f4, $f4 		# convierte f4 a doble precisión

add.d $f2, $f2, $f4 	# f2 = B + C
mul.d $f0, $f2, $f0 	# f0 = A * (B+C)

# aca hay que rescatar el guard bit, round bit y el sticky bit

mov.d $f6, $f0 			# se copia f0 en t6

cvt.s.d $f0, $f6 		# convertimos f6 a simple precision y se guarda en f0

la $a1, resu1Flotante	# guardar direccion de resu1Flotante en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

mov.s $f12, $f0 		# se guarda f0 en f12
jal floatToStr 			# llamamos a procedimiento para imprimir floats

la $a1, buffer			# guardar direccion de buffer en $a1
jal printStr  			# llamamos a procedimiento para imprimir strings

la $a1, saltoLinea   	# guardar direccion de saltoLinea en $a1
jal printStr  			# llamamos a procedimiento para imprimir strings

la $a1, resu1Normalizado	# guardar direccion de resu1Normalizado en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

mov.s $f12, $f0 		# se guarda f0 en f12
jal printFloat  		# llamamos a procedimiento para imprimir floats

# signo, mantisa, exponente
mov.s $f12, $f0  		# se guarda f0 en f12
jal printSEM  			# llamamos a procedimiento para imprimir signo, exponente y mantisa

la $a1, saltoLinea   	# guardar direccion de saltoLinea en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

jal printGRSOverUnder  	# llamamos a procedimiento para imprimir
						# guard, round, sticky bits, under y over flow

la $a1, saltoLinea   	# guardar direccion de saltoLinea en $a1
jal printStr  			# llamamos a procedimiento para imprimir strings

# (A·B) + (A·C)

l.s $f0, floatA			# guardamos floatA en $f0
l.s $f2, floatB			# guardamos floatB en $f2
l.s $f4, floatC			# guardamos floatC en $f4

# convertir a doble presicion

cvt.d.s $f0, $f0 		# convierte f0 a doble precisión
cvt.d.s $f2, $f2 		# convierte f2 a doble precisión
cvt.d.s $f4, $f4 		# convierte f4 a doble precisión

mul.d $f2, $f0, $f2 	# f2 = A * B
mul.d $f4, $f0, $f4 	# f4 = A * C

add.d $f0, $f2, $f4 	# f0 = (AB) + (AC)

mov.d $f6, $f0  		# se copia f0 en t6

cvt.s.d $f0, $f6 		# convertimos f6 a simple precision y se guarda en f0

la $a1, resu2Flotante	# guardar direccion de resu2Flotante en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

mov.s $f12, $f0 		# se guarda f0 en f12
jal floatToStr 			# llamamos a procedimiento para imprimir strings

la $a1, buffer			# guardar direccion de buffer en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

la $a1, saltoLinea   	# guardar direccion de saltoLinea en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

la $a1, resu2Normalizado	# guardar direccion de resu2Normalizado en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

mov.s $f12, $f0 		# se guarda f0 en f12
jal printFloat 			# llamamos a procedimiento para imprimir floats

# signo, mantisa, exponente
mov.s $f12, $f0 		# se guarda f0 en f12
jal printSEM 			# llamamos a procedimiento para imprimir signo, exponente y mantisa

la $a1, saltoLinea   	# guardar direccion de saltoLinea en $a1
jal printStr   			# llamamos a procedimiento para imprimir strings

jal printGRSOverUnder 	# llamamos a procedimiento para imprimir
						# guard, round, sticky bits, under y over flow

j exit 					# salir del programa


printStr: 
	add $a0, $a1, $zero	# mover $a1 a $a0
	li $v0, 4			# guardar entero 4 en $v0
	syscall				# llamada al sistema, 4 significa print str
	jr $ra 				# retornar


printInt:
	li $v0, 1			# guardamos entero 1 en $v0
	syscall				# llamada al sistema, 1 es print int
	jr $ra 				# retornar


printFloat:
	addi $sp, $sp, -4		# aumentamos el stack en 4 bytes
	sw $ra, 0($sp)			# guardamos el punto de retorno

	mfc1 $t0, $f12 			# transformamos el registro flotante f12 en 
							# un word y lo guardamos en t0

	addi $t3, $zero, 0xff800000	# -infinito
	addi $t4, $zero, 0x7f800000	# +infinito
	beq $t0, $t3, ret1 		# si t3 == t0 ir a ret1
	beq $t0, $t4 ret1 		# si t4 == t0 ir a ret1

	l.s $f11, fp1			# guardamos 10.0 en $f11
	add $s0, $zero, $zero	# inicializamos exponente en 0
	abs.s $f10, $f12		# $f10 = |$f12| valor absoluto
	c.lt.s $f11, $f10		# 10.0 < $f10 ? 
	bc1t normalizarHigh		# true
	l.s $f9, fp2			# guardamos 1.0 en $f11
	c.lt.s $f10, $f9		# 1.0 > $f10 ? 
	bc1t normalizarLow		# true

	ret1:
		li $v0, 2  			# 2 significa imprimir float guardado en f12
		syscall				# llamada al system

		la $a1, exponente   	# guardar direccion de exponente en $a1
		jal printStr 			# procedimiento para imprimir strings

		add $a0, $s0, $zero  	# se guarda s0 en a0
		jal printInt			# procedimiento para imprimir ints

		la $a1, saltoLinea   	# guardar direccion de saltoLinea en $a1
		jal printStr  			# procedimiento para imprimir strings

		lw $ra, 0($sp)			# restauramos el punto de retorno
		addi $sp, $sp, 4		# se reduce el stack en 4 bytes
		jr $ra 					# retorno

	normalizarHigh:
		addi $s0, $s0, 1	# exponente positivo
		div.s $f12, $f12, $f11 	# division de simple precision 
								# f12 = f12 / f11 
		abs.s $f10, $f12		# $f10 = |$f12| valor absoluto
		c.lt.s $f11, $f10 		# si f11 < f10 se asigna el flag 0 en 1
		bc1t normalizarHigh 	# si flag 0 en 1, saltar a normalizarHigh
		j ret1 					# saltar a ret1

	normalizarLow:
		addi $s0, $s0, -1	# exponente positivo
		mul.s $f12, $f12, $f11  # multiplicacion de simple precision 
								# f12 = f12 * f11 
		abs.s $f10, $f12		# $f10 = |$f12| valor absoluto
		c.lt.s $f10, $f9 		# si f10 < f9 se asigna el flag 0 en 1
		bc1t normalizarLow 		# si flag 0 en 1, saltar a normalizarLow
		j ret1 					# saltar a ret1


readStr:
	la $a0, buffer		# guardamos la direccion del buffer en $a0
	li $a1, SIZE		# definimos el tamaño del string a leer
	li $v0, 8			# guardamos entero 8 en $v0
	syscall				# llamada al sistema, 8 significa read string
	jr $ra 				# retorno


strToFloat: 
	la $t0, buffer 			# se guarda direccion de buffer en t0
	add $t1, $zero, $zero	# i = 0
	addi $t5, $zero, 8		# j = 9
	add $t4, $zero, $zero  	# en $t4 guardaremos el exponente

	addi $t6, $zero, 1  	# en $t6 guardamos 1, se setea en 0
							# cuando ya tenemos el exponente


	lbu $t2, 0($t0)   		# guardamos el signo del numero en $t2
	addi $v0, $t2, -48  	# al restar 48 estamos transformando un digito ascii
							# a un int, guardamos el signo int en $v0

	L1: 
		beq $t1, $t5, L2		# i == j 
		
		addi $t1, $t1, 1	# i = i + 1

		add $t2, $t0, $t1 	# t2 = t0 + t1

		lbu $t3, 0($t2)   	# guardamos el bit actual en $t3

		addi $t3, $t3, -48  # de ascii a int

		sll $t4, $t4, 1		# un shift left para hacer espacio para el siguiente

		add $t4, $t4, $t3 	# t4 = t4 + t3

		j L1 				# saltar a L1
	L2: 
		beq $t6, $zero, L3 	# si t6 == 0 saltar a L3

		add $t6, $zero, $zero # t6 = 0

		add $v1, $t4, $zero	# guardamos el exponente en $v1

		# mantisa

		add $t4, $zero, $zero 	# en $t4 guardaremos la mantisa

		add $t1, $zero, $zero	# i = 0
		addi $t5, $zero, 23		# j = 23

		addi $t0, $t0, 8 		# t0 += 8

		j L1 					# saltar a L1
	L3:
		add $s0, $t4, $zero	# guardamos la mantisa en $s0

		add $t7, $zero, $v0	# guardamos el signo en $t7
		sll $t7, $t7, 8		# hacemos espacio para el exponente
		add $t7, $t7, $v1	# juntamos el signo y el exponente
		sll $t7, $t7, 23 	# hacemos espacio para la mantisa
		add $t7, $t7, $s0	# agregmos la mantisa 

		sw $t7, 0($a2) 		# guardamos t7 en direcion de a2

		jr $ra 				# retorno


floatToStr:
	add $t0, $zero, $zero 	# t0 = 0
	la $t1, buffer 			# guardamos direccion de buffer en t1
	addiu $t2, $zero, 0x80000000	# mascara de 1 bit en pos. 31
	swc1 $f12, floatAny 	# guardamos en memoria floatAny el registro f12
	lw $t4, floatAny 		# guardamos en t4 el espacio de memoria floatAny 

	L4:
		beq $t0, 32, L5 	# si t0 == 32 saltar a L5
		and $t3, $t2, $t4 	# t3 = t2 & t4
		sne $t5, $t3, 0		# t5 = 1 si t3 != 0, sino 0
		addi $t5, $t5, 48	# convertirmos de bit a ascii
		sb $t5, 0($t1) 		# guardamos 1 byte t5 en espacio de memoria &t1
		addi $t0, $t0, 1 	# t0 += 1 (incrementamos contador)
		addi $t1, $t1, 1 	# t1 += 1 (hacemos avanzar el arreglo)
		srl $t2, $t2, 1 	# shift right de t2 en 1 espacio
		j L4 				# saltar a L4

	L5:
		sb $zero, 0($t1) 	# guardar byte de terminacion de string /0
		jr $ra 				# retornar


# print Signo Exponente Mantisa
printSEM:
	addi $sp, $sp, -4		# aumentamos el stack en 4 bytes
	sw $ra, 0($sp)			# guardamos el punto de retorno

	swc1 $f12, floatAny 	# guardar f12 en memoria
	lw $t0, floatAny 		# cargar en t0 espacio de memoria floatAny
	la $t1, floatAny 		# cargar direccion de floatAny en t1

	l.s $f11, fp3			# guardamos 0.0 en $f11
	c.lt.s $f12, $f11 		# si f12 < f11, setear flag 0

	bc1t mostrarMenos		# si flag 0 es 1, saltar a mostrarMenos

	la $a1, signoMas	   	# guardar direccion de signoMas en $a1
	jal printStr  			# procedimiento para imprimir strings

	la $a1, saltoLinea   	# guardar direccion de saltoLinea en $a1
	jal printStr 			# procedimiento para imprimir strings

	j 	Exponente 			# saltar a Exponente

	mostrarMenos: 
		la $a1, signoMen   	# guardar direccion de signoMen en $a1
		jal printStr 		# procedimiento para imprimir strings

		la $a1, saltoLinea  # guardar direccion de saltoLinea en $a1
		jal printStr 		# procedimiento para imprimir strings

	Exponente:
		addi $t2, $zero, 0x7f800000	# mascara de 8 bits en exponente
		and $t2, $t0, $t2 		# t2 = t0 & t2

		srl $t2, $t2, 23		# alineamos a la derecha el exponente

		addi $t2, $t2, -127 	# t2 -= 127

		la $a1, exponenteReal  	# guardar direccion de exponenteReal en $a1
		jal printStr 			# procedimiento para imprimir strings

		add $a0, $t2, $zero 	# a0 = t2
		jal printInt 			# procedimiento para imprimir strings

		la $a1, saltoLinea   	# guardar direccion de saltoLinea en $a1
		jal printStr 			# procedimiento para imprimir strings

		la $a1, mantisaDec  	# guardar direccion de mantisaDec en $a1
		jal printStr 			# procedimiento para imprimir strings

		addiu $t2, $zero, 0x807fffff	# mascara de 8 bits para borrar exponente
		and $t2, $t0, $t2 				# t2 = t0 & t2
		addi $t4, $zero, 127 	# t4 = 127
		sll $t4, $t4, 23		# alineamos a la izquierda el exponente 127
		or $t2, $t2, $t4		# t2 = t2 | t4
		sw $t2, floatAny 		# guardamos t2 en memoria
		l.s $f12, floatAny 		# obtenemos el float simple de memoria floatAny
		li $v0, 2 				# instruccion 2 para imprimir floats con syscall
		syscall					# llamada al sistema 

		la $a1, saltoLinea   	# guardar direccion de saltoLinea en $a1
		jal printStr 			# procedimiento para imprimir strings

		lw $ra, 0($sp)			# restauramos el punto de retorno
		addi $sp, $sp, 4		# se reduce el stack en 4 bytes
		jr $ra 					# retorno


printGRSOverUnder:
	addi $sp, $sp, -4		# aumentamos el stack en 4 bytes
	sw $ra, 0($sp)			# guardamos el punto de retorno

	mfc1 $t1, $f6 			# convertir f6 en un word y guardarlo en t1
	addiu $t0, $zero, 0x10000000	# mascara de 1 bit en pos. 28

	and $t2, $t1, $t0 		# t2 = t1 + t0
	slt $s0, $zero, $t2		# si $t2 es > 0 entonces guard bit = 1
	srl $t0, $t0, 1 		# t0 = t0 >> 1

	and $t2, $t1, $t0 		# t2 = t1 & t0
	slt $s1, $zero, $t2		# si $t2 es > 0 entonces round bit = 1

	addiu $t0, $zero, 0x7ffffff	# mascara de 1's desde posicion 26, 
								# basta un uno para que sticky sea 1

	and $t2, $t1, $t0
	slt $s2, $zero, $t2	# si $t2 es > 0 entonces sticky = 1

	la $a1, guardBit  	# guardar direccion de guardBit en $a1
	jal printStr  		# procedimiento para imprimir strings

	add $a0, $s0, $zero # a0 = s0
	jal printInt 		# procedimiento para imprimir strings

	la $a1, saltoLinea  # guardar direccion de saltoLinea en $a1
	jal printStr 		# procedimiento para imprimir strings

	la $a1, roundBit  	# guardar direccion de roundBit en $a1
	jal printStr

	add $a0, $s1, $zero # a0 = s1
	jal printInt 		# procedimiento para imprimir strings

	la $a1, saltoLinea  # guardar direccion de saltoLinea en $a1
	jal printStr 		# procedimiento para imprimir strings

	la $a1, stickyBit  	# guardar direccion de stickyBit en $a1
	jal printStr 		# procedimiento para imprimir strings

	add $a0, $s2, $zero # a0 = s2
	jal printInt 		# procedimiento para imprimir strings

	la $a1, saltoLinea  # guardar direccion de saltoLinea en $a1
	jal printStr 		# procedimiento para imprimir strings

	mfc1 $t1, $f7	 	# convertir f7 en un word y guardarlo en t1		
	addiu $t0, $zero, 0x7ff00000	# mascara de 1's en exponente (11 bits)

	and $t1, $t1, $t0		# t1 = t1 & t0
	srl $t1, $t1, 20		# se alinea a la derecha el exponente
	addi $t1, $t1, -1023	# se obtiene exponente real

	slti $s0, $t1, -126	# si $t1 es < 126 entonces underFlow

	la $a1, underFlow  	# guardar direccion de underFlow en $a1
	jal printStr 		# procedimiento para imprimir strings

	beq $zero, $s0, printN 	# si s0 == 0 saltar a printN

	la $a1, afirmar		# guardar direccion de afirmar en a1

	j continue 			# saltar a continue

	printN: 
		la $a1, negar 	# guardar direccion de negar en a1

	continue:

		jal printStr 			# procedimiento para imprimir strings
		la $a1, saltoLinea   	# guardar direccion de saltoLinea en $a1
		jal printStr			# procedimiento para imprimir strings

		slti $s0, $t1, 128		# si $t1 es < 128 entonces no es overFlow

		la $a1, overFlow  	# guardar direccion de overFlow en $a1
		jal printStr		# procedimiento para imprimir strings

		bne $zero, $s0, printN2 # si s0 == 0 saltar a printN2

		la $a1, afirmar 	# guardar direccion de afirmar en a1

		j continue2 	# saltar a continue2

		printN2:
			la $a1, negar 	# guardar direccion de negar en a1

		continue2:
			jal printStr 			# procedimiento para imprimir strings
			la $a1, saltoLinea   	# guardar direccion de saltoLinea en $a1
			jal printStr 			# procedimiento para imprimir strings

			lw $ra, 0($sp)			# restauramos el punto de retorno
			addi $sp, $sp, 4		# se reduce el stack en 4 bytes
			jr $ra 					# retornar


exit: 