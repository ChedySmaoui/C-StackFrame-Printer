/*
 * StackFrame.c
 *
 * Source file for StackFrame module that provides functionality relating to
 * stack frames and printing out stack frame data.
 *
 */

#include <stdio.h>
#include "StackFrame.h"
#include <stdlib.h>

/*
 * Non-static (akin to "public") functions that can be called from anywhere.
 * Comments for each function are given in the module interface StackFrame.h
 *
 * At present, they all just return 0 or do nothing.
 *
 * These are the functions you have to implement.
 *
 */

unsigned long getBasePointer() {
    /** Caller's base pointer.*/
    unsigned long basePointer;
    /**
     * The following inline assembly obtains the caller's base pointer which is the value held at getBasePointer()'s base pointer held at 0(%rbp).
    */
    asm("movq 0(%%rbp), %0;" : "=r" (basePointer));
    return basePointer;
}

unsigned long getReturnAddress() {
    /** Caller's return address.*/
    unsigned long returnAddress;
   /**
    * The following inline assembly code copies the caller's base pointer into the temporary register %rax.
    * The second instruction the uses RIP Relative Addressing Mode to obtain the caller's return address held at 8 bytes above its base pointer (rbp).
   */
    asm("movq 0(%%rbp), %%rax; movq 8(%%rax), %0;" : "=r" (returnAddress));
    return returnAddress;
}

void printStackFrameData(unsigned long basePointer, unsigned long previousBasePointer) {

    /** Size of the frame delimited by the two base pointers*/
    int frameSize;
    frameSize = previousBasePointer - basePointer;


    for (int offset = ZERO; offset < frameSize; offset += BYTES_PER_LINE) {

        /** String containing the 64bit number held at the memory address given by (basePointer+offset) in hexadecimal.*/
        char* numberInHex = malloc(DEFAULT_STRING_LENGTH + ONE);

        /** Points to the unsigne long variable containing the 64bit number held at the memory address given by (basePointer+offset) in decimal.*/
        unsigned long *ptr_numberInDec = malloc(__SIZEOF_LONG__);

        /**
         * This x86-64 instruction copy the 64bit number stored at the memory address (basePointer+offset) in the C variable ptr_numberInDec.
        */
        asm("movq 0(%1), %0;" : "=r" (*ptr_numberInDec) : "r" (basePointer + offset));

        /** Stores the 64 bit number as a 16 digit hexadecimal string in numberInHex.*/
        sprintf(numberInHex, "%016lx", *ptr_numberInDec);

        /**
         * Print line in the following format:
         * {memory address}: {64bit number in hexadecimal} {64bit number's 8 individual bytes as separate hexadecimal numbers}
        */
        printf("%016lx: %016lx --", basePointer+offset, *ptr_numberInDec);
        for (int i = DEFAULT_STRING_LENGTH - ONE; i > ZERO; i -= TWO) {
            printf(" %c%c", numberInHex[i - ONE], numberInHex[i]);
        }

        /** If the memory address is the base pointer, prints out a dashed line to indicate end/beginning of Stack Frame.*/
        if (offset == ZERO) { printf("\n-------------");}
        printf("\n");

        free(numberInHex);
        free(ptr_numberInDec);
    }
}

void printStackFrames(int number) {

    /** At initialization: holds the base pointer of printStackFrames.*/
    unsigned long basePointer;

    /** Points to the value (memory address) stored in C variable basePointer.*/
    unsigned long *ptr_basePointer = &basePointer;
    *ptr_basePointer = getBasePointer();

    /** At initialization: holds the base pointer of printStackFrames' caller.*/
    unsigned long previousBasePointer;

    /** Points to the value (memory address) stored in previousBasePointer.*/
    unsigned long *ptr_previousBasePointer = &previousBasePointer;

    /** Initializes previousBasePointer.*/
    asm("movq 0(%%rbp), %0;" : "=r" (*ptr_previousBasePointer) : "r" (*ptr_basePointer));

    /**
     * This for loop prints the given number of stack frames starting from the caller's stack frame.
     * 
     * It prints the stack frame data between the lowest memory address (base pointer) and the highest memory address (previous base pointer).
     * Then, it replaces the current base pointer by the value of the previous base pointer.
     * And updates the previous base pointer by gettting the previous previous base pointer using inline assembler.
    */
    for (int j = ZERO; j < (number + ONE); j++) {
        printStackFrameData(*ptr_basePointer, *ptr_previousBasePointer); // Prints the Stack Frame Data
        *ptr_basePointer = *ptr_previousBasePointer; // sets the current Base Pointer as the Previous Base Pointer
        asm("movq 0(%1), %0;" : "=r" (*ptr_previousBasePointer) : "r" (*ptr_basePointer)); // gets the previous previous Base Pointer to be the new previous base pointer.
    }
}
