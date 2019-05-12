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
movimientoMaximizado(-1,-1,-5000).
movimientoMinimizado(-1,-1,5000).
/*----------------------------------------------------------------------------*/
testing0:- //tresEnRayaDiagonalAlphaDerechaAbajo - tresEnRayaDiagonalAlphaIzquierdaArriba FUNCIONAN
	.abolish(posicion(_,_,_)) &
	.asserta(posicion(0,0,0)) & .asserta(posicion(1,0,0)) & .asserta(posicion(2,0,0)) & .asserta(posicion(3,0,0)) & .asserta(posicion(4,0,0)) & .asserta(posicion(5,0,0)) & .asserta(posicion(6,0,0)) & .asserta(posicion(7,0,0)) &
	.asserta(posicion(0,1,0)) & .asserta(posicion(1,1,0)) & .asserta(posicion(2,1,0)) & .asserta(posicion(3,1,0)) & .asserta(posicion(4,1,0)) & .asserta(posicion(5,1,0)) & .asserta(posicion(6,1,0)) & .asserta(posicion(7,1,0)) &
	.asserta(posicion(0,2,0)) & .asserta(posicion(1,2,0)) & .asserta(posicion(2,2,0)) & .asserta(posicion(3,2,0)) & .asserta(posicion(4,2,0)) & .asserta(posicion(5,2,0)) & .asserta(posicion(6,2,0)) & .asserta(posicion(7,2,0)) &
	.asserta(posicion(0,3,0)) & .asserta(posicion(1,3,0)) & .asserta(posicion(2,3,0)) & .asserta(posicion(3,3,0)) & .asserta(posicion(4,3,0)) & .asserta(posicion(5,3,0)) & .asserta(posicion(6,3,0)) & .asserta(posicion(7,3,0)) &
	.asserta(posicion(0,4,1)) & .asserta(posicion(1,4,1)) & .asserta(posicion(2,4,0)) & .asserta(posicion(3,4,0)) & .asserta(posicion(4,4,0)) & .asserta(posicion(5,4,0)) & .asserta(posicion(6,4,0)) & .asserta(posicion(7,4,0)) &
	.asserta(posicion(0,5,2)) & .asserta(posicion(1,5,2)) & .asserta(posicion(2,5,1)) & .asserta(posicion(3,5,0)) & .asserta(posicion(4,5,0)) & .asserta(posicion(5,5,0)) & .asserta(posicion(6,5,0)) & .asserta(posicion(7,5,0)) &
	.asserta(posicion(0,6,1)) & .asserta(posicion(1,6,2)) & .asserta(posicion(2,6,1)) & .asserta(posicion(3,6,1)) & .asserta(posicion(4,6,0)) & .asserta(posicion(5,6,0)) & .asserta(posicion(6,6,0)) & .asserta(posicion(7,6,0)) &
	.asserta(posicion(0,7,1)) & .asserta(posicion(1,7,2)) & .asserta(posicion(2,7,1)) & .asserta(posicion(3,7,2)) & .asserta(posicion(4,7,0)) & .asserta(posicion(5,7,0)) & .asserta(posicion(6,7,0)) & .asserta(posicion(7,7,0)).

testing1:- //ganarSiempreDiagonalBeta - tresEnRayaDiagonalBetaDerechaArriba - tresEnRayaDiagonalBetaIzquierdaAbajo FUNCIONAN
	.abolish(posicion(_,_,_)) &
	.asserta(posicion(0,0,0)) & .asserta(posicion(1,0,0)) & .asserta(posicion(2,0,0)) & .asserta(posicion(3,0,0)) & .asserta(posicion(4,0,0)) & .asserta(posicion(5,0,0)) & .asserta(posicion(6,0,0)) & .asserta(posicion(7,0,0)) &
	.asserta(posicion(0,1,0)) & .asserta(posicion(1,1,0)) & .asserta(posicion(2,1,0)) & .asserta(posicion(3,1,0)) & .asserta(posicion(4,1,0)) & .asserta(posicion(5,1,0)) & .asserta(posicion(6,1,0)) & .asserta(posicion(7,1,0)) &
	.asserta(posicion(0,2,0)) & .asserta(posicion(1,2,0)) & .asserta(posicion(2,2,0)) & .asserta(posicion(3,2,0)) & .asserta(posicion(4,2,0)) & .asserta(posicion(5,2,0)) & .asserta(posicion(6,2,0)) & .asserta(posicion(7,2,0)) &
	.asserta(posicion(0,3,0)) & .asserta(posicion(1,3,0)) & .asserta(posicion(2,3,0)) & .asserta(posicion(3,3,0)) & .asserta(posicion(4,3,0)) & .asserta(posicion(5,3,0)) & .asserta(posicion(6,3,0)) & .asserta(posicion(7,3,0)) &
	.asserta(posicion(0,4,0)) & .asserta(posicion(1,4,0)) & .asserta(posicion(2,4,0)) & .asserta(posicion(3,4,0)) & .asserta(posicion(4,4,0)) & .asserta(posicion(5,4,1)) & .asserta(posicion(6,4,1)) & .asserta(posicion(7,4,0)) &
	.asserta(posicion(0,5,0)) & .asserta(posicion(1,5,0)) & .asserta(posicion(2,5,0)) & .asserta(posicion(3,5,0)) & .asserta(posicion(4,5,1)) & .asserta(posicion(5,5,2)) & .asserta(posicion(6,5,2)) & .asserta(posicion(7,5,0)) &
	.asserta(posicion(0,6,0)) & .asserta(posicion(1,6,0)) & .asserta(posicion(2,6,0)) & .asserta(posicion(3,6,1)) & .asserta(posicion(4,6,2)) & .asserta(posicion(5,6,1)) & .asserta(posicion(6,6,1)) & .asserta(posicion(7,6,0)) &
	.asserta(posicion(0,7,0)) & .asserta(posicion(1,7,0)) & .asserta(posicion(2,7,0)) & .asserta(posicion(3,7,2)) & .asserta(posicion(4,7,1)) & .asserta(posicion(5,7,2)) & .asserta(posicion(6,7,1)) & .asserta(posicion(7,7,0)).

testing2:- //tresEnRayaVertical FUNCIONA
	.abolish(posicion(_,_,_)) &
	.asserta(posicion(0,0,0)) & .asserta(posicion(1,0,0)) & .asserta(posicion(2,0,0)) & .asserta(posicion(3,0,0)) & .asserta(posicion(4,0,0)) & .asserta(posicion(5,0,0)) & .asserta(posicion(6,0,0)) & .asserta(posicion(7,0,0)) &
	.asserta(posicion(0,1,0)) & .asserta(posicion(1,1,0)) & .asserta(posicion(2,1,0)) & .asserta(posicion(3,1,0)) & .asserta(posicion(4,1,0)) & .asserta(posicion(5,1,0)) & .asserta(posicion(6,1,0)) & .asserta(posicion(7,1,0)) &
	.asserta(posicion(0,2,0)) & .asserta(posicion(1,2,0)) & .asserta(posicion(2,2,0)) & .asserta(posicion(3,2,0)) & .asserta(posicion(4,2,0)) & .asserta(posicion(5,2,0)) & .asserta(posicion(6,2,0)) & .asserta(posicion(7,2,0)) &
	.asserta(posicion(0,3,0)) & .asserta(posicion(1,3,0)) & .asserta(posicion(2,3,0)) & .asserta(posicion(3,3,0)) & .asserta(posicion(4,3,0)) & .asserta(posicion(5,3,0)) & .asserta(posicion(6,3,0)) & .asserta(posicion(7,3,0)) &
	.asserta(posicion(0,4,0)) & .asserta(posicion(1,4,0)) & .asserta(posicion(2,4,0)) & .asserta(posicion(3,4,0)) & .asserta(posicion(4,4,0)) & .asserta(posicion(5,4,0)) & .asserta(posicion(6,4,0)) & .asserta(posicion(7,4,0)) &
	.asserta(posicion(0,5,1)) & .asserta(posicion(1,5,0)) & .asserta(posicion(2,5,0)) & .asserta(posicion(3,5,0)) & .asserta(posicion(4,5,0)) & .asserta(posicion(5,5,0)) & .asserta(posicion(6,5,0)) & .asserta(posicion(7,5,0)) &
	.asserta(posicion(0,6,1)) & .asserta(posicion(1,6,0)) & .asserta(posicion(2,6,0)) & .asserta(posicion(3,6,0)) & .asserta(posicion(4,6,0)) & .asserta(posicion(5,6,0)) & .asserta(posicion(6,6,0)) & .asserta(posicion(7,6,0)) &
	.asserta(posicion(0,7,1)) & .asserta(posicion(1,7,0)) & .asserta(posicion(2,7,0)) & .asserta(posicion(3,7,0)) & .asserta(posicion(4,7,0)) & .asserta(posicion(5,7,0)) & .asserta(posicion(6,7,0)) & .asserta(posicion(7,7,0)).

