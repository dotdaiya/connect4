// Agent player in project connect4.mas2j

/* ALPHA: Es una diagonal en la que las dos componentes son la suma de las 
   anteriores. Es decir la diagonal va de izquierda arriba a abajo derecha.
  
 * BETA: Es una diagonal en la que la componenet X es la resta de la anterior
   y la componente Y la suma de la anterior. Es decir la diagonal va de derecha
   arriba a abajo izquierda.*/

/* BELIEFS AND RULES */
/*----------------------------BELIEFS INICIALES-------------------------------*/
/*----------------------------------------------------------------------------*/


/* Comprueba que nadie haya ganado la partida */
nadieGano:- //Tested
	not cuatroEnRayaHorizontal(1) &
	not cuatroEnRayaVertical(1) &
	not cuatroEnRayaDiagonalAlpha(1) &
	not cuatroEnRayaDiagonalBeta(1) &
	not cuatroEnRayaHorizontal(2) &
	not cuatroEnRayaVertical(2) &
	not cuatroEnRayaDiagonalAlpha(2) &
	not cuatroEnRayaDiagonalBeta(2).


/*  Define quien es el jugador y quien[source(self)] es el rival de forma numerica en funcion 
	del nombre, queda comprobado que el posicion solo reconoce a los agentes con
	el nombre indicado */
quienSoy(1,2):-
	.my_name(player1).
quienSoy(2,1):-
	.my_name(player2).

/* Comprueba si se puede colocar en una posición por encima de la fila siete */ 
puedeColocar(X,Y):- //Tested 
	posicion(X,Y,0)[source(self)] &
    (X >= 0 & X < 8) &
    (Y >= 0 & Y < 8) &
    (posicion(X,Y+1,1)[source(self)] | posicion(X,Y+1,2)[source(self)]).
puedeColocar(X,7):- //Tested
    posicion(X,7,0)[source(self)].


/* Comprueba que aún se puede realizar movimientos */
comprobarCeldasLibres:- //Tested
	posicion(X,Y,0)[source(self)].


/* Comprueba que aún hay celdas libres en una columna */
comprobarCeldaLibreEnColumna(Columna,Fila):-
	(Columna >= 0 & Columna < 8) &
	puedeColocar(Columna,Fila).


/*-----------------------PARA EVALUAR EL TABLERO------------------------------*/
/* Obtener las puntuaciones del posicion contando el numero de trios, parejas 
y candidatos ganadores siempre y ponderando su valor */
evaluarTablero(J,jugarAGanar,45):-// Tres en raya ganar siempre
	jugador(J)[source(self)] &
	ganarSiempre(Elem,J) &
	.length(Elem,X) &
	//.print("tresEnRayaGanarSiempre-Length: ", X) &
	X >= 1 .
evaluarTablero(J,jugarAGanar,-45):-// Tres en raya ganar siempre
	oponente(J)[source(self)] &
	ganarSiempre(Elem,J) &
	.length(Elem,X) &
	//.print("tresEnRayaGanarSiempre-Length: ", X) &
	X >= 1 .
evaluarTablero(J,jugarAPerder,-45):-// Tres en raya ganar siempre
	jugador(J)[source(self)] &
	ganarSiempre(Elem,J) &
	.length(Elem,X) &
	//.print("tresEnRayaGanarSiempre-Length: ", X) &
	X >= 1 .
evaluarTablero(J,jugarAPerder,45):-// Tres en raya ganar siempre
	oponente(J)[source(self)] &
	ganarSiempre(Elem,J) &
	.length(Elem,X) &
	//.print("tresEnRayaGanarSiempre-Length: ", X) &
	X >= 1 .

evaluarTablero(J,jugarAGanar,45):-// >1 trio
	jugador(J)[source(self)] &
	trios(Elem,J) &
	.length(Elem,X) &
	//.print(">1trio-Length: ", X) & 
	X > 1.
evaluarTablero(J,jugarAGanar,-45):-// >1 trio
	oponente(J)[source(self)] &
	trios(Elem,J) &
	.length(Elem,X) &
	//.print(">1trio-Length: ", X) & 
	X > 1.
evaluarTablero(J,jugarAPerder,-45):-// >1 trio
	jugador(J)[source(self)] &
	trios(Elem,J) &
	.length(Elem,X) &
	//.print(">1trio-Length: ", X) & 
	X > 1.
evaluarTablero(J,jugarAPerder,45):-// >1 trio
	oponente(J)[source(self)] &
	trios(Elem,J) &
	.length(Elem,X) &
	//.print(">1trio-Length: ", X) & 
	X > 1.

evaluarTablero(J,jugarAGanar,35):-// Un solo trio
	jugador(J)[source(self)] &
	trios(Elem,J) &
	//.print("1trio") & 
	.length(Elem,1).
evaluarTablero(J,jugarAGanar,-35):-// Un solo trio
	oponente(J)[source(self)] &
	trios(Elem,J) &
	//.print("1trio") & 
	.length(Elem,1).
evaluarTablero(J,jugarAPerder,-35):-// Un solo trio
	jugador(J)[source(self)] &
	trios(Elem,J) &
	//.print("1trio") & 
	.length(Elem,1).
evaluarTablero(J,jugarAPerder,35):-// Un solo trio
	oponente(J)[source(self)] &
	trios(Elem,J) &
	//.print("1trio") & 
	.length(Elem,1).

evaluarTablero(J,jugarAGanar,30+X):-// Una pareja ganadora
	jugador(J)[source(self)] &
	parejaGanadora(Elem,J) &
	.length(Elem,X) &
	//.print("parejaGanadora-Length: ", X) &
	X >= 1 .
evaluarTablero(J,jugarAGanar,-30-X):-// Una pareja ganadora
	oponente(J)[source(self)] &
	parejaGanadora(Elem,J) &
	.length(Elem,X) &
	//.print("parejaGanadora-Length: ", X) &
	X >= 1 .
evaluarTablero(J,jugarAPerder,-30-X):-// Una pareja ganadora
	jugador(J)[source(self)] &
	parejaGanadora(Elem,J) &
	.length(Elem,X) &
	//.print("parejaGanadora-Length: ", X) &
	X >= 1 .
evaluarTablero(J,jugarAPerder,30+X):-// Una pareja ganadora
	oponente(J)[source(self)] &
	parejaGanadora(Elem,J) &
	.length(Elem,X) &
	//.print("parejaGanadora-Length: ", X) &
	X >= 1 .

evaluarTablero(J,jugarAGanar,10+X):-// Jugadas comunes con parejas
	jugador(J)[source(self)] &
	jugadasComunes(Elem,J) &
	.length(Elem,X) &
	//.print("jugadasComunes-Length: ", X) &
	X >= 1.
evaluarTablero(J,jugarAGanar,-10-X):-// Jugadas comunes con parejas
	oponente(J)[source(self)] &
	jugadasComunes(Elem,J) &
	.length(Elem,X) &
	//.print("jugadasComunes-Length: ", X) &
	X >= 1.
evaluarTablero(J,jugarAPerder,-10-X):-// Jugadas comunes con parejas
	jugador(J)[source(self)] &
	jugadasComunes(Elem,J) &
	.length(Elem,X) &
	//.print("jugadasComunes-Length: ", X) &
	X >= 1.
evaluarTablero(J,jugarAPerder,10+X):-// Jugadas comunes con parejas
	oponente(J)[source(self)] &
	jugadasComunes(Elem,J) &
	.length(Elem,X) &
	//.print("jugadasComunes-Length: ", X) &
	X >= 1.


	/*Obtiene la puntuacion de las parejas encontradas

	Horizontales:15 
	Diagonales:20
	Verticales:10
	Generan trios Horizontales:60
	Generan trios Diagonales:65
	*/		

evaluarTablero(J,jugarAGanar,9):-// Tres solas
	jugador(J)[source(self)] &
	solitaGeneraTres(Elem,J).
	//.print("jugadasComunes").
evaluarTablero(J,jugarAGanar,-9):-// Tres solas
	oponente(J)[source(self)] &
	solitaGeneraTres(Elem,J).
	//.print("jugadasComunes").
evaluarTablero(J,jugarAPerder,-9):-// Tres solas
	jugador(J)[source(self)] &
	solitaGeneraTres(Elem,J).
	//.print("jugadasComunes").
evaluarTablero(J,jugarAPerder,9):-// Tres solas
	oponente(J)[source(self)] &
	solitaGeneraTres(Elem,J).
	//.print("jugadasComunes").

evaluarTablero(J,jugarAGanar,7):-// Dos solas
	jugador(J)[source(self)] &
	solitaGeneraDos(Elem,J).
	//.print("jugadasComunes").
evaluarTablero(J,jugarAGanar,-7):-// Dos solas
	oponente(J)[source(self)] &
	solitaGeneraDos(Elem,J).
	//.print("jugadasComunes").
evaluarTablero(J,jugarAPerder,-7):-// Dos solas
	jugador(J)[source(self)] &
	solitaGeneraDos(Elem,J).
	//.print("jugadasComunes").
evaluarTablero(J,jugarAPerder,7):-// Dos solas
	oponente(J)[source(self)] &
	solitaGeneraDos(Elem,J).
	//.print("jugadasComunes").

evaluarTablero(J,jugarAGanar,4):-// Una sola
	jugador(J)[source(self)] &
	solitaGeneraUna(Elem,J).
	//.print("jugadasComunes").
evaluarTablero(J,jugarAGanar,-4):-// Una sola
	oponente(J)[source(self)] &
	solitaGeneraUna(Elem,J).
	//.print("jugadasComunes").
evaluarTablero(J,jugarAPerder,-4):-// Una sola
	jugador(J)[source(self)] &
	solitaGeneraUna(Elem,J).
	//.print("jugadasComunes").
evaluarTablero(J,jugarAPerder,4):-// Una sola
	oponente(J)[source(self)] &
	solitaGeneraUna(Elem,J).
	//.print("jugadasComunes").

evaluarTablero(_,_,0).// Predeterminado
	/*Obtiene la puntuacion de las parejas encontradas

	Horizontales:15 
	Diagonales:20
	Verticales:10
	Generan trios Horizontales:60
	Generan trios Diagonales:65
	*/		

/* Busca cuatro en raya */
cuatroEnRaya(Jugador):-
	cuatroEnRayaHorizontal(Jugador) |
	cuatroEnRayaVertical(Jugador) |
	cuatroEnRayaDiagonalAlpha(Jugador) |
	cuatroEnRayaDiagonalBeta(Jugador).


/* Halla los trios que ganan siempre */
ganarSiempre(Final,J):-
    ganarSiempreHorizontal(A,J) &
    ganarSiempreDiagonalAlpha(B,J) &
    ganarSiempreDiagonalBeta(C,J) &
    .concat(A,B,L) &
    .concat(C,L,Final).


/* Un trio */
trios(Final,J):-
	tresEnRayaVertical(A0,J) &
	tresEnRayaHorizontalIzquierda(A1,J) &
	tresEnRayaHorizontalDerecha(A2,J) &
	tresEnRayaDiagonalAlphaDerechaAbajo(A3,J) &
	tresEnRayaDiagonalAlphaIzquierdaArriba(A4,J) &
	tresEnRayaDiagonalBetaDerechaArriba(A5,J) &
	tresEnRayaDiagonalBetaIzquierdaAbajo(A6,J) &
	tresEnCuatroHorizontalCentroDerecha(A7,J) &
	tresEnCuatroHorizontalCentroIzquierda(A8,J) &
	tresEnCuatroDiagonalAlphaCentroDerecha(A9,J) &
	tresEnCuatroDiagonalAlphaCentroIzquierda(A10,J) &
	tresEnCuatroDiagonalBetaCentroDerecha(A11,J) &
	tresEnCuatroDiagonalBetaCentroIzquierda(A12,J) &
	.union(A0,A1,B0) &
	.union(A2,A3,B1) &
	.union(A4,A5,B2) &
	.union(A6,A7,B3) &
	.union(A8,A9,B4) &
	.union(A10,A11,B5) &
	.union(B0,B1,C0) &
	.union(B2,B3,C1) &
	.union(B4,B5,C2) &
	.union(C0,C1,D0) &
	.union(C2,D0,E0) &
	.union(C0,A12,Final).


/* Solas */
solitaGeneraTres([pos(X0,Y0)],J):-
	solitaGeneraHorizontal([pos(X0,Y0)],J) &
	solitaGeneraVertical([pos(X1,Y1)],J) &
	((X1=X0-1) & (Y1=Y0-1)) &
	solitaGeneraDiagonalAlpha([pos(X2,Y2)],J) &
	((X2=X0-2) & (Y2=Y0-1)).
solitaGeneraTres([pos(X0,Y0)],J):-
    solitaGeneraHorizontal([pos(X0,Y0)],J) &
    solitaGeneraVertical([pos(X1,Y1)],J) &
   	((X1=X0+1) & (Y1=Y0-1)) &
    solitaGeneraDiagonalBeta([pos(X2,Y2)],J) &
   	((X2=X0+2) & (Y2=Y0-1)).

solitaGeneraDos([pos(X0,Y0)],J):-
	solitaGeneraHorizontal([pos(X0,Y0)],J) &
	solitaGeneraVertical([pos(X1,Y1)],J) &
	((X1=X0-1) & (Y1=Y0-1)).
solitaGeneraDos([pos(X0,Y0)],J):-
    solitaGeneraHorizontal([pos(X0,Y0)],J) &
    solitaGeneraDiagonalAlpha([pos(X2,Y2)],J) &
   	((X2=X0-2) & (Y2=Y0-1)).
solitaGeneraDos([pos(X0,Y0)],J):-
	solitaGeneraHorizontal([pos(X0,Y0)],J) &
	solitaGeneraDiagonalBeta([pos(X2,Y2)],J) &
   	((X2=X0+2) & (Y2=Y0-1)).

solitaGeneraUna([pos(X0,Y0)],J):-
	(solitaGeneraHorizontal([pos(X0,Y0)],J) |
	solitaGeneraVertical([pos(X0,Y0)],J) |
	solitaGeneraDiagonalAlpha([pos(X0,Y0)],J) |
	solitaGeneraDiagonalBeta([pos(X0,Y0)],J)).
solitaGeneraUna([],J).


/* Una pareja que desemboque en una ganadora */
parejaGanadora(Final,J):-
	parejaGanadoraHorizontalDerecha(A0,J) &
	parejaGanadoraHorizontalIzquierda(A1,J) &
	parejaGanadoraHorizontalCentral(A2,J) &
	parejaGanadoraDiagonalAlphaDerecha(A3,J) &
	parejaGanadoraDiagonalAlphaIzquierda(A4,J) &
	parejaGanadoraDiagonalAlphaCentral(A5,J) &
	parejaGanadoraDiagonalBetaIzquierda(A6,J) &
	parejaGanadoraDiagonalBetaDerecha(A7,J) &
	parejaGanadoraDiagonalBetaCentral(A8,J) &
	.union(A0,A1,B0) &
	.union(A2,A3,B1) &
	.union(A4,A5,B2) &
	.union(A6,A7,B3) &
	.union(B0,B1,C0) &
	.union(B2,B3,C1) &
	.union(C0,C1,D0) &
	.union(D0,A8,Final).


/* Halla todas las parejas */
parejasHorizontales(Final,J):-
	parejaHorizontalIzquierda(A,J) &
	parejaHorizontalDerecha(B,J) &
	parejaHorizontalCentral(C,J) &
	parejaHorizontalSeparadaIzquierda(D,J) &
	parejaHorizontalSeparadaIzquierda(E,J) &
	parejaHorizontalSeparadaCentro(F,J) &
	.union(A,B,L) &
	.union(C,D,L2) &
	.union(E,F,L3) &
	.union(L,L2,L4) &
	.union(L4,L3,Final).
parejasDiagonales(Final,J):-
	parejaDiagonalAlphaIzquierda(A,J) &
	parejaDiagonalAlphaDerecha(B,J) &
	parejaDiagonalAlphaCentral(C,J) &
	parejaDiagonalAlphaSeparadaIzq(D,J) &
	parejaDiagonalAlphaSeparadaDer(E,J) &
	parejaDiagonalAlphaSeparadaCentro(F,J) &
	parejaDiagonalBetaIzquierda(G,J) &
	parejaDiagonalBetaDerecha(H,J) &
	parejaDiagonalBetaCentral(I,J) &
	parejaGeDiagonalBetaSeparadaIzq(K,J) &
	parejaGeneraTrioDiagonalSeparadaDer(L,J) &
	parejaDiagonalBetaSeparadaCentro(M,J) &
	.union(A,B,L) &
	.union(C,D,L2) &
	.union(E,F,L3) &
	.union(G,H,L4) &
	.union(I,K,L5) &
	.union(L,M,L6) &
	.union(L,L2,L7) &
	.union(L3,L4,L8) &
	.union(L5,L6,L9) &
	.union(L7,L8,L10) &
	.union(L9,L10,Final).


/* Halla las jugadas comunes */
jugadasComunes(I2,J):-
		parejasHorizontales(ParejasH,J) &
		parejasDiagonales(ParejasD,J) &
		parejaVertical(ParejasV,J) & 
		.union(ParejasH,ParejasD,A0) &
		.union(A0,ParejasV,A1) &
		.union(A1,ParejasD,A2).



/*----------------------------------------------------------------------------*/



/*-------------------------------MIN MAX--------------------------------------*/

/*Minimizar la puntuación de una lista de movimientos */
minimizarLista(X,[],X).
minimizarLista(Puntos0,[Puntos1|Tail],Puntos):-
	Puntos1 <= Puntos0 &
	minimizarLista(Puntos1,Tail,Puntos).
minimizarLista(Puntos0,[Puntos1|Tail],Puntos):-
	Puntos1 > Puntos0 &
	minimizarLista(Puntos0,Tail,Puntos).


/*Minimizar la puntuación de una lista de movimientos */
maximizarLista(X,[],X).
maximizarLista(Puntos0,[Puntos1|Tail],Puntos):-
	Puntos1 >= Puntos0 &
	maximizarLista(Puntos1,Tail,Puntos).
maximizarLista(Puntos0,[Puntos1|Tail],Puntos):-
	Puntos1 < Puntos0 &
	maximizarLista(Puntos0,Tail,Puntos).


/* Si gana devuelve 50 jugar a ganar*/
minMax(_,Profundidad,50,Maximizar):-
	//.print("GANAR") &
	estrategia(jugarAGanar)[source(percept)] &
	jugador(Jugador)[source(self)] &
	cuatroEnRaya(Jugador).
	//.print("FIN GANAR").
/* Si pierde devuelve -50 jugar a ganar*/
minMax(_,Profundidad,-50,Maximizar):-
	//.print("GANAR") &
	estrategia(jugarAGanar)[source(percept)] &
	oponente(O)[source(self)] &
	cuatroEnRaya(O).
	//.print("FIN GANAR").
/* Si gana devuelve -50 jugar a perder*/
minMax(_,Profundidad,-50,Maximizar):-
	//.print("GANAR") &
	estrategia(jugarAPerder)[source(percept)] &
	jugador(Jugador)[source(self)] &
	cuatroEnRaya(Jugador).
	//.print("FIN GANAR").
/* Si pierde devuelve 50 jugar a perder*/
minMax(_,Profundidad,50,Maximizar):-
	//.print("GANAR") &
	estrategia(jugarAPerder)[source(percept)] &
	oponente(O)[source(self)] &
	cuatroEnRaya(O).
	//.print("FIN GANAR").
/* En caso de empate*/
minMax(_,Profundidad,0,Maximizar):-
	//.print("EMPATE minMax") &
	not comprobarCeldasLibres &
	nadieGano.
	//.print("FIN EMPATE minMax").
/* Caso base */
minMax(_,0,Puntos1+Puntos2,Maximizar):-
	//.print("Caso base") &
	jugador(Jugador)[source(self)] &
	oponente(Oponente)[source(self)] &
	estrategia(Estrategia)[source(percept)] &
	evaluarTablero(Jugador,Estrategia,Puntos1) &
	evaluarTablero(Oponente,Estrategia,Puntos2).
	//.print("FIN Caso base").
/* Turno de maximizar */
minMax(_,Profundidad,Puntos,Maximizar):-
	Profundidad > 0 &
	//.print("MAXIMIZAR minMax") &
	Maximizar &
	oponente(Jugador[source(self)]) &
	//.print("DATOS:(","0 - ",Jugador2," - ",Profundidad-1," - ","not true",")") &
	iterar(0,Jugador,Profundidad-1,not true,LMovimientos) &
	maximizarLista(-500,LMovimientos,Puntos).
	//.print("FIN MAXIMIZAR minMax").
/* Turno de minimizar */
minMax(Jugador,Profundidad,Puntos,Maximizar):-
	Profundidad > 0 &
	//.print("MINIMIZAR minMax") &
	not Maximizar &
	jugador(Jugador)[source(self)] &
	//.print("DATOS:(","0 - ",Jugador2," - ",Profundidad-1," - ","true",")") &
	iterar(0,Jugador,Profundidad-1,true,LMovimientos) &
	minimizarLista(500,LMovimientos,Puntos).
	//.print("FIN MINIMIZAR minMax").


/* Ya se recorrieron todas las posibilidades de movimientos */
iterar(Columna,Jugador,Profundidad,Maximizar,[]):-
	(Columna >= 8).
/* Si no se puede colocar ficha en la columna */
iterar(Columna,Jugador,Profundidad,Maximizar,0):-
	(Columna >= 0 & Columna < 8) &
	comprobarCeldasLibres &
	not comprobarCeldaLibreEnColumna(Columna,Fila) &
	iterar(Columna+1,Jugador,Profundidad,Maximizar,LMovimientos).
/* Para cada movimiento */
iterar(Columna,Jugador,Profundidad,Maximizar,[Puntos|LMovimientos]):-
	(Columna >= 0 & Columna < 8) &
	comprobarCeldasLibres &
	comprobarCeldaLibreEnColumna(Columna,Fila) &
	posicion(Columna,Fila,W)[source(self)] &
	.abolish(posicion(Columna,Fila,W)) &
	.asserta(posicion(Columna,Fila,Jugador)) &
	minMax(Jugador,Profundidad,Puntos,Maximizar) &
	.abolish(posicion(Columna,Fila,Jugador)) &
	.asserta(posicion(Columna,Fila,W)) &
	iterar(Columna+1,Jugador,Profundidad,Maximizar,LMovimientos).
/*----------------------------------------------------------------------------*/



/*------------------------PATRONES DEL TABLERO--------------------------------*/
/* Comprueba si hay un cuatro en raya en el posicion */
cuatroEnRayaVertical(J):-
	posicion(X,Y,J)[source(self)] &
	posicion(X,Y+1,J)[source(self)] &
	posicion(X,Y+2,J)[source(self)] &
	posicion(X,Y+3,J)[source(self)].
cuatroEnRayaHorizontal(J):-
	posicion(X,Y,J)[source(self)] &
	posicion(X+1,Y,J)[source(self)] &
	posicion(X+2,Y,J)[source(self)] &
	posicion(X+3,Y,J)[source(self)].
cuatroEnRayaDiagonalAlpha(J):-
	posicion(X,Y,J)[source(self)] &
	posicion(X+1,Y+1,J)[source(self)] &
	posicion(X+2,Y+2,J)[source(self)] &
	posicion(X+3,Y+3,J)[source(self)].
cuatroEnRayaDiagonalBeta(J):-
	posicion(X,Y,J)[source(self)] &
	posicion(X-1,Y+1,J)[source(self)] &
	posicion(X-2,Y+2,J)[source(self)] &
	posicion(X-3,Y+3,J)[source(self)].


/* Posiciones en las que ganas siempre: +20 */
ganarSiempreHorizontal([pos(X0,Y),pos(X0+4,Y)],J):-//TESTED
	posicion(X0,Y,0)[source(self)] &
	posicion(X0+1,Y,J)[source(self)] &
	posicion(X0+2,Y,J)[source(self)] &
	posicion(X0+3,Y,J)[source(self)] &
	posicion(X0+4,Y,0)[source(self)] &
	puedeColocar(X0,Y) &
	puedeColocar(X0+4,Y).
ganarSiempreHorizontal([],J).

ganarSiempreDiagonalAlpha([pos(X0,Y0),pos(X0+4,Y0+4)],J):-//TESTED
	posicion(X0,Y0,0)[source(self)] &
	posicion(X0+1,Y0+1,J)[source(self)] &
	posicion(X0+2,Y0+2,J)[source(self)] &
	posicion(X0+3,Y0+3,J)[source(self)] &
	posicion(X0+4,Y0+4,0)[source(self)] &
	puedeColocar(X0,Y0) &
	puedeColocar(X0+4,Y0+4).//TESTED
ganarSiempreDiagonalAlpha([],J).

ganarSiempreDiagonalBeta([pos(X0,Y0),pos(X0-4,Y0+4)],J):-//TESTED
	posicion(X0,Y0,0)[source(self)] &
	posicion(X0-1,Y0+1,J)[source(self)] &
	posicion(X0-2,Y0+2,J)[source(self)] &
	posicion(X0-3,Y0+3,J)[source(self)] &
	posicion(X0-4,Y0+4,0)[source(self)] &
	puedeColocar(X0,Y0) &
	puedeColocar(X0-4,Y0+4).
ganarSiempreDiagonalBeta([],J).


/* Posiciones en las que tienes un tres en raya con solo una libre: +20*/
tresEnRayaVertical([pos(X,Y0)],J):-//TESTED
	posicion(X,Y0,0)[source(self)] &
	posicion(X,Y0+1,J)[source(self)] &
	posicion(X,Y0+2,J)[source(self)] &
	posicion(X,Y0+3,J)[source(self)].
tresEnRayaVertical([],J).

tresEnRayaHorizontalIzquierda([pos(X0,Y)],J):-//TESTED
	posicion(X0,Y,0)[source(self)] &
	posicion(X0+1,Y,J)[source(self)] &
	posicion(X0+2,Y,J)[source(self)] &
	posicion(X0+3,Y,J)[source(self)] &
	puedeColocar(X0,Y).
tresEnRayaHorizontalIzquierda([],J).

tresEnRayaHorizontalDerecha([pos(X0+3,Y)],J):-//TESTED
	posicion(X0,Y,J)[source(self)] &
	posicion(X0+1,Y,J)[source(self)] &
	posicion(X0+2,Y,J)[source(self)] &
	posicion(X0+3,Y,0)[source(self)] &
	puedeColocar(X0+3,Y).
tresEnRayaHorizontalDerecha([],J).

tresEnRayaDiagonalAlphaDerechaAbajo([pos(X0,Y0)],J):-//TESTED
	posicion(X0,Y0,0)[source(self)] &
	posicion(X0+1,Y0+1,J)[source(self)] &
	posicion(X0+2,Y0+2,J)[source(self)] &
	posicion(X0+3,Y0+3,J)[source(self)] &
	puedeColocar(X0,Y0).
tresEnRayaDiagonalAlphaDerechaAbajo([],J).
	
tresEnRayaDiagonalAlphaIzquierdaArriba([pos(X0+3,Y0+3)],J):-//TESTED
	posicion(X0,Y0,J)[source(self)] &
	posicion(X0+1,Y0+1,J)[source(self)] &
	posicion(X0+2,Y0+2,J)[source(self)] &
	posicion(X0+3,Y0+3,0)[source(self)] &
	puedeColocar(X0+3,Y0+3).
tresEnRayaDiagonalAlphaIzquierdaArriba([],J).

tresEnRayaDiagonalBetaDerechaArriba([pos(X0,Y0)],J):-//TESTED
	posicion(X0,Y0,0)[source(self)] &
	posicion(X0-1,Y0+1,J)[source(self)] &
	posicion(X0-2,Y0+2,J)[source(self)] &
	posicion(X0-3,Y0+3,J)[source(self)] &
	puedeColocar(X0,Y0).
tresEnRayaDiagonalBetaDerechaArriba([],J).

tresEnRayaDiagonalBetaIzquierdaAbajo([pos(X0-3,Y0+3)],J):-//TESTED
	posicion(X0,Y0,J)[source(self)] &
	posicion(X0-1,Y0+1,J)[source(self)] &
	posicion(X0-2,Y0+2,J)[source(self)] &
	posicion(X0-3,Y0+3,0)[source(self)] &
	puedeColocar(X0-3,Y0+3).
tresEnRayaDiagonalBetaIzquierdaAbajo([],J).


/* Posiciones en las que hay tres en cuatro y una para ganar: */
tresEnCuatroHorizontalCentroDerecha([pos(X0+2,Y)],J):-//TESTED
	posicion(X0,Y,J)[source(self)] &
	posicion(X0+1,Y,J)[source(self)] &
	posicion(X0+2,Y,0)[source(self)] &
	posicion(X0+3,Y,J)[source(self)] &
	puedeColocar(X0+2,Y).
tresEnCuatroHorizontalCentroDerecha([],J).

tresEnCuatroHorizontalCentroIzquierda([pos(X0+1,Y)],J):-//TESTED
	posicion(X0,Y,J)[source(self)] &
	posicion(X0+1,Y,0)[source(self)] &
	posicion(X0+2,Y,J)[source(self)] &
	posicion(X0+3,Y,J)[source(self)] &
	puedeColocar(X0+1,Y).
tresEnCuatroHorizontalCentroIzquierda([],J).

tresEnCuatroDiagonalAlphaCentroDerecha([pos(X0+2,Y0+2)],J):-//TESTED
	posicion(X0,Y0,J)[source(self)] &
	posicion(X0+1,Y0+1,J)[source(self)] &
	posicion(X0+2,Y0+2,0)[source(self)] &
	posicion(X0+3,Y0+3,J)[source(self)] &
	puedeColocar(X0+2,Y0+2).
tresEnCuatroDiagonalAlphaCentroDerecha([],J).

tresEnCuatroDiagonalAlphaCentroIzquierda([pos(X0+1,Y0+1)],J):-//TESTED
	posicion(X0,Y0,J)[source(self)] &
	posicion(X0+1,Y0+1,0)[source(self)] &
	posicion(X0+2,Y0+2,J)[source(self)] &
	posicion(X0+3,Y0+3,J)[source(self)] &
	puedeColocar(X0+1,Y0+1).
tresEnCuatroDiagonalAlphaCentroIzquierda([],J).

tresEnCuatroDiagonalBetaCentroDerecha([pos(X0-2,Y0+2)],J):-//TESTED
	posicion(X0,Y0,J)[source(self)] &
	posicion(X0-1,Y0+1,J)[source(self)] &
	posicion(X0-2,Y0+2,0)[source(self)] &
	posicion(X0-3,Y0+3,J)[source(self)] &
	puedeColocar(X0-2,Y0+2).
tresEnCuatroDiagonalBetaCentroDerecha([],J).

tresEnCuatroDiagonalBetaCentroIzquierda([pos(X0-1,Y0+1)],J):-//TESTED
	posicion(X0,Y0,J)[source(self)] &
	posicion(X0-1,Y0+1,0)[source(self)] &
	posicion(X0-2,Y0+2,J)[source(self)] &
	posicion(X0-3,Y0+3,J)[source(self)] &
	puedeColocar(X0-1,Y0+1).
tresEnCuatroDiagonalBetaCentroIzquierda([],J).


/* Parejas horizontal que generan un trio que gana siempre: */
parejaGanadoraHorizontalDerecha([pos(X0+3,Y)],J):-
	posicion(X0,Y,0)[source(self)] &
	posicion(X0+1,Y,J)[source(self)] &
	posicion(X0+2,Y,J)[source(self)] &
	posicion(X0+3,Y,0)[source(self)] &
	posicion(X0+4,Y,0)[source(self)] &
	puedeColocar(X0+3,Y).
parejaGanadoraHorizontalDerecha([],J).

parejaGanadoraHorizontalIzquierda([pos(X0+1,Y)],J):-
	posicion(X0,Y,0)[source(self)] &
	posicion(X0+1,Y,0)[source(self)] &
	posicion(X0+2,Y,J)[source(self)] &
	posicion(X0+3,Y,J)[source(self)] &
	posicion(X0+4,Y,0)[source(self)] &
	puedeColocar(X0+1,Y).
parejaGanadoraHorizontalIzquierda([],J).

parejaGanadoraHorizontalCentral([pos(X0+2,Y)],J):-
	posicion(X0,Y,0)[source(self)] &
	posicion(X0+1,Y,J)[source(self)] &
	posicion(X0+2,Y,0)[source(self)] &
	posicion(X0+3,Y,J)[source(self)] &
	posicion(X0+4,Y,0)[source(self)] &
	puedeColocar(X0+2,Y).
parejaGanadoraHorizontalCentral([],J).

parejaGanadoraDiagonalAlphaDerecha([pos(X0+3,Y0+3)],J):-
	posicion(X0,Y0,0)[source(self)] &
	posicion(X0+1,Y0+1,J)[source(self)] &
	posicion(X0+2,Y0+2,J)[source(self)] &
	posicion(X0+3,Y0+3,0)[source(self)] &
	posicion(X0+4,Y0+4,0)[source(self)] &
	puedeColocar(X0+3,Y0+3).
parejaGanadoraDiagonalAlphaDerecha([],J).

parejaGanadoraDiagonalAlphaIzquierda([pos(X0+1,Y0+1)],J):-
	posicion(X0,Y0,0)[source(self)] &
	posicion(X0+1,Y0+1,0)[source(self)] &
	posicion(X0+2,Y0+2,J)[source(self)] &
	posicion(X0+3,Y0+3,J)[source(self)] &
	posicion(X0+4,Y0+4,0)[source(self)] &
	puedeColocar(X0+1,Y0+1).
parejaGanadoraDiagonalAlphaIzquierda([],J).

parejaGanadoraDiagonalAlphaCentral([pos(X0+2,Y0+2)],J):-
	posicion(X0,Y0,0)[source(self)] &
	posicion(X0+1,Y0+1,J)[source(self)] &
	posicion(X0+2,Y0+2,0)[source(self)] &
	posicion(X0+3,Y0+3,J)[source(self)] &
	posicion(X0+4,Y0+4,0)[source(self)] &
	puedeColocar(X0+2,Y0+2).
parejaGanadoraDiagonalAlphaCentral([],J).

parejaGanadoraDiagonalBetaIzquierda([pos(X0+3,Y0+3)],J):-
	posicion(X0,Y0,0)[source(self)] &
	posicion(X0-1,Y0+1,J)[source(self)] &
	posicion(X0-2,Y0+2,J)[source(self)] &
	posicion(X0-3,Y0+3,0)[source(self)] &
	posicion(X0-4,Y0+4,0)[source(self)] &
	puedeColocar(X0-3,Y0+3).
parejaGanadoraDiagonalBetaIzquierda([],J).

parejaGanadoraDiagonalBetaDerecha([pos(X0-1,Y0+1)],J):-
	posicion(X0,Y0,0)[source(self)] &
	posicion(X0-1,Y0+1,0)[source(self)] &
	posicion(X0-2,Y0+2,J)[source(self)] &
	posicion(X0-3,Y0+3,J)[source(self)] &
	posicion(X0-4,Y0+4,0)[source(self)] &
	puedeColocar(X0-1,Y0+1).
parejaGanadoraDiagonalBetaDerecha([],J).

parejaGanadoraDiagonalBetaCentral([pos(X0-2,Y0+2)],J):-
	posicion(X0,Y0,0)[source(self)] &
	posicion(X0-1,Y0+1,J)[source(self)] &
	posicion(X0-2,Y0+2,0)[source(self)] &
	posicion(X0-3,Y0+3,J)[source(self)] &
	posicion(X0-4,Y0+4,0)[source(self)] &
	puedeColocar(X0-2,Y0+2).
parejaGanadoraDiagonalBetaCentral([],J).

/* Parejas que generan un trio: */
/* Horizontales */
parejaHorizontalIzquierda([pos(X0+2,Y)],J):-
	posicion(X0,Y,J)[source(self)] &
	posicion(X0+1,Y,J)[source(self)] &
	posicion(X0+2,Y,0)[source(self)] &
	posicion(X0+3,Y,0)[source(self)] &
	puedeColocar(X0+2,Y).
parejaHorizontalIzquierda([],J).

parejaHorizontalDerecha([pos(X0+1,Y)],J):-
	posicion(X0,Y,0)[source(self)] &
	posicion(X0+1,Y,0)[source(self)] &
	posicion(X0+2,Y,J)[source(self)] &
	posicion(X0+3,Y,J)[source(self)] &
	puedeColocar(X0+1,Y).
parejaHorizontalDerecha([],J).

parejaHorizontalCentral([pos(X0,Y)],J):-
	posicion(X0,Y,0)[source(self)] &
	posicion(X0+1,Y,J)[source(self)] &
	posicion(X0+2,Y,J)[source(self)] &
	posicion(X0+3,Y,0)[source(self)] &
	puedeColocar(X0,Y).
parejaHorizontalCentral([],J).

parejaHorizontalSeparadaIzquierda([pos(X0+1,Y)],J):-
	posicion(X0,Y,J)[source(self)] &
	posicion(X0+1,Y,0)[source(self)] &
	posicion(X0+2,Y,J)[source(self)] &
	posicion(X0+3,Y,0)[source(self)] &
	puedeColocar(X+1,Y).
parejaHorizontalSeparadaIzquierda([],J).

parejaHorizontalSeparadaIzquierda([pos(X0+2,Y)],J):-
	posicion(X0,Y,0)[source(self)] &
	posicion(X0+1,Y,J)[source(self)] &
	posicion(X0+2,Y,0)[source(self)] &
	posicion(X0+3,Y,J)[source(self)] &
	puedeColocar(X0+2,Y).
parejaHorizontalSeparadaIzquierda([],J).

parejaHorizontalSeparadaCentro([pos(X0+1,Y)],J):-
	posicion(X0,Y,J)[source(self)] &
	posicion(X0+1,Y,0)[source(self)] &
	posicion(X0+2,Y,0)[source(self)] &
	posicion(X0+3,Y,J)[source(self)] &
	puedeColocar(X0+1,Y).
parejaHorizontalSeparadaCentro([],J).

/* Verticales */
parejaVertical([pos(X0,Y)],J):- 
    posicion(X0,Y,0)[source(self)] & 
    posicion(X0,Y+1,J)[source(self)] &
    posicion(X0,Y+2,J)[source(self)].
parejaVertical([],J).

/* Diagonales Alpha */ 
parejaDiagonalAlphaIzquierda([pos(X0+2,Y0+2)],J):-
	posicion(X0,Y0,J)[source(self)] &
	posicion(X0+1,Y0+1,J)[source(self)] &
	posicion(X0+2,Y0+2,0)[source(self)] &
	posicion(X0+3,Y0+3,0)[source(self)] &
	puedeColocar(X0+2,Y0+2).
parejaDiagonalAlphaIzquierda([],J).

parejaDiagonalAlphaDerecha([pos(X0+1,Y0+1)],J):-
	posicion(X0,Y0,0)[source(self)] &
	posicion(X0+1,Y0+1,0)[source(self)] &
	posicion(X0+2,Y0+2,J)[source(self)] &
	posicion(X0+3,Y0+3,J)[source(self)] &
	puedeColocar(X0+1,Y0+1).
parejaDiagonalAlphaDerecha([],J).

parejaDiagonalAlphaCentral([pos(X0,Y0)],J):-
	posicion(X0,Y0,0)[source(self)] &
	posicion(X0+1,Y0+1,J)[source(self)] &
	posicion(X0+2,Y0+2,J)[source(self)] &
	posicion(X0+3,Y0+3,0)[source(self)] &
	puedeColocar(X0,Y0).
parejaDiagonalAlphaCentral([],J).

parejaDiagonalAlphaSeparadaIzq([pos(X0+1,Y0+1)],J):-
	posicion(X0,Y0,J)[source(self)] &
	posicion(X0+1,Y0+1,0)[source(self)] &
	posicion(X0+2,Y0+2,J)[source(self)] &
	posicion(X0+3,Y0+3,0)[source(self)] &
	puedeColocar(X0+1,Y0+1).
parejaDiagonalAlphaSeparadaIzq([],J).

parejaDiagonalAlphaSeparadaDer([pos(X0+2,Y0+2)],J):-
	posicion(X0,Y0,0)[source(self)] &
	posicion(X0+1,Y0+1,J)[source(self)] &
	posicion(X0+2,Y0+2,0)[source(self)] &
	posicion(X0+3,Y0+3,J)[source(self)] &
	puedeColocar(X0+2,Y0+2).
parejaDiagonalAlphaSeparadaDer([],J).

parejaDiagonalAlphaSeparadaCentro([pos(X0+1,Y0+1)],J):-
	posicion(X0,Y0,J)[source(self)] &
	posicion(X0+1,Y0+1,0)[source(self)] &
	posicion(X0+2,Y0+2,0)[source(self)] &
	posicion(X0+3,Y0+3,J)[source(self)] &
	puedeColocar(X0+1,Y0+1).
parejaDiagonalAlphaSeparadaCentro([],J).

/* Diagonales Beta */
parejaDiagonalBetaIzquierda([pos(X0+2,Y0+2)],J):-
	posicion(X0,Y0,J)[source(self)] &
	posicion(X0+1,Y0+1,J)[source(self)] &
	posicion(X0+2,Y0+2,0)[source(self)] &
	posicion(X0+3,Y0+3,0)[source(self)] &
	puedeColocar(X0+2,Y0+2).
parejaDiagonalBetaIzquierda([],J).

parejaDiagonalBetaDerecha([pos(X0+1,Y0+1)],J):-
	posicion(X0,Y0,0)[source(self)] &
	posicion(X0-1,Y0+1,0)[source(self)] &
	posicion(X0-2,Y0+2,J)[source(self)] &
	posicion(X0-3,Y0+3,J)[source(self)] &
	puedeColocar(X0-1,Y0+1).
parejaDiagonalBetaDerecha([],J).

parejaDiagonalBetaCentral([pos(X0,Y0)],J):-
	posicion(X0,Y0,0)[source(self)] &
	posicion(X0-1,Y0+1,J)[source(self)] &
	posicion(X0-2,Y0+2,J)[source(self)] &
	posicion(X0-3,Y0+3,0)[source(self)] &
	puedeColocar(X0,Y0).
parejaDiagonalBetaCentral([],J).

parejaGeDiagonalBetaSeparadaIzq([pos(X0-1,Y0+1)],J):-
	posicion(X0,Y0,J)[source(self)] &
	posicion(X0-1,Y0+1,0)[source(self)] &
	posicion(X0-2,Y0+2,J)[source(self)] &
	posicion(X0-3,Y0+3,0)[source(self)] &
	puedeColocar(X0-1,Y0+1).
parejaGeDiagonalBetaSeparadaIzq([],J).

parejaGeneraTrioDiagonalSeparadaDer([pos(X0-2,Y0+2)],J):-
	posicion(X0,Y0,0)[source(self)] &
	posicion(X0-1,Y0+1,J)[source(self)] &
	posicion(X0-2,Y0+2,0)[source(self)] &
	posicion(X0-3,Y0+3,J)[source(self)] &
	puedeColocar(X0-2,Y0+2).
parejaGeneraTrioDiagonalSeparadaDer([],J).

parejaDiagonalBetaSeparadaCentro([pos(X0-1,Y0+1)],J):-
	posicion(X0,Y0,J)[source(self)] &
	posicion(X0-1,Y0+1,0)[source(self)] &
	posicion(X0-2,Y0+2,0)[source(self)] &
	posicion(X0-3,Y0+3,J)[source(self)] &
	puedeColocar(X0-1,Y0+1).
parejaDiagonalBetaSeparadaCentro([],J).

/* Solo una ficha */
solitaGeneraHorizontal([pos(X0+1,Y0)],J):-
	posicion(X0,Y0,J)[source(self)] &
	posicion(X0+1,Y0,0)[source(self)] & 
	posicion(X0+2,Y0,0)[source(self)] &
	posicion(X0+3,Y0,0)[source(self)] &
	puedeColocar(X0+1,Y0).
solitaGeneraHorizontal([],J).

solitaGeneraVertical([pos(X0,Y0-1)],J):-
	posicion(X0,Y0,J)[source(self)] &
	posicion(X0,Y0-1,0)[source(self)] & 
	posicion(X0,Y0-2,0)[source(self)] &
	posicion(X0,Y0-3,0)[source(self)] &
	puedeColocar(X0,Y0-1).
solitaGeneraVertical([],J).

solitaGeneraDiagonalAlpha([pos(X0-1,Y0-1)],J):-
	posicion(X0,Y0,J)[source(self)] &
	posicion(X0-1,Y0-1,0)[source(self)] & 
	posicion(X0-2,Y0-2,0)[source(self)] &
	posicion(X0-3,Y0-3,0)[source(self)] &
	puedeColocar(X0-1,Y0-1).
solitaGeneraDiagonalAlpha([],J).

solitaGeneraDiagonalBeta([pos(X0+1,Y0-1)],J):-
	posicion(X0,Y0,J)[source(self)] &
	posicion(X0+1,Y0-1,0)[source(self)] & 
	posicion(X0+2,Y0-2,0)[source(self)] &
	posicion(X0+3,Y0-3,0)[source(self)] &
	puedeColocar(X0+1,Y0-1).
solitaGeneraDiagonalBeta([],J).
/*----------------------------------------------------------------------------*/
fichaEnemiga(X):-
	oponente(J)[source(self)] &
	tablero(X,Y,J)[source(percept)] &
	tablero(X,Y-1,0)[source(percept)].


/* INITIAL GOALS */


!comienzo.


/* PLANS */

/*----------------------------------------------------------------------------*/
/*-----------------------JUEGAR A PERDER DE SEGUNDO---------------------------*/
/*----------------------------------------------------------------------------*/
/*	Busca la primera ficha del rival que no tenga una ficha del jugador colocada
[source(self)]	encima y coloca su ficha encima de la del rival */		
+!jugarAperderSegundo[source(self)]:
	quienSoy(Jugador,Rival) &
	posicion(X,Y,Rival)[source(self)] &
	posicion(X,Y-1,0)[source(self)] <-
		put(X);
		!jugar.
/*----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*/
/*---------------------CREAR-BORRAR TABLERO TEMPORAL--------------------------*/
/*----------------------------------------------------------------------------*/
+!copiarTablero(Columna,Fila)[source(self)]:
	(Columna >= 0 & Columna < 8) &
	(Fila >= 0 & Fila < 8) <-	
		?tablero(Columna,Fila,Jugador)[source(percept)];
		.asserta(posicion(Columna,Fila,Jugador));
		!copiarTablero(Columna,Fila+1).
+!copiarTablero(Columna,Fila)[source(self)]:
	(Columna >= 0 & Columna < 8) &
	Fila = 8 <-
		!copiarTablero(Columna+1,0).
+!copiarTablero(Columna,Fila)[source(self)]:
	Columna >= 8 <-
		.print("Se ha generado el tablero temporal").//;
		//!borrarTablero.

+!borrarTablero[source(self)] <-
	.abolish(posicion(_,_,_)).
/*----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*/
/*-----------------------ENCONTRAR MEJOR MOVIMIENTO---------------------------*/
/*----------------------------------------------------------------------------*/

// Si no hay celdas libres
+!encontrarMejorMovimiento(Columna,Profundidad)[source(self)]:
	not comprobarCeldasLibres <-
		!jugar.
// Si no se puede colocar en la columna
+!encontrarMejorMovimiento(Columna,Profundidad)[source(self)]: 
	(Columna < 8 & Columna >= 0) &
	comprobarCeldasLibres &
	not comprobarCeldaLibreEnColumna(Columna,Fila) <-
		!encontrarMejorMovimiento(Columna+1,Profundidad).
// Si se puede colocar ficha en la columna
+!encontrarMejorMovimiento(Columna,Profundidad)[source(self)]:
	(Columna < 8 & Columna >= 0) &
	comprobarCeldasLibres &
	comprobarCeldaLibreEnColumna(Columna,Fila) &
	jugador(Jugador)[source(self)] <-
		?posicion(Columna,Fila,0);
		-posicion(Columna,Fila,0);
		+posicion(Columna,Fila,Jugador);
		.print("Columna: ",Columna,"-Fila: ",Fila,"- Ocupado por: ",Jugador);
		?minMax(Jugador,Profundidad,Puntos,true);
		.print("Acabo el minMax para columna: ",Columna," con ", Puntos);
		!maximizar(Columna,Fila,Puntos);
		-posicion(Columna,Fila,Jugador);
		+posicion(Columna,Fila,0);
		!encontrarMejorMovimiento(Columna+1,Profundidad).
