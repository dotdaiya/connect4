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

/* Calcula si un celda esta ocupada por el rival o fuera del posicion */
/* Falta implementar jugadorOponente(J) */
ocupadoFueraDeTablero(X,Y,J):-
	(X >= 0 & X <= 7) &
	(Y >= 0 & Y <= 7) &
	posicion(X,Y,jugadorOponente(J)).


// Comprueba si se puede colocar en una posición por encima de la fila siete 
/*puedeColocar(X,Y-1):- //Tested 
	(X >= 0 & X < 7) &
	(posicion(X,Y,1) | posicion(X,Y,2)) &
	posicion(X,Y-1,0) &
	(Y >= 0 & Y < 7).

puedeColocar(X,7):- //Tested
	posicion(X,7,0).*/


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
minimizarLista(X,[],X). //TESTED

minimizarLista(mov(X0,Y0,Puntos0),[mov(X1,Y1,Puntos1)|Tail],Puntos):-
	Puntos1 <= Puntos0 &
	minimizarLista(mov(X1,Y1,Puntos1),Tail,Puntos).

minimizarLista(mov(X0,Y0,Puntos0),[mov(X,Y,Puntos1)|Tail],Puntos):-
	Puntos1 > Puntos0 &
	minimizarLista(mov(X0,Y0,Puntos0),Tail,Puntos).

/*Minimizar la puntuación de una lista de movimientos */
maximizarLista(X,[],X). //TESTED

maximizarLista(mov(X0,Y0,Puntos0),[mov(X1,Y1,Puntos1)|Tail],Puntos):-
	Puntos1 >= Puntos0 &
	maximizarLista(mov(X1,Y1,Puntos1),Tail,Puntos).

maximizarLista(mov(X0,Y0,Puntos0),[mov(X,Y,Puntos1)|Tail],Puntos):-
	Puntos1 < Puntos0 &
	maximizarLista(mov(X0,Y0,Puntos0),Tail,Puntos).

/* Si ya se recorrieron todas las columnas */
nodosTerminales(Columna,Jugador,Estrategia,[]):-
	(Columna >= 8).

/* Si no se puede colocar ninguna ficha mas y no hay ganador */
nodosTerminales(Columna,Jugador,Estrategia,mov(-1,-1,0)):-
	(Columna >= 0 & Columna < 8) &
	not comprobarCeldasLibres &
	nadieGano.

/* Si no se puede colocar ninguna ficha mas y hay ganador */
nodosTerminales(Columna,Jugador,Estrategia,mov(-1,-1,0)):-
	(Columna >= 0 & Columna < 8) &
	not comprobarCeldasLibres &
	nadieGano.

/* Si no se puede colocar en esa columna */
nodosTerminales(Columna,Jugador,Estrategia,LMovimientos):-
	(Columna >= 0 & Columna < 8) &
	not comprobarCeldaLibreEnColumna(Columna,Fila) &
	nodosTerminales(Columna+1,Jugador,Estrategia,LMovimientos).

/* Para cada movimiento */
nodosTerminales(Columna,Jugador,Estrategia,[mov(Columna,Fila,Puntos)|LMovimientos]):-
	(Columna >= 0 & Columna < 8) &
	comprobarCeldaLibreEnColumna(Columna,Fila) &
	.asserta(tmpTablero(Columna,Fila,J)) &
	evaluarTablero(Jugador,Estrategia,Puntos) &
	.abolish(tmpTablero(Columna,Fila,J)) &
	nodosTerminales(Columna+1,Jugador,Estrategia,LMovimientos).


/* Para nodos terminales - Maximizar */
minMax(Jugador,Profundidad,Puntos,Maximizar):- //TESTED
	.print("MAXIMIZAR -terminales- minMax") &
	Profundidad = 0 & 
	Maximizar &
	.print("Terminales:",Profundidad) &
	nodosTerminales(0,Jugador,Estrategia,LMovimientos) &
	maximizarLista(mov(-1,-1,-5000),LMovimientos,Puntos) &
	.print("FIN MAXIMIZAR -terminales- minMax").

/* Para nodos terminales - Minimizar */
minMax(Jugador,Profundidad,Puntos,Maximizar):- //TESTED
	.print("MINIMIZAR -terminales- minMax") &
	Profundidad = 0 & 
	not Maximizar &
	.print("Terminales:",Profundidad) &
	nodosTerminales(0,Jugador,Estrategia,LMovimientos) &
	maximizarLista(mov(-1,-1,5000),LMovimientos,Puntos) &
	.print("FIN MINIMIZAR -terminales- minMax").

/* Si gana o pierde devuelve ese movimiento */
minMax(Jugador,Profundidad,Puntos,Maximizar):-
	Profundidad > 0 &
	.print("GANAR O PERDER") &
	evaluarTablero(Jugador,Estrategia,Puntos) &
	(Puntos = 50 | Puntos = -50) & 
	.print("FIN GANAR O PERDER").

/* En caso de empate */
minMax(Jugador,Profundidad,0,Maximizar):-
	Profundidad > 0 &
	.print("EMPATE minMax") &
	//estrategia(Estrategia)[source(self)] &
	not comprobarCeldasLibres &
	.print("FIN EMPATE minMax").

/* Turno de maximizar */
minMax(Jugador,Profundidad,Puntos,Maximizar):-
	Profundidad > 0 &
	.print("MAXIMIZAR minMax") &
	//estrategia(Estrategia)[source(self)] &
	Maximizar &
	oponente(Jugador2) &
	.print(Profundidad) &
	iterar(0,Jugador2,Profundidad-1,not true,LMovimientos) &
	maximizarLista(LMovimientos,Puntos) &
	.print("FIN MAXIMIZAR minMax").

