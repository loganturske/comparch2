# Write a program that will sum the values in the following array, and write out the answer.
# This program should output "The sum is 25"
# Note: the array is now null terminated.  Processs the array until a value of 0 is found..text
.globl main
.text

main:
	la $t0, arr		 # Load the address of arr

	lbu $t8, 0($t0)

begin_loop:
	beq $t8, $zero, exit_loop

	sll $t3, $t1, 2			# $t3 = 4 * i
	addu $t3, $t3, $t0		# 4i = 4i + memory location of array

	lw $t6, 0($t3)			# Put into $t6 where we are at in the array
	addu $s7, $s7, $t6 		# add what was loaded into $t6  to the running total
	addi $t1, $t1, 1		# iterate

	lbu $t8, 0($t3)			# Load what is at the address of arr
	j begin_loop

exit_loop:

	li $v0, 4		# get ready to print a string
	la $a0, strA	# address of string to print
	syscall			# print the string

	li $v0, 1		# get ready to print a int
	la $a0, ($s7)	# add total sum
	syscall			# print int

	li $v0, 10		# Sets $v0 to "10" to select exit syscall
	syscall 		# Exi

.data
strA: .asciiz "The sum is "
arr:
    .word 7
    .word 9
    .word 4
    .word 5
    .word 0