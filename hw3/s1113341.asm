.data
buffer: .space 100  
bufferx: .space 100
buffery: .space 100
lengthx: .space 100
lengthy: .space 100
outbuffer: .space 1024
sID: .string "s1113341"
endl: .string "\n"
inputfile: .string "Please enter the input file name = "
outputfile: .string "The output file name of result = "
#ilein: .string "1.txt"
fin: .space 100
infname: .space 100
fout: .string "s1113341_output.txt"
fail: .string "File open fail"
space: .string " "

.text
.globl _start
main:
    jal printID
    jal printNewline 
    jal input
    jal output
    jal printOut
    jal End

printID:
    la a0, sID
    li a7, 4
    ecall
    ret

printNewline:
    la a0, endl
    li a7, 4
    ecall
    ret

input:
    la a0, inputfile
    li a7, 4
    ecall
    
    la a0, fin   
    li a1, 100  
    li a7, 8   #  sys_read, read from console
    ecall

    la t0, fin
    la t2, infname
    li s0, '\n'
    jal x0, delete_end_line_loop

output:    
    # Open (for writing) a file that does not exist
	li   a7, 1024     # system call for open file
	la   a0, fout     # output file name
	li   a1, 1        # Open for writing (flags are 0: read, 1: write)
	ecall             # open a file (file descriptor returned in a0)
	mv   s6, a0       # save the file descriptor
  
	# Write to file just opened
	li   a7, 64       # system call for write to file
	mv   a0, s6       # file descriptor
	la   a1, outbuffer   # address of buffer from which to write
	li   a2, 1024       # hardcoded buffer length
	ecall             # write to file

	# Close the file
	li   a7, 57       # system call for close file
	mv   a0, s6       # file descriptor to close
	ecall             # close file
    ret

printOut:
    la a0, outputfile
    li a7, 4
    ecall
    la a0, fout
    li a7, 4
    ecall
    ret

delete_end_line_loop:
    lbu t1, 0(t0)
    beq t1, s0, _start
    sb t1, 0(t2)

    addi t0, t0, 1
    addi t2, t2, 1
    jal x0, delete_end_line_loop

_start:
    # open file
    la a0, infname
    li a1, 0    # read_only
    li a7, 1024 
    ecall       

    # check if file is opened successfully
    li t0, -1
    bne a0, t0, open_success

    # exit if file is not opened successfully
    la a0, fail
    li a7, 4
    ecall
    jal x0, End      

open_success:
    # read file
    mv a0, a0   
    la a1, buffer   
    li a2, 100  
    li a7, 63   # sys_read
    ecall       

    # print the content of the file
    la t0, buffer   # t0 is the pointer to the buffer
    li t1, 0        # t1 is the index of the buffer
    la t2, bufferx
    la t4, buffery
    
print_loop:
    lbu t3, 0(t0)   # load a character from the buffer
    beqz t3, print_done # if the character is null, print_done 
    
    mv a0,t3
    addi a0,a0,-48

    beq t1, zero, skip_print_char # skip the first character, which is the number of points
   
    li t6, 2
    rem t6, t1, t6
    beqz t6, sumY
sumX:
    sb a0, 0(t2)
    add a3, a3, a0 #sum of x
    addi t2, t2, 1
    jal x0, skip_print_char
sumY:
    sb a0, 0(t4)
    add a4, a4, a0 #sum of y
    addi t4, t4, 1

skip_print_char:
    # continue to the next character
    addi t0, t0, 2      # move to the next character
    addi t1, t1, 1      # increment the index
    jal x0, print_loop

print_done:
    # close the file
    mv a0, a0   
    li a7, 57   # sys_close
    ecall       

    la t0, buffer
    lbu t5, 0(t0)
    addi t5, t5, -48 # t5 = number of points
      
    # (a5, a6) = (sum of x, sum of y) / number of points = center of gravity
    div a5, a3, t5
    div a6, a4, t5
    
     # *10 
    li s0, 10
    mul a3,a3,s0
    mul a4,a4,s0

    div s1, a3, t5
    div s2, a4, t5
    # rounding
    rem s1, s1, s0
    rem s2, s2, s0
    li s0, 5
    bge s1,s0,xadd1

yaddornot:
    bge s2,s0,yadd1

continus:    
    la t2, bufferx
    la t4, buffery
    li s4, 0	# the difference of x and center of gravity
    li s5, 0	# the difference of y and center of gravity
    
    lbu s6, 0(t2)   # record the max x
    lbu s7, 0(t2)   # record the min x
    lbu s8, 0(t4)   # record the max y
    lbu s9, 0(t4)   # record the min y
    
    li s11, 0	# counter
    
length_loop:
    lbu t3, 0(t2)   # read character from buffer x
    lbu s3, 0(t4)   # read character from buffer y
    beq s11,t5, length_done  

    sub s0, a5, t3
    sub s1, a6, s3
    
    blt s0, zero, xmul_1
