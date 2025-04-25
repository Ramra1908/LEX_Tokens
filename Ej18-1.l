%{
#include "y.tab.h"
extern int yylval;
%}

%%

[ \t]   ;  /* Ignora espacios */

[0-9]+  {
        yylval = atoi(yytext);  /* Convierte toda la cadena numérica */
        return NUMBER;  /* Cambiamos DIGIT por NUMBER para múltiples dígitos */
        }

[a-z]   {
        yylval = yytext[0] - 'a';
        return LETTER;
        }

\n      { return '\n'; }
.       { return yytext[0]; }

%%

int yywrap() {
    return 1;
}