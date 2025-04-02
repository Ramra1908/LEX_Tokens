%{
#include<stdio.h>
#include<string.h>

int yylex(void);
int yywrap();
int yyerror(char* s);
extern FILE *yyin;
%}

%start query
%union { int inum; }

%token INSERT INTO VALUES
%token IDENTIF STRING NUMERO
%token COMA LPAREN RPAREN PUNTOYCOMA

%% 

query:
    query insert_stmt '\n' { printf("\nSentencia INSERT valida.\n"); }
    | insert_stmt '\n' { printf("\nSentencia INSERT valida.\n"); }
    ;

insert_stmt:
    INSERT INTO IDENTIF VALUES LPAREN value_list RPAREN PUNTOYCOMA
    ;

value_list:
    value
    | value_list COMA value
    ;

value:
    STRING
    | NUMERO
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
    printf("\nTerminando, resultado: %d\n", res);

    fclose(file);
    return res;
}