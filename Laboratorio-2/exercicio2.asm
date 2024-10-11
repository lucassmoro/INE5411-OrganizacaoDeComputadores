				#lembrar de rodar com Run speed de umas 10 instr/sec pra não travar o MARS
.data				#entrada de dados da decodificacao binario p 7segmentos conforme help do \Tools\Digital_Lab_Sim do MARS
	zero:	.byte	63	#note nessa segunda versao decidimos mudar tudo p byte
	um:	.byte	6
	dois:	.byte	91
	tres:	.byte	79
	quatro:	.byte	102
	cinco:	.byte	109
	seis:	.byte	125
	sete:	.byte	7
	oito:	.byte	127
	nove:	.byte	111
	_a:	.byte	119
	_b:	.byte	124
	_c:	.byte	57
	_d:	.byte	94
	_e:	.byte	121
	_f:	.byte	113
.text
.globl main
main:
	li	$s0,	0xFFFF0010	#endereco do display de 7 segmentos
	li	$s2,	0xFFFF0012	#endereco teclado
	li	$s1,	0xFFFF0014	#endereco do codigo da tecla pressionada
	li	$t3,	-1		# inicializa $t3 com valor invalido
loop:
	li	$t0,	0x01		#seleciona linha 1
	sb	$t0,	0($s2)		#escreve em $s2 para selecionar a linha
	lbu	$t1,	0($s1)		#carrega tecla pressionada da linha 1
	bne	$t1,	$zero,	processa_tecla

	li	$t0,	0x02		#seleciona linha 2
	sb	$t0,	0($s2)
	lbu	$t1,	0($s1)
	bne	$t1,	$zero,	processa_tecla

	li	$t0,	0x04		#seleciona linha 3
	sb	$t0,	0($s2)
	lbu	$t1,	0($s1)
	bne	$t1,	$zero,	processa_tecla

	li	$t0,	0x08		#seleciona linha 4
	sb	$t0,	0($s2)
	lbu	$t1,	0($s1)
	bne	$t1,	$zero,	processa_tecla
	j	loop			# Repete o loop
processa_tecla:
	beq	$t1,	$t3,	loop
	move	$t3,	$t1			#tecla atual eh a ultima pressionada
 	li	$t2,	0			#inicializa $t2 com 0
	beq	$t1,	0x11,	load_zero	#tecla 0
	beq	$t1,	0x21,	load_um		#tecla 1
	beq	$t1,	0x41,	load_dois	#e assim por diante...
	beq	$t1,	0x81,	load_tres
	beq	$t1,	0x12,	load_quatro
	beq	$t1,	0x22,	load_cinco
	beq	$t1,	0x42,	load_seis
	beq	$t1,	0x82,	load_sete
	beq	$t1,	0x14,	load_oito
	beq	$t1,	0x24,	load_nove
	beq	$t1,	0x44,	load_a
	beq	$t1,	0x84,	load_b
	beq	$t1,	0x18,	load_c
	beq	$t1,	0x28,	load_d
	beq	$t1,	0x48,	load_e
	beq	$t1,	0x88,	load_f
	j	loop

load_zero:			#alternativas de execucao
	lb	$t2,	zero
	j	atualiza_display
load_um:
	lb	$t2,	um
	j	atualiza_display
load_dois:
	lb	$t2,	dois
	j	atualiza_display
load_tres:
	lb	$t2,	tres
	j	atualiza_display
load_quatro:
	lb	$t2,	quatro
	j	atualiza_display
load_cinco:
	lb	$t2,	cinco
	j	atualiza_display
load_seis:
	lb	$t2,	seis
	j	atualiza_display
load_sete:
	lb	$t2,	sete
	j	atualiza_display
load_oito:
	lb	$t2,	oito
	j	atualiza_display
load_nove:
	lb	$t2,	nove
	j	atualiza_display
load_a:
	lb	$t2,	_a
	j	atualiza_display
load_b:
	lb	$t2,	_b
	j	atualiza_display
load_c:
	lb	$t2,	_c
	j	atualiza_display
load_d:
	lb	$t2,	_d
	j	atualiza_display
load_e:
	lb	$t2,	_e
	j	atualiza_display
load_f:
	lb	$t2,	_f
	j	atualiza_display

atualiza_display:
	sb	$t2,	0($s0)	#atualiza display de 7 segmentos
	j	loop
