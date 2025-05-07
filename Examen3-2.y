%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
int yylex();
%}

%token NUM ASTERISK EOL

%%

lines: 
      | lines line
      ;

line: expr EOL  { printf("Multiplicacion valida. \nResultado: %d\n\n Que otro quiere analizar:\n", $1); }
    ;

expr: expr ASTERISK expr { $$ = $1 * $3; }
     | NUM                { $$ = $1; }
     | '(' expr ')'       { $$ = $2; }
     | expr '+' expr      { $$ = $1 + $3; }
     ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Introduzca la multiplicacion a analizar:\n");
    while (1) {
        yyparse();
    }
    return 0;
}