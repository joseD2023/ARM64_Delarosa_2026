/* CSET: significa establecer condicionalmente, donde su funcion es guardar 1 en un registro si se cumple 
una condicion y 0 si no se cumple. 

 sintaxis: 
 cset wd, condicion 
 
 wd : registro donde guardamos el resultado 
 condicion : condicion que se evalua utilizando las banderas  */

 mov w1, #10
 mov w2, #10

 cmp  w1, w2
 cset w0, eq

 /* COmo en este caso w1 y w2 son iguales entonces w0 lo que hace es guardar 1 para indicar que fue verdadero 
   en este caso a traves del cmp que modifica la bandera Z 
   
   int resultado = (a == b) ? 1 : 0; */

  mov w1, #8
  mov w2, #3
  cmp  w1, w2  // 8 - 3 = 5  Z = 0   V = 0  N = 0 
  cset w0, gt // 8 > 3  entonces w0 = 1  si fuera falseo w0 = 0 


