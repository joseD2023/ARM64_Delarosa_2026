/* CCMN: Funciona como la misma idea de comparacion condicional, pero las operacion que realiza es una suma para actualizar 
las banderas.  
  sintaxis: 
    ccmn wn, wm, #inmediato, condicion 
    - si la condicion se cumple, calcula conceptualmente wn + wm y actualiza las banderas 
    - si no se cumple, establece las banderas segun el inmediato de 4 bits.  */

    cmp  w1, w2
    ccmn w3, w4, #0, eq

