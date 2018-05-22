CXX		= g++ -std=c++11
CXXFLAGS	= -g -Wall
OBJS		= scope.o symbol.o tree.o type.o checker.o lexer.o parser.o
PROG		= scc

all:		$(PROG)

$(PROG):	$(OBJS)
		$(CXX) -o $(PROG) $(OBJS)

clean:;		$(RM) -f $(PROG) core *.o
