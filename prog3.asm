# Write a program that will sum the values in the following array RECURSIVLY, and write out the answer.
# This program should output "The sum is 25"
# Note: the array is now null terminated.  Processs the array until a value of 0 is found..text
.globl main
.text

main:
	la $t0, arr		 # Load the address of arr
	lw $t1, iterator # Load the word of iterator
	lw $t2, arrSize  # Load the word of arrSize

    jal     sumrecurs1              # get recursive sum

exit:

	li $v0, 4		# get ready to print a string
	la $a0, strA	# address of string to print
	syscall			# print the string

	li $v0, 1		# get ready to print a int
	la $a0, ($s7)	# add total sum
	syscall			# print int


	li $v0, 10		# Sets $v0 to "10" to select exit syscall
	syscall 		# Exit


sumrecurs1:
    addi   $sp,$sp,-4	# Make room on stack
    sw      $ra,0($sp)	# Save return address

    blt     $t1,$t2,sumrecurs1_call # at the end? if no, fly
    j       exit


sumrecurs1_call:

    sll $t3, $t1, 2		# $t3 = 4 * i
	addu $t3, $t3, $t0	# 4i = 4i + memory location of array

	lw $t6, 0($t3)		# Put into $t6 where we are at in the array
	addu $s7, $s7, $t6 	# add what was loaded into $t6  to the running total
	addi    $t1,$t1,1		# bump up the index
    jal     sumrecurs1 		# recursive call
    jr $ra

.data
	strA: .asciiz "The sum is "
	strTest: .asciiz "Test\n"
	arrSize: .word 4
	iterator: .word 0
	arr: 
		.word 7
		.word 9
		.word 4
		.word 5