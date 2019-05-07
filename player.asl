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


/* Comprueba si se puede colocar en una posición por encima de la fila siete */
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

/* Initial goals */
/* Plans */