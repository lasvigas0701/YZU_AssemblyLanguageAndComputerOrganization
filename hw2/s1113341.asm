#s1113341
.data
sID: .string "s1113341\n"
strLast1: .string "Please enter the strokes of the first character of the last name (if the last name only contains 1 character, please enter 0) ="
strLast2: .string "Please enter the strokes of the second character of the last name ="
strFirst1: .string "Please enter the strokes of the first character of the first name ="
strFirst2: .string "Please enter the strokes of the second character of the first name (if the first name only contains 1 character, please enter 0) ="
wood: .string " Wood "
fire: .string " Fire "
earth: .string " Earth "
metal: .string " Metal "
water: .string " Water "
sky: .string "Sky"
people: .string "People"
land: .string "Land"
outside: .string "Outside"
total: .string "Total"
generate: .string " generate "
restaint: .string " restaint "
equal: .string " equal "
symbol: .string " = "
newline: .string "\n"

.text
main:
    jal printID
    jal printLast1 # print "please enter the strokes of the first character of the last name"
    jal input
    mv t0, a0 # t0 is the strokes of the first character of last name
    jal printLast2 # print "please enter the strokes of the second character of last name"
    jal input
    mv t1, a0 # t1 is the strokes of the second character of last name
    jal printFirst1 # print "please enter the strokes of the first character of first name"
    jal input
    mv t2, a0 # t2 is the strokes of the first character of first name
    jal printFirst2 # print "please enter the strokes of the second character of first name"
    jal input
    mv t3, a0 # t3 is the strokes of the second character of first name

    jal computeStroke # compute the strokes of Sky, People, Land, Outside, and Total
    jal determineZero # determine if t0 and t3 are 0
    
    jal printNewline
    
    jal printSky # print "Sky"
    jal printSymbol # print " = "
    mv a0, s0 # a0 = s0, the strokes of Sky
    jal computeWuxin # print the stokes of sky (s0) and compute the type of Wuxin of Sky
    mv s5, a1 # s5 is the type of Wuxin of Sky, 1 for Wood, 2 for Fire, 3 for Earth, 4 for Metal, 5 for Water
    jal printNewline

    jal printPeople # print "People"
    jal printSymbol
    mv a0, s1
    jal computeWuxin # print the stokes of people (s1) and compute the type of Wuxin of People
    mv s6, a1 # s6 is the type of Wuxin of People
    jal printNewline

    jal printLand # print "Land"
    jal printSymbol
    mv a0, s2
    jal computeWuxin # print the stokes of land (s2) and compute the type of Wuxin of Land
    mv s7, a1 # s7 is the type of Wuxin of Land
    jal printNewline

    jal printOutside # print "Outside"
    jal printSymbol
    mv a0, s3
    jal computeWuxin # print the stokes of outside (s3) and compute the type of Wuxin of Outside
    mv s8, a1 # s8 is the type of Wuxin of Outside
    jal printNewline

    jal printTotal # print "Total"
    jal printSymbol
    mv a0, s4
    jal computeWuxin # print the stokes of total (s4) and compute the type of Wuxin of Total
    mv s9, a1 # s9 is the type of Wuxin of Total
    jal printNewline
    jal printNewline

    mv a2, s5 # a2 = s5, the type of Wuxin of Sky
    mv a3, s6 # a3 = s6, the type of Wuxin of People
    jal compare # compare the type of Wuxin of Sky and People
    jal printLeftSP # print the left term of "Left Action Right", eg. "Sky" generate People
    jal printAction # print the action of "Left Action Right", eg. Sky "generate" People
    jal printRightSP # print the right term of "Left Action Right", eg. Sky generate "People"
    jal printNewline

    mv a3, s7 # a3 = s7, the type of Wuxin of Land
    jal compare
    jal printLeftSL # print the left term of "Left Action Right", eg. "Sky" generate Land
    jal printAction # print the action of "Left Action Right", eg. Sky "generate" Land
    jal printRightSL # print the right term of "Left Action Right", eg. Sky generate "Land"
    jal printNewline

    mv a3, s8 # a3 = s8, the type of Wuxin of Outside
    jal compare
    jal printLeftSO
    jal printAction
    jal printRightSO
    jal printNewline

    mv a3, s9 # a3 = s9, the type of Wuxin of Total
    jal compare
    jal printLeftST
    jal printAction
    jal printRightST
    jal printNewline

    mv a2, s6 # a2 = s6, the type of Wuxin of People
    mv a3, s7 # a3 = s7, the type of Wuxin of Land
    jal compare
    jal printLeftPL
    jal printAction
    jal printRightPL
    jal printNewline

    mv a3, s8 # a3 = s8, the type of Wuxin of Outside
    jal compare
    jal printLeftPO
    jal printAction
    jal printRightPO
    jal printNewline

    mv a3, s9 # a3 = s9, the type of Wuxin of Total
    jal compare
    jal printLeftPT
    jal printAction
    jal printRightPT
    jal printNewline

    mv a2, s7 # a2 = s7, the type of Wuxin of Land
    mv a3, s8 # a3 = s8, the type of Wuxin of Outside
    jal compare
    jal printLeftLO
    jal printAction
    jal printRightLO
    jal printNewline
    
    mv a3, s9 # a3 = s9, the type of Wuxin of Total
    jal compare
    jal printLeftLT
    jal printAction
    jal printRightLT
    jal printNewline

    mv a2, s8 # a2 = s8, the type of Wuxin of Outside
    mv a3, s9 # a3 = s9, the type of Wuxin of Total
    jal compare
    jal printLeftOT
    jal printAction
    jal printRightOT
    jal printNewline

    j end

