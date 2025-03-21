/*Cadena con error*/
%option noyywrap
%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int potter = 0;
int poter = 0;

FILE *salida;

char cad1[] = "Potter";
char cad2[] = "Poter";

extern FILE *yyin;

%}

%%

[a-zA-Z]+	{if(strcmp(yytext, cad2) == 0){
			fprintf(yyout, "%s", cad1);
			poter++;
		}
		else {
			fprintf(yyout, "%s", yytext);
			potter++;
			}
		}
.		{ fprintf(yyout, "%s", yytext); }

%%

int main()
{
	yyin = fopen("Harry_Espanol.txt", "r");
	yyout = fopen("Harry_Espanol_Corregido.txt", "w");

	yylex();

	printf("\n\n\nCantidad de veces repetidas por cada nombre\n");
	printf("\nPotter: %d veces repetidas.", potter);
	printf("\nPoter: %d veces repetidas.", poter);
	printf("\n\nFin...\n\n");

    return 0;
}