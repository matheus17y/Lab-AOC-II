    .data
array: .word 34, 7, 23, 32, 15, 88, 26, 12, 29, 5   # vetor com 10 posições
min_msg: .asciiz "min="
max_msg: .asciiz "\nmax="

    .text
.globl main
main:
    la $a0, array          # Endereço base do vetor em $a0
    li $t0, 0               # Inicializa o índice i = 0
    lw $t1, 0($a0)          # Inicializa $t1 com o primeiro elemento do vetor (min = array[0])
    lw $t2, 0($a0)          # Inicializa $t2 com o primeiro elemento do vetor (max = array[0])
    li $t3, 10              # Tamanho do vetor

loop:
    sll $t4, $t0, 2         # Calcula o deslocamento do elemento atual do vetor
    add $t4, $t4, $a0       # Adiciona o deslocamento ao endereço base do vetor
    lw $t5, 0($t4)          # Carrega o elemento atual do vetor
    
    slt $t6, $t5, $t1       # Se o elemento atual for menor que o mínimo atual
    bne $t6, $zero, update_max # Pula se o elemento atual não for menor
    
    move $t1, $t5           # Atualiza o mínimo
    
update_max:
    slt $t6, $t2, $t5       # Se o elemento atual for maior que o máximo atual
    bne $t6, $zero, increment_index # Pula se o elemento atual não for maior
    
    move $t2, $t5           # Atualiza o máximo
    
increment_index:
    addi $t0, $t0, 1        # Incrementa o índice
    blt $t0, $t3, loop      # Se não chegou ao fim do vetor, continue o loop

    # Imprime os resultados
    li $v0, 4               # Código da syscall para imprimir string
    la $a0, min_msg         # Carrega o endereço da string "min="
    syscall

    li $v0, 1               # Código da syscall para imprimir inteiro
    move $a0, $t1           # Carrega o mínimo em $a0
    syscall

    li $v0, 4               # Código da syscall para imprimir string
    la $a0, max_msg         # Carrega o endereço da string "\nmax="
    syscall

    li $v0, 1               # Código da syscall para imprimir inteiro
    move $a0, $t2           # Carrega o máximo em $a0
    syscall

    li $v0, 10              # Encerra o programa
    syscall

