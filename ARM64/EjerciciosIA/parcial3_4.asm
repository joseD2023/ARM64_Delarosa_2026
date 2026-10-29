/*

Ejercicio 4.8
Sin usar ninguna instrucción mul, dé las instrucciones 
para multiplicar x3 por las siguientes constantes, dejando 
el resultado en x0. Puede usar también x1 y x2 para resultados 
temporales, y no necesita conservar el contenido original de x3.

a. 10
b. 100
c. 575
d. 123

*/

   .global _start 
   .text 

_start: 

   mov x3, #10 
   add x0, x3, x3, lsl #1