testing3:- //tresEnRayaHorizontalIzquierda - tresEnRayaHorizontalDerecha FUNCIONAN
	.abolish(posicion(_,_,_)) &
	.asserta(posicion(0,0,0)) & .asserta(posicion(1,0,0)) & .asserta(posicion(2,0,0)) & .asserta(posicion(3,0,0)) & .asserta(posicion(4,0,0)) & .asserta(posicion(5,0,0)) & .asserta(posicion(6,0,0)) & .asserta(posicion(7,0,0)) &
	.asserta(posicion(0,1,0)) & .asserta(posicion(1,1,0)) & .asserta(posicion(2,1,0)) & .asserta(posicion(3,1,0)) & .asserta(posicion(4,1,0)) & .asserta(posicion(5,1,0)) & .asserta(posicion(6,1,0)) & .asserta(posicion(7,1,0)) &
	.asserta(posicion(0,2,0)) & .asserta(posicion(1,2,0)) & .asserta(posicion(2,2,0)) & .asserta(posicion(3,2,0)) & .asserta(posicion(4,2,0)) & .asserta(posicion(5,2,0)) & .asserta(posicion(6,2,0)) & .asserta(posicion(7,2,0)) &
	.asserta(posicion(0,3,0)) & .asserta(posicion(1,3,0)) & .asserta(posicion(2,3,0)) & .asserta(posicion(3,3,0)) & .asserta(posicion(4,3,0)) & .asserta(posicion(5,3,0)) & .asserta(posicion(6,3,0)) & .asserta(posicion(7,3,0)) &
	.asserta(posicion(0,4,0)) & .asserta(posicion(1,4,0)) & .asserta(posicion(2,4,0)) & .asserta(posicion(3,4,0)) & .asserta(posicion(4,4,0)) & .asserta(posicion(5,4,0)) & .asserta(posicion(6,4,0)) & .asserta(posicion(7,4,0)) &
	.asserta(posicion(0,5,0)) & .asserta(posicion(1,5,0)) & .asserta(posicion(2,5,0)) & .asserta(posicion(3,5,0)) & .asserta(posicion(4,5,0)) & .asserta(posicion(5,5,0)) & .asserta(posicion(6,5,0)) & .asserta(posicion(7,5,0)) &
	.asserta(posicion(0,6,0)) & .asserta(posicion(1,6,0)) & .asserta(posicion(2,6,0)) & .asserta(posicion(3,6,0)) & .asserta(posicion(4,6,0)) & .asserta(posicion(5,6,0)) & .asserta(posicion(6,6,0)) & .asserta(posicion(7,6,0)) &
	.asserta(posicion(0,7,0)) & .asserta(posicion(1,7,1)) & .asserta(posicion(2,7,1)) & .asserta(posicion(3,7,1)) & .asserta(posicion(4,7,0)) & .asserta(posicion(5,7,0)) & .asserta(posicion(6,7,0)) & .asserta(posicion(7,7,0)).

testing5:- //tresEnCuatroHorizontalCentroDerecha - tresEnCuatroHorizontalCentroIzquierdaFUNCIONAN
	.abolish(posicion(_,_,_)) &
	.asserta(posicion(0,0,0)) & .asserta(posicion(1,0,0)) & .asserta(posicion(2,0,0)) & .asserta(posicion(3,0,0)) & .asserta(posicion(4,0,0)) & .asserta(posicion(5,0,0)) & .asserta(posicion(6,0,0)) & .asserta(posicion(7,0,0)) &
	.asserta(posicion(0,1,0)) & .asserta(posicion(1,1,0)) & .asserta(posicion(2,1,0)) & .asserta(posicion(3,1,0)) & .asserta(posicion(4,1,0)) & .asserta(posicion(5,1,0)) & .asserta(posicion(6,1,0)) & .asserta(posicion(7,1,0)) &
	.asserta(posicion(0,2,0)) & .asserta(posicion(1,2,0)) & .asserta(posicion(2,2,0)) & .asserta(posicion(3,2,0)) & .asserta(posicion(4,2,0)) & .asserta(posicion(5,2,0)) & .asserta(posicion(6,2,0)) & .asserta(posicion(7,2,0)) &
	.asserta(posicion(0,3,0)) & .asserta(posicion(1,3,0)) & .asserta(posicion(2,3,0)) & .asserta(posicion(3,3,0)) & .asserta(posicion(4,3,0)) & .asserta(posicion(5,3,0)) & .asserta(posicion(6,3,0)) & .asserta(posicion(7,3,0)) &
	.asserta(posicion(0,4,0)) & .asserta(posicion(1,4,0)) & .asserta(posicion(2,4,0)) & .asserta(posicion(3,4,0)) & .asserta(posicion(4,4,0)) & .asserta(posicion(5,4,0)) & .asserta(posicion(6,4,0)) & .asserta(posicion(7,4,0)) &
	.asserta(posicion(0,5,0)) & .asserta(posicion(1,5,0)) & .asserta(posicion(2,5,0)) & .asserta(posicion(3,5,0)) & .asserta(posicion(4,5,0)) & .asserta(posicion(5,5,0)) & .asserta(posicion(6,5,0)) & .asserta(posicion(7,5,0)) &
	.asserta(posicion(0,6,0)) & .asserta(posicion(1,6,0)) & .asserta(posicion(2,6,0)) & .asserta(posicion(3,6,0)) & .asserta(posicion(4,6,0)) & .asserta(posicion(5,6,0)) & .asserta(posicion(6,6,0)) & .asserta(posicion(7,6,0)) &
	.asserta(posicion(0,7,0)) & .asserta(posicion(1,7,1)) & .asserta(posicion(2,7,1)) & .asserta(posicion(3,7,0)) & .asserta(posicion(4,7,1)) & .asserta(posicion(5,7,1)) & .asserta(posicion(6,7,0)) & .asserta(posicion(7,7,0)).

testing6:- //tresEnCuatroDiagonalAlphaCentroDerecha - tresEnCuatroDiagonalAlphaCentroIzquierdaFUNCIONAN
	.abolish(posicion(_,_,_)) &
	.asserta(posicion(0,0,0)) & .asserta(posicion(1,0,0)) & .asserta(posicion(2,0,0)) & .asserta(posicion(3,0,0)) & .asserta(posicion(4,0,0)) & .asserta(posicion(5,0,0)) & .asserta(posicion(6,0,0)) & .asserta(posicion(7,0,0)) &
	.asserta(posicion(0,1,0)) & .asserta(posicion(1,1,0)) & .asserta(posicion(2,1,0)) & .asserta(posicion(3,1,0)) & .asserta(posicion(4,1,0)) & .asserta(posicion(5,1,0)) & .asserta(posicion(6,1,0)) & .asserta(posicion(7,1,0)) &
	.asserta(posicion(0,2,1)) & .asserta(posicion(1,2,0)) & .asserta(posicion(2,2,0)) & .asserta(posicion(3,2,0)) & .asserta(posicion(4,2,0)) & .asserta(posicion(5,2,0)) & .asserta(posicion(6,2,0)) & .asserta(posicion(7,2,0)) &
	.asserta(posicion(0,3,0)) & .asserta(posicion(1,3,0)) & .asserta(posicion(2,3,0)) & .asserta(posicion(3,3,0)) & .asserta(posicion(4,3,0)) & .asserta(posicion(5,3,0)) & .asserta(posicion(6,3,0)) & .asserta(posicion(7,3,0)) &
	.asserta(posicion(0,4,0)) & .asserta(posicion(1,4,1)) & .asserta(posicion(2,4,1)) & .asserta(posicion(3,4,0)) & .asserta(posicion(4,4,0)) & .asserta(posicion(5,4,0)) & .asserta(posicion(6,4,0)) & .asserta(posicion(7,4,0)) &
	.asserta(posicion(0,5,0)) & .asserta(posicion(1,5,2)) & .asserta(posicion(2,5,0)) & .asserta(posicion(3,5,1)) & .asserta(posicion(4,5,0)) & .asserta(posicion(5,5,0)) & .asserta(posicion(6,5,0)) & .asserta(posicion(7,5,0)) &
	.asserta(posicion(0,6,0)) & .asserta(posicion(1,6,1)) & .asserta(posicion(2,6,0)) & .asserta(posicion(3,6,0)) & .asserta(posicion(4,6,0)) & .asserta(posicion(5,6,0)) & .asserta(posicion(6,6,0)) & .asserta(posicion(7,6,0)) &
	.asserta(posicion(0,7,0)) & .asserta(posicion(1,7,1)) & .asserta(posicion(2,7,0)) & .asserta(posicion(3,7,0)) & .asserta(posicion(4,7,1)) & .asserta(posicion(5,7,1)) & .asserta(posicion(6,7,0)) & .asserta(posicion(7,7,0)).	

