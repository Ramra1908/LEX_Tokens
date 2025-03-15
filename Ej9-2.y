%{

#include<stdio.h>
int yylex(void);
int yywrap();
int yyerror(char* s);

%}

%start program
%union { int inum; }

%token DIGIT
%token OPERATOR

%%

/*program: DIGIT OPERATOR DIGIT
    {
        printf("Formula reconocida\n");
    };*/

program: /* Allow multiple expressions */
    program expression
    | expression
    ;

expression:
    DIGIT OPERATOR DIGIT {
        printf("Formula reconocida\n");
    }
    ;

%%

int main() {

   printf("Iniciando...\n\n");
   int res = yyparse();
   printf("ending, %d\n", res);
   return(res);

}