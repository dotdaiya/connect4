// Agent player in project connect4.mas2j

/* ALPHA: Es una diagonal en la que las dos componentes son la suma de las 
   anteriores. Es decir la diagonal va de izquierda arriba a abajo derecha.
  
 * BETA: Es una diagonal en la que la componenet X es la resta de la anterior
   y la componente Y la suma de la anterior. Es decir la diagonal va de derecha
   arriba a abajo izquierda.*/

/* BELIEFS AND RULES */

/*----------------------------BELIEFS INICIALES-------------------------------*/
mejorMovimiento(mov(-1,-1,-100000)). // El mejor movimiento a realizar
profundidad(3). // La profundidad de búsqueda del árbol minmax
jugador(1). // TEMPORAL
oponente(2). // TEMPORAL
/*----------------------------------------------------------------------------*/


/* Comprueba si se puede colocar en una posición por encima de la fila siete */ 
puedeColocar(X,Y):- //Tested 
	posicion(X,Y,0) &
    (X >= 0 & X < 8) &
    (Y >= 0 & Y < 8) &
    (posicion(X,Y+1,1) | posicion(X,Y+1,2)).

puedeColocar(X,7):- //Tested
    posicion(X,7,0).


/* Comprueba que aún se puede realizar movimientos */
comprobarCeldasLibres:- //Tested
	posicion(X,Y,0).


/* Comprueba que aún hay celdas libres en una columna */
comprobarCeldaLibreEnColumna(Columna,Fila):-
	(Columna >= 0 & Columna < 8) &
	puedeColocar(Columna,Fila).


/* Comprueba si hay un cuatro en raya en el posicion */
cuatroEnRayaVertical(J):- //Tested
	posicion(X,Y,J) &
	posicion(X,Y+1,J) &
	posicion(X,Y+2,J) &
	posicion(X,Y+3,J).

cuatroEnRayaHorizontal(J):- //Tested
	posicion(X,Y,J) &
	posicion(X+1,Y,J) &
	posicion(X+2,Y,J) &
	posicion(X+3,Y,J).

cuatroEnRayaDiagonalAlpha(J):- //Tested
	posicion(X,Y,J) &
	posicion(X+1,Y+1,J) &
	posicion(X+2,Y+2,J) &
	posicion(X+3,Y+3,J).

cuatroEnRayaDiagonalBeta(J):- //Tested
	posicion(X,Y,J) &
	posicion(X-1,Y+1,J) &
	posicion(X-2,Y+2,J) &
	posicion(X-3,Y+3,J).


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


/* Si gana o pierde devuelve ese movimiento */
minMax(Jugador,Profundidad,Puntos,Maximizar):-
	.print("GANAR O PERDER") &
	evaluarTablero(Jugador,Estrategia,Puntos) &
	(Puntos = 50 | Puntos = -50) &
	.print("FIN GANAR O PERDER").

/* En caso de empate */
minMax(Jugador,Profundidad,0,Maximizar):-
	.print("EMPATE minMax") &
	not comprobarCeldasLibres &
	evaluarTablero(Jugador,Estrategia,0) &
	.print("FIN EMPATE minMax").

/* Caso base */
minMax(Jugador,0,Puntos,Maximizar):-
	evaluarTablero(Jugador,Estrategia,Puntos).

/* Turno de maximizar */
minMax(Jugador,Profundidad,Puntos,Maximizar):-
	Profundidad > 0 &
	.print("MAXIMIZAR minMax") &
	Maximizar &
	oponente(Jugador2) &
	.print("DATOS:(","0 - ",Jugador2," - ",Profundidad-1," - ","not true",")") &
	iterar(0,Jugador2,Profundidad-1,not true,LMovimientos) &
	maximizarLista(-5000,LMovimientos,Puntos) &
	.print("FIN MAXIMIZAR minMax").

/* Turno de minimizar */
minMax(Jugador,Profundidad,Puntos,Maximizar):-
	Profundidad > 0 &
	.print("MINIMIZAR minMax") &
	not Maximizar &
	jugador(Jugador2) &
	.print("DATOS:(","0 - ",Jugador2," - ",Profundidad-1," - ","true",")") &
	iterar(0,Jugador2,Profundidad-1,true,LMovimientos) &
	minimizarLista(5000,LMovimientos,Puntos) &
	.print("FIN MINIMIZAR minMax").


/* Ya se recorrieron todas las posibilidades de movimientos */
iterar(Columna,Jugador,Profundidad,Maximizar,[]):-
	(Columna >= 8).

/* Si no se puede colocar ficha en la columna */
iterar(Columna,Jugador,Profundidad,Maximizar,[Puntos|LMovimientos]):-
	(Columna >= 0 & Columna < 8) &
	comprobarCeldasLibres &
	not comprobarCeldaLibreEnColumna(Columna,Fila) &
	iterar(Columna+1,Jugador,Profundidad,Maximizar,LMovimientos).

