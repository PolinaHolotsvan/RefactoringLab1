all:
	flex lexer.l
	bison -d parser.y
	g++ -o pcb parser.tab.c lex.yy.c PCBClass.cpp
