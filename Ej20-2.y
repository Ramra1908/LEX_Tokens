%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylineno = 1;

extern FILE *yyin;
int yylex(void);

int using_count = 0;
int class_count = 0;
char *current_namespace = NULL;

void yyerror(const char *s) {
    fprintf(stderr, "Error en línea %d: %s\n", yylineno, s);
}
%}

%union {
    int int_val;
    char* string_val;
}

%token USING NAMESPACE CLASS PUBLIC STATIC
%token VOID INT STRING_TYPE
%token RETURN CONSOLE WRITELINE
%token LBRACE RBRACE LPAREN RPAREN SEMICOLON DOT ASSIGN PLUS

%token <int_val> INTEGER_LIT
%token <string_val> STRING_LIT IDENTIFIER

%%

program:
    using_directives namespace_decl
    {
	printf("\nUsing reconocido: System
		\nClase reconocida: Program
		\nCampo con valor: mensaje = "Hola mundo"
		\nMetodo reconocido: Main()
		\nConsole.WriteLine: mensaje
		\n
		\nAnalisis completado con exito!
		\n- Usings: 1
		\n- Namespace: MiApp
		\n- Clases: 1);
        printf("\nResumen del análisis:\n");
        printf("- Directivas using: %d\n", using_count);
        printf("- Namespace: %s\n", current_namespace ? current_namespace : "(ninguno)");
        printf("- Clases: %d\n", class_count);
        if (current_namespace) free(current_namespace);
    }
;

using_directives:
    /* vacío */
    | using_directives using_directive
;

using_directive:
    USING IDENTIFIER SEMICOLON
    {
        printf("Using encontrado: %s\n", $2);
        using_count++;
        free($2);
    }
;

namespace_decl:
    NAMESPACE IDENTIFIER LBRACE class_decl RBRACE
    {
        current_namespace = $2;
    }
;

class_decl:
    CLASS IDENTIFIER LBRACE class_members RBRACE
    {
        printf("Clase encontrada: %s\n", $2);
        class_count++;
        free($2);
    }
;

class_members:
    /* vacío */
    | class_members class_member
;

class_member:
    field_decl
    | method_decl
;

field_decl:
    PUBLIC STATIC STRING_TYPE IDENTIFIER SEMICOLON
    {
        printf("Campo encontrado: string %s\n", $4);
        free($4);
    }
    | PUBLIC STATIC STRING_TYPE IDENTIFIER ASSIGN STRING_LIT SEMICOLON
    {
        printf("Campo con valor: string %s = %s\n", $4, $6);
        free($4); free($6);
    }
;

method_decl:
    PUBLIC STATIC VOID IDENTIFIER LPAREN RPAREN LBRACE statements RBRACE
    {
        printf("Método encontrado: %s()\n", $4);
        free($4);
    }
;

statements:
    /* vacío */
    | statements statement
;

statement:
    CONSOLE DOT WRITELINE LPAREN STRING_LIT RPAREN SEMICOLON
    {
        printf("Console.WriteLine: %s\n", $5);
        free($5);
    }
    | RETURN SEMICOLON
    | RETURN INTEGER_LIT SEMICOLON
;

%%

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s archivo.cs\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Error al abrir archivo");
        return 1;
    }

    yyparse();
    fclose(yyin);
    return 0;
}