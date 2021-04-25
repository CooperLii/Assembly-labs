########################################################
# This procedure takes a binary byte and prints a hexadecimal character.
#
# The call to syscall has the following parameters:
#   $a0: thing to be printed
#   $v0: Mode
#       1=integer
#       4=null-terminated string
########################################################
	.data
header: .asciiz  "Print byte: 0x"		
table:  .asciiz  "0123456789ABCDEF"		
char:	.byte	 0,0
number: .byte  	 0x4b				
	.text
	.globl main
main:	
	addi	$sp, $sp, -4	
	sw	$ra, 0($sp)
	
				
							
													
	li 	$v0,4			# printString("Print byte: 0x"
	la	$a0,header
	syscall
#					
	lb	$s2,number		# index = number >> 4 & 0xf			
	srl	$s4,$s2,4	
	andi	$s4,$s4,0xf		# index = number & 0xf   
	
	
	
	la	$a0, ($s4)		#parameter for function (index)	
	sw	$a0, -4($sp)
	jal	PrtNbl			######################
	
	
	andi	$s4,$s2,0xf		# index = number & 0xf
 	la	$a0, ($s4)		#parameter for function (index)
	
	
	sw	$a0, -4($sp)
	jal 	PrtNbl			#############
	
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4

#					 
	li	$v0,10			# exit
	syscall
#########################################################################
#PrintNibble(Nibble): This procedure prints a nibble
#Register convention: (how register are used)
#Calling sequence:	lw	$a0,nibble
#			sw	$a0,-4($sp)
#			jal	PrtNbl
#Stack usage:		4($sp) = binary nibble
#			0($sp) = return address
#########################################################################
PrtNbl:
	addi	$sp, $sp, -8
	sw	$ra, 0($sp)
	lw	$s0, 4($sp)
	
						

	lw	$t0, 4($sp)
	la	$t5,table		# entry = table[index]
	add	$t5,$t5,$t0
	lb	$t3,0($t5)
	sb	$t3,char		# char = entry
					
	li	$v0,4			# printString(char)
	la	$a0,char
	syscall
	
	
	lw	$ra, 0($sp)
	addi	$sp, $sp, 8
	jr	$ra
	
	
