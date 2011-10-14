/* memphis.compilertools.net/interpreter.html */

/* definition section */

%{
	#include <stdio.h>
	#include <stdlib.h>
	extern int yylex();
	int at_end = 0;
%}

/* token declaration */
%token NAME NUMBER

%token BEGINTABLE
%token LCR_ARGS

%token TEX_EOL
%token TEX_ROWSEP

%token ENDTABLE

%token FIN

/* statemebnt is the axiom */
%start statement

/* grammmar rule section */
%%
statement : NAME '=' expression
			| expression {printf("%d\n",$1);}
			| beginTable LCR_ARGS
			| TEX_EOL    { printf("TEX_EOL\n"); }
			| TEX_ROWSEP { printf("TEX_ROWSEP\n"); }
			| endTable   { at_end = 1; }
			| FIN 		 { at_end = 1; }
			;
			
expression : expression '+' NUMBER 	{$$ = $1 + $3;}
			|expression '-' NUMBER	{$$ = $1 - $3;}
			|NUMBER 				{$$ = $1;}
			;
beginTable : BEGINTABLE {printf("debut_tab\n");}
			;
endTable : 	 ENDTABLE {printf("fin_tab\n");}
			;
%%

/* user routine subsection 	*/
/* empty					*/
extern FILE* yyin;

int yyerror(char* s){ printf("%s\n",s); }

void main (int argc, char *argv[])
{
	if(argc>1)
	{
		yyin = fopen(argv[1],"r");
		if(!yyin) {printf("File %s cannot be read\n",argv[1]);exit(1);}
		// if(!yyparse()) {printf("=== fini ===\n"); fclose(yyin);} /* successful parsing */
		// else {printf("parse error\n");exit(1);}
		while(!at_end)
		{
			yyparse();
		}	
	}
	else 
	{
		printf ("please specify a file to open\n");
		exit(1);
	}
}
