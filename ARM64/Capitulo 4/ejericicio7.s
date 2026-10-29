/* 
  Tienes este arreglo de 6 elementos de 8 bytes (.quad):
  .data
   arr:  .quad 12, 7, 40, 33, 8, 25

   Escribe un programa en ARM64 que recorra el arreglo con un for (i de 0 a 5) y calcule:
   x4 = cuántos elementos son pares
   x5 = la suma de los elementos que son múltiplos de 8
   x6 = x5 módulo 5

   Requisitos:
   Cargar la dirección base con adr y recorrer con ldr x3, [x1, x0, lsl #?]. Tú decides cuánto va en el shift y debes justificarlo.
   Controlar el bucle con cmp y un salto condicional. Explica por qué usas la condición contraria para salir.
   Para par y múltiplo de 8 usa tst con la máscara correcta (indica cuál y por qué).
   El módulo debe salir con udiv + msub, porque ARM64 no tiene instrucción de módulo.
   Escribe el prólogo y epílogo de main con stp/ldp (guardando x29 y x30) y di para qué sirve cada parte.

 */

 .section .data 
 arr: .quad 12, 7, 40, 33, 8, 25 

 .global _start  
 .text 

_start: 
   ldr x0, =arr 
   mov x1, #0 // variable i 
   mov x4, #0 //contador elementos pares 
   mov x5, #0 // suma de los elementos que son multiplos de 8 
   mov x6, #0 // el modulo de la suma total de x5 

inicio_for: 
   cmp x1, #5  // i < 5 
   b.lt fin_for: 
   ldr x7, [x0, x1, lsl #3] // cargo x7 <- arr[1] <-7 

   //tst podriamos utilizar par alos 8 bits y ver el bit 0 si es par o impar 
   tst x7, #1 
   b.eq es_par 
   b.ne es_impar 
es_par: 
   add x4, x4, #1 
   /*Multiplos de 8 la suma total como son mult = 8 entonces son de n = 3  entonces #7  */
    tst x7, #7 
    b.eq multiplo_indice 
    b inicio_for
es_impar: 
multiplo_indice: 
    //suma de los elementos que son multiplos de 8 
    add x5, x5, x7 
    b inicio_for
fin_for: 
  mov x14, #5
  udiv x12, x5, x14 
  msub x6, x12, x5, x14  

fin: 
   b fin 