input:
	li 	a7, 5 # input and read an integer
	ecall
	ret 

printID:
    la a0, sID # print the student ID
    li a7, 4
    ecall
    ret

printLast1:
    la a0, strLast1 # print the stoke of the first character of last name
    li a7, 4
    ecall
    ret

printLast2:
    la a0, strLast2 # print the stoke of the second character of last name
    li a7, 4
    ecall
    ret

printFirst1:
    la a0, strFirst1 # print the stoke of the first character of first name
    li a7, 4
    ecall
    ret

printFirst2:
    la a0, strFirst2 # print the stoke of the second character of first name
    li a7, 4
    ecall
    ret

computeStroke:
    add s0, t0, t1 # s0 is the Sky, add strokes of two characters of last name
    add s1, t1, t2 # s1 is the People, add strokes of the second character of last name and the first character of first name
    add s2, t2, t3 # s2 is the Land, add strokes of two characters of first name
    add s3, t0, t3 # s3 is the Outside, add strokes of the first character of first name and the second character of last name
    add t5, t0, t1 # t5 is to add strokes of two characters of last name
    add t6, t2, t3 # t6 is to, add strokes of two characters of first name
    add s4, t5, t6 # s4 is the Total, add strokes of two characters of last name and two characters of first name
    ret

computeWuxin:
    li a7, 1 # print the stoke
    ecall

    li t6, 10 # let 10 is the divisor
    rem t4, a0, t6 # t4 is the remainder, t4 = a0 % 10
    
    beqz t4, printWater # if the remainder is 0, print Water => if (t4 == 0) printWater

    li t6, 2 # if the remainder is 1-2, print Wood
    ble t4, t6, printWood # => else if (t4 <= 2) printWood

    li t6, 4 # if the remainder is 3-4, print Fire
    ble t4, t6, printFire # => else if (t4 <= 4) printFire

    li t6, 6 # if the remainder is 5-6, print Earth
    ble t4, t6, printEarth # => else if (t4 <= 6) printEarth

    li t6, 8 # if the remainder is 7-8, print Metal
    ble t4, t6, printMetal # => else if (t4 <= 8) printMetal

    jal, x0, printWater # if the remainder is 9, print Water => else printWater (t4 == 9)

printSky:
    la a0, sky
    li a7, 4
    ecall
    ret

printPeople:
    la a0, people
    li a7, 4
    ecall
    ret

printLand:
    la a0, land
    li a7, 4
    ecall
    ret

