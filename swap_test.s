
    //trying to make a test code. Given is dogshit
    LDA X0,a
    ADDI X1,X0,#8

    // INSERT YOUR CODE HERE
    SUBI	SP, SP, #24 // Reserving 4 double words on stack
	STUR	FP, [SP, #16] // Save parent's FP on SP+24
	STUR	LR, [SP, #8] // Save return addres on SP+16
	ADDI	FP, SP, #16  // move fp up to create stack frame

    //SWAPPING
    LDUR X9,[X0,#0]      
    STUR X0,[X1,#0]
    STUR X1,[X9,#0]
    
    LDUR	FP, [SP, #16] // Restore parent's FP from SP+24
 	LDUR	LR, [SP, #8] // Restore return addres from SP+16
	ADDI	SP, SP, #24 // Releasing 4 double words of my stack
	BR	LR