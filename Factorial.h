/*
 * Factorial.h
 *
 * Header file for recursive factorial implementation.
 *
 */

#ifndef SRC_FACTORIAL_H_
#define SRC_FACTORIAL_H_

/*
 * The default number to use when computing factorial.
 */
#define DEFAULT_VALUE_OF_N 6l

/*
 * Executes a recursive factorial function and prints out its own base pointer, return address
 * and a number of stack frames starting at the final recursive call to the factorial function.
 */
void executeFactorial();

#endif /* SRC_FACTORIAL_H_ */