testing7:- //tresEnCuatroDiagonalBetaCentroDerecha - tresEnCuatroDiagonalBetaCentroIzquierdaFUNCIONAN1
	.abolish(posicion(_,_,_)) &
	.asserta(posicion(0,0,0)) & .asserta(posicion(1,0,0)) & .asserta(posicion(2,0,0)) & .asserta(posicion(3,0,0)) & .asserta(posicion(4,0,0)) & .asserta(posicion(5,0,0)) & .asserta(posicion(6,0,0)) & .asserta(posicion(7,0,0)) &
	.asserta(posicion(0,1,0)) & .asserta(posicion(1,1,0)) & .asserta(posicion(2,1,0)) & .asserta(posicion(3,1,0)) & .asserta(posicion(4,1,0)) & .asserta(posicion(5,1,0)) & .asserta(posicion(6,1,0)) & .asserta(posicion(7,1,0)) &
	.asserta(posicion(0,2,0)) & .asserta(posicion(1,2,0)) & .asserta(posicion(2,2,0)) & .asserta(posicion(3,2,0)) & .asserta(posicion(4,2,0)) & .asserta(posicion(5,2,1)) & .asserta(posicion(6,2,0)) & .asserta(posicion(7,2,0)) &
	.asserta(posicion(0,3,0)) & .asserta(posicion(1,3,0)) & .asserta(posicion(2,3,0)) & .asserta(posicion(3,3,0)) & .asserta(posicion(4,3,1)) & .asserta(posicion(5,3,1)) & .asserta(posicion(6,3,0)) & .asserta(posicion(7,3,0)) &
	.asserta(posicion(0,4,0)) & .asserta(posicion(1,4,0)) & .asserta(posicion(2,4,0)) & .asserta(posicion(3,4,0)) & .asserta(posicion(4,4,2)) & .asserta(posicion(5,4,2)) & .asserta(posicion(6,4,0)) & .asserta(posicion(7,4,0)) &
	.asserta(posicion(0,5,0)) & .asserta(posicion(1,5,0)) & .asserta(posicion(2,5,1)) & .asserta(posicion(3,5,1)) & .asserta(posicion(4,5,1)) & .asserta(posicion(5,5,1)) & .asserta(posicion(6,5,0)) & .asserta(posicion(7,5,0)) &
	.asserta(posicion(0,6,0)) & .asserta(posicion(1,6,1)) & .asserta(posicion(2,6,2)) & .asserta(posicion(3,6,1)) & .asserta(posicion(4,6,2)) & .asserta(posicion(5,6,2)) & .asserta(posicion(6,6,0)) & .asserta(posicion(7,6,0)) &
	.asserta(posicion(0,7,0)) & .asserta(posicion(1,7,2)) & .asserta(posicion(2,7,2)) & .asserta(posicion(3,7,2)) & .asserta(posicion(4,7,1)) & .asserta(posicion(5,7,1)) & .asserta(posicion(6,7,0)) & .asserta(posicion(7,7,0)).

testing8:-//parejaHorizontalIzquierda - parejaHorizontalDerecha - parejaDiagonalAlphaIzquierda
    .abolish(posicion(_,_,_)) &
    .asserta(posicion(0,0,0)) & .asserta(posicion(1,0,0)) & .asserta(posicion(2,0,0)) & .asserta(posicion(3,0,0)) & .asserta(posicion(4,0,0)) & .asserta(posicion(5,0,0)) & .asserta(posicion(6,0,0)) & .asserta(posicion(7,0,0)) &
    .asserta(posicion(0,1,0)) & .asserta(posicion(1,1,0)) & .asserta(posicion(2,1,0)) & .asserta(posicion(3,1,0)) & .asserta(posicion(4,1,0)) & .asserta(posicion(5,1,0)) & .asserta(posicion(6,1,0)) & .asserta(posicion(7,1,0)) &
    .asserta(posicion(0,2,0)) & .asserta(posicion(1,2,0)) & .asserta(posicion(2,2,0)) & .asserta(posicion(3,2,0)) & .asserta(posicion(4,2,0)) & .asserta(posicion(5,2,0)) & .asserta(posicion(6,2,0)) & .asserta(posicion(7,2,0)) &
    .asserta(posicion(0,3,0)) & .asserta(posicion(1,3,0)) & .asserta(posicion(2,3,0)) & .asserta(posicion(3,3,0)) & .asserta(posicion(4,3,0)) & .asserta(posicion(5,3,0)) & .asserta(posicion(6,3,0)) & .asserta(posicion(7,3,0)) &
    .asserta(posicion(0,4,0)) & .asserta(posicion(1,4,0)) & .asserta(posicion(2,4,0)) & .asserta(posicion(3,4,0)) & .asserta(posicion(4,4,2)) & .asserta(posicion(5,4,1)) & .asserta(posicion(6,4,0)) & .asserta(posicion(7,4,0)) &
    .asserta(posicion(0,5,0)) & .asserta(posicion(1,5,0)) & .asserta(posicion(2,5,0)) & .asserta(posicion(3,5,0)) & .asserta(posicion(4,5,1)) & .asserta(posicion(5,5,1)) & .asserta(posicion(6,5,0)) & .asserta(posicion(7,5,0)) &
    .asserta(posicion(0,6,0)) & .asserta(posicion(1,6,0)) & .asserta(posicion(2,6,0)) & .asserta(posicion(3,6,0)) & .asserta(posicion(4,6,2)) & .asserta(posicion(5,6,2)) & .asserta(posicion(6,6,1)) & .asserta(posicion(7,6,0)) &
    .asserta(posicion(0,7,1)) & .asserta(posicion(1,7,1)) & .asserta(posicion(2,7,0)) & .asserta(posicion(3,7,0)) & .asserta(posicion(4,7,1)) & .asserta(posicion(5,7,1)) & .asserta(posicion(6,7,1)) & .asserta(posicion(7,7,1)).

testing9:- //parejaGanadoraHorizontalCentral
    .abolish(posicion(_,_,_)) &
    .asserta(posicion(0,0,0)) & .asserta(posicion(1,0,0)) & .asserta(posicion(2,0,0)) & .asserta(posicion(3,0,0)) & .asserta(posicion(4,0,0)) & .asserta(posicion(5,0,0)) & .asserta(posicion(6,0,0)) & .asserta(posicion(7,0,0)) &
    .asserta(posicion(0,1,0)) & .asserta(posicion(1,1,0)) & .asserta(posicion(2,1,0)) & .asserta(posicion(3,1,0)) & .asserta(posicion(4,1,0)) & .asserta(posicion(5,1,0)) & .asserta(posicion(6,1,0)) & .asserta(posicion(7,1,0)) &
    .asserta(posicion(0,2,0)) & .asserta(posicion(1,2,0)) & .asserta(posicion(2,2,0)) & .asserta(posicion(3,2,0)) & .asserta(posicion(4,2,0)) & .asserta(posicion(5,2,0)) & .asserta(posicion(6,2,0)) & .asserta(posicion(7,2,0)) &
    .asserta(posicion(0,3,0)) & .asserta(posicion(1,3,0)) & .asserta(posicion(2,3,0)) & .asserta(posicion(3,3,0)) & .asserta(posicion(4,3,0)) & .asserta(posicion(5,3,0)) & .asserta(posicion(6,3,0)) & .asserta(posicion(7,3,0)) &
    .asserta(posicion(0,4,0)) & .asserta(posicion(1,4,0)) & .asserta(posicion(2,4,0)) & .asserta(posicion(3,4,0)) & .asserta(posicion(4,4,0)) & .asserta(posicion(5,4,0)) & .asserta(posicion(6,4,0)) & .asserta(posicion(7,4,0)) &
    .asserta(posicion(0,5,0)) & .asserta(posicion(1,5,0)) & .asserta(posicion(2,5,0)) & .asserta(posicion(3,5,0)) & .asserta(posicion(4,5,0)) & .asserta(posicion(5,5,0)) & .asserta(posicion(6,5,0)) & .asserta(posicion(7,5,0)) &
    .asserta(posicion(0,6,0)) & .asserta(posicion(1,6,0)) & .asserta(posicion(2,6,0)) & .asserta(posicion(3,6,0)) & .asserta(posicion(4,6,0)) & .asserta(posicion(5,6,0)) & .asserta(posicion(6,6,0)) & .asserta(posicion(7,6,0)) &
    .asserta(posicion(0,7,0)) & .asserta(posicion(1,7,1)) & .asserta(posicion(2,7,0)) & .asserta(posicion(3,7,1)) & .asserta(posicion(4,7,0)) & .asserta(posicion(5,7,0)) & .asserta(posicion(6,7,0)) & .asserta(posicion(7,7,0)).