determineZero:
    or t4, t0, t3 # t4 = t0 || t3
    beqz t4, SLAddOneTis2 # if (t0 == 0 && t3 == 0), add 1 to the strokes of Sky and Land, Outside is 2
    beqz t0, SOAddOne # else if (t0 == 0 && t3 != 0), add 1 to the strokes of Sky and Outside
    beqz t3, LOTaddOne # else if (t0 != 0 && t3 == 0), add 1 to the strokes of Land, Outside, and Total
    ret # else if (t0 != 0 && t3 != 0), do nothing

SLAddOneTis2:
    addi s0, s0, 1
    addi s2, s2, 1
    li s3, 2
    jr ra

SOAddOne:
    addi s0, s0, 1
    addi s3, s3, 1
    jr ra

LOTaddOne:
    addi s2, s2, 1
    addi s3, s3, 1
    addi s4, s4, 1
    jr ra

printOutside:
    la a0, outside
    li a7, 4
    ecall
    ret

printTotal:
    la a0, total
    li a7, 4
    ecall
    ret

printSymbol:
    la a0, symbol
    li a7, 4
    ecall
    ret
    
printWood:
    la a0, wood
    li a7, 4
    ecall
    li a1, 1
    ret

printFire:
    la a0, fire
    li a7, 4
    ecall
    li a1, 2
    ret

printEarth:
    la a0, earth
    li a7, 4
    ecall
    li a1, 3
    ret

printMetal:
    la a0, metal
    li a7, 4
    ecall
    li a1, 4
    ret

printWater:
    la a0, water
    li a7, 4
    ecall
    li a1, 5
    ret

printNewline:
    la a0, newline
    li a7, 4
    ecall
    ret

# Let a, b be two types of Wuxin. If a = b, two elements are equal. 
# If a - b = 1 or -4, b generates a, if a - b = -1 or 4 (b - a = 1 or -4), a generates b.
# If a - b = 2 or -3, a restrains b, if a - b = -2 or 3 (b - a = 2 or -3), b restrains a.
compare:
    li t1, 1
    li t2, 2
    li t3, 3
    li t4, 4
    sub t5, a2, a3 # compute the difference between two elements a - b
    sub t6, a3, a2 # compute the difference between two elements b - a
    beq a2, a3, Equal # if a = b, eg. print "Sky equal People"
    beq t6, t1, AGB # if b - a = 1, print "a generate b". eg. print "Sky generate People"
    beq t5, t1, BGA # if a - b = 1, print "b generate a". eg. print "People generate Sky"
    beq t6, t2, ARB # if b - a = 2, print "a restrain b". eg. print "Sky restrain People"
    beq t5, t2, BRA # if a - b = 2, print "b restrain a". eg. print "People restrain Sky"
    beq t5, t4, AGB # for Water - Wood, if a - b = 4, print "a generate b". eg. print "Sky generate People"
    beq t6, t4, BGA # for Wood - Water, if b - a = 4, print "b generate a". eg. print "People generate Sky"
    beq t5, t3, ARB # for Water - Fire, Metal - Wood, if a - b = 3, print "a restrain b". eg. print "Sky restrain People"
    beq t6, t3, BRA # for Fire - Water, Wood - Metal, if b - a = 3, print "b restrain a". eg. print "People restrain Sky"
# following 10 labels are to determine what should be the left term of "Left Action Right" (eg. sky generate people)
printLeftSP: #for the relation of Sky and People
    beqz a1, printSky
    beq a1, t1, printSky
    beq a1, t2, printSky
    beq a1, t3, printPeople
    beq a1, t4, printPeople

printLeftSL: #for the relation of Sky and Land
    beqz a1, printSky
    beq a1, t1, printSky
    beq a1, t2, printSky
    beq a1, t3, printLand
    beq a1, t4, printLand

printLeftSO: #for the relation of Sky and Outside
    beqz a1, printSky
    beq a1, t1, printSky
    beq a1, t2, printSky
    beq a1, t3, printOutside
    beq a1, t4, printOutside

printLeftST: #for the relation of Sky and Total
    beqz a1, printSky
    beq a1, t1, printSky
    beq a1, t2, printSky
    beq a1, t3, printTotal
    beq a1, t4, printTotal

printLeftPL: #for the relation of People and Land
    beqz a1, printPeople
    beq a1, t1, printPeople
    beq a1, t2, printPeople
    beq a1, t3, printLand
    beq a1, t4, printLand