/* Turno de minimizar */
minMax(Jugador,Profundidad,Puntos,Maximizar):-
	Profundidad > 0 &
	.print("MINIMIZAR minMax") &
	//estrategia(Estrategia)[source(self)] &
	not Maximizar &
	jugador(Jugador2) &
	.print(Profundidad) &
	iterar(0,Jugador2,Profundidad-1,true,LMovimientos) &
	minimizarLista(LMovimientos,Puntos) &
	.print("FIN MINIMIZAR minMax").


/* Ya se recorrieron todas las posibilidades de movimientos */
iterar(Columna,Jugador,Profundidad,Maximizar,[]):-
	(Columna >= 8).

/* Para cada movimiento */
iterar(Columna,Jugador,Profundidad,Maximizar,[Puntos|LMovimientos]):-
	(Columna >= 0 & Columna < 8) &
	comprobarCeldasLibres &
	comprobarCeldaLibreEnColumna(Columna,Fila) &
	.asserta(tmpTablero(Columna,Fila,Jugador)) &
	//tmpTablero(Columna,Fila,Jugador) &
	//.print(Columna," - ",Fila," - ",Jugador) &
	minMax(Jugador,Profundidad,Puntos,Maximizar) &
	.abolish(tmpTablero(Columna,Fila,Jugador)) &
	iterar(Columna+1,Jugador,Profundidad,Maximizar,LMovimientos).


/* Devuelve los puntos de estado del posicion */
evaluarTablero(Jugador,Estrategia,5). // Falta implementar



testing:-
	.asserta(posicion(0,0,1)) &
	.asserta(posicion(0,1,1)) &
	.asserta(posicion(0,2,1)) &
	.asserta(posicion(0,3,1)) &
	.asserta(posicion(0,4,1)) &
	.asserta(posicion(0,5,1)) &
	.asserta(posicion(0,6,1)) &
	.asserta(posicion(0,7,1)) &
	.asserta(posicion(1,0,1)) &
	.asserta(posicion(1,1,1)) &
	.asserta(posicion(1,2,1)) &
	.asserta(posicion(1,3,1)) &
	.asserta(posicion(1,4,1)) &
	.asserta(posicion(1,5,1)) &
	.asserta(posicion(1,6,1)) &
	.asserta(posicion(1,7,1)) &
	.asserta(posicion(2,0,1)) &
	.asserta(posicion(2,1,1)) &
	.asserta(posicion(2,2,1)) &
	.asserta(posicion(2,3,1)) &
	.asserta(posicion(2,4,1)) &
	.asserta(posicion(2,5,1)) &
	.asserta(posicion(2,6,1)) &
	.asserta(posicion(2,7,1)) &
	.asserta(posicion(3,0,1)) &
	.asserta(posicion(3,1,1)) &
	.asserta(posicion(3,2,1)) &
	.asserta(posicion(3,3,1)) &
	.asserta(posicion(3,4,1)) &
	.asserta(posicion(3,5,1)) &
	.asserta(posicion(3,6,1)) &
	.asserta(posicion(3,7,1)) &
	.asserta(posicion(4,0,1)) &
	.asserta(posicion(4,1,1)) &
	.asserta(posicion(4,2,1)) &
	.asserta(posicion(4,3,1)) &
	.asserta(posicion(4,4,1)) &
	.asserta(posicion(4,5,1)) &
	.asserta(posicion(4,6,1)) &
	.asserta(posicion(4,7,1)) &
	.asserta(posicion(5,0,1)) &
	.asserta(posicion(5,1,1)) &
	.asserta(posicion(5,2,1)) &
	.asserta(posicion(5,3,1)) &
	.asserta(posicion(5,4,1)) &
	.asserta(posicion(5,5,1)) &
	.asserta(posicion(5,6,1)) &
	.asserta(posicion(5,7,1)) &
	.asserta(posicion(6,0,1)) &
	.asserta(posicion(6,1,1)) &
	.asserta(posicion(6,2,1)) &
	.asserta(posicion(6,3,1)) &
	.asserta(posicion(6,4,1)) &
	.asserta(posicion(6,5,1)) &
	.asserta(posicion(6,6,1)) &
	.asserta(posicion(6,7,1)) &
	.asserta(posicion(7,0,1)) &
	.asserta(posicion(7,1,1)) &
	.asserta(posicion(7,2,1)) &
	.asserta(posicion(7,3,1)) &
	.asserta(posicion(7,4,1)) &
	.asserta(posicion(7,5,1)) &
	.asserta(posicion(7,6,1)) &
	.asserta(posicion(7,7,1)).
/* INITIAL GOALS */
//!encontrarMejorMovimiento(0,LMovimientos).
/* PLANS */


!copiarTablero(0,0).


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
		.print("holiiiii");
		+tmpTablero(Columna,Fila,Jugador);
		.print("holiiiii2");
		?minMax(Jugador,3,Puntos,not true);
		.print("holiiiii3");
		-tmpTablero(Columna,Fila,Jugador);
		.print("holiiiii4");
		!encontrarMejorMovimiento(Columna+1,[Puntos|LMovimientos]).

// Si ya has comprobado todas las columnas
+!encontrarMejorMovimiento(Columna,LMovimientos)[source(self)]: 
	Columna >= 8 <-
		-mejorMovimiento(mov(Columna,Fila,Puntos));
		put(Columna).

/*----------------------------------------------------------------------------*/



/*---------------------------------ERRORES------------------------------------*/
+!encontrarMejorMovimiento <- .print("Error en +!encontrarMejorMovimiento").
+!copiarTablero(_,_) <- .print("Error en +!copiarTablero").
+!borrarTablero(_,_) <- .print("Error en +!borrarTablero").
/*----------------------------------------------------------------------------*/