y_mul_or_not:
    blt s1, zero, ymul_1

add_x_and_y:
    add s4, s4, s0
    add s5, s5, s1

    bge t3, s6, switch_max_x
minx:
    bge s7, t3, switch_min_x
maxy:
    bge s3, s8, switch_max_y
miny:
    bge s9, s3, switch_min_y

next_number:
    # move to the next character
    addi t2, t2, 1      # move to the next character
    addi t4, t4, 1      # move to the next character
    addi s11, s11, 1
    jal x0, length_loop

length_done:
    # calculate the total distance between the center of gravity and the point
    li s11, 0
    sub s11, s8, s9
    add s4, s4, s11	# s4 = the length of tree for x
    li s11, 0
    sub s11, s6, s7
    add s5, s5, s11	# s5 = the length of tree for y
    
    blt s4, s5, mainx	# axis for x
    bge s4, s5, mainy	# axis for y

xadd1:
    addi a5, a5, 1
    jal x0, yaddornot  
          
yadd1:
    addi a6, a6, 1
    jal x0, continus  
    
xmul_1:     
    li s10, -1
    mul s0, s0, s10
    jal x0, y_mul_or_not
ymul_1:   
    li s10, -1
    mul s1, s1, s10
    jal x0, add_x_and_y   
    
switch_max_x:
    mv s6, t3
    jal x0, minx
switch_min_x:
    mv s7, t3
    jal x0, maxy
switch_max_y:
    mv s8, s3
    jal x0, miny
switch_min_y:   
    mv s9, s3
    jal x0, next_number       

mainx:
    la t2, bufferx
    la t4, buffery
    la t6, outbuffer
    li s11, 0
    
store_ans_loop_x:########################
    lbu t3, 0(t2)   # read character from buffer x
    lbu s3, 0(t4)   # read character from buffer y
    bge s11,t5, final_line_x  

    li s10, ','
    beq t3, a5, next_point_x
    addi a0, a5, 48
    sw a0, 0(t6)    # center of gravity x
    sw s10, 4(t6)   # , 
    addi a0, s3, 48
    sw a0, 8(t6)    # center of gravity y
    sw s10, 12(t6)   # ,
    addi a0, t3, 48
    sw a0, 16(t6)    # point x
    sw s10, 20(t6)   # ,
    addi a0, s3, 48
    sw a0, 24(t6)    # point y
    
    li s10, 10
    sb s10, 28(t6)   # \n
    
    addi t6, t6, 32

next_point_x:
    # move to the next character
    addi t2, t2, 1      # move to the next character
    addi t4, t4, 1      # move to the next character
    addi s11, s11, 1	# increment the counter
    jal x0, store_ans_loop_x
final_line_x:
    addi a0, a5, 48
    sw a0, 0(t6)    # center of gravity x
    sw s10, 4(t6)   # , 
    addi a0, s8, 48
    sw a0, 8(t6)    # max y
    sw s10, 12(t6)   # ,
    addi a0, a5, 48
    sw a0, 16(t6)    # center of gravity x
    sw s10, 20(t6)   # ,
    addi a0, s9, 48
    sw a0, 24(t6)    #min y
    jal x0, output
    
mainy:
    la t2, bufferx
    la t4, buffery
    la t6, outbuffer
    li s11, 0
    
store_ans_loop_y:
    lbu t3, 0(t2)   # read character from buffer x
    lbu s3, 0(t4)   # read character from buffer y
    bge s11,t5, final_line_y  

    li s10, ','	# , 
    beq s3, a6, next_point_y
    addi a0, t3, 48
    sw a0, 0(t6)    # x
    sw s10, 4(t6)   # , 
    addi a0, a6, 48
    sw a0, 8(t6)    # center of gravity y
    sw s10, 12(t6)   # ,
    addi a0, t3, 48
    sw a0, 16(t6)    # x
    sw s10, 20(t6)   # ,
    addi a0, s3, 48
    sw a0, 24(t6)    # y
    
    li s10, 10
    sw s10, 28(t6)   # \n
    
    addi t6, t6, 32

next_point_y:
    # move to the next character
    addi t2, t2, 1      
    addi t4, t4, 1      
    addi s11, s11, 1
    jal x0, store_ans_loop_y
final_line_y:
    li s10, ','
    addi a0, s6, 48
    sw a0, 0(t6)    # max x
    sw s10, 4(t6)   # , 
    addi a0, a6, 48
    sw a0, 8(t6)    # center of gravity y
    sw s10, 12(t6)   # ,
    addi a0, s7, 48
    sw a0, 16(t6)    # min x
    sw s10, 20(t6)   # ,
    addi a0, a6, 48
    sw a0, 24(t6)    # center of gravity y
    jal x0, output
End:
	li a7, 10			
	ecall
