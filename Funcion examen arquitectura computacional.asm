# Author: Eduardo Jeremías López Rizo
# Date: June 13, 2018
# Description: Matricial operations

.data
	
	R: .word 1 2 3			# Matriz R en Memoria
	V: .word 0 0 0			# Matriz V en Memoria
	M: .word 1 2 3 4 5 6 7 8 9	# Matriz M en Memoria
	# i = $t0 (en la función)
	# j = $t1 (en la función)
	
.text
	la $a1 R			# Cargamos los argumentos para la función
	la $a2 V
	la $a3 M
	
	jal funcion			# Llamamos a la función
	
	j Exit
	
# Función, Recibe como argumentos las direcciones de las matrices R, V, M y hace R[i] = R[i] + M[i][j] * V[j]
funcion:addi $t2, $zero, 12		# Guardando el número "3" para comparaciones
	addi $t7, $zero, 3		# guardando el número 3 para multiplicaciones
	addi $t0, $zero, -4		# i = -4, para comenzar el for.
for:	addi $t0, $t0, 4		# i++
	beq $t0, $t2, endF		# Primer for for(i=0, i < 3, i++)
	add $t1, $zero, $zero		# Poner en 0 el valor de j para volver a entar al segundo for.
E_for2:	beq $t1, $t2, for		# Segundo for for(j=0, j < 3, j++)
	
	addi $sp, $sp, -8
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	
	#add $t8, $t1, $zero
	mult $t1, $t7
	
	add $t0, $t0, $a1
	add $t1, $t1, $a1
	
	lw $t3, 0($t0)			# Cargando el valor de R[i]
	lw $t4, 12($t1)			# Cargando el valor de V[j]
	addi $t6, $t0, 24		# Cargando el valor de M[i][j]
	#add $t1, $t8, $zero
	mflo $t8
	add $t6, $t6, $t8
	lw $t5, 0($t6)			#
	
	#Aquí se hace la operación y se guarda en R
	
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	addi $sp, $sp, 8
	
	addi $t1, $t1, 4		# j++
	j E_for2			# Rebobinar el 2do for
	
endF:	jr $ra
	
Exit:
