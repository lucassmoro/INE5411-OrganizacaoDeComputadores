.data				#entrada de dados da decodificacao binario p 7segmentos conforme help do \Tools\Digital_Lab_Sim do MARS
	zero:	.word 63
	um:	.word 6
	dois:	.word 91
	tres:	.word 79
	quatro:	.word 102
	cinco:	.word 109
	seis:	.word 125
	sete:	.word 7
	oito:	.word 127
	nove:	.word 111
.text
	li	$t3,	0xFFFF0010	#carrega o endereco do display da direita em $t3
	li	$t1,	0		#inicializa $t1 com 0 p contador de 0 a 9
loop:
	jal	carrega_numero		#chama funcao pra carregar numero
	sw	$t0,	0($t3)		#na volta de jr $ra coloca o numero carregado em $t0 pra posicao 0 apontada por $t3
	addi	$t1,	$t1,	1	#incrementa contador
	bne	$t1,	10,	loop	#limite do contador, enquanto nao passou pela sequencia de 0 a 9, mantem executando loop
	j	end_loop		#vai para o fim da execucao
carrega_numero:				#essa funcao foi implementada quase como uma JAT (usual pra case switch) mas fora do segmento de dados
	beq	$t1,	0,	load_zero 	#baseado no valor do contador $t1, decide qual número carregar
	beq	$t1,	1,	load_um
	beq	$t1,	2,	load_dois
	beq	$t1,	3,	load_tres
	beq	$t1,	4,	load_quatro
	beq	$t1,	5,	load_cinco
	beq	$t1,	6,	load_seis
	beq	$t1,	7,	load_sete
	beq	$t1,	8,	load_oito
	beq	$t1,	9,	load_nove
	jr	$ra
					#alternativas de execucao vindos da Jump Address Table
load_zero:
	lw	$t0,	zero		#carrega valor que imprime zero no display
	jr	$ra			#volta pra rotina chamadora
load_um:
	lw	$t0,	um		#carrega valor que imprime 1 no display
    	jr	$ra			#volta pra rotina chamadora, e assim por diante...
load_dois:
	lw	$t0,	dois
	jr	$ra
load_tres:
	lw	$t0,	tres
	jr	$ra
load_quatro:
	lw	$t0,	quatro
	jr	$ra
load_cinco:
	lw	$t0,	cinco
	jr	$ra
load_seis:
	lw	$t0,	seis
	jr	$ra
load_sete:
	lw	$t0,	sete
	jr	$ra
load_oito:
	lw	$t0,	oito
	jr	$ra
load_nove:
	lw	$t0,	nove
	jr	$ra
end_loop:
	nop
