CC=gcc
RM=rm -f

# General compile & link flags, e.g. to show all warnings and turn off optimisation
GFLAGS = -Wall -Wextra -O0

# Compiler Flags to use for compiling only
CFLAGS = $(GFLAGS) -c -g

TryStackFrames: TryStackFrames.o Factorial.o StackFrame.o
	$(CC) $(GFLAGS) -o TryStackFrames TryStackFrames.o Factorial.o StackFrame.o

%.o: %.c
	$(CC) $(GFLAGS) $(CFLAGS) -o $@ $<

%.s: %.c
	$(CC) $(GFLAGS) -S -o $@ $<

# EDITED: make test
Tests: TestFactorial0 TestFactorial1 TestFactorial7 TestFactorial10 TestFactorial20
	./TestFactorial0
	./TestFactorial1
	./TestFactorial7
	./TestFactorial10
	./TestFactorial20

TestFactorial20: TestFactorial20.o Factorial.o StackFrame.o
	$(CC) $(GFLAGS) -o TestFactorial20 TestFactorial20.o Factorial.o StackFrame.o

TestFactorial10: TestFactorial10.o Factorial.o StackFrame.o
	$(CC) $(GFLAGS) -o TestFactorial10 TestFactorial10.o Factorial.o StackFrame.o

TestFactorial7: TestFactorial7.o Factorial.o StackFrame.o
	$(CC) $(GFLAGS) -o TestFactorial7 TestFactorial7.o Factorial.o StackFrame.o

TestFactorial1: TestFactorial1.o Factorial.o StackFrame.o
	$(CC) $(GFLAGS) -o TestFactorial1 TestFactorial1.o Factorial.o StackFrame.o

TestFactorial0: TestFactorial0.o Factorial.o StackFrame.o
	$(CC) $(GFLAGS) -o TestFactorial0 TestFactorial0.o Factorial.o StackFrame.o

# Targets to clean up your file space

clean:
	$(RM) TryStackFrames TestFactorial20 TestFactorial10 TestFactorial7 TestFactorial1 TestFactorial0 *.o *~
	