testing10:- //parejaGanadoraDiagonalAlphaDerecha - parejaGanadoraDiagonalAlphaIzquierda
    .abolish(posicion(_,_,_)) &
    .asserta(posicion(0,0,0)) & .asserta(posicion(1,0,0)) & .asserta(posicion(2,0,0)) & .asserta(posicion(3,0,0)) & .asserta(posicion(4,0,0)) & .asserta(posicion(5,0,0)) & .asserta(posicion(6,0,0)) & .asserta(posicion(7,0,0)) &
    .asserta(posicion(0,1,0)) & .asserta(posicion(1,1,0)) & .asserta(posicion(2,1,0)) & .asserta(posicion(3,1,0)) & .asserta(posicion(4,1,0)) & .asserta(posicion(5,1,0)) & .asserta(posicion(6,1,0)) & .asserta(posicion(7,1,0)) &
    .asserta(posicion(0,2,0)) & .asserta(posicion(1,2,0)) & .asserta(posicion(2,2,0)) & .asserta(posicion(3,2,0)) & .asserta(posicion(4,2,0)) & .asserta(posicion(5,2,0)) & .asserta(posicion(6,2,0)) & .asserta(posicion(7,2,0)) &
    .asserta(posicion(0,3,2)) & .asserta(posicion(1,3,0)) & .asserta(posicion(2,3,0)) & .asserta(posicion(3,3,0)) & .asserta(posicion(4,3,0)) & .asserta(posicion(5,3,0)) & .asserta(posicion(6,3,0)) & .asserta(posicion(7,3,0)) &
    .asserta(posicion(0,4,2)) & .asserta(posicion(1,4,2)) & .asserta(posicion(2,4,1)) & .asserta(posicion(3,4,0)) & .asserta(posicion(4,4,0)) & .asserta(posicion(5,4,0)) & .asserta(posicion(6,4,0)) & .asserta(posicion(7,4,0)) &
    .asserta(posicion(0,5,2)) & .asserta(posicion(1,5,2)) & .asserta(posicion(2,5,2)) & .asserta(posicion(3,5,1)) & .asserta(posicion(4,5,0)) & .asserta(posicion(5,5,0)) & .asserta(posicion(6,5,0)) & .asserta(posicion(7,5,0)) &
    .asserta(posicion(0,6,2)) & .asserta(posicion(1,6,2)) & .asserta(posicion(2,6,2)) & .asserta(posicion(3,6,2)) & .asserta(posicion(4,6,0)) & .asserta(posicion(5,6,0)) & .asserta(posicion(6,6,0)) & .asserta(posicion(7,6,0)) &
    .asserta(posicion(0,7,2)) & .asserta(posicion(1,7,1)) & .asserta(posicion(2,7,2)) & .asserta(posicion(3,7,2)) & .asserta(posicion(4,7,2)) & .asserta(posicion(5,7,0)) & .asserta(posicion(6,7,0)) & .asserta(posicion(7,7,0)).

testing11:- //parejaGanadoraDiagonalAlphaCentral
    .abolish(posicion(_,_,_)) &
    .asserta(posicion(0,0,0)) & .asserta(posicion(1,0,0)) & .asserta(posicion(2,0,0)) & .asserta(posicion(3,0,0)) & .asserta(posicion(4,0,0)) & .asserta(posicion(5,0,0)) & .asserta(posicion(6,0,0)) & .asserta(posicion(7,0,0)) &
    .asserta(posicion(0,1,0)) & .asserta(posicion(1,1,0)) & .asserta(posicion(2,1,0)) & .asserta(posicion(3,1,0)) & .asserta(posicion(4,1,0)) & .asserta(posicion(5,1,0)) & .asserta(posicion(6,1,0)) & .asserta(posicion(7,1,0)) &
    .asserta(posicion(0,2,0)) & .asserta(posicion(1,2,0)) & .asserta(posicion(2,2,0)) & .asserta(posicion(3,2,0)) & .asserta(posicion(4,2,0)) & .asserta(posicion(5,2,0)) & .asserta(posicion(6,2,0)) & .asserta(posicion(7,2,0)) &
    .asserta(posicion(0,3,0)) & .asserta(posicion(1,3,0)) & .asserta(posicion(2,3,0)) & .asserta(posicion(3,3,0)) & .asserta(posicion(4,3,0)) & .asserta(posicion(5,3,0)) & .asserta(posicion(6,3,0)) & .asserta(posicion(7,3,0)) &
    .asserta(posicion(0,4,2)) & .asserta(posicion(1,4,1)) & .asserta(posicion(2,4,0)) & .asserta(posicion(3,4,0)) & .asserta(posicion(4,4,0)) & .asserta(posicion(5,4,0)) & .asserta(posicion(6,4,0)) & .asserta(posicion(7,4,0)) &
    .asserta(posicion(0,5,2)) & .asserta(posicion(1,5,2)) & .asserta(posicion(2,5,0)) & .asserta(posicion(3,5,0)) & .asserta(posicion(4,5,0)) & .asserta(posicion(5,5,0)) & .asserta(posicion(6,5,0)) & .asserta(posicion(7,5,0)) &
    .asserta(posicion(0,6,2)) & .asserta(posicion(1,6,2)) & .asserta(posicion(2,6,2)) & .asserta(posicion(3,6,1)) & .asserta(posicion(4,6,0)) & .asserta(posicion(5,6,0)) & .asserta(posicion(6,6,0)) & .asserta(posicion(7,6,0)) &
    .asserta(posicion(0,7,2)) & .asserta(posicion(1,7,2)) & .asserta(posicion(2,7,2)) & .asserta(posicion(3,7,2)) & .asserta(posicion(4,7,0)) & .asserta(posicion(5,7,0)) & .asserta(posicion(6,7,0)) & .asserta(posicion(7,7,0)).

testing12:- //
    .abolish(posicion(_,_,_)) &
    .asserta(posicion(0,0,0)) & .asserta(posicion(1,0,0)) & .asserta(posicion(2,0,0)) & .asserta(posicion(3,0,0)) & .asserta(posicion(4,0,0)) & .asserta(posicion(5,0,0)) & .asserta(posicion(6,0,0)) & .asserta(posicion(7,0,0)) &
    .asserta(posicion(0,1,0)) & .asserta(posicion(1,1,0)) & .asserta(posicion(2,1,0)) & .asserta(posicion(3,1,0)) & .asserta(posicion(4,1,0)) & .asserta(posicion(5,1,0)) & .asserta(posicion(6,1,0)) & .asserta(posicion(7,1,0)) &
    .asserta(posicion(0,2,0)) & .asserta(posicion(1,2,0)) & .asserta(posicion(2,2,0)) & .asserta(posicion(3,2,0)) & .asserta(posicion(4,2,0)) & .asserta(posicion(5,2,0)) & .asserta(posicion(6,2,0)) & .asserta(posicion(7,2,0)) &
    .asserta(posicion(0,3,0)) & .asserta(posicion(1,3,0)) & .asserta(posicion(2,3,0)) & .asserta(posicion(3,3,0)) & .asserta(posicion(4,3,0)) & .asserta(posicion(5,3,0)) & .asserta(posicion(6,3,0)) & .asserta(posicion(7,3,0)) &
    .asserta(posicion(0,4,0)) & .asserta(posicion(1,4,0)) & .asserta(posicion(2,4,0)) & .asserta(posicion(3,4,0)) & .asserta(posicion(4,4,0)) & .asserta(posicion(5,4,0)) & .asserta(posicion(6,4,0)) & .asserta(posicion(7,4,0)) &
    .asserta(posicion(0,5,0)) & .asserta(posicion(1,5,0)) & .asserta(posicion(2,5,0)) & .asserta(posicion(3,5,0)) & .asserta(posicion(4,5,0)) & .asserta(posicion(5,5,0)) & .asserta(posicion(6,5,0)) & .asserta(posicion(7,5,0)) &
    .asserta(posicion(0,6,0)) & .asserta(posicion(1,6,0)) & .asserta(posicion(2,6,0)) & .asserta(posicion(3,6,0)) & .asserta(posicion(4,6,0)) & .asserta(posicion(5,6,0)) & .asserta(posicion(6,6,0)) & .asserta(posicion(7,6,0)) &
    .asserta(posicion(0,7,0)) & .asserta(posicion(1,7,0)) & .asserta(posicion(2,7,0)) & .asserta(posicion(3,7,0)) & .asserta(posicion(4,7,0)) & .asserta(posicion(5,7,0)) & .asserta(posicion(6,7,0)) & .asserta(posicion(7,7,0)).



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

cuatroEnRaya(Jugador):-
	cuatroEnRayaHorizontal(Jugador) |
	cuatroEnRayaVertical(Jugador) |
	cuatroEnRayaDiagonalAlpha(Jugador) |
	cuatroEnRayaDiagonalBeta(Jugador).

/*  Define quien es el jugador y quien es el rival de forma numerica en funcion 
	del nombre, queda comprobado que el posicion solo reconoce a los agentes con
	el nombre indicado */
quienSoy(1,2):-
	.my_name(player1).
quienSoy(2,1):-
	.my_name(player2).

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



/*-----------------------PARA EVALUAR EL TABLERO------------------------------*/
/* Obtener las puntuaciones del posicion contando el numero de trios, parejas 
y candidatos ganadores siempre y ponderando su valor */

/* Obtiene la puntuacion total del posicion */
evaluarTablero(Jugador,jugarAGanar,500):-
	cuatroEnRaya(Jugador).
	//.print("1-:Acabo el evaluarTablero con ", 500).
evaluarTablero(Jugador,jugarAPerder,-500):-
	oponente(X) &
	cuatroEnRaya(X).
	//.print("2---:Acabo el evaluarTablero con ", -500).
evaluarTablero(Jugador,jugarAGanar,Puntuacion):-
	puntuacionParejas(P,Jugador) &
	puntuacionGanarSiempre(Q,Jugador) &
	puntuacionTrios(R,Jugador) &
	jugadasComunes(S,Jugador) &
	(Puntuacion = P+Q+R+S).
	//.print("3-----:Acabo el evaluarTablero con ", Puntuacion," - Jugador: ",Jugador," - jugarAGanar").
