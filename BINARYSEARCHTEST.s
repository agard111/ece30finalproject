    
    LDA X0, a
    ADDI X1, X0, #80
    ADDI X2,XZR, #6
    
    
    
    SUBI    SP, SP, #48        // Reserve 6 double words on stack
    STUR    X1, [SP, #16]       // Save initial X1 on SP+8
    STUR    X0, [SP, #8]      // Save initial X0 on SP+16 so we can use it freely
    ADDI    FP, SP, #40        // Move frame pointer up to create new stack frame

    BinarySearch:
    ADD     X3,XZR,XZR
    SUBS   XZR, X1, X0 //if START>END return 0
    B.LT    RETURNBIN

    SUB     X21, X1, X0 //RIGHT-LEFT IN ADDRESSES
    LSR     X21, X21, #3 //DIVIDE BY 8 FOR INDEX
    LSR     X22, X21, #1 //DIVIDE LENGTH BY 2
    LSL     X23, X21, #3 //MUL BY 8 FOR ADDRESS OF MID
    LDUR    X24,[X23,#0] //STORE VALUE OF ARRAY AT Midpoint

    ADDI    X3,XZR,#1
    SUB     X25, X24, X2 //CHECK IF EQUAL TO VALUE TO BE SEARCHED
    CBZ     X25, RETURNBIN //RETURN 1
    ADD     X3,XZR,XZR

    SUBI    X25,X23, #8 //MID-1
    ADD     X1,XZR,X25 //END=MID-1
    SUBS    XZR, X24 ,X2 // if target is smaller than mid
    B.LT    BinarySearch //RECURSIVE CALLING

    ADDI    X25, X25, #16 //MID+1
    ADD     X0,XZR,X25 //START =MID+1
    LDUR    X1,[SP, #16] //RESTORE ENDING ADDY
    LDUR    X0,[SP, #8]

    RETURNBIN:
    LDUR    X0, [SP, #8]   //Restore value of initial X0
    LDUR    X1, [SP, #16]    //Restore value of initial X1
    ADDI    SP, SP, #48     //Deallocate 5 double words

    ADDI X1,XZR,#10 

    printList:
    // x0: start address
    // x1: length of array
    addi x13, xzr, #32       // x3 = ' '
    addi x4, xzr, #10       // x4 = '\n'
    printList_loop:
    subis xzr, x1, #0       // if (x1 == 0) break
    b.eq printList_loopEnd  // break
    subi x1, x1, #1         // x1 = x1 - 1
    ldur x12, [x0, #0]       // x2 = x0->val
    putint x12               // print x2
    addi x0, x0, #8         // x0 = x0 + 8
    putchar x13              // print x3 ' '
    b printList_loop        // continue
    printList_loopEnd:
    putchar x4              // print x4 '\n'
    putint X3
    stop
    // return