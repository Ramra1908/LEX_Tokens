%{
#include<stdio.h>
int yylex(void);
int yywrap();
int yyerror(char* s);
extern FILE *yyin;
%}

%start program
%union { int inum; }

%token DIGIT
%token OPERATOR

%%

program:
    program expression
    | expression
    ;

expression:
    DIGIT OPERATOR DIGIT {
        printf("Expresion valida\n");
    }
    ;

%%

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Uso: %s <archivo.txt>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Error al abrir el archivo");
        return 1;
    }

    yyin = file;

    printf("Iniciando...\n\n");
    int res = yyparse();
    printf("Terminando, resultado: %d\n", res);

    fclose(file); // Cerrar el archivo
    return res;
}