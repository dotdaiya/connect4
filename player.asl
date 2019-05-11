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
puntuacionTotal(P+Q+R,Jugador,jugarAganar):-
	puntuacionParejas(P,Jugador) &
	puntuacionGanarSiempre(Q,Jugador) &
	puntuacionTrios(R,Jugador).

/*Obtiene la puntuacion de las parejas encontradas*/	
//NOT TESTED	
puntuacionParejas(Puntuacion+Puntuacion2,Jugador):-
	parejas(Lista1,Jugador) &
	parejasTriosGanadoras(Lista2,Jugador) &
	.length(Lista1,Puntuacion) &
	.lengt(Lista2,Puntuacion2).
	
/*Obtiene la puntuacion de los candidatos a ganar siempre*/
//NOT TESTED
puntuacionGanarSiempre(Puntuacion,Jugador):-
	ganarSiempre(L,Jugador) &
	.length(L,Puntuacion).
/*Obtiene la puntuacion de los trios encontrados*/
//NOT TESTED
puntuacionTrios(Puntuacion+Puntuacion2,Jugador):-
	trios(L,Jugador) &
	.length(L,Puntuacion)&
	triosGanan(M,Jugador) &
	.length(M,Puntuacion2).
	  

/*Halla las parejas disponibles en el tablero*/
//NOT TESTED
parejas([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T],J):-
	parejaHorizontalIzquierda(A,J) &
	parejaHorizontalDerecha(B,J) &
	parejaHorizontalCentral(C,J) &
	parejaHorizontalSeparadaIzquierda(D,J) &
	parejaHorizontalSeparadaIzquierda(E,J) &
	parejaHorizontalSeparadaCentro(F,J) &
	parejaVertical(G,J) &
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
parejasTriosGanadoras([A,B,C,D,E,F,G,H,I],Jugador):-
	parejaGanadoraHorizontalDerecha(A,J) &
	parejaGanadoraHorizontalIzquierda(B,J) &
	parejaGanadoraHorizontalCentral(C,J) &
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
triosGanan([A,B,C,D,E,F,G],J):-	
	tresEnRayaVertical(A,J) &
	tresEnRayaHorizontalIzquierda(B,J) &
	tresEnRayaHorizontalDerecha(C,J) &
	tresEnRayaDiagonalAlphaDerechaAbajo(D,J) &
	tresEnRayaDiagonalAlphaIzquierdaArriba(E,J) &
	tresEnRayaDiagonalBetaDerechaArriba(F,J) &
	tresEnRayaDiagonalBetaIzquierdaAbajo(G,J).
	
/*Halla los trios que ganan siempre*/
//NOT TESTED
ganarSiempre([A,B,C],J):-
	ganarSiempreHorizontal(A,J) &
	ganarSiempreDiagonalAlpha(B,J) &
	ganarSiempreDiagonalBeta(C,J).

/*Halla las jugadas comunes*/
//NOT TESTED
jugadasComunes(Jugador,Puntuacion):-
		parejas(ListaParejas,Jugador) &
		parejasTriosGanadoras(ListaParejasTrioGanan,Jugador) &
		ganarSiempre(ListaGanaSiempre,Jugador) &
		trios(ListaTrios,Jugador) &
		triosGanan(ListaTriosGanan,Jugador) &
		
		busqueda(ListaParejas,ListaParejasTrioGanan,P1) &
		busqueda(ListaParejas,ListaGanaSiempre,P2) &
		busqueda(ListaParejas,ListaTrios,P3) &
		busqueda(ListaParejas,ListaTriosGanan,P4) &
 
		busqueda(ListaParejasTrioGanan,ListaGanaSiempre,P5) &
		busqueda(ListaParejasTrioGanan,ListaTrios,P6) &
		busqueda(ListaParejasTrioGanan,ListaTriosGanan,P7) &
		
		busqueda(ListaGanaSiempre,ListaTrios,P8) &
		busqueda(ListaGanaSiempre,ListaTriosGanan,P9) &
		
		busqueda(ListaTrios,ListaTriosGanan,P10) &
		
		unoMismoComunes(ListaParejas,ListaParejas,P11) &
		unoMismoComunes(ListaParejasTrioGanan,ListaParejasTrioGanan,P12) &
		unoMismoComunes(ListaGanaSiempre,ListaGanaSiempre,P13) &
		unoMismoComunes(ListaTrios,ListaTrios,P14) &
		unoMismoComunes(ListaTriosGanan,ListaTriosGanan,P15) &
		Puntuacion = P1 + P2 + P3 + P4 + P5 + P6 + P7 + P8 + P9 + P10 + P11 + P12 + P13 + P14 + P15. 


	  	
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
	




	


	

	
