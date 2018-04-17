all:
	g++ -g -std=c++11 -o scc parser.cpp lexer.cpp

debug:
	g++ -g -std=c++11 -o scc -D DEBUG parser.cpp lexer.cpp
