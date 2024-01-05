        .text
        .globl __start

__start:

            li $v0, 4
            la $a0, prompt_n #prints text to read n
            syscall

            li $v0, 5 #read n
            syscall
            move $t1, $v0

            bgt $t1, 12, overflow # because every factorial bigger than 12 is higher than 2147483647, the largest 32-bit number

            li $v0, 4
            la $a0, prompt_k #also prints text message to read k
            syscall 

            li $v0, 5 #read k
            syscall
            move $t2, $v0

            bgt $t2, 12, overflow #same goes with k

            lw $t3, nk
            sub $t3, $t1, $t2 # diafora n-k

            bge $t1, $t2, cond2 #cond1 n>=k

            li $v0, 4
            la $a0, prompt_nlessk # kanei print to prompt gia n<k
            syscall

            j exit #paei sto exit an den isxuei to prwto cond

    cond2: #k>=0

        bge $t2, 0, factorial_n #eisodos se sunarthseis

        j exit

factorial_n: 

        li $t4, 1 #set to factn = 1 gia enarkh epanalhpshs
        sw $t4, factn #timh paragontikou
        li $t0, 1 #deikths sto $t0 se kathe loop

    loop1:

        bgt $t0, $t1, factorial_k #elegxos deikth an einai megaluteros apo n

        lw $t4, factn
        mul $t4, $t4, $t0 #(n-1)*n
        sw $t4, factn
        addi $t0, $t0, 1 # i = i+1

        j loop1
        
factorial_k:

        li $t5, 1 #set to factk = 1 gia enarkh epanalhpshs
        sw $t5, factk 
        li $t0, 1 #mhdenismos deikth
        
    loop2:

        bgt $t0, $t2, factorial_nk

        lw $t5, factk
        mul $t5, $t5, $t0
        sw $t5, factk
        addi $t0, $t0, 1

        j loop2

factorial_nk:

        li $t6, 1 #set to factnk = 1 gia enarkh epanalhpshs
        sw $t6, factnk 
        li $t0, 1 #mhdenismos deikth

    loop3:

        bgt $t0, $t3, division

        lw $t6, factnk
        mul $t6, $t6, $t0
        sw $t6, factnk
        addi $t0, $t0, 1

        j loop3

division:

        lw $t4, factn
        lw $t5, factk
        lw $t6, factnk

        mul $t7, $t5, $t6 #k!(n-k)!

        div $t4, $t7 # n!/(k!(n-k)!)
        mflo $s1

        move $a0, $s1
        li $v0, 1
        syscall #ektupwsh sunduasmwn

        j exit #paei sto exit gia na kanei skip to overflow, alliws to deixnei

overflow:

        li $v0, 4
        la $a0, overflow_msg #print to mhnuma tou overflow, paei sto exit meta
        syscall

        j exit

exit:

        li $v0, 10
        syscall

.data
i:              .space 4
n:              .space 4
k:              .space 4
nk:             .space 4
factn:          .space 4
factk:          .space 4
factnk:         .space 4
prompt_n:       .asciiz "Enter number of objects in set: "
prompt_k:       .asciiz "Enter number to be chosen: "
prompt_nlessk:  .asciiz "Number n must be bigger or equal than k."
overflow_msg:   .asciiz "The biggest value of n or k is 12. Anything bigger than 12! cannot be stored in a 32-bit number."
