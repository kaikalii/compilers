#include <iostream>
#include <string>
#include <vector>
#include <cctype>
#include <algorithm>

#include "tokens.h"
#include "lexer.h"

using namespace std;

bool is_alpha_num_us(char c) {
    return isalnum(c) || c == '_';
}

bool is_alpha_us(char c) {
    return isalpha(c) || c == '_';
}

vector<string> keywords = { "auto", "break", "case", "char", "const", "continue", "default", "do", "double", "else", "enum", "extern", "for", "goto", "if", "int", "long", "register", "return", "short", "signed", "sizeof", "static", "struct", "switch", "typedef", "union", "unsigned", "void", "volatile", "while" };

token_t lexan(std::string &lexbuf) {
    while(true) {
        lexbuf.clear();
        char input;
        input = cin.get();
        if(input == EOF) return DONE;

        // Things that start with digit
        if(isdigit(input)) {
            lexbuf.push_back(input);
            while(isdigit(input = cin.get())) {
                lexbuf.push_back(input);
            }
            // longs
            if(input == 'l' || input == 'L') {
                lexbuf.push_back(input);
                return NUM;
            }
            // integers
            else {
                cin.putback(input);
                return NUM;
            }
        }
        // Things that start with alpha or '_'
        else if(is_alpha_us(input)) {
            lexbuf.push_back(input);
            while(is_alpha_num_us(input = cin.get())) {
                lexbuf.push_back(input);
            }
            cin.putback(input);
            // Keywords
            for(unsigned int i = 0; i < keywords.size(); i++) {
                if(keywords[i] == lexbuf) {
                    return (token_t)(i + 256);
                }
            }
            // Identifier
            return ID;
        }
        // String literals
        else if(input == '\"') {
            lexbuf.push_back(input);
            char last_char = input;
            while((input = cin.get()) != EOF) {
                lexbuf.push_back(input);
                if(input == '\"') {
                    if(last_char != '\\') {
                        return STRING;
                    }
                }
                last_char = input;
            }
        }else if(isspace(input)) {
            if(input == '\n') lineno++;
        }
        // Operators (and comments)
        else {
            lexbuf.push_back(input);
            switch(input) {
            // Operators
            case '=':
            case '<':
            case '>':
            case '!':
                if(cin.peek() == '=') {
                    lexbuf.push_back(cin.get());
                }
                if(lexbuf == "=") return ASSIGN;
                else if(lexbuf == "==") return EQL;
                else if(lexbuf == "!") return NOT;
                else if(lexbuf == "!=") return NEQ;
                else if(lexbuf == "<") return LTN;
                else if(lexbuf == ">") return GTN;
                else if(lexbuf == "<=") return LEQ;
                else if(lexbuf == ">=") return GEQ;

                break;
            case '|':
                if(cin.peek() == '|') {
                    lexbuf.push_back(cin.get());
                }
                return OR;

            case '&':
                if(cin.peek() == '&') {
                    lexbuf.push_back(cin.get());
                }
                if(lexbuf == "&") return ADDR;
                else if(lexbuf == "&&") return AND;

                break;
            case '-':
                if(cin.peek() == '>') {
                    lexbuf.push_back(cin.get());
                }
                if(lexbuf == "-") return MINUS;
                else if(lexbuf == "->") return ARROW;

                break;
            case '+': return PLUS;

            case '*': return STAR;

            case '(': return LPAREN;

            case ')': return RPAREN;

            case '[': return LBRACKET;

            case ']': return RBRACKET;

            case '{': return LCURLY;

            case '}': return RCURLY;

            case ';': return SEMICOLON;

            case ':': return COLON;

            case '.': return PERIOD;

            case ',': return COMMA;

            case '%': return REM;

            // Comments
            case '/': {
                if(cin.peek() == '*') {
                    cin.get();
                    while(!(cin.get() == '*' && cin.peek() == '/')) {
                        if(cin.peek() == EOF) break;
                    }
                    cin.get();
                }else return DIV;

                break;
            }
            default: return DONE;
            }
        }
    }
}
