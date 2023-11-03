
    //trying to make a test code. Given is dogshit
    LDA X0,a
    ADDI X1,XZR, #8

    ////////////////////////// CODE FROM MAIN //////////////////////////
    SUBI	SP, SP, #32 // Reserving 4 double words on stack
	STUR	FP, [SP, #24] // Save parent's FP on SP+16
	STUR	LR, [SP, #16] // Save return addres on SP+8
	ADDI	FP, SP, #24  // move fp up to create stack frame

    //SWAPPING
    LDUR X9,[X0,#0] 
    LDUR X10,[X1,#0]        
    STUR X9,[X1,#0]
    STUR X10,[X0,#0]
    
    LDUR	FP, [SP, #24] // Restore parent's FP from SP+24
 	LDUR	LR, [SP, #16] // Restore return addres from SP+16
	ADDI	SP, SP, #32 // Releasing 4 double words of my stack

    //////////////////////// END OF CODE FROM MAIN. START OF PRINT ///////////////////////

ADDI X1,XZR,#10 
printList:
    // x0: start address
    // x1: length of array
    addi x3, xzr, #32       // x3 = ' '
    addi x4, xzr, #10       // x4 = '\n'
printList_loop:
    subis xzr, x1, #0       // if (x1 == 0) break
    b.eq printList_loopEnd  // break
    subi x1, x1, #1         // x1 = x1 - 1
    ldur x2, [x0, #0]       // x2 = x0->val
    putint x2               // print x2
    addi x0, x0, #8         // x0 = x0 + 8
    putchar x3              // print x3 ' '
    b printList_loop        // continue
printList_loopEnd:
    putchar x4              // print x4 '\n'
    stop
    // return
