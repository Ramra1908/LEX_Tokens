%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "y.tab.h"

void yyerror(const char *s);
%}

%option noyywrap

%%

[ \t]    ; /* Ignorar espacios en blanco */
\n       return NEWLINE;
[0-9]+(\.[0-9]+)?   { yylval.num = atof(yytext); return NUMBER; }
"+"      { return PLUS; }
"-"      { return MINUS; }
"*"      { return TIMES; }
"/"      { return DIVIDE; }
"^"      { return POWER; }
"("      { return LPAREN; }
")"      { return RPAREN; }
"sin"    { return SIN; }
"cos"    { return COS; }
"tan"    { return TAN; }
"sqrt"   { return SQRT; }
"log"    { return LOG; }
"exp"    { return EXP; }
.        { yyerror("Caracter no reconocido"); }

%%