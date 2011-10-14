all: compile_all 

flex:
	flex -o src/lexic.c src/lexic.l 

yacc:
	yacc -d src/syntax.y
	mv y.tab.c src/syntax.c
	mv y.tab.h src/syntax.h
	
compile_all: flex yacc
	gcc -o Programme src/lexic.c src/syntax.c -lfl
