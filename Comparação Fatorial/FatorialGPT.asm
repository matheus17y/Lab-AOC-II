.data
prompt: .asciiz "%d\n"

.text
.globl main

# Função fatorial
fatorial:
    addi $sp, $sp, -8       # Cria espaço no stack para variáveis locais
    sw   $ra, 4($sp)        # Salva o registrador de retorno
    sw   $a0, 0($sp)        # Salva o argumento n

    li   $t0, 1             # Carrega 1 em $t0
    ble  $a0, $t0, base_case # Se n <= 1, vai para base_case

    addi $a0, $a0, -1       # n = n - 1
    jal  fatorial           # Chama fatorial(n-1)

    lw   $a0, 0($sp)        # Restaura o valor de n
    mul  $v0, $a0, $v0      # Multiplica n * fatorial(n-1)
    j    end_recursion      # Vai para end_recursion

base_case:
    li   $v0, 1             # Retorna 1

end_recursion:
    lw   $ra, 4($sp)        # Restaura o registrador de retorno
    addi $sp, $sp, 8        # Libera espaço no stack
    jr   $ra                # Retorna

# Função main
main:
    addi $sp, $sp, -8       # Cria espaço no stack para variáveis locais
    sw   $ra, 4($sp)        # Salva o registrador de retorno

    li   $a0, 10            # Carrega 10 em $a0
    jal  fatorial           # Chama fatorial(10)

    move $a0, $v0           # Move o resultado para $a0
    la   $a1, prompt        # Carrega o endereço de prompt em $a1
    li   $v0, 4             # Código do serviço para imprimir string
    syscall                 # Chama o serviço de sistema

    lw   $ra, 4($sp)        # Restaura o registrador de retorno
    addi $sp, $sp, 8        # Libera espaço no stack
    li   $v0, 10            # Código do serviço para encerrar o programa
    syscall                 # Chama o serviço de sistema
