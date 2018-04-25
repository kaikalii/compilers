all:
	g++ -g -std=c++11 -o scc parser.cpp lexer.cpp type.cpp checker.cpp symbol.cpp scope.cpp

debug:
	g++ -g -std=c++11 -o scc -D DEBUG parser.cpp lexer.cpp type.cpp checker.cpp symbol.cpp scope.cpp
