/*
 * StackFrame.h
 *
 * Header file for StackFrame module that provides functionality relating to
 * stack frames and printing out stack frame data.
 *
 */

#ifndef STACKFRAME_H_
#define STACKFRAME_H_

#define BYTES_PER_LINE 8
#define ZERO 0
#define ONE 1
#define TWO 2
#define DEFAULT_STRING_LENGTH 16

/*
 * Gets hold of the base pointer in the stack frame of the function that called getBasePointer
 * (i.e. the base pointer in getBasePointer's caller's stack frame).
 * @return the base pointer of getBasePointer's caller's stack frame
 *
 */
unsigned long getBasePointer();

/*
 * Gets hold of the return address in the stack frame of the function that called getReturnAddress
 * (i.e. the return address to which getReturnAddress's caller will return to upon completion).
 * @return the return address of getReturnAddress's caller
 */
unsigned long getReturnAddress();

/*
 * Prints out stack frame data (formatted as hexadecimal values) between two given base pointers in the call stack.
 * @param basePointer the later basePointer (lower memory address)
 * @param previousBasePointer a previous base pointer (higher memory address)
 */
void printStackFrameData(unsigned long basePointer, unsigned long previousBasePointer);

/*
 * Prints out a given number of stack frames starting from the caller's stack frame.
 */
void printStackFrames(int number);

#endif /* STACKFRAME_H_ */
