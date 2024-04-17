# CS2002 W08-C-Architecture

# 1. How to build

See [Makefile](Makefile) for the build scripts.

To build the *TryStackFrames* executable, simply run **make** at the command line in the current directory.

To compile and run the test suite, run **make Tests**.

**Important:** the command **make clean** will try to delete any executable or .o files in the src directory (tests or main executable files included).


# 2. Project Overview

1. My program implementation is in [StackFrames.c](StackFrames.c)
2. The [header file](StackFrame.h) has been edited to add MACRO definitions
3. The [Makefile](Makefile) has been edited to implement to make the test suite executables.


# 3. Testing Framework

To compile and run the test suite, run **make Tests**. This will automatically print the Stack Frames for different variants of executeFactorial.
The stack frames printed out are for the following factorial numbers: 0!, 1!, 7!, 10!, and 20!.

1. [TestFactorial0](TestFactorial0.c) is a variant almost identical to [Factorial](Factorial.c) but performs factorial(0,1).
2. [TestFactorial1](TestFactorial1.c) is a variant almost identical to [Factorial](Factorial.c) but performs factorial(1,1).
3. [TestFactorial7](TestFactorial7.c) is a variant almost identical to [Factorial](Factorial.c) but performs factorial(7,1).
4. [TestFactorial10](TestFactorial10.c) is a variant almost identical to [Factorial](Factorial.c) but performs factorial(10,1).
5. [TestFactorial20](TestFactorial20.c) is a variant almost identical to [Factorial](Factorial.c) but performs factorial(20,1).