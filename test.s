//testing if printing works
printSwapNumbers:	lda x2, swap_test   // x0 = &swap_test
                    ldur x0, [x2, #0]   // x1 = swap_test[0]
                    ldur x1, [x2, #8]   // x2 = swap_test[1]
                    addi x3, xzr, #32   // x3 = ' '
                    addi x4, xzr, #10   // x4 = '\n'
                    putint x0           // print x1
                    putchar x3          // print ' '
                    putint x1           // print x2
                    putchar x4          // print '\n'
    	        br lr   
BL printSwapNumbers // print the original values
