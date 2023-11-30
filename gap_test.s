



////////////////////////
//                    //
//     GetNextGap     //
//                    //
////////////////////////
ADDI X0,XZR,#1
GetNextGap:
    // input:
    //     x0: The previous value for gap

    // output:
    //     x0: the updated gap value

    // INSERT YOUR CODE HERE
    //NEED TO BE TESTED
    /// responsibilities at the start
    SUBI    SP, SP, #32 // Reserving 4 double words on stack
    STUR    FP, [SP, #24] // Save parent's FP on SP+24
    STUR    LR, [SP, #16] // Save return addres on SP+16
    ADDI    FP, SP, #24  // move fp up to create stack frame
    
    STUR X0, [SP, #8] // Save the value of gap (X0) in memory so X0 can be changed for return
    ADD X16, XZR,X0 //MAKE COPY OF GAP X0
    ADD X0, XZR, XZR //setting return value (X0) to 0 (for return 0)
    SUBIS XZR, X16, #1
    B.LE returnx
   
   

    else:
    LDUR X0, [SP, #8] //Restore value of gap for Ceil operation
    ADDI X16, XZR, #1 //Temp reg x16 = 1 for the upcoming AND operation
    AND X16, X0, X16 //AND gap with 1, if LSB 1 then odd number, if 0 then even
    
    CBZ X16 even_number
    odd_number: //If gap is an odd number
    ADDI X0, X0, #1 //Add 1 to make gap even
    B even_number //Go to even number logic

    even_number: //If gap is an even number
    LSR X0, X0, #1 //Divide gap by 2
    B returnx //Return ceil(gap/2)
    
    
    // Responsibilities of a procedure at return time
    returnx:
    LDUR    FP, [SP, #24] // Restore parent's FP from SP+24
    LDUR    LR, [SP, #16] // Restore return addres from SP+16
    ADDI    SP, SP, #32 // Releasing 4 double words of my stack

stop