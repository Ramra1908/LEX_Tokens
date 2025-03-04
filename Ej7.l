/* Convierta de letras mayúsculas a letras minúsculas un texto que el usuario teclee como entrada */

%option noyywrap
%{

#include<stdio.h>
#include<ctype.h>

%}

%%

[A-Z]	{ printf("%c", tolower(yytext[0])); }
.	{ printf("%s", yytext); }

%%
int main()
{
	yyin = fopen("Cuento_minusculas.txt", "r");
	yylex();

	printf("\n\nTexto convertido a minusculas\n");

	return 0;
}