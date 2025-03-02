/* 1. De quien se habla mas en la novela */
/* 2. Palabras positivas, negativas, neutras */

%option noyywrap
%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int harry = 0;
/*int harry1 = 0;*/
int ron = 0;
int hermione = 0;
int sirius = 0;
int remus = 0;
int severus = 0;

%}

%%

"Harry Potter"		{ harry++; } /* "[[:space:]]" ó "\t" se usa para cuando hay mas o's y comillas cuando es unica*/
Harry|Potter		{ harry++; }
"Ron Weasley"		{ ron++; }
Ron|Weasley		{ ron++; }
"Hermione Granger"	{ hermione++; }
Hermione|Granger	{ hermione++; }
"Sirius Black"		{ sirius++; }
Sirius|Black		{ sirius++; }
"Remus Lupin"		{ remus++; }
Remus|Lupin		{ remus++; }
"Severus Snape"		{ severus++; }
Severus|Snape		{ severus++; }

%%

int main()
{
	yyin = fopen("El_Prisionero_de_Azkaban.txt", "r");

	yylex();

	printf("\n\n\nCantidad de veces repetidas por cada nombre\n");
	printf("\nHarry Potter: %d veces repetidas.", harry);
	/*printf("\nHarry o Potter: %d veces repetidas.", harry1);*/
	printf("\nRon Weasley: %d veces repetidas.", ron);
	printf("\nHermione Granger: %d veces repetidas.", hermione);
	printf("\nSirius Black: %d veces repetidas.", sirius);
	printf("\nSeverus Snape: %d veces repetidas.", severus);
	printf("\n\n\n");

	//Comparador para saber quien es el protaginista
	char *nombres[] = {"Harry Potter", "Ron Weasley", "Hermione Granger", "Sirius Black", "Remus Lupin", "Severus Snape"};
	int conteos[] = {harry, ron, hermione, sirius, remus, severus};

	int may = 0;
	int i; //Al parecer en lex no acepta la declaracion dentro del for, algo de C99 de que es antiguo el lex
	for (i = 1; i < 6; i++) {
		if (conteos[i] > conteos[may]) {
		may = i;
		}
	}

	printf("\n\nEl personaje mas mencionado es: %s con %d menciones.", nombres[may], conteos[may]);
	printf("\nPor lo tanto es el/la protagonista\n\n");

    return 0;
}