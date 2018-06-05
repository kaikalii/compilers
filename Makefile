CXX		= g++ -std=c++11
CXXFLAGS	= -g -Wall
OBJS		= register.o scope.o symbol.o tree.o type.o allocator.o \
		  checker.o generator.o lexer.o parser.o
PROG		= scc

all:		$(PROG)

$(PROG):	$(OBJS)
		$(CXX) -o $(PROG) $(OBJS)

clean:;		$(RM) -f $(PROG) core *.o
