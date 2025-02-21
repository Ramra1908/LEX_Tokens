/* Generar el programa de lex para reconocer los siguientes tokens: */
/* 1. Palabras que contienen cadena ae, ai, ao, au, (Sumatoria) = {a-z} */
/* 2. Palabras formadas con simbolos (Sumatoria) = {0, 1}, que inicien o terminen con 00 */
/* 3. Los números enteros y decimales sin signo */
/* 4. 5 palabras reservadas de Java (a eleccion personal) */
/* 5. Palabras que inicien con mayuscula (Nombres propios) */

%option noyywrap
%{
	#include<stdio.h>
%}

AEAI [A-Za-z]*(ae|ai|ao|au)[A-Za-z]*(ae|ai|ao|au)?
DOBLECERO (00[01]*)|([01]*00)
SINSIGNO [0-9]+(\.[0-9]+)?
RESJAVA "class"|"public"|"static"|"void"|"return"
MAYUS [A-Z][a-z]*

%%

{AEAI}       printf("Token encontrado: Palabra con ae, ai, ao, au -> %s\n", yytext);
{DOBLECERO}  printf("Token encontrado: Palabra binaria con 00 -> %s\n", yytext);
{SINSIGNO}   printf("Token encontrado: Numero entero o decimal -> %s\n", yytext);
{RESJAVA}    printf("Token encontrado: Palabra reservada de Java -> %s\n", yytext);
{MAYUS}      printf("Token encontrado: Nombre propio -> %s\n", yytext);

%%
int main()
{
	yylex();
	return 0;
}