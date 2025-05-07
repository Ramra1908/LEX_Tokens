%{
#include "y.tab.h"
%}%option noyywrap

%%

[0-9]+      { yylval = atoi(yytext); return NUM; }
"*"         { return ASTERISK; }
[ \t]       ;
\n          { return EOL; }
.           { return yytext[0]; }

%%

int yywrap() {
    return 1;
}