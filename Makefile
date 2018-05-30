CXX		= g++ -std=c++11
CXXFLAGS	= -g -Wall
OBJS		= scope.o symbol.o tree.o type.o checker.o lexer.o parser.o generator.o
PROG		= scc

all:		$(PROG)

$(PROG):	$(OBJS)
		$(CXX) -o $(PROG) $(OBJS)

clean:;		$(RM) -f $(PROG) core *.o

t:
	all
	./scc < test.c > test.s
	gcc -S test.c -o gcc_test.s
	gcc test.s -o test
	./test