evaluarTablero(Jugador,jugarAPerder,Puntuacion):-
	puntuacionGanarSiempre(Q,Jugador) &
	puntuacionTrios(R,Jugador) &
	jugadasComunes(S,Jugador) &
	puntuacionParejas(P,Jugador) &
	(Puntuacion = -P-Q-R-S).
	//.print("4--------:Acabo el evaluarTablero con ", Puntuacion).


/*Obtiene la puntuacion de las parejas encontradas

	Horizontales:15 
	Diagonales:20
	Verticales:10
	Generan trios Horizontales:60
	Generan trios Diagonales:65
	*/		
puntuacionParejas(Total,Jugador):-
	parejasHorizontales(Lista1,Jugador) &
	parejasTriosGanadorasH(Lista2,Jugador) &
	parejasTriosGanadorasD(Lista3,Jugador) &
	parejasDiagonales(Lista4,Jugador) &
	parejaVertical(Lista5,Jugador) & 
	.length(Lista1,Puntuacion) &
	.length(Lista2,Puntuacion2) &
	.length(Lista3,Puntuacion3) &
	.length(Lista4,Puntuacion4) &
	.length(Lista5,Puntuacion5) &
	Total = Puntuacion*15 + Puntuacion2*60 + Puntuacion3*65 + Puntuacion4*20 + Puntuacion5*10.


/*Obtiene la puntuacion de los candidatos a ganar siempre 90/100 */
puntuacionGanarSiempre(Total,Jugador):-
	ganarSiempre(L,Jugador) &
	.length(L,Puntuacion) &
	Total = Puntuacion*90.


/* Halla los trios que ganan siempre */
ganarSiempre(Final,J):-
    ganarSiempreHorizontal(A,J) &
    ganarSiempreDiagonalAlpha(B,J) &
    ganarSiempreDiagonalBeta(C,J) &
    .concat(A,B,L) &
    .concat(C,L,Final).


/* Halla las parejas que generan un trio que ganan siempre */
parejasTriosGanadorasH(L,J):-
	parejaGanadoraHorizontalDerecha(A,J) &
	parejaGanadoraHorizontalIzquierda(B,J) &
	parejaGanadoraHorizontalCentral(C,J) &
	.concat(A,B,L) &
	.concat(C,L,L2).
parejasTriosGanadorasD(Final,J):-
	parejaGanadoraDiagonalAlphaDerecha(A,J)&
	parejaGanadoraDiagonalAlphaIzquierda(B,J) &
	parejaGanadoraDiagonalAlphaCentral(C,J) &
	parejaGanadoraDiagonalBetaIzquierda(D,J) &
	parejaGanadoraDiagonalBetaDerecha(E,J) &
	parejaGanadoraDiagonalBetaCentral(F,J) &
	.concat(A,B,L) &
	.concat(C,D,L2) &
	.concat(E,F,L3) &
	.concat(L,L2,L4) &
	.concat(L4,L3,Final).


/* 	Halla los trios en el posicion donde hay tres en cuatro y falta
	una para ganar */
trios(Final,J):-
    tresEnCuatroHorizontalCentroDerecha(A,J) &
    tresEnCuatroHorizontalCentroIzquierda(B,J) &
    tresEnCuatroDiagonalAlphaCentroDerecha(C,J) &
    tresEnCuatroDiagonalAlphaCentroIzquierda(D,J) &
    tresEnCuatroDiagonalBetaCentroDerecha(E,J) &
    tresEnCuatroDiagonalBetaCentroIzquierda(F,J) & 
    .concat(A,B,L) &
    .concat(C,D,L2) &
    .concat(E,F,L3) &
    .concat(L,L2,L4) &
    .concat(L4,L3,Final).


/* Posiciones en las que tienes un tres en raya con solo una libre */
triosGananD(Final,J):-
    tresEnRayaDiagonalAlphaDerechaAbajo(A,J) &
    tresEnRayaDiagonalAlphaIzquierdaArriba(B,J) &
    tresEnRayaDiagonalBetaDerechaArriba(C,J) &
    tresEnRayaDiagonalBetaIzquierdaAbajo(D,J) & 
    .concat(A,B,L) &
    .concat(C,D,L2) &
    .concat(L,L2,Final).
triosGananH(Final,J):-
    tresEnRayaHorizontalIzquierda(A,J) &
    tresEnRayaHorizontalDerecha(B,J) &
    .concat(A,B,Final).


/* Halla las parejas disponibles en el posicion */
parejasHorizontales(Final,J):-
	parejaHorizontalIzquierda(A,J) &
	parejaHorizontalDerecha(B,J) &
	parejaHorizontalCentral(C,J) &
	parejaHorizontalSeparadaIzquierda(D,J) &
	parejaHorizontalSeparadaIzquierda(E,J) &
	parejaHorizontalSeparadaCentro(F,J) &
	.concat(A,B,L) &
	.concat(C,D,L2) &
	.concat(E,F,L3) &
	.concat(L,L2,L4) &
	.concat(L4,L3,Final).
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
	.concat(A,B,L) &
	.concat(C,D,L2) &
	.concat(E,F,L3) &
	.concat(G,H,L4) &
	.concat(I,K,L5) &
	.concat(L,M,L6) &
	.concat(L,L2,L7) &
	.concat(L3,L4,L8) &
	.concat(L5,L6,L9) &
	.concat(L7,L8,L10) &
	.concat(L9,L10,Final).


/*
	Obtiene la puntuacion de los trios encontrados
			trio que les falta una para ganar 85
			trios que ganan en Diagonal 75
			trios que ganan en Horizontal 70
			trios verticales 60
*/
puntuacionTrios(Total,Jugador):-
	trios(Lista1,Jugador) &
	triosGananH(Lista2,Jugador) &
	triosGananD(Lista3,Jugador) &
	tresEnRayaVertical(Lista4,Jugador) &
	.length(Lista1,Puntuacion)&
	.length(Lista2,Puntuacion2)&
	.length(Lista3,Puntuacion3)&
	.length(Lista4,Puntuacion4)&
	Total = Puntuacion*85 + Puntuacion3*75 + Puntuacion2*70 + Puntuacion4*60.
/*----------------------------------------------------------------------------*/





/*SE SUBSTITUIRAN POR .INTERSECTION*/
busqueda([],Lista,0).
busqueda([pos(X,Y)|Tail],Lista,Resultado+Resultado2):-
	comunes(pos(X,Y),Lista,Resultado) &
	busqueda(Tail,Lista,Resultado2).
comunes(pos(_,_),[],0).
comunes(pos(X,Y),[pos(X,Y)|Tail],Resultado):-
	comunes(pos(X,Y),Tail,Resultado+1).
comunes(pos(X,Y),[pos(_,_)|Tail],Resultado):-
	comunes(pos(X,Y),Tail,Resultado). 
/***********************************/

unoMismoComunes(_,[],0).
unoMismoComunes([pos(X,Y)|Tail],[pos(_,_),pos(Y,X)|Tail2],Resultado):-
	comunes(Tail,Tail2,Resultado+1). 
unoMismoComunes([pos(X,Y)|Tail],[pos(_,_),pos(A,B)|Tail2],Resultado):-
	comunes(Tail,Tail2,Resultado). 









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


/* Si gana devuelve 500 */
minMax(Jugador,Profundidad,500,Maximizar):-
	//.print("GANAR") &
	estrategia(Estrategia)[source(percept)] &
	cuatroEnRaya(Jugador).
	//.print("FIN GANAR").
/* Si pierde devuelve -500 */
minMax(Jugador,Profundidad,-500,Maximizar):-
	//.print("GANAR") &
	estrategia(Estrategia)[source(percept)] &
	oponente(O) &
	cuatroEnRaya(O).
	//.print("FIN GANAR").
/* En caso de empate */
minMax(Jugador,Profundidad,0,Maximizar):-
	//.print("EMPATE minMax") &
	not comprobarCeldasLibres &
	estrategia(Estrategia)[source(percept)] &
	evaluarTablero(Jugador,Estrategia,0).
	//.print("FIN EMPATE minMax").
/* Caso base */
minMax(Jugador,0,Puntos,Maximizar):-
	//.print("Caso base") &
	estrategia(Estrategia)[source(percept)] &
	evaluarTablero(Jugador,Estrategia,Puntos).
	//.print("FIN Caso base").
/* Turno de maximizar */
minMax(Jugador,Profundidad,Puntos,Maximizar):-
	Profundidad > 0 &
	//.print("MAXIMIZAR minMax") &
	Maximizar &
	oponente(Jugador2) &
	//.print("DATOS:(","0 - ",Jugador2," - ",Profundidad-1," - ","not true",")") &
	iterar(0,Jugador2,Profundidad-1,not true,LMovimientos) &
	maximizarLista(-5000,LMovimientos,Puntos).
	//.print("FIN MAXIMIZAR minMax").
/* Turno de minimizar */
minMax(Jugador,Profundidad,Puntos,Maximizar):-
	Profundidad > 0 &
	//.print("MINIMIZAR minMax") &
	not Maximizar &
	jugador(Jugador2) &
	//.print("DATOS:(","0 - ",Jugador2," - ",Profundidad-1," - ","true",")") &
	iterar(0,Jugador2,Profundidad-1,true,LMovimientos) &
	minimizarLista(5000,LMovimientos,Puntos).
	//.print("FIN MINIMIZAR minMax").


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


