# s1113341
.data
strID: .string "s1113341\n"
strM: .string "input number M = "
strN: .string "input numner N = "
strP: .string "P(M, N) = "
strC: .string "C(M, N) = "
strH: .string "H(M, N) = "
strPow: .string "M^N = "
strLine: .string "\n"
strError: .string "No output"
strAll1: .string "output = 1 (for all)"

.text
main:
	jal	printID # print "s1113341"
	jal 	printMsgM # print "input number M = "
	jal	input # input M, return a0
	mv 	s0, a0 # a0 = M, s0 = a0, so s0 = M
	
	jal	printMsgN # print "input number N = "
	jal 	input # input N, return a0
	mv	s1, a0 # a0 =N, s1 = a0, so s1 = N
	
	mv	a0, s0 # s0 is M, move it to a0
	jal 	factoria # find M!, return a0
	mv	s2, a0 # a0 = M!, s2 = a0, so s2 = M!
	
	mv	a0, s1 # s1 is N, move it to a0
	jal	factoria #find N!, return a0
	mv	s3, a0 #  a0 = N!, s3 = 0, so  s3 = N!
	
	sub	t1, s0, s1 # t1 = s0 - s1 => t1 = M - N

	mv	a0, t1 # t1 = M - N, move it to a0
	jal	factoria # find (M-N)!, return a0
	mv	s4, a0 #s4 = (M-N)!
	
	add	t1, s0, s1 # t1 = s0 + s1 => t1 = M + N
	addi	t1, t1, -1 # t1 = t1 - 1 => t1 = M + N - 1
	mv	a0, t1 # t1 = M + N - 1, move it to a0
	jal	factoria # find (M+N-1)!, return a0
	mv	s5, a0 # s5 = (M+N-1)!
	
	jal 	printResultP # print P(M, N)
	jal 	changeLine # print "\n"
	
	jal	printResultC # print C(M, N)
	jal	changeLine # print "\n"
	
	jal	printResultH # print H(M, N)
	jal	changeLine # print "\n"
	
	jal 	power # find M^N, return a0
	mv	s6, a0 # s6 = M^N
	jal	printPower # print M^N
	
	j end # end of the program

changeLine:
	la 	a0, strLine # print "\n"
	li	a7, 4
	ecall
	ret
	
printID:
	la	a0, strID # print "s1113341"
	li	a7, 4
	ecall
	ret
	
printMsgM:
	la	a0, strM # print "input number M = "
	li	a7, 4
	ecall
	ret
	
printMsgN:
	la	a0, strN # print "input number N = "
	li	a7, 4
	ecall
	ret 
	
input:
	li 	a7, 5 # input and read an integer
	ecall
	ret 
	
factoria:
	li 	t0, 1 # t0 = 1
	mv 	t1, a0 # t1 = a0
	mv	a0, t0 # a0 = t0 = 1
loop: # for (i = t1; i > 1; i--), t1 is the number to find the factoria
	bge 	t0, t1, endFactoria # if t0 >= t1, end the loop => if i <= 1, end the loop
	mul 	a0, a0, t1 # a0 *= t1 => a0 *= i
	addi 	t1, t1, -1 # t1-- => i--
	jal 	x0, loop # recursive call
endFactoria:
	jr 	ra  # return to the caller

printResultP:
	la	a0, strP # move "P(M, N) = " to a0
	li	a7, 4 # print "P(M, N) = "
	ecall # system call
	
	li 	t1, 13 # t1 = 13
	mv	a0, s0 # a0 = M
	blez	s0, noOutput # if M <= 0, no output
	bltz	s1, noOutput # if N < 0, no output
	beqz	s1, output1 # if N == 0, output is 1
	blt	s0, s1, noOutput # if M < N, no output
	bge	s0, t1, noOutput # if M >= 13, no output
	
	div	t1, s2, s4 # t1 = M! / (M-N)!
	mv	a0, t1 # a0 = t1
	
	li	a7, 1 # print the result, a0
	ecall
	ret # return to the caller
	
printResultC: # print C(M, N)
	la	a0, strC # move "C(M, N) = " to a0
	li	a7, 4 # print "C(M, N) = "
	ecall # system call
	
	li 	t1, 13 # t1 = 13
	mv	a0, s0 # a0 = M
	blez	s0, noOutput # if M <= 0, no output
	bltz	s1, noOutput # if N < 0, no output
	beqz	s1, output1 # if N == 0, output is 1
	beq	s0, s1, output1 # if M == N, output is 1
	blt	s0, s1, noOutput # if M < N, no output
	bge	s0, t1, noOutput # if M >= 13, no output
	
	mul	t1, s3, s4 # t1 = N! * (M-N)!
	div	t1, s2, t1 # t1 = M! / (N! * (M-N)!)
	
	mv	a0, t1 # a0 = t1
	li	a7, 1 # print the result, a0
	ecall 
	ret
	
printResultH:
	la 	a0, strH # move "H(M, N) = " to a0
	li 	a7, 4 # print "H(M, N) = "
	ecall
	
	li 	t1, 13 # t1 = 13
	blez	s0, noOutput # if M <= 0, no output
	bltz	s1, noOutput # if N < 0, no output
	beqz	s1, output1 # if N == 0, output must 1
	bge	s0, t1, noOutput # if M >= 13, no output
	
	mul 	t0, s0, s5 # t0 = M * (M + N - 1)
	mul	t1, s2, s3 # t1 = M! * N!
	div	t2, t0, t1 # t2 = M * (M + N - 1) / (M! * N!)
	mv	a0, t2 # a0 = t2
	li	a7, 1 # print the result, a0
	ecall
	ret

power:
	li	t0, 1 # t0 = 1
	mv	a0, s0 # a0 = M
loopP: # for  (i(t0) = 0; i < N; i++)
	bge	t0, s1, endPower # if t0 >= N, end the loop
	mul	a0, a0, s0 # a0 *= M
	addi 	t0, t0, 1 # t0++ => i++
	jal	x0, loopP # recursive call
endPower:
	jr	ra # return to the caller
	
printPower:
	la	a0, strPow # move "M^N = " to a0
	li	a7, 4 # print "M^N = "
	ecall # system call
	bltz	s0, noOutput # if M < 0, no output
	bltz	s1, noOutput # if N < 0, no output
	or 	t0, s0, s1 # t0 = M | N, if t0 == 0, M == 0 and N == 0
	beqz 	t0, noOutput # if M == 0 and N == 0, no output
	beqz	s1, output1 # if N == 0 and M >0 0, output must 1
	mv	a0, s6 # a0 = M^N
	li	a7, 1 # print the result, a0
	ecall
	ret
	
noOutput:
	la	a0, strError # move "No output" to a0
	li	a7, 4 # print "No output"
	ecall
	jr	ra # return to the caller
	
output1:
	li 	a0, 1 # let a0 = 1
	li	a7, 1 # print the result, a0
	ecall
	jr	ra # return to the caller
end:
	li	a7, 10 # end the program
	ecall
