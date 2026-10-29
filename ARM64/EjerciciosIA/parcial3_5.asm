/*

Ejercicio 4.9
Suponga que x0 guarda los 64 bits menos significativos de 
un entero de 128 bits a, y x1 guarda los 64 bits más 
significativos. Igualmente, x2 guarda los 64 bits menos 
significativos de un entero de 128 bits b, y x3 los más 
significativos.

Muestre las secuencias de instrucciones más cortas para:

a. comparar a con b, actualizando las banderas de PSTATE,
b. desplazar a una posición a la izquierda y guardar el 
resultado en b,
c. sumar b a a,
d. restar b de a.


*/


   .section .data 
   a: .quad 2, 4 
   b: .quad 3, 4 

   .global _start 
   .text 

_start: 
   adr x9, a 
   adr x10, b 
   ldr x1, [x9] 
   ldr x0, [x9, #8] 
   ldr x3, [x10] 
   ldr x2, [x10, #8]

   //Comparacion 