/* Halla las jugadas comunes */
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
		
		Puntuacion = 	P1+P2+P3+P4+P5+P6+P7+P8+P9+P10+P11+P12+P13+P14+P15+
						P16+P17+P18+P19+P20+P21+P22+P23+P24+P25+P26+P27+P28+
						P29+P30+P31+P32+P33+P34+P35+P36+P37+P38+P39+P40+P41+
						P42+P43+P44+P45.



/*-----------------------PARA EVALUAR EL TABLERO------------------------------*/
/* Comprueba si hay un cuatro en raya en el posicion */
cuatroEnRayaVertical(J):-
	posicion(X,Y,J) &
	posicion(X,Y+1,J) &
	posicion(X,Y+2,J) &
	posicion(X,Y+3,J).
cuatroEnRayaHorizontal(J):-
	posicion(X,Y,J) &
	posicion(X+1,Y,J) &
	posicion(X+2,Y,J) &
	posicion(X+3,Y,J).
cuatroEnRayaDiagonalAlpha(J):-
	posicion(X,Y,J) &
	posicion(X+1,Y+1,J) &
	posicion(X+2,Y+2,J) &
	posicion(X+3,Y+3,J).
cuatroEnRayaDiagonalBeta(J):-
	posicion(X,Y,J) &
	posicion(X-1,Y+1,J) &
	posicion(X-2,Y+2,J) &
	posicion(X-3,Y+3,J).


/* Posiciones en las que ganas siempre: +20 */
ganarSiempreHorizontal([pos(X0,Y),pos(X0+4,Y)],J):-//TESTED
	posicion(X0,Y,0) &
	posicion(X0+1,Y,J) &
	posicion(X0+2,Y,J) &
	posicion(X0+3,Y,J) &
	posicion(X0+4,Y,0) &
	puedeColocar(X0,Y) &
	puedeColocar(X0+4,Y).
ganarSiempreHorizontal([],J).

ganarSiempreDiagonalAlpha([pos(X0,Y0),pos(X0+4,Y0+4)],J):-//TESTED
	posicion(X0,Y0,0) &
	posicion(X0+1,Y0+1,J) &
	posicion(X0+2,Y0+2,J) &
	posicion(X0+3,Y0+3,J) &
	posicion(X0+4,Y0+4,0) &
	puedeColocar(X0,Y0) &
	puedeColocar(X0+4,Y0+4).//TESTED
ganarSiempreDiagonalAlpha([],J).

ganarSiempreDiagonalBeta([pos(X0,Y0),pos(X0-4,Y0+4)],J):-//TESTED
	posicion(X0,Y0,0) &
	posicion(X0-1,Y0+1,J) &
	posicion(X0-2,Y0+2,J) &
	posicion(X0-3,Y0+3,J) &
	posicion(X0-4,Y0+4,0) &
	puedeColocar(X0,Y0) &
	puedeColocar(X0-4,Y0+4).
ganarSiempreDiagonalBeta([],J).


/* Posiciones en las que tienes un tres en raya con solo una libre: +20*/
tresEnRayaVertical([pos(X,Y0)],J):-//TESTED
	posicion(X,Y0,0) &
	posicion(X,Y0+1,J) &
	posicion(X,Y0+2,J) &
	posicion(X,Y0+3,J).
tresEnRayaVertical([],J).

tresEnRayaHorizontalIzquierda([pos(X0,Y)],J):-//TESTED
	posicion(X0,Y,0) &
	posicion(X0+1,Y,J) &
	posicion(X0+2,Y,J) &
	posicion(X0+3,Y,J) &
	puedeColocar(X0,Y).
tresEnRayaHorizontalIzquierda([],J).

tresEnRayaHorizontalDerecha([pos(X0+3,Y)],J):-//TESTED
	posicion(X0,Y,J) &
	posicion(X0+1,Y,J) &
	posicion(X0+2,Y,J) &
	posicion(X0+3,Y,0) &
	puedeColocar(X0+3,Y).
tresEnRayaHorizontalDerecha([],J).

tresEnRayaDiagonalAlphaDerechaAbajo([pos(X0,Y0)],J):-//TESTED
	posicion(X0,Y0,0) &
	posicion(X0+1,Y0+1,J) &
	posicion(X0+2,Y0+2,J) &
	posicion(X0+3,Y0+3,J) &
	puedeColocar(X0,Y0).
tresEnRayaDiagonalAlphaDerechaAbajo([],J).
	
tresEnRayaDiagonalAlphaIzquierdaArriba([pos(X0+3,Y0+3)],J):-//TESTED
	posicion(X0,Y0,J) &
	posicion(X0+1,Y0+1,J) &
	posicion(X0+2,Y0+2,J) &
	posicion(X0+3,Y0+3,0) &
	puedeColocar(X0+3,Y0+3).
tresEnRayaDiagonalAlphaIzquierdaArriba([],J).

tresEnRayaDiagonalBetaDerechaArriba([pos(X0,Y0)],J):-//TESTED
	posicion(X0,Y0,0) &
	posicion(X0-1,Y0+1,J) &
	posicion(X0-2,Y0+2,J) &
	posicion(X0-3,Y0+3,J) &
	puedeColocar(X0,Y0).
tresEnRayaDiagonalBetaDerechaArriba([],J).

tresEnRayaDiagonalBetaIzquierdaAbajo([pos(X0-3,Y0+3)],J):-//TESTED
	posicion(X0,Y0,J) &
	posicion(X0-1,Y0+1,J) &
	posicion(X0-2,Y0+2,J) &
	posicion(X0-3,Y0+3,0) &
	puedeColocar(X0-3,Y0+3).
tresEnRayaDiagonalBetaIzquierdaAbajo([],J).


/* Posiciones en las que hay tres en cuatro y una para ganar: */
tresEnCuatroHorizontalCentroDerecha([pos(X0+2,Y)],J):-//TESTED
	posicion(X0,Y,J) &
	posicion(X0+1,Y,J) &
	posicion(X0+2,Y,0) &
	posicion(X0+3,Y,J) &
	puedeColocar(X0+2,Y).
tresEnCuatroHorizontalCentroDerecha([],J).

tresEnCuatroHorizontalCentroIzquierda([pos(X0+1,Y)],J):-//TESTED
	posicion(X0,Y,J) &
	posicion(X0+1,Y,0) &
	posicion(X0+2,Y,J) &
	posicion(X0+3,Y,J) &
	puedeColocar(X0+1,Y).
tresEnCuatroHorizontalCentroIzquierda([],J).

tresEnCuatroDiagonalAlphaCentroDerecha([pos(X0+2,Y0+2)],J):-//TESTED
	posicion(X0,Y0,J) &
	posicion(X0+1,Y0+1,J) &
	posicion(X0+2,Y0+2,0) &
	posicion(X0+3,Y0+3,J) &
	puedeColocar(X0+2,Y0+2).
tresEnCuatroDiagonalAlphaCentroDerecha([],J).

tresEnCuatroDiagonalAlphaCentroIzquierda([pos(X0+1,Y0+1)],J):-//TESTED
	posicion(X0,Y0,J) &
	posicion(X0+1,Y0+1,0) &
	posicion(X0+2,Y0+2,J) &
	posicion(X0+3,Y0+3,J) &
	puedeColocar(X0+1,Y0+1).
tresEnCuatroDiagonalAlphaCentroIzquierda([],J).

tresEnCuatroDiagonalBetaCentroDerecha([pos(X0-2,Y0+2)],J):-//TESTED
	posicion(X0,Y0,J) &
	posicion(X0-1,Y0+1,J) &
	posicion(X0-2,Y0+2,0) &
	posicion(X0-3,Y0+3,J) &
	puedeColocar(X0-2,Y0+2).
tresEnCuatroDiagonalBetaCentroDerecha([],J).

tresEnCuatroDiagonalBetaCentroIzquierda([pos(X0-1,Y0+1)],J):-//TESTED
	posicion(X0,Y0,J) &
	posicion(X0-1,Y0+1,0) &
	posicion(X0-2,Y0+2,J) &
	posicion(X0-3,Y0+3,J) &
	puedeColocar(X0-1,Y0+1).
tresEnCuatroDiagonalBetaCentroIzquierda([],J).


/* Parejas horizontal que generan un trio que gana siempre: */
parejaGanadoraHorizontalDerecha([pos(X0+3,Y)],J):-
	posicion(X0,Y,0) &
	posicion(X0+1,Y,J) &
	posicion(X0+2,Y,J) &
	posicion(X0+3,Y,0) &
	posicion(X0+4,Y,0) &
	puedeColocar(X0+3,Y).
parejaGanadoraHorizontalDerecha([],J).

parejaGanadoraHorizontalIzquierda([pos(X0+1,Y)],J):-
	posicion(X0,Y,0) &
	posicion(X0+1,Y,0) &
	posicion(X0+2,Y,J) &
	posicion(X0+3,Y,J) &
	posicion(X0+4,Y,0) &
	puedeColocar(X0+1,Y).
parejaGanadoraHorizontalIzquierda([],J).

