/* No detecta el idioma español, las tildes las detecta como desconocidas */

%option noyywrap
%{

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<locale.h>

int love = 0;
int joy = 0;
int hope = 0;
int success = 0;
int sadness = 0;
int fear = 0;
int anger = 0;
int defeat = 0;
int neutro = 0;

%}

%%

querer|amar|carino|ternura|admiracion|afecto      { love++; }
feliz|contento|entusiasmo|risa|euforia|placer     { joy++; }
optimismo|confianza|ilusion|motivacion|inspirador { hope++; }
logro|triunfo|superacion|avance|ganar|orgullo     { success++; }

llanto|soledad|vacio|desesperanza|perdida|dolor   { sadness++; }
temor|angustia|inseguridad|panico|horror|amenaza  { fear++; }
ira|odio|rabia|resentimiento|frustracion|venganza { anger++; }
fracaso|decepcion|perdida|humillacion|rendirse    { defeat++; }

cambio|duda|destino|misterio|sorpresa             { neutro++; }

%%
int main()
{
	setlocale(LC_ALL, "es_ES.UTF-8");
	yyin = fopen("El_Prisionero_de_Azkaban.txt", "r");
	yylex();

	printf("\nCONTEO DE EMOCIONES");

	printf("\n\nCantidad de emociones positivas");
	printf("\nAmor: %d", love);
	printf("\nAlegría: %d", joy);
	printf("\nEsperanza: %d", hope);
	printf("\nÉxito: %d", success);

	printf("\n\nCantidad de emociones negativas");
	printf("\nTristeza: %d", sadness);
	printf("\nMiedo: %d", fear);
	printf("\nEnojo: %d", anger);
	printf("\nDerrota: %d", defeat);

	printf("\n\nCantidad de emociones neutras");
	printf("\nNeutro: %d", neutro);

	// Comparador para determinar la emoción predominante
	char *emociones[] = {"Amor", "Alegría", "Esperanza", "Éxito", "Tristeza", "Miedo", "Enojo", "Derrota", "Neutro"};
	int conteos[] = {love, joy, hope, success, sadness, fear, anger, defeat, neutro};

	int feelings = 0;
	int i;
	for (i = 1; i < 9; i++) {
		if (conteos[i] > conteos[feelings]) {
			feelings = i;
		}
	}

	printf("\n\nLa emocion predominante es: %s con %d menciones.", emociones[feelings], conteos[feelings]);
	printf("\nPor lo tanto, %s es la emocion mas representativa del texto.\n\n", emociones[feelings]);

	return 0;
}