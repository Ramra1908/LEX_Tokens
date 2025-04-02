%{
#include<stdio.h>
#include "y.tab.h"

extern YYSTYPE yylval;
int yywrap();
int yyerror(char* s);
%}

%%

"INSERT"    { return INSERT; }
"INTO"      { return INTO; }
"VALUES"    { return VALUES; }
[a-zA-Z_]+  { return IDENTIF; }
\"[^\"]*\"  { return STRING; }
[0-9]+      { return NUMERO; }
","         { return COMA; }
"("         { return LPAREN; }
")"         { return RPAREN; }
";"         { return PUNTOYCOMA; }
[\n]+	    { return '\n'; }
[ \t]+	    {  }
.           { printf("Token desconocido %s\n", yytext); return 0; }

%%

int yywrap() {
     return 1;
}

int yyerror(char* s) {
   fprintf(stderr, "%s\n", s);
   return 1;
}