parejaGanadoraHorizontalCentral([pos(X0+2,Y)],J):-
	posicion(X0,Y,0) &
	posicion(X0+1,Y,J) &
	posicion(X0+2,Y,0) &
	posicion(X0+3,Y,J) &
	posicion(X0+4,Y,0) &
	puedeColocar(X0+2,Y).
parejaGanadoraHorizontalCentral([],J).

parejaGanadoraDiagonalAlphaDerecha([pos(X0+3,Y0+3)],J):-
	posicion(X0,Y0,0) &
	posicion(X0+1,Y0+1,J) &
	posicion(X0+2,Y0+2,J) &
	posicion(X0+3,Y0+3,0) &
	posicion(X0+4,Y0+4,0) &
	puedeColocar(X0+3,Y0+3).
parejaGanadoraDiagonalAlphaDerecha([],J).

parejaGanadoraDiagonalAlphaIzquierda([pos(X0+1,Y0+1)],J):-
	posicion(X0,Y0,0) &
	posicion(X0+1,Y0+1,0) &
	posicion(X0+2,Y0+2,J) &
	posicion(X0+3,Y0+3,J) &
	posicion(X0+4,Y0+4,0) &
	puedeColocar(X0+1,Y0+1).
parejaGanadoraDiagonalAlphaIzquierda([],J).

parejaGanadoraDiagonalAlphaCentral([pos(X0+2,Y0+2)],J):-
	posicion(X0,Y0,0) &
	posicion(X0+1,Y0+1,J) &
	posicion(X0+2,Y0+2,0) &
	posicion(X0+3,Y0+3,J) &
	posicion(X0+4,Y0+4,0) &
	puedeColocar(X0+2,Y0+2).
parejaGanadoraDiagonalAlphaCentral([],J).

parejaGanadoraDiagonalBetaIzquierda([pos(X0+3,Y0+3)],J):-
	posicion(X0,Y0,0) &
	posicion(X0-1,Y0+1,J) &
	posicion(X0-2,Y0+2,J) &
	posicion(X0-3,Y0+3,0) &
	posicion(X0-4,Y0+4,0) &
	puedeColocar(X0-3,Y0+3).
parejaGanadoraDiagonalBetaIzquierda([],J).

parejaGanadoraDiagonalBetaDerecha([pos(X0-1,Y0+1)],J):-
	posicion(X0,Y0,0) &
	posicion(X0-1,Y0+1,0) &
	posicion(X0-2,Y0+2,J) &
	posicion(X0-3,Y0+3,J) &
	posicion(X0-4,Y0+4,0) &
	puedeColocar(X0-1,Y0+1).
parejaGanadoraDiagonalBetaDerecha([],J).

parejaGanadoraDiagonalBetaCentral([pos(X0-2,Y0+2)],J):-
	posicion(X0,Y0,0) &
	posicion(X0-1,Y0+1,J) &
	posicion(X0-2,Y0+2,0) &
	posicion(X0-3,Y0+3,J) &
	posicion(X0-4,Y0+4,0) &
	puedeColocar(X0-2,Y0+2).
parejaGanadoraDiagonalBetaCentral([],J).

/* Parejas que generan un trio: */
/* Horizontales */
parejaHorizontalIzquierda([pos(X0+2,Y)],J):-
	posicion(X0,Y,J) &
	posicion(X0+1,Y,J) &
	posicion(X0+2,Y,0) &
	posicion(X0+3,Y,0) &
	puedeColocar(X0+2,Y).
parejaHorizontalIzquierda([],J).

parejaHorizontalDerecha([pos(X0+1,Y)],J):-
	posicion(X0,Y,0) &
	posicion(X0+1,Y,0) &
	posicion(X0+2,Y,J) &
	posicion(X0+3,Y,J) &
	puedeColocar(X0+1,Y).
parejaHorizontalDerecha([],J).

parejaHorizontalCentral([pos(X0,Y)],J):-
	posicion(X0,Y,0) &
	posicion(X0+1,Y,J) &
	posicion(X0+2,Y,J) &
	posicion(X0+3,Y,0) &
	puedeColocar(X0,Y).
parejaHorizontalCentral([],J).

parejaHorizontalSeparadaIzquierda([pos(X0+1,Y)],J):-
	posicion(X0,Y,J) &
	posicion(X0+1,Y,0) &
	posicion(X0+2,Y,J) &
	posicion(X0+3,Y,0) &
	puedeColocar(X+1,Y).
parejaHorizontalSeparadaIzquierda([],J).

parejaHorizontalSeparadaIzquierda([pos(X0+2,Y)],J):-
	posicion(X0,Y,0) &
	posicion(X0+1,Y,J) &
	posicion(X0+2,Y,0) &
	posicion(X0+3,Y,J) &
	puedeColocar(X0+2,Y).
parejaHorizontalSeparadaIzquierda([],J).

parejaHorizontalSeparadaCentro([pos(X0+1,Y)],J):-
	posicion(X0,Y,J) &
	posicion(X0+1,Y,0) &
	posicion(X0+2,Y,0) &
	posicion(X0+3,Y,J) &
	puedeColocar(X0+1,Y).
parejaHorizontalSeparadaCentro([],J).

/* Verticales */
parejaVertical([pos(X0,Y)],J):- 
    posicion(X0,Y,0) & 
    posicion(X0,Y+1,J) &
    posicion(X0,Y+2,J).
parejaVertical([],J).

/* Diagonales Alpha */ 
parejaDiagonalAlphaIzquierda([pos(X0+2,Y0+2)],J):-
	posicion(X0,Y0,J) &
	posicion(X0+1,Y0+1,J) &
	posicion(X0+2,Y0+2,0) &
	posicion(X0+3,Y0+3,0) &
	puedeColocar(X0+2,Y0+2).
parejaDiagonalAlphaIzquierda([],J).

parejaDiagonalAlphaDerecha([pos(X0+1,Y0+1)],J):-
	posicion(X0,Y0,0) &
	posicion(X0+1,Y0+1,0) &
	posicion(X0+2,Y0+2,J) &
	posicion(X0+3,Y0+3,J) &
	puedeColocar(X0+1,Y0+1).
parejaDiagonalAlphaDerecha([],J).

parejaDiagonalAlphaCentral([pos(X0,Y0)],J):-
	posicion(X0,Y0,0) &
	posicion(X0+1,Y0+1,J) &
	posicion(X0+2,Y0+2,J) &
	posicion(X0+3,Y0+3,0) &
	puedeColocar(X0,Y0).
parejaDiagonalAlphaCentral([],J).

parejaDiagonalAlphaSeparadaIzq([pos(X0+1,Y0+1)],J):-
	posicion(X0,Y0,J) &
	posicion(X0+1,Y0+1,0) &
	posicion(X0+2,Y0+2,J) &
	posicion(X0+3,Y0+3,0) &
	puedeColocar(X0+1,Y0+1).
parejaDiagonalAlphaSeparadaIzq([],J).

parejaDiagonalAlphaSeparadaDer([pos(X0+2,Y0+2)],J):-
	posicion(X0,Y0,0) &
	posicion(X0+1,Y0+1,J) &
	posicion(X0+2,Y0+2,0) &
	posicion(X0+3,Y0+3,J) &
	puedeColocar(X0+2,Y0+2).
parejaDiagonalAlphaSeparadaDer([],J).

parejaDiagonalAlphaSeparadaCentro([pos(X0+1,Y0+1)],J):-
	posicion(X0,Y0,J) &
	posicion(X0+1,Y0+1,0) &
	posicion(X0+2,Y0+2,0) &
	posicion(X0+3,Y0+3,J) &
	puedeColocar(X0+1,Y0+1).
parejaDiagonalAlphaSeparadaCentro([],J).

/* Diagonales Beta */
parejaDiagonalBetaIzquierda([pos(X0+2,Y0+2)],J):-
	posicion(X0,Y0,J) &
	posicion(X0+1,Y0+1,J) &
	posicion(X0+2,Y0+2,0) &
	posicion(X0+3,Y0+3,0) &
	puedeColocar(X0+2,Y0+2).
parejaDiagonalBetaIzquierda([],J).

parejaDiagonalBetaDerecha([pos(X0+1,Y0+1)],J):-
	posicion(X0,Y0,0) &
	posicion(X0-1,Y0+1,0) &
	posicion(X0-2,Y0+2,J) &
	posicion(X0-3,Y0+3,J) &
	puedeColocar(X0-1,Y0+1).
parejaDiagonalBetaDerecha([],J).

parejaDiagonalBetaCentral([pos(X0,Y0)],J):-
	posicion(X0,Y0,0) &
	posicion(X0-1,Y0+1,J) &
	posicion(X0-2,Y0+2,J) &
	posicion(X0-3,Y0+3,0) &
	puedeColocar(X0,Y0).
parejaDiagonalBetaCentral([],J).

parejaGeDiagonalBetaSeparadaIzq([pos(X0-1,Y0+1)],J):-
	posicion(X0,Y0,J) &
	posicion(X0-1,Y0+1,0) &
	posicion(X0-2,Y0+2,J) &
	posicion(X0-3,Y0+3,0) &
	puedeColocar(X0-1,Y0+1).
