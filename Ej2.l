%option noyywrap
%{
#include<stdio.h>
%}
DIGIT [0-9]
OPERATOR [+*/-]
%%
{DIGIT}+	printf("N-mero: %s\n", yytext);
{OPERATOR}	printf("Operator: %s\n", yytext);
.		/*Ignorar otros caracteres */

%%
int main()
{
	yylex();
	return 0;
}