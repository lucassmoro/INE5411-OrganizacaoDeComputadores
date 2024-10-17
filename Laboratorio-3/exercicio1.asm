.data
    	estimativa: .double 1
    	n: .word 15
    	dois: .double 2.0
.text
    
    	li  $v0, 7	#leitura do numero flutuante 'x' via teclado
    	syscall 

    	lw  $t0, n           #carrega n (número de iterações) em $t0
    	ldc1 $f2, estimativa #carrega da memoria a estimativa inicial em $f2
    	ldc1 $f10, dois #carrega da memoria o valor 2 em $f10
    	
    	jal raiz_quadrada
    	j exit
    	
raiz_quadrada:
    	addi $t0, $t0, -1

    	# estimativa = (x/estimativa + estimativa) / 2
    	div.d $f6, $f0, $f2  #f6 = x / estimativa
    	add.d $f8, $f6, $f2  #f8 = x/estimativa + estimativa
    	div.d $f2, $f8, $f10  #f2 = f8 / 2 (nova estimativa)

    	bne $t0, $zero, raiz_quadrada  #verifica se $t0 igual a zero, senão volta pro começo do loop

    	# armazena a estimativa final em 'estimativa'
    	s.d $f2, estimativa
   
    	jr	$ra #retorna para a funcao chamadora (PC = PC + 4)
exit:
	mov.d $f12, $f2 
    	li $v0, 3
    	syscall
