.data 
	mensagemI: .asciiz "Qual numero voce deseja calcular o fatorial ?"
	mensagemR: .ascii "\n O fatorial e"
	numero: .word 0 
	resp: .word 0
	
.text
	.globl main
	main:
		#Ler o número do usúario 
		li $v0, 4
		la $a0, mensagemI
		syscall 
		
		li $v0, 5
		syscall
		
		sw $v0, numero 
		
		#chamada da função fatorial 
		lw $a0, numero 
		jal fatorial 
		sw $v0, resp 
		
		#mostra o resultado 
		li $v0, 4
		la $a0, mensagemR
		syscall
		
		li $v0, 1
		lw $a0, resp
		syscall
		
		#fim do programa 
		li $v0, 10 
		syscall
		
	#função fatorial
	.globl fatorial 
	fatorial: 
		subu $sp, $sp, 8
		sw $ra, ($sp)
		sw $s0, 4($sp)
		
		#caso base 
		li $v0, 1
		beq $a0, 0, saiFatorial
		
		#logica (numero-1)
		move $s0, $a0
		sub $a0, $s0, 1 
		jal fatorial 
		
		mul $v0, $s0, $v0
		
		saiFatorial:
			lw $ra, ($sp)
			lw $s0, 4($sp)
			addu $sp, $sp, 8
			
			jr $ra
		