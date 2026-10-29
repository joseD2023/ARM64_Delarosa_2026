/* 
  Aquí tienes el texto de la imagen:

   EJERCICIO:
   Suponga que el registro X3 le ha sido asignado un numero digital de 64 bits, utilizando filtrado digital y conceptos de complemento a dos, 
   determine si el numero es positivo o negativo, si es negativo asigne al registro x0 el valor 1, de lo contrario asigne 0

*/

    .section .data 
    valor: .quad  4 // valor 4 ocupa 64 bits 
    .global _start
    .text  
_start: 
   adr x1, valor 
   ldr x3, [x1]  // cargamos el valor en el registro x3 
   /*Cuando determinamos si un numero es positivo o negativo debemos ver su bit alto si es 1 es negativo si es 0 es positivo */
   //negativo 1 | positivo 0 
   ands x2, x3, x3 
   b.ne no_es_negativo // si 0 son iguales si es 1 no son iguales
   mov x0, #1 
   b fin 
no_es_negativo: 
   mov x0, #0 
fin: 
   b fin 