/* Para cada movimiento */
iterar(Columna,Jugador,Profundidad,Maximizar,[Puntos|LMovimientos]):-
	(Columna >= 0 & Columna < 8) &
	comprobarCeldasLibres &
	comprobarCeldaLibreEnColumna(Columna,Fila) &
	posicion(Columna,Fila,W) &
	.abolish(posicion(Columna,Fila,W)) &
	.asserta(posicion(Columna,Fila,Jugador)) &
	minMax(Jugador,Profundidad,Puntos,Maximizar) &
	.abolish(posicion(Columna,Fila,Jugador)) &
	.asserta(posicion(Columna,Fila,W)) &
	iterar(Columna+1,Jugador,Profundidad,Maximizar,LMovimientos).


/* Devuelve los puntos de estado del posicion */
evaluarTablero(Jugador,Estrategia,5). // Falta implementar


/* INITIAL GOALS */
//!encontrarMejorMovimiento(0,LMovimientos).
!copiarTablero(0,0).
/* PLANS */

/*----------------------------------------------------------------------------*/
/*-------------------------CREAR TABLERO TEMPORAL-----------------------------*/
/*----------------------------------------------------------------------------*/
+!copiarTablero(Columna,Fila):
	(Columna >= 0 & Columna < 8) &
	(Fila >= 0 & Fila < 8) <-	
		?tablero(Columna,Fila,Jugador)[source(percept)];
		.asserta(posicion(Columna,Fila,Jugador));
		!copiarTablero(Columna,Fila+1).

+!copiarTablero(Columna,Fila):
	(Columna >= 0 & Columna < 8) &
	Fila = 8 <-
		!copiarTablero(Columna+1,0).

+!copiarTablero(Columna,Fila):
	Columna >= 8 <-
		.print("Se ha generado el tablero temporal").//;
		//!borrarTablero.
/*----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*/
/*-----------------------------BORRAR TABLERO---------------------------------*/
/*----------------------------------------------------------------------------*/
+!borrarTablero <-
	.abolish(posicion(_,_,_)).
/*----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*/
/*-----------------------ENCONTRAR MEJOR MOVIMIENTO---------------------------*/
/*----------------------------------------------------------------------------*/

// Si no hay celdas libres
+!encontrarMejorMovimiento(Columna,LMovimientos)[source(self)]:
	not comprobarCeldasLibres[source(self)] <-
		!finPartida.

// Si no se puede colocar en la columna
+!encontrarMejorMovimiento(Columna,LMovimientos)[source(self)]: 
	(Columna < 8 & Columna >= 0) &
	comprobarCeldasLibres[source(self)] &
	not comprobarCeldaLibreEnColumna(Columna,Fila)[source(self)] <-
		!encontrarMejorMovimiento(Columna+1,LMovimientos).

// Si se puede colocar ficha en la columna
+!encontrarMejorMovimiento(Columna,LMovimientos)[source(self)]:
	(Columna < 8 & Columna >= 0) &
	comprobarCeldasLibres[source(self)] &
	comprobarCeldaLibreEnColumna(Columna,Fila)[source(self)] &
	jugador(Jugador)[source(self)] <-
		?posicion(Columna,Fila,0);
		-posicion(Columna,Fila,0);
		+posicion(Columna,Fila,Jugador);
		?minMax(Jugador,3,Puntos,not true);
		!maximizar(Columna,Fila,Puntos);
		-posicion(Columna,Fila,Jugador);
		+posicion(Columna,Fila,0);
		!encontrarMejorMovimiento(Columna+1,[Puntos|LMovimientos]).

// Si ya has comprobado todas las columnas
+!encontrarMejorMovimiento(Columna,LMovimientos)[source(self)]: 
	Columna >= 8 &
	movimientoMaximizado(X,Y,Puntos) <-
		put(X).
/*----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*/
/*---------------------------MINIMIZAR-MAXIMIZAR------------------------------*/
/*----------------------------------------------------------------------------*/
+!maximizar(X,Y,Puntos)[source(self)]:
	movimientoMaximizado(X1,Y1,Puntos1) &
	Puntos > Puntos1 <-
		-movimientoMaximizado(X1,Y1,Puntos);
		+movimientoMaximizado(X,Y,Puntos1).

+!maximizar(X,Y,Puntos)[source(self)].

+!minimizar(X,Y,Puntos)[source(self)]:
	movimientoMinizado(X1,Y1,Puntos1) &
	Puntos < Puntos1 <-
		-movimientoMinizado(X1,Y1,Puntos);
		+movimientoMinizado(X,Y,Puntos1).

+!minimizar(Puntos)[source(self)].
/*----------------------------------------------------------------------------*/



/*---------------------------------ERRORES------------------------------------*/
+!encontrarMejorMovimiento <- .print("Error en +!encontrarMejorMovimiento").
+!copiarTablero(_,_) <- .print("Error en +!copiarTablero").
+!borrarTablero(_,_) <- .print("Error en +!borrarTablero").
+!maximizarLista(_) <- .print("Error en +!maximizarLista").
+!minimizarLista(_) <- .print("Error en +!minimizarLista").
/*----------------------------------------------------------------------------*/