parejaGeDiagonalBetaSeparadaIzq([],J).

parejaGeneraTrioDiagonalSeparadaDer([pos(X0-2,Y0+2)],J):-
	posicion(X0,Y0,0) &
	posicion(X0-1,Y0+1,J) &
	posicion(X0-2,Y0+2,0) &
	posicion(X0-3,Y0+3,J) &
	puedeColocar(X0-2,Y0+2).
parejaGeneraTrioDiagonalSeparadaDer([],J).

parejaDiagonalBetaSeparadaCentro([pos(X0-1,Y0+1)],J):-
	posicion(X0,Y0,J) &
	posicion(X0-1,Y0+1,0) &
	posicion(X0-2,Y0+2,0) &
	posicion(X0-3,Y0+3,J) &
	puedeColocar(X0-1,Y0+1).
parejaDiagonalBetaSeparadaCentro([],J).

/* Solo una ficha */
solitaGeneraHorizontal([pos(X0+1,Y0)],J):-
	posicion(X0,Y0,J) &
	posicion(X0+1,Y0,0) & 
	posicion(X0+2,Y0,0) &
	posicion(X0+3,Y0,0) &
	puedeColocar(X0+1,Y0).
solitaGeneraHorizontal([],J).

solitaGeneraVertical([pos(X0,Y0-1)],J):-
	posicion(X0,Y0,J) &
	posicion(X0,Y0-1,0) & 
	posicion(X0,Y0-2,0) &
	posicion(X0,Y0-3,0) &
	puedeColocar(X0,Y0-1).
solitaGeneraVertical([],J).

solitaGeneraDiagonalAlpha([pos(X0-1,Y0-1)],J):-
	posicion(X0,Y0,J) &
	posicion(X0-1,Y0-1,0) & 
	posicion(X0-2,Y0-2,0) &
	posicion(X0-3,Y0-3,0) &
	puedeColocar(X0-1,Y0-1).
solitaGeneraDiagonalAlpha([],J).

solitaGeneraDiagonalBeta([pos(X0+1,Y0-1)],J):-
	posicion(X0,Y0,J) &
	posicion(X0+1,Y0-1,0) & 
	posicion(X0+2,Y0-2,0) &
	posicion(X0+3,Y0-3,0) &
	puedeColocar(X0+1,Y0-1).
solitaGeneraDiagonalBeta([],J).


/* Para una sola ficha */
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

solitaGeneraUna([pos(X0,Y0)],J):-
	(solitaGeneraHorizontal([pos(X0,Y0)],J) |
	solitaGeneraVertical([pos(X0,Y0)],J) |
	solitaGeneraDiagonalAlpha([pos(X0,Y0)],J) |
	solitaGeneraDiagonalBeta([pos(X0,Y0)],J)).
solitaGeneraUna([],J).
/*----------------------------------------------------------------------------*/



/* INITIAL GOALS */


//!encontrarMejorMovimiento(0,LMovimientos).
!copiarTablero(0,0).


/* PLANS */

/*----------------------------------------------------------------------------*/
/*-----------------------JUEGAR A PERDER DE SEGUNDO---------------------------*/
/*----------------------------------------------------------------------------*/
/*	Busca la primera ficha del rival que no tenga una ficha del jugador colocada
	encima y coloca su ficha encima de la del rival */		
+!jugarAperderSegundo[source(self)]:
	quienSoy(Jugador,Rival) &
	posicion(X,Y,Rival) &
	posicion(X,Y-1,0) <-
		put(X);
		!jugar.
/*----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*/
/*---------------------CREAR-BORRAR TABLERO TEMPORAL--------------------------*/
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

+!borrarTablero <-
	.abolish(posicion(_,_,_)).
/*----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*/
/*-----------------------ENCONTRAR MEJOR MOVIMIENTO---------------------------*/
/*----------------------------------------------------------------------------*/

// Si no hay celdas libres
+!encontrarMejorMovimiento(Columna)[source(self)]:
	not comprobarCeldasLibres[source(self)] <-
		!jugar.
// Si no se puede colocar en la columna
+!encontrarMejorMovimiento(Columna)[source(self)]: 
	(Columna < 8 & Columna >= 0) &
	comprobarCeldasLibres[source(self)] &
	not comprobarCeldaLibreEnColumna(Columna,Fila)[source(self)] <-
		!encontrarMejorMovimiento(Columna+1).
// Si se puede colocar ficha en la columna
+!encontrarMejorMovimiento(Columna)[source(self)]:
	(Columna < 8 & Columna >= 0) &
	comprobarCeldasLibres[source(self)] &
	comprobarCeldaLibreEnColumna(Columna,Fila)[source(self)] &
	jugador(Jugador)[source(self)] <-
		?posicion(Columna,Fila,0);
		-posicion(Columna,Fila,0);
		+posicion(Columna,Fila,Jugador);
		.print("Columna: ",Columna,"-Fila: ",Fila,"- Ocupado por: ",Jugador);
		?minMax(Jugador,2,Puntos,true);
		.print("Acabo el minMax para columna: ",Columna," con ", Puntos);
		!maximizar(Columna,Fila,Puntos);
		-posicion(Columna,Fila,Jugador);
		+posicion(Columna,Fila,0);
		!encontrarMejorMovimiento(Columna+1).
// Si ya has comprobado todas las columnas
+!encontrarMejorMovimiento(Columna)[source(self)]: 
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
		-movimientoMaximizado(X1,Y1,Puntos1);
		+movimientoMaximizado(X,Y,Puntos).
+!maximizar(X,Y,Puntos)[source(self)].

+!minimizar(X,Y,Puntos)[source(self)]:
	movimientoMinizado(X1,Y1,Puntos1) &
	Puntos < Puntos1 <-
		-movimientoMinizado(X1,Y1,Puntos1);
		+movimientoMinizado(X,Y,Puntos).
+!minimizar(Puntos)[source(self)].
/*----------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------*/
/*---------------------------------TURNOS-------------------------------------*/
/*----------------------------------------------------------------------------*/
/* Define elementos iniciales tales como el primer turno */
+!definiciones[source(self)]:
	turno(X)[source(percept)] &
	.my_name(X) &
	quienSoy(X1,Y1) <- 
		+primerTurno("primero");
		+jugador(X1);
		+oponente(Y1);
		!borrarTablero;
		!copiarTablero(0,0);
		!jugar.
+!definiciones[source(self)]:
	turno(X)[source(percept)] &
	not .my_name(X) &
	quienSoy(X1,Y1) <- 
		+primerTurno("segundo");
		+jugador(X1);
		+oponente(Y1);
		!borrarTablero;
		!copiarTablero(0,0);
		!jugar.
+!definiciones[source(self)] <- 
	.wait(50); 
	!definiciones.
/*----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*/
/*---------------------------------JUGAR--------------------------------------*/
/*----------------------------------------------------------------------------*/
+!jugar[source(self)]:
	turno(X)[source(percept)] &
	.my_name(X) &
	estrategia(jugarAGanar)[source(percept)] <-
		.print("hi").
+!jugar[source(self)]:
	turno(X) &
	.my_name(X) &
	estrategia(jugarAGanar) <-
		.print("hi").


/* Gestiona la partida cuando juega a perder y empieza primero */
+!jugar[source(self)]:
	turno(X)[source(percept)] &
	.my_name(X) &
	estrategia(jugarAPerder)[source(percept)] &
	primerTurno("primero")[source(self)] <-
		.print("hi").
+!jugar[source(self)]:
	turno(X)[source(percept)] &
	.my_name(X) &
	estrategia(jugarAPerder)[source(percept)] &
	primerTurno("primero")[source(self)] <-
		.print("hi").

/* Gestiona la partida cuando juega a perder y empieza segundo */
+!jugar[source(self)]:
	turno(X)[source(percept)] &
	.my_name(X) &
	(X = player1) &
	estrategia(jugarAPerder)[source(percept)] &
	primerTurno("segundo")[source(self)] <-
		!jugarAperderSegundo.
+!jugar[source(self)]:
	turno(X)[source(percept)] &
	.my_name(X) &
	(X = player2) &
	estrategia(jugarAPerder)[source(percept)] &
	primerTurno("segundo")[source(self)] <-
		!jugarAperderSegundo.

/* Si es el turno del oponente no hace nada */
+!jugar[source(self)]:
	turno(X)[source(percept)] &
	not .my_name(X) <- 
		.wait(50);
		!jugar. 
/*----------------------------------------------------------------------------*/



/*---------------------------------ERRORES------------------------------------*/
+!encontrarMejorMovimiento(_) <- .print("Error en +!encontrarMejorMovimiento").
+!copiarTablero(_,_) <- .print("Error en +!copiarTablero").
+!borrarTablero(_,_) <- .print("Error en +!borrarTablero").
+!maximizarLista(_,_,_) <- .print("Error en +!maximizarLista").
+!minimizarLista(_,_,_) <- .print("Error en +!minimizarLista").
+!definiciones <- .print("Error en +!definiciones").
+!jugar <- .print("Error en +!jugar").
+!jugarAperderSegundo <- .print("Error en +!jugarAperderSegundo").
/*----------------------------------------------------------------------------*/
