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


/* Posiciones en las que ganas siempre: +20 */
ganarSiempreHorizontal([pos(X0,Y),pos(X0+4,Y)],J):-
	tablero(X0,Y,0) &
	tablero(X0+1,Y,J) &
	tablero(X0+2,Y,J) &
	tablero(X0+3,Y,J) &
	tablero(X0+4,Y,0).

ganarSiempreDiagonalAlpha([pos(X0,Y0),pos(X0+4,Y0+4)],J):-
	tablero(X0,Y0,0) &
	tablero(X0+1,Y0+1,J) &
	tablero(X0+2,Y0+2,J) &
	tablero(X0+3,Y0+3,J) &
	tablero(X0+4,Y0+4,0).


ganarSiempreDiagonalBeta([pos(X0,Y0),pos(X0-4,Y0+4)],J):-
	tablero(X0,Y0,0) &
	tablero(X0-1,Y0+1,J) &
	tablero(X0-2,Y0+2,J) &
	tablero(X0-3,Y0+3,J) &
	tablero(X0-4,Y0+4,0).


/* Posiciones en las que tienes un tres en raya con solo una libre: +20*/
tresEnRayaVertical([pos(X,Y0)],J):-
	tablero(X,Y0,0) &
	tablero(X,Y0+1,J) &
	tablero(X,Y0+2,J) &
	tablero(X,Y0+3,J).

tresEnRayaHorizontalDerecha([pos(X0,Y)],J):-
	tablero(X0,Y,0) &
	tablero(X0+1,Y,J) &
	tablero(X0+2,Y,J) &
	tablero(X0+3,Y,J).

tresEnRayaHorizontalDerecha([pos(X0+3,Y)],J):-
	tablero(X0,Y,J) &
	tablero(X0+1,Y,J) &
	tablero(X0+2,Y,J) &
	tablero(X0+3,Y,0).

tresEnRayaDiagonalAlphaDerechaAbajo([pos(X0,Y0)],J):-
	tablero(X0,Y0,0) &
	tablero(X0+1,Y0+1,J) &
	tablero(X0+2,Y0+2,J) &
	tablero(X0+3,Y0+3,J).

tresEnRayaDiagonalAlphaIzquierdaArriba([pos(X0+3,Y0+3)],J):-
	tablero(X0,Y0,J) &
	tablero(X0+1,Y0+1,J) &
	tablero(X0+2,Y0+2,J) &
	tablero(X0+3,Y0+3,0).

tresEnRayaDiagonalBetaDerechaArriba([pos(X0,Y0)],J):-
	tablero(X0,Y0,0) &
	tablero(X0-1,Y0+1,J) &
	tablero(X0-2,Y0+2,J) &
	tablero(X0-3,Y0+3,J).

tresEnRayaDiagonalBetaIzquierdaAbajo([pos(X0-3,Y0-3)],J):-
	tablero(X0,Y0,J) &
	tablero(X0-1,Y0+1,J) &
	tablero(X0-2,Y0+2,J) &
	tablero(X0-3,Y0+3,0).

/* Posiciones en las que hay tres en cuatro y una para ganar:  */

tresEnCuatroHorizontalCentroDerecha([pos(X0+2,Y)],J):-
	tablero(X0,Y,J) &
	tablero(X0+1,Y,J) &
	tablero(X0+2,Y,0) &
	tablero(X0+3,Y,J).

tresEnCuatroHorizontalCentroIzquierda([pos(X0+1,Y)],J):-
	tablero(X0,Y,J) &
	tablero(X0+1,Y,0) &
	tablero(X0+2,Y,J) &
	tablero(X0+3,Y,J).

tresEnCuatroDiagonalAlphaCentroDerecha([pos(X0+2,Y0+2)],J):-
	tablero(X0,Y0,J) &
	tablero(X0+1,Y0+1,J) &
	tablero(X0+2,Y0+2,0) &
	tablero(X0+3,Y0+3,J).

tresEnCuatroDiagonalAlphaCentroIzquierda([pos(X0+1,Y0+1)],J):-
	tablero(X0,Y0,J) &
	tablero(X0+1,Y0+1,0) &
	tablero(X0+2,Y0+2,J) &
	tablero(X0+3,Y0+3,J).

tresEnCuatroDiagonalBetaCentroDerecha([pos(X0-2,Y0+2)],J):-
	tablero(X0,Y0,J) &
	tablero(X0-1,Y0+1,J) &
	tablero(X0-2,Y0+2,0) &
	tablero(X0-3,Y0+3,J).

tresEnCuatroDiagonalBetaCentroIzquierda([pos(X0-1,Y0+1)],J):-
	tablero(X0,Y0,J) &
	tablero(X0-1,Y0+1,0) &
	tablero(X0-2,Y0+2,J) &
	tablero(X0-3,Y0+3,J).

/* Initial goals */
/* Plans */


