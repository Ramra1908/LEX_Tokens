%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(const char *s);
int yylex(void);

extern FILE *yyin;
%}

%union { double num; }

%token <num> NUMBER
%token PLUS MINUS TIMES DIVIDE POWER
%token LPAREN RPAREN
%token SIN COS TAN SQRT LOG EXP
%token NEWLINE

%type <num> expression term factor exponent primary

%left PLUS MINUS
%left TIMES DIVIDE
%right POWER
%left UMINUS

%%

input: 
    /* vacio */
    | input line
;

line: NEWLINE
    | expression NEWLINE {
        printf("\nOperacion: %s\n", "Expresion analizada");
        printf("Resultado: %g\n\n", $1);
    }
;

expression: 
    term
    | expression PLUS term { $$ = $1 + $3; }
    | expression MINUS term { $$ = $1 - $3; }
;

term: 
    factor
    | term TIMES factor { $$ = $1 * $3; }
    | term DIVIDE factor { $$ = $1 / $3; }
;

factor:
    exponent
    | factor POWER exponent { $$ = pow($1, $3); }
;

exponent:
    primary
    | MINUS exponent %prec UMINUS { $$ = -$2; }
;

primary:
    NUMBER
    | LPAREN expression RPAREN { $$ = $2; }
    | SIN LPAREN expression RPAREN { $$ = sin($3); }
    | COS LPAREN expression RPAREN { $$ = cos($3); }
    | TAN LPAREN expression RPAREN { $$ = tan($3); }
    | SQRT LPAREN expression RPAREN { $$ = sqrt($3); }
    | LOG LPAREN expression RPAREN { $$ = log($3); }
    | EXP LPAREN expression RPAREN { $$ = exp($3); }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            fprintf(stderr, "No se pudo abrir el archivo %s\n", argv[1]);
            return 1;
        }
    }
    
    printf("\nCALCULADORA DE EXPRESIONES ARITMETICAS COMPLEJAS\n");
    printf("Ingrese las expresiones a analizar:\n");
    
    yyparse();
    
    if (argc > 1) {
        fclose(yyin);
    }
    
    return 0;
}