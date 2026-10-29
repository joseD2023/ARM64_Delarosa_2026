/* EJERCICIO 1

En memoria hay un arreglo de 10 números enteros con signo de 32 bits:

4, −2, 7, −9, 0, 15, −1, 3, 8, −6

El registro x1 contiene la dirección donde empieza el arreglo.

Diseñar un programa que recorra el arreglo y, al terminar, deje:

en w0 la suma de los elementos positivos (el 0 no cuenta como negativo),
en w1 la cantidad de elementos negativos.

Restricción: para identificar los negativos no se pueden usar comparaciones; debe revisarse directamente el bit de signo del número.

Pregunta adicional: si los primeros 4 bytes de otro arreglo, guardados desde la dirección más baja, son FE FF 00 80, ¿qué valor en hexadecimal 
tiene el entero de 32 bits que se carga con ldr?
*/

 .section .data 
 array: .word 4, -2, 7, -9, 0, 15, -1, 3, 8, -6

 .global _start 
 .text 

_start: 
   ldr x1, =array // contiene la direccion de donde empiza el arreglo 
   mov w0, #0  // var -> suma de elementos  positivos 
   mov w2, #0 //  var -> suma de elementos negativos 
   mov w4, #0 // cantidad elementos negativos
   mov x3, #0  // iterador -> i 

for_init: 
   cmp x3, #10
   b.ge for_fin   // i < 10 
   ldr w4, [x1, x3, lsl #2]  // x2 contiene el iterador del indice array[x2 -> 0 , 1 , 2, 3...]

   //Ahora la parte de conocer si es positivo o no  (no se puede utilizar comparaciones)
   //referencia si es 1 salta si es 0 no salta 
   tst w4, w4 
   b.mi es_negativo  //salta si el bit mas alto es 1 
   //suma de los negativos 
   add w0, w0, w4 
   add x3, x3, #1 
   b for_init
es_negativo: 
   //suma de numero negativos 
   add w2, w2, w4 
   add x3, x3, #1 
   add w4, w4, #1
   b for_init

for_fin: 
 
fin:
   b fin 



/*SOLUCION DE LA IA */


  .section .data 
  array: .word 4, -2, 7, -9, 0, 15, -1, 3, 8, -6 

  .global _start 
  .text 

_start: 
   ldr x1, =array 
   mov w0, #0 //sum + 
   mov w2, #0 // cant - 
   mov x3, #0  // i 

for_init: 
   cmp x3, #10 
   b.ge for_fin 

   ldr w4, [x1, x3, lsl #2] 

   tbnz w4, #31, es_negativo // si el bit 31 vale 1, es negativo 

   add w0, w0, w4 
   b siguiente 
es_negativo: 
   add w2, w2, #1 

siguiente: 
   add x3, x3, #1 
   b for_init 
for_fin: 
fin: 
   b fin 