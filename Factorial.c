/*
 * Factorial.c
 *
 * Source file for recursive factorial implementation.
 *
 */

#include <stdio.h>
#include "Factorial.h"
#include "StackFrame.h"

/*
 * Static (akin to "private") function to this module.
 * This function is only ever called by executeFactorial below.
 * When it has reached the final recursive call, it
 * calls printStackFrames() to print out stack frame data.
 *
 */

static unsigned long factorial(unsigned long n, unsigned long accumulator) {

    if (n <= 1) {
        printStackFrames(DEFAULT_VALUE_OF_N + 1);
        return accumulator;
    }
    return factorial(n - 1, n * accumulator);
}

/*
 * Non-static (akin to "public") function to call factorial with set parameter value.
 * and print out the result of calling getBasePointer and getReturnAddress.
 *
 */

void executeFactorial() {
    unsigned long basePointer = getBasePointer();
    printf("executeFactorial: basePointer = %lx\n", basePointer);

    unsigned long returnAddress = getReturnAddress();
    printf("executeFactorial: returnAddress = %lx\n", returnAddress);

    printf("executeFactorial: about to call factorial which should print the stack\n\n");

    unsigned long result = 0l;
    unsigned long number = DEFAULT_VALUE_OF_N;
    unsigned long accumulator = 1l;
    result = factorial(number, accumulator);
    printf("executeFactorial: factorial(%lu) = %lu\n", number, result);
}
