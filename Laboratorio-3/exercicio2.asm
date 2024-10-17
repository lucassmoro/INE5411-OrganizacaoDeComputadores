.data
	n: .double 0
	um: .double 1
	dois: .double 2.0
	menosUm: .double -1.0
	resultado: .double 0
.text
	li $v0, 7
	syscall #$f0 agora contém o valor digitado pelo usuário
	ldc1 $f2, n
	ldc1 $f4, menosUm
	ldc1 $f6, dois
	ldc1 $f8, um	
	ldc1 $f30, resultado
seno:

	#calcula -1^n
	mov.d $f12, $f4
	mov.d $f14, $f2
	jal potenciacao
	mov.d $f20, $f12 #armazena -1^n em $f20
	
													
	
	#calcula (2n + 1)!
	mul.d $f10, $f6, $f2
	add.d $f18, $f10, $f8 #2n + 1
	mov.d $f24, $f18 #movemos pra $f24 pois iremos alterar $f18
	mov.d $f12, $f18
	jal fatorial #(2n+1)! armazenado em f18
	
	div.d $f22, $f20, $f18 # fazemos -1^n/(2n + 1)! e armazenamos em $f22
	#multiplica o resultado por x^(2n+1)
	mov.d $f14, $f24 #passamos 2n + 1 como expoente
	mov.d $f12, $f0 #passamos o valor digitado pelo usuario via teclado como base
	jal potenciacao #guardamos o resultado em $f12
	
	mul.d $f28, $f12, $f22 #ARMAZENAMOS O RESULTADO EM $f28
	add.d $f30, $f30, $f28 #INCREMENTA O RESULTADO FINAL EM $f30
	
	cvt.w.d $f2, $f2 #pegamos o n e transformamos em inteiro
	mfc1 $t0, $f2 #pegamos n e passamos para $t0
	beq $t0, 3, exit #comparamos $t0 com 20, se for igual finaliza, senao acresenta 1 e volta pro comeco do procedimento
	add.d $f2, $f2, $f8
	j seno

potenciacao:
	cvt.w.d $f14, $f14 #transformamos o arg $f14 (expoente) para inteiro
    	mfc1 $t3, $f14 #passo o expoente para inteiro para contar quantidade de multiplicação	
    	mov.d $f16, $f12 #guarda o arg em f16
    	beq $t3, 1, fim_potenciacao #verifica se o expoente = 1, se for, o resultado é a propria base
    	bne $t3, $zero, potenciacao_loop #se o expoente for diferente de 0 ele vai pro loop
    	mov.d $f16, $f8 # se o expoente for zero passamos $f8 (que é igual a 0) para $f16
    	j fim_potenciacao #vamos para o fim da potenciacao
potenciacao_loop:
    	mul.d $f16, $f16, $f12 # multiplico o arg por ele mesmo e guardo em $f16	
    	addi $t3, $t3, -1 # decrementa
    	ble $t3, 1, fim_potenciacao
    	j potenciacao_loop # explicitando mesmo que ele naturalmente ja fosse pro procedimento
fim_potenciacao:
	mov.d $f12, $f16 #passamos o valor de f16 de volta pro arg
	jr $ra   #retorna ao endereco chamador
fatorial:
	cvt.w.d $f12, $f12 #f12 pra inteiro
	mfc1 $t3, $f12 #f12 pro reg t3
	bne $t3, $zero, fatorial_loop #se t3=0 entao 0! = 1, senao vai pro loop
	mov.d $f12, $f8
fatorial_loop:
	addi $t3, $t3, -1          # Decrementa o contador ($t3 = $t3 - 1)
    	beq $t3, $zero, fatorial_fim  # Se $t3 chegar a zero, finaliza o loop
	mtc1 $t3, $f12 
    	cvt.d.w $f12, $f12         # Converte $t3 de volta para ponto flutuante ($f12 = $t3)
    	mul.d $f18, $f18, $f12     # Multiplica $f18 pelo valor atual de $f12
    	j fatorial_loop            # Repete o loop
fatorial_fim:
	jr $ra
exit:
