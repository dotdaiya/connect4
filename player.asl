// Agent player in project connect4.mas2j



/* Initial beliefs and rules */


/*ALPHA: Es una diagonal en la que las dos componentes son la suma de las 
  anteriores. Es decir la diagonal va de izquierda arriba a abajo derecha. */


/*BETA: Es una diagonal en la que la componenet X es la resta de la anterior
  y la componente Y la suma de la anterior. Es decir la diagonal va de derecha
  arriba a abajo izquierda.


/* Calcula si un celda esta ocupada por el rival o fuera del tablero */
/* Falta implementar jugadorOponente(J) */
ocupadoFueraDeTablero(X,Y,J):-
	(X >= 0 & X <= 7) &
	(Y >= 0 & Y <= 7) &
	tablero(X,Y,jugadorOponente(J)).


/* Comprueba si se puede colocar en una posiciÃ³n por encima de la fila siete */
puedeColocar(X,0).

puedeColocar(X,Y):-
	(Y > 0) &
	(tablero(X,Y-1,1) |
	tablero(X,Y-1,2)).


/* Posiciones en las que ganas siempre: +20 */
ganarSiempreHorizontal([pos(X0,Y),pos(X0+4,Y)],J):-
	tablero(X0,Y,0) &
	tablero(X0+1,Y,J) &
	tablero(X0+2,Y,J) &
	tablero(X0+3,Y,J) &
	tablero(X0+4,Y,0) &
	puedeColocar(X0,Y) &
	puedeColocar(X0+4,Y).

ganarSiempreDiagonalAlpha([pos(X0,Y0),pos(X0+4,Y0+4)],J):-
	tablero(X0,Y0,0) &
	tablero(X0+1,Y0+1,J) &
	tablero(X0+2,Y0+2,J) &
	tablero(X0+3,Y0+3,J) &
	tablero(X0+4,Y0+4,0) &
	puedeColocar(X0,Y0) &
	puedeColocar(X0+4,Y0+4).

ganarSiempreDiagonalBeta([pos(X0,Y0),pos(X0-4,Y0+4)],J):-
	tablero(X0,Y0,0) &
	tablero(X0-1,Y0+1,J) &
	tablero(X0-2,Y0+2,J) &
	tablero(X0-3,Y0+3,J) &
	tablero(X0-4,Y0+4,0) &
	puedeColocar(X0,Y0) &
	puedeColocar(X0-4,Y0+4).


/* Posiciones en las que tienes un tres en raya con solo una libre: +20*/
tresEnRayaVertical([pos(X,Y0)],J):-
	tablero(X,Y0,0) &
	tablero(X,Y0+1,J) &
	tablero(X,Y0+2,J) &
	tablero(X,Y0+3,J).

tresEnRayaHorizontalIzquierda([pos(X0,Y)],J):-
	tablero(X0,Y,0) &
	tablero(X0+1,Y,J) &
	tablero(X0+2,Y,J) &
	tablero(X0+3,Y,J) &
	puedeColocar(X0,Y).

tresEnRayaHorizontalDerecha([pos(X0+3,Y)],J):-
	tablero(X0,Y,J) &
	tablero(X0+1,Y,J) &
	tablero(X0+2,Y,J) &
	tablero(X0+3,Y,0) &
	puedeColocar(X0+3,Y).

tresEnRayaDiagonalAlphaDerechaAbajo([pos(X0,Y0)],J):-
	tablero(X0,Y0,0) &
	tablero(X0+1,Y0+1,J) &
	tablero(X0+2,Y0+2,J) &
	tablero(X0+3,Y0+3,J) &
	puedeColocar(X0,Y0).

tresEnRayaDiagonalAlphaIzquierdaArriba([pos(X0+3,Y0+3)],J):-
	tablero(X0,Y0,J) &
	tablero(X0+1,Y0+1,J) &
	tablero(X0+2,Y0+2,J) &
	tablero(X0+3,Y0+3,0) &
	puedeColocar(X0+3,Y0+3).

tresEnRayaDiagonalBetaDerechaArriba([pos(X0,Y0)],J):-
	tablero(X0,Y0,0) &
	tablero(X0-1,Y0+1,J) &
	tablero(X0-2,Y0+2,J) &
	tablero(X0-3,Y0+3,J) &
	puedeColocar(X0,Y0).

tresEnRayaDiagonalBetaIzquierdaAbajo([pos(X0-3,Y0-3)],J):-
	tablero(X0,Y0,J) &
	tablero(X0-1,Y0+1,J) &
	tablero(X0-2,Y0+2,J) &
	tablero(X0-3,Y0+3,0) &
	puedeColocar(X0-3,Y0+3).

/* Posiciones en las que hay tres en cuatro y una para ganar:  */

tresEnCuatroHorizontalCentroDerecha([pos(X0+2,Y)],J):-
	tablero(X0,Y,J) &
	tablero(X0+1,Y,J) &
	tablero(X0+2,Y,0) &
	tablero(X0+3,Y,J) &
	puedeColocar(X0+2,Y).

tresEnCuatroHorizontalCentroIzquierda([pos(X0+1,Y)],J):-
	tablero(X0,Y,J) &
	tablero(X0+1,Y,0) &
	tablero(X0+2,Y,J) &
	tablero(X0+3,Y,J) &
	puedeColocar(X0+1,Y).

tresEnCuatroDiagonalAlphaCentroDerecha([pos(X0+2,Y0+2)],J):-
	tablero(X0,Y0,J) &
	tablero(X0+1,Y0+1,J) &
	tablero(X0+2,Y0+2,0) &
	tablero(X0+3,Y0+3,J) &
	puedeColocar(X0+2,Y0+2).

tresEnCuatroDiagonalAlphaCentroIzquierda([pos(X0+1,Y0+1)],J):-
	tablero(X0,Y0,J) &
	tablero(X0+1,Y0+1,0) &
	tablero(X0+2,Y0+2,J) &
	tablero(X0+3,Y0+3,J) &
	puedeColocar(X0+1,Y0+1).

tresEnCuatroDiagonalBetaCentroDerecha([pos(X0-2,Y0+2)],J):-
	tablero(X0,Y0,J) &
	tablero(X0-1,Y0+1,J) &
	tablero(X0-2,Y0+2,0) &
	tablero(X0-3,Y0+3,J) &
	puedeColocar(X0-2,Y0+2).

tresEnCuatroDiagonalBetaCentroIzquierda([pos(X0-1,Y0+1)],J):-
	tablero(X0,Y0,J) &
	tablero(X0-1,Y0+1,0) &
	tablero(X0-2,Y0+2,J) &
	tablero(X0-3,Y0+3,J) &
	puedeColocar(X0-1,Y0+1).


/* Parejas horizontal que generan un trio que gana siempre: */

parejaGanadoraHorizontalDerecha([pos(X0+3,Y)],J):-
	tablero(X0,Y,0) &
	tablero(X0+1,Y,J) &
	tablero(X0+2,Y,J) &
	tablero(X0+3,Y,0) &
	tablero(X0+4,Y,0) &
	puedeColocar(X0+3,Y).

parejaGanadoraHorizontalIzquierda([pos(X0+1,Y)],J):-
	tablero(X0,Y,0) &
	tablero(X0+1,Y,0) &
	tablero(X0+2,Y,J) &
	tablero(X0+3,Y,J) &
	tablero(X0+4,Y,0) &
	puedeColocar(X0+1,Y).

parejaGanadoraHorizontalCentral([pos(X0+2,Y)],J):-
	tablero(X0,Y,0) &
	tablero(X0+1,Y,J) &
	tablero(X0+2,Y,0) &
	tablero(X0+3,Y,J) &
	tablero(X0+4,Y,0) &
	puedeColocar(X0+2,Y).

parejaGanadoraDiagonalAlphaDerecha([pos(X0+3,Y0+3)],J):-
	tablero(X0,Y0,0) &
	tablero(X0+1,Y0+1,J) &
	tablero(X0+2,Y0+2,J) &
	tablero(X0+3,Y0+3,0) &
	tablero(X0+4,Y0+4,0) &
	puedeColocar(X0+3,Y0+3).

parejaGanadoraDiagonalAlphaIzquierda([pos(X0+1,Y0+1)],J):-
	tablero(X0,Y0,0) &
	tablero(X0+1,Y0+1,0) &
	tablero(X0+2,Y0+2,J) &
	tablero(X0+3,Y0+3,J) &
	tablero(X0+4,Y0+4,0) &
	puedeColocar(X0+1,Y0+1).

parejaGanadoraDiagonalAlphaCentral([pos(X0+2,Y0+2)],J):-
	tablero(X0,Y0,0) &
	tablero(X0+1,Y0+1,J) &
	tablero(X0+2,Y0+2,0) &
	tablero(X0+3,Y0+3,J) &
	tablero(X0+4,Y0+4,0) &
	puedeColocar(X0+2,Y0+2).

parejaGanadoraDiagonalBetaIzquierda([pos(X0+3,Y0+3)],J):-
	tablero(X0,Y0,0) &
	tablero(X0-1,Y0+1,J) &
	tablero(X0-2,Y0+2,J) &
	tablero(X0-3,Y0+3,0) &
	tablero(X0-4,Y0+4,0) &
	puedeColocar(X0-3,Y0+3).

parejaGanadoraDiagonalBetaDerecha([pos(X0-1,Y0+1)],J):-
	tablero(X0,Y0,0) &
	tablero(X0-1,Y0+1,0) &
	tablero(X0-2,Y0+2,J) &
	tablero(X0-3,Y0+3,J) &
	tablero(X0-4,Y0+4,0) &
	puedeColocar(X0-1,Y0+1).

parejaGanadoraDiagonalBetaCentral([pos(X0-2,Y0+2)],J):-
	tablero(X0,Y0,0) &
	tablero(X0-1,Y0+1,J) &
	tablero(X0-2,Y0+2,0) &
	tablero(X0-3,Y0+3,J) &
	tablero(X0-4,Y0+4,0) &
	puedeColocar(X0-2,Y0+2).


/* Parejas que generan un trio: */
/* Horizontales */

parejaHorizontalIzquierda([pos(X0+2,Y)],J):-
	tablero(X0,Y,J) &
	tablero(X0+1,Y,J) &
	tablero(X0+2,Y,0) &
	tablero(X0+3,Y,0) &
	puedeColocar(X0+2,Y).

parejaHorizontalDerecha([pos(X0+1,Y)],J):-
	tablero(X0,Y,0) &
	tablero(X0+1,Y,0) &
	tablero(X0+2,Y,J) &
	tablero(X0+3,Y,J) &
	puedeColocar(X0+1,Y).

parejaHorizontalCentral([pos(X0,Y)],J):-
	tablero(X0,Y,0) &
	tablero(X0+1,Y,J) &
	tablero(X0+2,Y,J) &
	tablero(X0+3,Y,0) &
	puedeColocar(X0,Y).

parejaHorizontalSeparadaIzquierda([pos(X0+1,Y)],J):-
	tablero(X0,Y,J) &
	tablero(X0+1,Y,0) &
	tablero(X0+2,Y,J) &
	tablero(X0+3,Y,0) &
	puedeColocar(X+1,Y).

parejaHorizontalSeparadaIzquierda([pos(X0+2,Y)],J):-
	tablero(X0,Y,0) &
	tablero(X0+1,Y,J) &
	tablero(X0+2,Y,0) &
	tablero(X0+3,Y,J) &
	puedeColocar(X0+2,Y).

parejaHorizontalSeparadaCentro([pos(X0+1,Y)],J):-
	tablero(X0,Y,J) &
	tablero(X0+1,Y,0) &
	tablero(X0+2,Y,0) &
	tablero(X0+3,Y,J) &
	puedeColocar(X0+1,Y).

/* Verticales */

parejaVertical([pos(X0,Y)],J):-
	tablero(X0,Y,0) &
	tablero(X0,Y+1,J) &
	tablero(X0,Y+2,J).

/* Diagonales Alpha */ 

parejaDiagonalAlphaIzquierda([pos(X0+2,Y0+2)],J):-
	tablero(X0,Y0,J) &
	tablero(X0+1,Y0+1,J) &
	tablero(X0+2,Y0+2,0) &
	tablero(X0+3,Y0+3,0) &
	puedeColocar(X0+2,Y0+2).

parejaDiagonalAlphaDerecha([pos(X0+1,Y0+1)],J):-
	tablero(X0,Y0,0) &
	tablero(X0+1,Y0+1,0) &
	tablero(X0+2,Y0+2,J) &
	tablero(X0+3,Y0+3,J) &
	puedeColocar(X0+1,Y0+1).

parejaDiagonalAlphaCentral([pos(X0,Y0)],J):-
	tablero(X0,Y0,0) &
	tablero(X0+1,Y0+1,J) &
	tablero(X0+2,Y0+2,J) &
	tablero(X0+3,Y0+3,0) &
	puedeColocar(X0,Y0).

parejaDiagonalAlphaSeparadaIzq([pos(X0+1,Y0+1)],J):-
	tablero(X0,Y0,J) &
	tablero(X0+1,Y0+1,0) &
	tablero(X0+2,Y0+2,J) &
	tablero(X0+3,Y0+3,0) &
	puedeColocar(X0+1,Y0+1).

parejaDiagonalAlphaSeparadaDer([pos(X0+2,Y0+2)],J):-
	tablero(X0,Y0,0) &
	tablero(X0+1,Y0+1,J) &
	tablero(X0+2,Y0+2,0) &
	tablero(X0+3,Y0+3,J) &
	puedeColocar(X0+2,Y0+2).

parejaDiagonalAlphaSeparadaCentro([pos(X0+1,Y0+1)],J):-
	tablero(X0,Y0,J) &
	tablero(X0+1,Y0+1,0) &
	tablero(X0+2,Y0+2,0) &
	tablero(X0+3,Y0+3,J) &
	puedeColocar(X0+1,Y0+1).

/* Diagonales Beta */

parejaDiagonalBetaIzquierda([pos(X0+2,Y0+2)],J):-
	tablero(X0,Y0,J) &
	tablero(X0+1,Y0+1,J) &
	tablero(X0+2,Y0+2,0) &
	tablero(X0+3,Y0+3,0) &
	puedeColocar(X0+2,Y0+2).

parejaDiagonalBetaDerecha([pos(X0+1,Y0+1)],J):-
	tablero(X0,Y0,0) &
	tablero(X0-1,Y0+1,0) &
	tablero(X0-2,Y0+2,J) &
	tablero(X0-3,Y0+3,J) &
	puedeColocar(X0-1,Y0+1).

parejaDiagonalBetaCentral([pos(X0,Y0)],J):-
	tablero(X0,Y0,0) &
	tablero(X0-1,Y0+1,J) &
	tablero(X0-2,Y0+2,J) &
	tablero(X0-3,Y0+3,0) &
	puedeColocar(X0,Y0).

parejaGeDiagonalBetaSeparadaIzq([pos(X0-1,Y0+1)],J):-
	tablero(X0,Y0,J) &
	tablero(X0-1,Y0+1,0) &
	tablero(X0-2,Y0+2,J) &
	tablero(X0-3,Y0+3,0) &
	puedeColocar(X0-1,Y0+1).

parejaGeneraTrioDiagonalSeparadaDer([pos(X0-2,Y0+2)],J):-
	tablero(X0,Y0,0) &
	tablero(X0-1,Y0+1,J) &
	tablero(X0-2,Y0+2,0) &
	tablero(X0-3,Y0+3,J) &
	puedeColocar(X0-2,Y0+2).

parejaDiagonalBetaSeparadaCentro([pos(X0-1,Y0+1)],J):-
	tablero(X0,Y0,J) &
	tablero(X0-1,Y0+1,0) &
	tablero(X0-2,Y0+2,0) &
	tablero(X0-3,Y0+3,J) &
	puedeColocar(X0-1,Y0+1).


/* Calcula una lista de movimientos con su puntuacion */
calcularMovimientos(8,J,[]).

calcularMovimientos(Columna,J,[MovPunt|LMovPunt]):-
	Columna < 8 &
	calcularFichaSuperior(Columna,X,Y) &
	calcularPuntuacion(X,Y,J,MovPunt) &
	calcularMovimientos(Columna+1,J,LMovPunt).

calcularMovimientos(Columna,J,LFinal):-
	Columna < 8 &
	not(calcularFichaSuperior(Columna,X,Y)) &
	calcularMovimientos(Columna+1,J,LFinal).


/* Movimiento-puntuacion = mov(X,Y,Puntuacion) */
calcularPuntuacion(X,Y,J,mov(X,Y,Puntuacion)):-
	.asserta(tmpTablero(X,Y,J)) &
	puntos(Puntuacion) &
	.abolish(tmpTablero(X,Y,J)).


/* Devuelve los puntos de estado del tablero */
//puntos(X,Y,J):-

/*
	Define quien es el jugador y quien es el rival de forma numerica en funcion 
del nombre, queda comprobado que el tablero solo reconoce a los agentes con el 
nombre indicado
*/
//NOT TESTED
quienSoy(1,2):-
	  .my_name(player1).
quienSoy(2,1):-
	  .my_name(player2).
	 
	  
/***************************************************************************/
/****************	PUNTUACION TABLERO  ***********************************/
/*************************************************************************/
/*Obtener las puntuaciones del tablero contando el numero de trios, parejas 
y candidatos ganadores siempre y ponderando su valor*/

/*Obtiene la puntuacion total del tablero*/
//NOT TESTED
puntuacionTotal(Puntuacion,Jugador,jugarAganar):-
	puntuacionParejas(P,Jugador) &
	puntuacionGanarSiempre(Q,Jugador) &
	puntuacionTrios(R,Jugador) &
	puntuacionComunes(S,Jugador) &
	Puntuacion = P+Q+R+S.
puntuacionTotal(0,Jugador,jugarAganar).//Puntuacion por defecto si no encuentra parejas

/*Obtiene la puntuacion de las parejas encontradas

	Horizontales:15 
	Diagonales:20
	Verticales:10
	Generan trios Horizontales:60
	Generan trios Diagonales:65
	*/	
//NOT TESTED	
puntuacionParejas(Total,Jugador):-
	parejasHorizontales(Lista1,Jugador) &
	parejasTriosGanadorasH(Lista2,Jugador) &
	parejasTriosGanadorasD(Lista3,Jugador) &
	parejasDiagonales(Lista4,Jugador) &
	parejaVertical(Lista5,Jugador) & 
	.length(Lista1,Puntuacion) &
	.length(Lista2,Puntuacion2) &
	.length(Lista3,Puntuacion3) &
	.length(Lista4,Puntuacio4) &
	.length(Lista5,Puntuacio5) &
	Total = Puntuacion*15 + Puntuacion2*60 + Puntuacion3*65 + Puntuacio4*20 + Puntuacion5*10.
	
/*Obtiene la puntuacion de los candidatos a ganar siempre 90/100 */
//NOT TESTED
puntuacionGanarSiempre(Total,Jugador):-
	ganarSiempre(L,Jugador) &
	.length(L,Puntuacion) &
	Total = Puntuacion*90.
/*
	Obtiene la puntuacion de los trios encontrados
			trio que les falta una para ganar 85
			trios que ganan en Diagonal 75
			trios que ganan en Horizontal 70
			trios verticales 60
	*/
//NOT TESTED
puntuacionTrios(Total,Jugador):-
	trios(Lista1,Jugador) &
	triosGananH(Lista2,Jugador) &
	triosGananD(Lista3,Jugador) &
	tresEnRayaVertical(Lista4,J) &
	.length(Lista1,Puntuacion)&
	.length(Lista2,Puntuacion2)&
	.length(Lista3,Puntuacion3)&
	.length(Lista4,Puntuacion4)&
	Total = Puntuacion*85 + Puntuacion2*75 + Puntuacion3*70 + Puntuacion4*60.
	  

/*Halla las parejas disponibles en el tablero*/
//NOT TESTED
parejasHorizontales([A,B,C,D,E,F],J):-
	parejaHorizontalIzquierda(A,J) &
	parejaHorizontalDerecha(B,J) &
	parejaHorizontalCentral(C,J) &
	parejaHorizontalSeparadaIzquierda(D,J) &
	parejaHorizontalSeparadaIzquierda(E,J) &
	parejaHorizontalSeparadaCentro(F,J).
	
	
parejasDiagonales([H,I,K,L,M,N,O,P,Q,R,S,T],J):-
	parejaDiagonalAlphaIzquierda(H,J) &
	parejaDiagonalAlphaDerecha(I,J) &
	parejaDiagonalAlphaCentral(K,J) &
	parejaDiagonalAlphaSeparadaIzq(L,J) &
	parejaDiagonalAlphaSeparadaDer(M,J) &
	parejaDiagonalAlphaSeparadaCentro(N,J) &
	parejaDiagonalBetaIzquierda(O,J) &
	parejaDiagonalBetaDerecha(P,J) &
	parejaDiagonalBetaCentral(Q,J) &
	parejaGeDiagonalBetaSeparadaIzq(R,J) &
	parejaGeneraTrioDiagonalSeparadaDer(S,J) &
	parejaDiagonalBetaSeparadaCentro(T,J).
	
/* Halla las parejas que generan un trio que ganan siempre */
//NOT TESTED
parejasTriosGanadorasH([A,B,C],J):-
	parejaGanadoraHorizontalDerecha(A,J) &
	parejaGanadoraHorizontalIzquierda(B,J) &
	parejaGanadoraHorizontalCentral(C,J).
parejasTriosGanadorasD([D,E,F,G,H,I],J):-
	parejaGanadoraDiagonalAlphaDerecha(D,J)&
	parejaGanadoraDiagonalAlphaIzquierda(E,J) &
	parejaGanadoraDiagonalAlphaCentral(F,J) &
	parejaGanadoraDiagonalBetaIzquierda(G,J) &
	parejaGanadoraDiagonalBetaDerecha(H,J) &
	parejaGanadoraDiagonalBetaCentral(I,J).
	
/*Halla los trios en el tablero donde hay tres en cuatro y falta una para ganar*/
//NOT TESTED
trios([A,B,C,D,E,F],J):-
	tresEnCuatroHorizontalCentroDerecha(A,J) &
	tresEnCuatroHorizontalCentroIzquierda(B,J) &
	tresEnCuatroDiagonalAlphaCentroDerecha(C,J) &
	tresEnCuatroDiagonalAlphaCentroIzquierda(D,J) &
	tresEnCuatroDiagonalBetaCentroDerecha(E,J) &
	tresEnCuatroDiagonalBetaCentroIzquierda(F,J).
	
/*Posiciones en las que tienes un tres en raya con solo una libre*/
//NOT TESTED
triosGananD([D,E,F,G],J):-	
	tresEnRayaDiagonalAlphaDerechaAbajo(D,J) &
	tresEnRayaDiagonalAlphaIzquierdaArriba(E,J) &
	tresEnRayaDiagonalBetaDerechaArriba(F,J) &
	tresEnRayaDiagonalBetaIzquierdaAbajo(G,J).
triosGananH([B,C],J):-	
	tresEnRayaHorizontalIzquierda(B,J) &
	tresEnRayaHorizontalDerecha(C,J).

	
/*Halla los trios que ganan siempre*/
//NOT TESTED
ganarSiempre([A,B,C],J):-
	ganarSiempreHorizontal(A,J) &
	ganarSiempreDiagonalAlpha(B,J) &
	ganarSiempreDiagonalBeta(C,J).

/*Halla las jugadas comunes*/
//NOT TESTED
jugadasComunes(Puntuacion,Jugador):-
		parejasHorizontales(ParejasH,Jugador) &
		parejasDiagonales(ParejasD,Jugador) &
		parejaVertical(ParejasV,Jugador) & 
		parejasTriosGanadorasH(ParejasTrioGananH,Jugador) &
		parejasTriosGanadorasD(ParejasTrioGananD,Jugador) &
		
		trios(Trios3en4,Jugador) &
		tresEnRayaVertical(TriosVertical,Jugador) &
		triosGananH(TriosGananH,Jugador) &
		triosGananD(TriosGananD,Jugador) &
		
		busqueda(ParejasH,ParejasD,P1) &
		busqueda(ParejasH,ParejasV,P2) &
		busqueda(ParejasH,ParejasTrioGananH,P3) &
		busqueda(ParejasH,ParejasTrioGananH,P4) &
		busqueda(ParejasH,Trios3en4,P5) &
		busqueda(ParejasH,TriosVertical,P6) &
		busqueda(ParejasH,TriosGananH,P7) &
		busqueda(ParejasH,TriosGananD,P8) &
		busqueda(ParejasD,ParejasV,P9) &
		busqueda(ParejasD,ParejasTrioGananH,P10) &
		busqueda(ParejasD,ParejasTrioGananD,P11) &
		busqueda(ParejasD,Trios3en4,P12) &
		busqueda(ParejasD,TriosVertical,P13) &
		busqueda(ParejasD,TriosGananH,P14) &
		busqueda(ParejasD,TriosGananD,P15) &
		busqueda(ParejasV,ParejasTrioGananH,P16) &
		busqueda(ParejasV,ParejasTrioGananD,P17) &
		busqueda(ParejasV,Trios3en4,P18) &
		busqueda(ParejasV,TriosVertical,P19) &
		busqueda(ParejasV,TriosGananH,P20) &
		busqueda(ParejasV,TriosGananD,P21) &
		busqueda(ParejasTrioGananH,ParejasTrioGananD,P22) &
		busqueda(ParejasTrioGananH,Trios3en4,P23) &
		busqueda(ParejasTrioGananH,TriosVertical,P24) &
		busqueda(ParejasTrioGananH,TriosGananH,P25) &
		busqueda(ParejasTrioGananH,TriosGananD,P26) &
		busqueda(ParejasTrioGananD,Trios3en4,P27) &
		busqueda(ParejasTrioGananD,TriosVertical,P28) &
		busqueda(ParejasTrioGananD,TriosGananH,P29) &
		busqueda(ParejasTrioGananD,TriosGananD,P30) &
		busqueda(Trios3en4,TriosVertical,P31) &
		busqueda(Trios3en4,TriosGananH,P32) &
		busqueda(Trios3en4,TriosGananD,P33) &
		busqueda(TriosVertical,TriosGananH,P34) &
		busqueda(TriosVertical,TriosGananD,P35) &
		busqueda(TriosGananH,TriosGananD,P36) &
		unoMismoComunes(ParejasH,ParejasH,P37) &
		unoMismoComunes(ParejasD,ParejasD,P38) &
		unoMismoComunes(ParejasV,ParejasV,P39) &
		unoMismoComunes(ParejasTrioGananH,ParejasTrioGananH,P40) &
		unoMismoComunes(ParejasTrioGananD,ParejasTrioGananD,P41) &
		unoMismoComunes(Trios3en4,Trios3en4,P42) &
		unoMismoComunes(TriosVertical,TriosVertical,P43) &
		unoMismoComunes(TriosGananH,TriosGananH,P44) &
		unoMismoComunes(TriosGananD,TriosGananD,P45) &
		
		Puntuacion = P1 + P2 + P3 + P4 + P5 + P6 + P7 + P8 + P9 + P10 + P11 + P12 + P13 + P14 + P15 + P16 + P17 + P18 + P19 + P20 + P21 + P22 + P23 + P24 + P25 + P26 + P27 + P28 + P29 + P30 + P31 + P32 + P33 + P34 + P35 + P36 + P37 + P38 + P39 + P40 + P41 + P42 + P43 + P44 + P45. 


	  	
/*Dadas dos listas de posiciones obtiene los elementos comunes entre ellas*/
/*
	Casos base:
		Lista vacía con una lista cualquiera 
		Una lista cualquiera con una lista vacía
	Lógica:
		Dado un elemento recorre la lista en busca del numero de coincidencias
		Si dos elementos coinciden entonces aumenta el resultado
		si ningun elemento coincide avanza en la lista y mantiene el resultado
*/
busqueda([],Lista,0).
busqueda([pos(X,Y)|Tail],Lista,Resultado+Resultado2):-comunes(pos(X,Y),Lista,Resultado) & busqueda(Tail,Lista,Resultado2).
comunes(pos(_,_),[],0).
comunes(pos(X,Y),[pos(X,Y)|Tail],Resultado):- comunes(pos(X,Y),Tail,Resultado+1). 
comunes(pos(X,Y),[pos(_,_)|Tail],Resultado):- comunes(pos(X,Y),Tail,Resultado). 

unoMismoComunes(_,[],0).
unoMismoComunes([pos(X,Y) | Tail],[pos(_,_),pos(Y,X)|Tail2],Resultado):- comunes(Tail,Tail2,Resultado+1). 
unoMismoComunes([pos(X,Y) | Tail],[pos(_,_),pos(A,B)|Tail2],Resultado):- comunes(Tail,Tail2,Resultado). 
	
/* Initial goals */
/* Plans */

//NOT TESTED
+!minMax(XActual,Profundidad,LMovimientos):
	Profundidad > 0 &
	esPar(Profundidad) &
	XActual < 7 <-
		!minMax(XActual,Profundidad-1,LMovimientos);
		!minMax(XActual + 1, Profundidad,LMovimientos2).

+!minMax(XActual,Profundidad,LMovimientos):
	Profundidad > 0 &
	not(esPar(Profundidad)) &
	XActual < 7 <-
		!minMax(XActual,Profundidad-1,LMovimientos);
		!minMax(XActual + 1, Profundidad,LMovimientos2).


+!minMax(XActual,Profundidad,LMovimientos):
	Profundidad = 0 <-
		?calcularMovimientos(LMovimientos).
		

/*Busca la primera ficha del rival que no tenga una ficha del jugador colocada encima y coloca su ficha encima de la del rival*/		
//NOT TESTED
+!jugarAperderSegundo: estrategia(jugarAPerder) & tablero(X,Y,Rival) & tablero(X,Y-1,0) & quienSoy(Jugador,Rival) <-
	.put(X,Y-1).

+!jugarAperderSegundo: estrategia(jugarAPerder) & tablero(X,Y,Rival) & tablero(X,Y-1,0) & quienSoy(Jugador,Rival) <-
	.put(X,Y-1).
	




	


	

	
