%{
#include <stdio.h>
#include <stdlib.h>  /* Para atoi() */

int regs[26] = {0};  /* Inicializa registros a 0 */

extern int yylex(void);
void yyerror(const char *s);
%}

%token NUMBER LETTER

%left '|'
%left '&'
%left '+' '-'
%left '*' '/' '%'
%left UMINUS

%%

list:   /* vacía */
    | list stat '\n'
    | list error '\n' { yyerrok; }
    ;

stat:   expr { printf("= %d\n", $1); }
    | LETTER '=' expr { regs[$1] = $3; printf("Registro %c = %d\n", $1+'a', $3); }
    ;

expr:   '(' expr ')' { $$ = $2; }
    | expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { 
          if($3 == 0) yyerror("División por cero");
          else $$ = $1 / $3; 
      }
    | expr '%' expr { 
          if($3 == 0) yyerror("Módulo por cero");
          else $$ = $1 % $3; 
      }
    | expr '&' expr { $$ = $1 & $3; }
    | expr '|' expr { $$ = $1 | $3; }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | LETTER { $$ = regs[$1]; }
    | NUMBER { $$ = $1; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Calculadora interactiva (ingrese expresiones o q para salir):\n");
    return yyparse();
}