// Si ya has comprobado todas las columnas
+!encontrarMejorMovimiento(Columna,Profundidad)[source(self)]: 
	Columna >= 8 &
	movimientoMaximizado(X,Y,Puntos) <-
		.print("Encontrado el mejor movimiento...").
/*----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*/
/*-----------------------ENCONTRAR PEOR MOVIMIENTO---------------------------*/
/*----------------------------------------------------------------------------*/

// Si no hay celdas libres
+!encontrarPeorMovimiento(Columna,Profundidad)[source(self)]:
	not comprobarCeldasLibres <-
		!jugar.
// Si no se puede colocar en la columna
+!encontrarPeorMovimiento(Columna,Profundidad)[source(self)]: 
	(Columna < 8 & Columna >= 0) &
	comprobarCeldasLibres &
	not comprobarCeldaLibreEnColumna(Columna,Fila) <-
		!encontrarPeorMovimiento(Columna+1,Profundidad).
// Si se puede colocar ficha en la columna
+!encontrarPeorMovimiento(Columna,Profundidad)[source(self)]:
	(Columna < 8 & Columna >= 0) &
	comprobarCeldasLibres &
	comprobarCeldaLibreEnColumna(Columna,Fila) &
	jugador(Jugador)[source(self)] <-
		?posicion(Columna,Fila,0);
		-posicion(Columna,Fila,0);
		+posicion(Columna,Fila,Jugador);
		.print("Columna: ",Columna," - Fila: ",Fila," - Ocupado por: ",Jugador);
		?minMax(Jugador,Profundidad,Puntos,true);
		.print("Acabo el minMax para columna: ",Columna," con ", Puntos);
		!maximizar(Columna,Fila,Puntos);
		-posicion(Columna,Fila,Jugador);
		+posicion(Columna,Fila,0);
		!encontrarPeorMovimiento(Columna+1,Profundidad).
// Si ya has comprobado todas las columnas
+!encontrarPeorMovimiento(Columna,Profundidad)[source(self)]:
	Columna >= 8 &
	movimientoMinimizado(X,Y,Puntos) <-
		.print("Encontrado el peor movimiento...").
/*----------------------------------------------------------------------------*/




/*----------------------------------------------------------------------------*/
/*---------------------------MINIMIZAR-MAXIMIZAR------------------------------*/
/*----------------------------------------------------------------------------*/
+!maximizar(X,Y,Puntos)[source(self)]:
	movimientoMaximizado(X1,Y1,Puntos1)[source(self)] &
	Puntos >= Puntos1 <-
		-movimientoMaximizado(X1,Y1,Puntos1);
		+movimientoMaximizado(X,Y,Puntos).
+!maximizar(X,Y,Puntos)[source(self)].


+!minimizar(X,Y,Puntos)[source(self)]:
	movimientoMinizado(X1,Y1,Puntos1)[source(self)] &
	Puntos <= Puntos1 <-
		-movimientoMinizado(X1,Y1,Puntos1);
		+movimientoMinizado(X,Y,Puntos).
+!minimizar(X,Y,Puntos)[source(self)].
/*----------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------*/
/*---------------------------------TURNOS-------------------------------------*/
/*----------------------------------------------------------------------------*/
/* Define elementos iniciales tales como el primer turno */
+!comienzo[source(self)]:
	turno(X)[source(percept)] &
	.my_name(X) &
	quienSoy(X1,Y1) <- 
		+jugador(X1);
		+oponente(Y1);
		!jugar.
+!comienzo[source(self)]:
	turno(X)[source(percept)] &
	not .my_name(X) &
	quienSoy(X1,Y1) <- 
		+jugador(X1);
		+oponente(Y1);
		!jugar.
+!comienzo[source(self)] <- 
	.wait(50); 
	!comienzo.
/*----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*/
/*---------------------------------JUGAR--------------------------------------*/
/*----------------------------------------------------------------------------*/
/* Gestiona la partida cuando juega a ganar y empieza */
+!jugar[source(self)]:
	turno(X)[source(percept)] &
	.my_name(X) &
	oponente(J) &
	estrategia(jugarAGanar)[source(percept)] &
	not tablero(Columna,Fila,J)[source(percept)] <-
		put(4);
		.wait(1000);
		!jugar.

/* Gestiona la partida cuando juega a ganar y empieza segundo */
+!jugar[source(self)]:
	turno(X)[source(percept)] &
	.my_name(X) &
	estrategia(jugarAGanar)[source(percept)] <-
		!borrarTablero;
		!copiarTablero(0,0);
		+movimientoMaximizado(-1,-1,-500);
		!encontrarMejorMovimiento(0,1);
		?movimientoMaximizado(Columna,Fila,P);
		put(Columna);
		.wait(1000);
		.abolish(movimientoMaximizado(_,_,_));
		!jugar.

/* Gestiona la partida cuando juega a perder y empieza segundo */
+!jugar[source(self)]:
	turno(X)[source(percept)] &
	.my_name(X) &
	estrategia(jugarAPerder)[source(percept)] &
	fichaEnemiga(Y) <-
		put(Y);
		!jugar.

/* Gestiona la partida cuando juega a perder y empieza primero */
+!jugar[source(self)]:
	turno(X)[source(percept)] &
	.my_name(X) &
	jugador(J) &
	estrategia(jugarAPerder)[source(percept)] &
	not tablero(Columna,Fila,J)[source(percept)] <-
		put(4);
		!jugar.

/* Gestiona la partida cuando juega a perder y empezó primero*/
+!jugar[source(self)]:
	turno(X)[source(percept)] &
	.my_name(X) &
	estrategia(jugarAPerder)[source(percept)] <-
		!borrarTablero;
		!copiarTablero(0,0);
		+movimientoMaximizado(-1,-1,-500);
		!encontrarPeorMovimiento(0,1);
		?movimientoMaximizado(Columna,Fila,P);
		put(Columna)
		.abolish(movimientoMaximizado(_,_,_));
		!jugar.

		


/* Si es el turno del oponente no [source(self)]hace nada */
+!jugar[source(self)] <-
	//.print("Tengo que esperar a mi turno...");
	.wait(500);
	!jugar. 
/*----------------------------------------------------------------------------*/



/*---------------------------------ERRORES------------------------------------*/
+!encontrarMejorMovimiento(_,_)[source(_)] <- 
	.print("Error en +!encontrarMejorMovimiento").
+!encontrarPeorMovimiento(_,_)[source(_)] <- 
	.print("Error en +!encontrarPeorMovimiento").
+!copiarTablero(_,_)[source(_)] <- 
	.print("Error en +!copiarTablero").
+!borrarTablero(_,_)[source(_)] <- 
	.print("Error en +!borrarTablero").
+!maximizar(_,_)[source(_)] <- 
	.print("Error en +!maximizarLista").
+!minimizar(_,_)[source(_)] <- 
	.print("Error en +!minimizarLista").
+!comienzo[source(_)] <- 
	.print("Error en +!comienzo").
+!jugar[source(_)] <- 
	.print("Error en +!jugar").
/*----------------------------------------------------------------------------*/

/*------------------------------EVITAR TRAMPAS--------------------------------*/
+!A[source(Agente)] <-
	Agente \== percept.
/*----------------------------------------------------------------------------*/