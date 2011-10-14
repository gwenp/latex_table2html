/* lexic */

/* definition section */

%{
	#include "syntax.h"
	/* the parser calls the lexer yylex() whenever it needs a token */
	/* from the input */
	/* Yacc defines the token names in syntax.h */
	extern int yylval;
	extern int at_end;
%}


/* definitions */
separator [ \t]

/* rule section */
%%

<<EOF>>				{return FIN; } /* probleme avec ca */
" " | "\n" | "\t"	;

begin\{tabular\}	{ return BEGINTABLE; }

\{[a-zA-Z |]*\}	{ return LCR_ARGS; }

end\{tabular\}	{ return ENDTABLE; }
[0-9]+			{yylval = atoi(yytext); printf("number = %d\n",yylval); return NUMBER; }
{separator}		{} /* ignore */
\n				{return f(0);}
.				{ printf("joker = %c\n", yytext[0]); return yytext[0];}
%%
/* user subroutine section */

/* just to show */
int f(int i)
{
	return i;
}
