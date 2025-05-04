%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

/* Eliminamos la declaración de yylineno aquí para evitar duplicados */
extern int yylineno;

int yylex(void);
%}

%option noyywrap

DIGIT       [0-9]
ID          [a-zA-Z_][a-zA-Z0-9_]*
INTEGER     {DIGIT}+
STRING      \"([^\\\"]|\\.)*\"
COMMENT     \/\/.*
WHITESPACE  [ \t\r\n]

%%

"using"         { return USING; }
"namespace"     { return NAMESPACE; }
"class"         { return CLASS; }
"public"        { return PUBLIC; }
"static"        { return STATIC; }
"void"          { return VOID; }
"int"           { return INT; }
"string"        { return STRING_TYPE; }
"return"        { return RETURN; }
"Console"       { return CONSOLE; }
"WriteLine"     { return WRITELINE; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
"("             { return LPAREN; }
")"             { return RPAREN; }
";"             { return SEMICOLON; }
"."             { return DOT; }
"="             { return ASSIGN; }
"+"             { return PLUS; }

{INTEGER}       { yylval.int_val = atoi(yytext); return INTEGER_LIT; }
{STRING}        { yylval.string_val = strdup(yytext); return STRING_LIT; }
{ID}            { yylval.string_val = strdup(yytext); return IDENTIFIER; }
{COMMENT}       { /* Ignorar comentarios */ }
{WHITESPACE}    { /* Ignorar espacios en blanco */ }
\n              { yylineno++; }

.               { fprintf(stderr, "Error léxico en línea %d: Caracter no reconocido '%s'\n", yylineno, yytext); }

%%