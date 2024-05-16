    .data
msgQtn:     .asciiz "Quantos numeros?\n"
msgNum:     .asciiz "Informe o num.:\n"
fmtInt:     .asciiz "%d"

    .text
    .globl main

printa:
    # função printa
               
    li $v0, 4              
    la $a0, fmtInt      
    syscall

    move $a0, $a1       
    li $v0, 1           
    syscall

    jr $ra              

main:
    # declaração das variáveis
   
    li $t2, 0           

    # printf
    li $v0, 4           
    la $a0, msgQtn
    syscall

    # scanf
    li $v0, 5           
    syscall
    move $t0, $v0       

loop:
    # printf
    li $v0, 4           
    la $a0, msgNum      
    syscall

    # scanf
    li $v0, 5
    syscall
    move $t1, $v0       

    # printa
    move $a0, $t1       
    jal printa          

    # i++;
    addi $t2, $t2, 1

    # while 
    bge $t2, $t0, fimLoop 
    j loop  
                   
fimLoop:
    li $v0, 10          
    sysc
