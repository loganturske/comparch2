# Write a program that will sum the values in the following array RECURSIVLY, and write out the answer.
# This program should output "The sum is 25"
# Note: the array is now null terminated.  Processs the array until a value of 0 is found..text
.globl main
.text

main:
	la $a0, arr 		# Load the address of arr
	la $a1, arrSize		# Load the size of arr

	jal sum

	li $v0, 4		# get ready to print a string
	la $a0, strA	# address of string to print
	syscall			# print the string

	li $v0, 1		# get ready to print a int
	la $a0, ($t1)	# add total sum
	syscall			# print int

	li $v0, 10		# Sets $v0 to "10" to select exit syscall
	syscall 		# Exi

sum:    addi $sp, $sp, -8       # Adjust sp
        addi $t0, $a0, -1       # Compute size - 1
        sw   $t0, 0($sp)        # Save size - 1 to stack
        sw   $ra, 4($sp)        # Save return address
        bne  $a0, $zero, ELSE   # branch ! ( size == 0 )
        li   $v0, 0             # Set return value to 0
        addi $sp, $sp, 8        # Adjust sp
        jr $ra                  # Return

ELSE:   move  $a1, $t0          # update second arg  
        jal   sum 
        lw    $t0, 0($sp)       # Restore size - 1 from stack
        li    $t7, 4            # t7 = 4 
        mult  $t0, t7           # Multiple size - 1 by 4 
        mflo  $t1               # Put result in t1 
        add   $t1, $t1, $a0     # Compute & arr[ size - 1 ]
        lw    $t2, 0($t1)       # t2 = arr[ size - 1 ]
        add   $v0, $v0, $t2     # retval = $v0 + arr[size - 1]
        lw    $ra, 4($sp)       # restore return address from stack         
        addi $sp, $sp, 8        # Adjust sp
        jr $ra                  # Return

.data
	strA: .asciiz "The sum is "
	arrSize: .word 4
	arr: 
		.word 7
		.word 9
		.word 4
		.word 5