printLeftPO: #for the relation of People and Outside
    beqz a1, printPeople
    beq a1, t1, printPeople
    beq a1, t2, printPeople
    beq a1, t3, printOutside
    beq a1, t4, printOutside

printLeftPT: #for the relation of People and Total
    beqz a1, printPeople
    beq a1, t1, printPeople
    beq a1, t2, printPeople
    beq a1, t3, printTotal
    beq a1, t4, printTotal

printLeftLO: #for the relation of Land and Outside
    beqz a1, printLand
    beq a1, t1, printLand
    beq a1, t2, printLand
    beq a1, t3, printOutside
    beq a1, t4, printOutside

printLeftLT: #for the relation of Land and Total
    beqz a1, printLand
    beq a1, t1, printLand
    beq a1, t2, printLand
    beq a1, t3, printTotal
    beq a1, t4, printTotal

printLeftOT: #for the relation of Outside and Total
    beqz a1, printOutside
    beq a1, t1, printOutside
    beq a1, t2, printOutside
    beq a1, t3, printTotal
    beq a1, t4, printTotal

# following label is to determine what should be the action of "Left Action Right"
printAction:
    beqz a1, printEqual
    beq a1, t1, printGenerate
    beq a1, t2, printRestaint
    beq a1, t3, printRestaint
    beq a1, t4, printGenerate

# following 10 labels are to determine what should be the right term of "Left Action Right" (eg. sky generate people)
printRightSP: # for the relation of Sky and People
    beqz a1, printPeople
    beq a1, t1, printPeople
    beq a1, t2, printPeople
    beq a1, t3, printSky
    beq a1, t4, printSky

printRightSL: # for the relation of Sky and Land
    beqz a1, printLand
    beq a1, t1, printLand
    beq a1, t2, printLand
    beq a1, t3, printSky
    beq a1, t4, printSky

printRightSO: # for the relation of Sky and Outside
    beqz a1, printOutside
    beq a1, t1, printOutside
    beq a1, t2, printOutside
    beq a1, t3, printSky
    beq a1, t4, printSky

printRightST: # for the relation of Sky and Total
    beqz a1, printTotal
    beq a1, t1, printTotal
    beq a1, t2, printTotal
    beq a1, t3, printSky
    beq a1, t4, printSky

printRightPL: # for the relation of People and Land
    beqz a1, printLand
    beq a1, t1, printLand
    beq a1, t2, printLand
    beq a1, t3, printPeople
    beq a1, t4, printPeople

printRightPO: # for the relation of People and Outside
    beqz a1, printOutside
    beq a1, t1, printOutside
    beq a1, t2, printOutside
    beq a1, t3, printPeople
    beq a1, t4, printPeople

printRightPT: # for the relation of People and Total
    beqz a1, printTotal
    beq a1, t1, printTotal
    beq a1, t2, printTotal
    beq a1, t3, printPeople
    beq a1, t4, printPeople

printRightLO: # for the relation of Land and Outside
    beqz a1, printOutside
    beq a1, t1, printOutside
    beq a1, t2, printOutside
    beq a1, t3, printLand
    beq a1, t4, printLand

printRightLT: # for the relation of Land and Total
    beqz a1, printTotal
    beq a1, t1, printTotal
    beq a1, t2, printTotal
    beq a1, t3, printLand
    beq a1, t4, printLand

printRightOT: # for the relation of Outside and Total
    beqz a1, printTotal
    beq a1, t1, printTotal
    beq a1, t2, printTotal
    beq a1, t3, printOutside
    beq a1, t4, printOutside

Equal:
    li a1, 0 # Left term equal Right term
    jr ra
AGB:
    li a1, 1 # Left term generates Right term
    jr ra
ARB:
    li a1, 2 # Left term restrains Right term
    jr ra
BRA:
    li a1, 3 # Right term restrains Left term
    jr ra
BGA:
    li a1, 4 # Right term generates Left term
    jr ra

printGenerate:
    la a0, generate
    li a7, 4
    ecall
    ret

printRestaint:
    la a0, restaint
    li a7, 4
    ecall
    ret

printEqual:
    la a0, equal
    li a7, 4
    ecall
    ret

end:
    li a7, 10
    ecall
