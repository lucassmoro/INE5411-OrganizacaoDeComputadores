.data				#define segmento de memoria de dados
	_b: .word 2		#valor inteiro a escolha para testar o codigo
	_d: .word 3		#valor inteiro a escolha para testar o codigo
	_e: .word 2		#valor inteiro a escolha para testar o codigo
	_c: .word 0		#zera valor de c
.text				#define inicio segmento de texto
.globl main			#define inicio do codigo
main:				#label (endereco simbolico) que define inicio do codigo
	lw	$s0, _b		#carrega da memoria de dados para registrador
	lw	$s1, _d		#carrega da memoria de dados para registrador		
	lw	$s2, _e		#carrega da memoria de dados para registrador
	addi	$t0, $s0, 0x23	#a=b+35, onde a=$t0,b=$s0 e 35 escrito em hexa  
	add	$t1, $t0, $s2	# t1 recebe a soma de a com e (a+e)
#iniciando valores.
	addi	$t2, $s1, 0	#t2 recebe d pra usar no decrementador
	addi	$t3,  $0, 0	#zera um temporario pra usar nas somas
loop_square:
	add	$t3, $t3, $s1	#t3 recebe d+d
	addi	$t2, $t2, -1	#decrementa t2
	bne	$t2, $0, loop_square #compara e se acumulador nao chegou no valor d, desvia pro loop de soma 
#inicio do segundo loop p d^3 com base em d^2
	addi	$t2, $s1, 0	#reinicia t2 com d p decrementador
	addi	$t4,  $0, 0	#inicia t4 p realizar as somas
loop_cube:
	add	$t4, $t4, $t3	#t4 = t4 + d^2
	addi	$t2, $t2, -1	#decrementa t2
	bne	$t2, $0, loop_cube #enquanto t2 != 0 continua no loop
#entrega de c
	sub	$s3, $t4, $t1
	sw	$s3, _c
