////////////////////////
//                    //
// Project Submission //
//                    //
////////////////////////

// Partner1: Anshul Garde (Chakkya), A16824160
// Partner2: Aryaman Jadhav (Dholya), A16846457

////////////////////////
//                    //
//       main         //
//                    //
////////////////////////

    // Print Input Array
    lda x0, arr1        // x0 = &list1
    lda x1, arr1_length // x1 = &list1_length
    ldur x1, [x1, #0]   // x1 = list1_length
    bl printList

    // Test Swap Function
    bl printSwapNumbers // print the original values
    lda x0, swap_test   // x0 = &swap_test[0]
    addi x1, x0, #8     // x1 = &swap_test[1]
    bl Swap             // Swap(&swap_test[0], &swap_test[1])
    bl printSwapNumbers // print the swapped values

    // Test GetNextGap Function
    addi x0, xzr, #1    // x0 = 1
    bl GetNextGap       // x0 = GetNextGap(1) = 0
    putint x0           // print x0
    addi x1, xzr, #32   // x1 = ' '
    putchar x1          // print x1

    addi x0, xzr, #6    // x0 = 6
    bl GetNextGap       // x0 = GetNextGap(6) = 3
    putint x0           // print x0
    addi x1, xzr, #32   // x1 = ' '
    putchar x1          // print x1

    addi x0, xzr, #7    // x0 = 7
    bl GetNextGap       // x0 = GetNextGap(7) = 4
    putint x0           // print x0
    addi x1, xzr, #10   // x1 = '\n'
    putchar x1          // print x1


    // Test inPlaceMerge Function
    lda x0, merge_arr_length // x1 = &merge_arr1_length
    ldur x0, [x0, #0]        // x0 = merge_arr1_length
    bl GetNextGap            // x0 = GetNextGap(merge_arr1_length)
    addi x2, x0, #0          // x2 = x0 = gap
    lda x0, merge_arr        // x0 = &merge_arr1
    lda x3, merge_arr_length // x3 = &merge_arr1_length
    ldur x3, [x3, #0]        // x3 = merge_arr1_length
    subi x3, x3, #1          // x3 = x3 - 1     to get the last element
    lsl x3, x3, #3           // x3 = x3 * 8 <- convert length to bytes
    add x1, x3, x0           // x1 = x3 + x0 <- x1 = &merge_arr1[0] + length in bytes
    bl inPlaceMerge          // inPlaceMerge(&merge_arr1[0], &merge_arr1[0] + length in bytes, gap)
    lda x0, merge_arr
    lda x1, merge_arr_length // x1 = &merge_arr1_length
    ldur x1, [x1, #0]        // x1 = list1_length
    bl printList             // print the merged list


    // Test MergeSort Function
    lda x0, arr1            // x0 = &merge_arr1
    lda x2, arr1_length     // x2 = &merge_arr1_length
    ldur x2, [x2, #0]       // x2 = merge_arr1_length
    subi x2, x2, #1         // x2 = x2 - 1     to get the last element
    lsl x2, x2, #3          // x2 = x2 * 8 <-- convert length to bytes
    add x1, x2, x0          // x1 = x2 + x0 <-- x1 = &merge_arr1[0] + length in bytes
    bl MergeSort            // inPlaceMerge(&merge_arr1[0], &merge_arr1[0] + length in bytes, gap)
    lda x1, arr1_length     // x1 = &list1_length
    ldur x1, [x1, #0]       // x1 = list1_length
    bl printList            // print the merged list


    // [BONUS QUESTION] Binary Search Extension
    // load the sorted array's start and end indices
    lda x0, arr1            // x0 = &merge_arr1
    lda x2, arr1_length     // x2 = &merge_arr1_length
    ldur x2, [x2, #0]       // x2 = merge_arr1_length
    subi x2, x2, #1         // x2 = x2 - 1     to get the last element
    lsl x2, x2, #3          // x2 = x2 * 8 <-- convert length to bytes
    add x1, x2, x0          // x1 = x2 + x0 <-- x1 = &merge_arr1[0] + length in bytes

    // Write your code here to check if each values of binary_search_queries are in the sorted array
    // You must loop through the binary_search_queries array and print 1 if the index is found else 0
    // Hint: use binary_search_query_length and binary_search_queries pointers to loop through the queries
    //       and preserve x0 and x1 values, ie. the starting and ending address which you need to pass
    //       in every function call

    // [BONUS QUESTION] INSERT YOUR CODE HERE

    stop

////////////////////////
//                    //
//        Swap        //
//                    //
////////////////////////
Swap:
    // input:
    //     x0: the address of the first value
    //     x1: the address of the second value

    // INSERT YOUR CODE HERE
    SUBI	SP, SP, #24 // Reserving 3 double words on stack
	STUR	FP, [SP, #16] // Save parent's FP on SP+16
	STUR	LR, [SP, #8] // Save return addres on SP+8
	ADDI	FP, SP, #16  // move fp up to create stack frame

    //SWAPPING
    LDUR X9,[X0,#0]         
    STUR X0,[X1,#0]
    STUR X1,[X9,#0]
    
    LDUR	FP, [SP, #16] // Restore parent's FP from SP+24
 	LDUR	LR, [SP, #8] // Restore return addres from SP+16
	ADDI	SP, SP, #24 // Releasing 4 double words of my stack
	BR	LR



    br lr

////////////////////////
//                    //
//     GetNextGap     //
//                    //
////////////////////////
GetNextGap:
    // input:
    //     x0: The previous value for gap

    // output:
    //     x0: the updated gap value

    // INSERT YOUR CODE HERE
    
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

    BR LR


////////////////////////
//                    //
//    inPlaceMerge    //
//                    //
////////////////////////
inPlaceMerge:
    // input:
    //    x0: The address of the starting element of the first sub-array.
    //    x1: The address of the last element of the second sub-array.
    //    x2: The gap used in comparisons for shell sorting ***passed to gap***
    // variable log:
    //    X9: The interator for the for loop. In C code it is "left". ***passed to SWAP***
    //    X10: The right variable that is left+gap. ***passed to SWAP***
    //    X11:-
    //    X12: stores the array index= right*8
    //    X13: stores the array index= left*8
    //    X14: stores the right*8th index value
    //    X15: stores the left*8th index value 
    //    X16: stores the condition for the loop (left+gap)

    // INSERT YOUR CODE HERE
    
    /// responsibilities at the start *****need to verify********
    SUBI    SP, SP, #72 // Reserving 9 double words on stack
    STUR    FP, [SP, #64] // Save parent's FP on SP+64
    STUR    LR, [SP, #56] // Save return addres on SP+56
    ADDI    FP, SP, #64  // move fp up to create stack frame

    //main code
    SUBIS XZR, X2, #1 //if gap<1 return
    B.LT returnproc

    ADD X9, XZR, X0 //interating variable in the for loop (left)
    ADD X10, XZR, XZR //INITIALIZING RIGHT VARIABLE

    //FOR LOOP
    loop: 
    ADD X10, X9, X2 //RIGHT=LEFT+GAP
    LSL X12, X10, #3 //RIGHT*8 th INDEX
    LSL X13, X9, #3 //LEFT*8 th INDEX
    LDUR X14, [X0, X12] //ARR[RIGHT]
    LDUR X15, [X0, X13] //ARR[LEFT]
    SUBS XZR, X14, X15 // IF ARR[LEFT]>ARR[RIGHT]

    B Swap  //*** BRANCH TO SWAP** IDK IF THIS IS THE RIGHT WAY TO BRANCH AND HOW TO PASS VALUES TO SWAP

    ADD X16, X9, X2 //LEFT+GAP
    SUBS XZR, X16, X1 //IF LEFT+GAP<END
    B.LE loop 
    ADDI X9,X9,#1 //INCREMENTING LEFT BY 1

    //END OF FOR LOOP

    //****** CALL GAP *********//gap=GetNextGap(gap);

    //****** RECURSIVE CALL inPlaceMerge *************//


    // Responsibilities of a procedure at return time *****need to verify********
    returnproc:
    LDUR    FP, [SP, #64] // Restore parent's FP from SP+64
    LDUR    LR, [SP, #56] // Restore return addres from SP+56
    ADDI    SP, SP, #72 // Releasing 9 double words of my stack

    BR LR

////////////////////////
//                    //
//      MergeSort     //
//                    //
////////////////////////
MergeSort:
    // input:
    //     x0: The starting address of the array.
    //     x1: The ending address of the array

    // INSERT YOUR CODE HERE

    br lr

////////////////////////
//                    //
//      [BONUS]       //
//   Binary Search    //
//                    //
////////////////////////
BinarySearch:
    // input:
    //     x0: The starting address of the sorted array.
    //     x1: The ending address of the sorted array
    //     x2: The value to search for in the sorted array
    // output:
    //     x3: 1 if value is found, 0 if not found

    // INSERT YOUR CODE HERE

    br lr

////////////////////////
//                    //
//     printList      //
//                    //
////////////////////////

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
    br lr                   // return


////////////////////////
//                    //
//  helper functions  //
//                    //
////////////////////////
printSwapNumbers:
    lda x2, swap_test   // x0 = &swap_test
    ldur x0, [x2, #0]   // x1 = swap_test[0]
    ldur x1, [x2, #8]   // x2 = swap_test[1]
    addi x3, xzr, #32   // x3 = ' '
    addi x4, xzr, #10   // x4 = '\n'
    putint x0           // print x1
    putchar x3          // print ' '
    putint x1           // print x2
    putchar x4          // print '\n'
    br lr               // return
