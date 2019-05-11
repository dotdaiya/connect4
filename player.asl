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

/*----------------------------------------------------------------------------*/

/* Calcula si un celda esta ocupada por el rival o fuera del tablero */
/* Falta implementar jugadorOponente(J) */
ocupadoFueraDeTablero(X,Y,J):-
	(X >= 0 & X <= 7) &
	(Y >= 0 & Y <= 7) &
	tablero(X,Y,jugadorOponente(J)).


// Comprueba si se puede colocar en una posición por encima de la fila siete 
puedeColocar(X,Y-1):- //Tested 
	(X >= 0 & X < 7) &
	(tablero(X,Y,1) | tablero(X,Y,2)) &
	tablero(X,Y-1,0) &
	(Y >= 0 & Y < 7).

puedeColocar(X,7):- //Tested
	tablero(X,7,0).


/* Comprueba que aún se puede realizar movimientos */
comprobarCeldasLibres:- //Tested
	tablero(X,Y,0).

/* Comprueba que aún hay celdas libres en una columna */
comprobarCeldaLibreEnColumna(Columna,Fila):-
	(Columna >= 0 & Columna < 8) &
	puedeColocar(Columna,Fila).

/* Comprueba si hay un belief de tmpTablero sino coge el percept */
posicion(X,Y,J):-
	tmpTablero(X,Y,J).

posicion(X,Y,J):-
	tablero(X,Y,J)[source(percept)].

/* Comprueba si hay un cuatro en raya en el tablero */
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
minMax(Jugador,Profundidad,Puntos,Maximizar):-
	Profundidad = 0 & 
	Maximizar &
	nodosTerminales(0,Jugador,Estrategia,LMovimientos) &
	maximizarLista(mov(-1,-1,-5000),LMovimientos,Puntos).

/* Para nodos terminales - Minimizar */
minMax(Jugador,Profundidad,Puntos,Maximizar):-
	Profundidad = 0 & 
	not Maximizar &
	nodosTerminales(0,Jugador,Estrategia,LMovimientos) &
	maximizarLista(mov(-1,-1,5000),LMovimientos,Puntos).

/* Si gana o pierde devuelve ese movimiento */
minMax(Jugador,Profundidad,Puntos,Maximizar):-
	estrategia(Estrategia) &
	evaluarTablero(Jugador,Estrategia,Puntos) &
	(Puntos = 50 | Puntos = -50).

/* En caso de empate */
minMax(Jugador,Profundidad,0,Maximizar):-
	estrategia(Estrategia)[source(self)] &
	not comprobarCeldasLibres.

/* Turno de maximizar */
minMax(Jugador,Profundidad,Puntos,Maximizar):-
	estrategia(Estrategia)[source(self)] &
	Maximizar &
	iterar(0,Profundidad-1,not true,LMovimientos) &
	maximizarLista(LMovimientos,Puntos).

/* Turno de minimizar */
minMax(Jugador,Profundidad,Puntos,Maximizar):-
	estrategia(Estrategia)[source(self)] &
	not Maximizar &
	iterar(0,Profundidad-1,true,LMovimientos) &
	minimizarLista(LMovimientos,Puntos).


/* Para cada movimiento */
iterar(Columna,Profundidad,Maximizar,[Puntos|LMovimientos]):-
	(Columna >= 0 & Columna < 8) &
	comprobarCeldasLibres &
	.asserta(tmpTablero(Columna,Fila,J)) &
	minMax(Jugador,Profundidad,Puntos,Maximizar) &
	.abolish(tmpTablero(Columna,Fila,J)) &
	iterar(Columna+1,Profundidad,Maximizar,LMovimientos).

/* Ya se recorrieron todas las posibilidades de movimientos */
iterar(Columna,Profundidad,Maximizar,[]):-
	(Columna >= 8).


/* Devuelve los puntos de estado del tablero */
evaluarTablero(Jugador,Estrategia,5). // Falta implementar

/* INITIAL GOALS */
/* PLANS */



/*---------------------------------ERRORES------------------------------------*/
/*----------------------------------------------------------------------------*/