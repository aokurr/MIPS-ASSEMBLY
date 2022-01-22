
.data
	mymessage: .asciiz "\nEnter the  number="
	myArray: .space 40
	myArray2: .space 40
	myArray3: .space 40
	message2: .asciiz"Entered numbers="
	virgul: .asciiz","
	new_line: .asciiz"\n"
	message6: .asciiz "}Array length="
	message3: .asciiz"\n longest array size="
	message_curly: .asciiz"{"
	message_curly2:.asciiz"}"
	message_main: .asciiz "THIS PROGRAM WILL EXECUTE 6 TIMES"
	message_execute_number: .asciiz "\nEXECUTE="	
.text


main:
	li $v0,4
	la $a0,message_main
	syscall
	
	addi $t6,$zero,6
	addi $t7,$zero,0
# 6 times execution loop
all_loop:
	beq $t6,$t7,exit6
	
	li $v0,4
	la $a0,message_execute_number
	syscall
	
	li $v0,1
	move $a0,$t7
	syscall
	
	addi $t0,$zero,0
	addi $t7,$t7,1
#array scanf loop
while:
	beq  $t0,40,exit
	li $v0,4
	la $a0,mymessage
	syscall
	
	li $v0,5
	syscall
	move $s1,$v0
	sb $s1,myArray($t0)
	addi $t0,$t0,4
	j while
	
exit:
	addi $t0,$zero,0
	addi $s1,$s1,0
	li $v0,4
	la $a0,message2
	syscall
#printing the sequence
while2:
	beq  $t0,40,exit2
	lb  $s1,myArray($t0)
	li $v0,1
	move $a0,$s1
	syscall
	
	li $v0,4
	la $a0,virgul
	syscall
	
	addi $t0,$t0,4
	
	j while2
exit2:
	li $v0,4
	la $a0,new_line
	syscall
	addi $t0,$zero,0 #i
	#s1 içine yüklenen sayi
	addi $s1,$zero,0

	addi $s2,$zero,0 #s2=count
	
	addi $s3,$zero,0 #s3=max
	
	addi $t5,$zero,0 #number long
	
	
###########################
#while 3,4,5 subsequance finding loops
while3:
	beq  $t0,40,exit5
	move $s4,$t0 #j=i
	
	j while4
while3_1:
	addi $t0,$t0,4
	######
	j while3


while4:
   
    beq  $s4,40,while3_1
    lb $s3,myArray($t0)
    move $s5,$s4 #s5=k
    addi $s5,$s5,4
    j while5
while4_1:
    sb $s3,myArray2($s2)
    jal print
    jal store_long_array
    addi $s2,$zero,0
    addi $s4,$s4,4
    j while4
 ####################################   
while5:
    beq  $s5,40,while4_1
    lb $s6,myArray($s5)
    slt $t1,$s3,$s6 # if s3<s6
    beq $t1,$zero,if_exit#if 
    sb  $s3,myArray2($s2)#array2[count]=max;
    addi $s2,$s2,4#count++;
    lb $s3,myArray($s5)#max=array[k];
    if_exit:
    addi $s5,$s5,4
    j while5
exit5:
	
	#en uzun arrayin boyutunu basar
	li $v0,4
	la $a0,message3
	syscall
	li $v0,1
	move $a0,$t5
	syscall
	jal print_long_array
	j all_loop
exit6:
	li $v0, 10
    syscall

# print all subsequence arrays 
print:
 	addi $t3,$zero,0
	addi $s2,$s2,4
	srl $t4,$s2,2
	li $v0,4
	la $a0,new_line
	syscall
	li $v0,4
	la $a0,message_curly
	syscall
	while_print:
	beq  $t3,$s2,exit_print
	lb  $s7,myArray2($t3)
	
	li $v0,1
	move $a0,$s7
	syscall
	
	li $v0,4
	la $a0,virgul
	syscall
	
	addi $t3,$t3,4
	j while_print
	exit_print:
	li $v0,4
	la $a0,message6
	syscall
   
   #print length
	li $v0,1
	move $a0,$t4
	syscall
	jr $ra

#sotere long array in array3 func
store_long_array:
	#countun 4 e bölümü
	srl $t4,$s2,2
	addi $t3,$zero,0	
	
	#en uzun arrayin boyutu hesaplanýr
	slt $t1,$t5,$t4 # if t5<t4
	
	beq $t1,$zero,store_l_exit
	move $t5,$t4
	
	while_store:
	beq $t3,$s2,store_l_exit
	lb $s7,myArray2($t3)
	sb $s7,myArray3($t3)
	addi $t3,$t3,4
	j while_store
	store_l_exit:
	jr $ra

#print longest array func
print_long_array:
	addi $t3,$zero,0
	 
	li $v0,4
	la $a0,new_line
	syscall
    sll $s2,$t5,2
    
    li $v0,4
	la $a0,message_curly
	syscall
	
	while_print2:
	beq  $t3,$s2,exit_print2
	lb  $s7,myArray3($t3)
	
	li $v0,1
	move $a0,$s7
	syscall
	
	li $v0,4
	la $a0,virgul
	syscall	
	
	addi $t3,$t3,4
	
	j while_print2
	exit_print2:
	li $v0,4
	la $a0,message_curly2
	syscall
	jr $ra
	
	
	
	
	


	
	
