/*EJERCICIO: Control de bomba de una tuberia*/

  //RETO OPTIMIZAR EL CODIGO


  .section .data 
  lecturas: .word 40, -5, 62, 33, 90, -12, 18, 75, 104, 130, 50, 20

  .equ longitud, (. - lecturas) / 4  

  .global _start 
  .text 

_start: 
   ldr x1, =lecturas // direccion del primer elemento de lecturas 
   mov x9, #0 // interador (i)
   // Registros Auxiliares 
   mov w0, #0 //suma de lecturas validas 
   mov w2, #0  //cantidad de lecturas 
   mov w3, #0  // cantidad de fallas (negativas)
   mov w4, #0  // cantidad de errores de transmision (impares)
   mov x5, #0 // posicion (0 a 11) lectura sobrepresion 
   mov w6, #0 // estado de la bomba 
   mov w7, #0 // promediode la lecturas valdias de las bombas 
   mov w8, #0 // residuo de la division 

for_init: 
   cmp x9, #12 
   b.ge for_final  // i >= 12 salta 
   ldr w10, [x1, x9, lsl #2] // w10 <- lecturas[x9]

   tbnz w10, #31, es_negativo_lectura  // lectura negativa si bit alto es 1 
   // si no es negativo pero es impar fallo transmision 
   tbnz w10, #0, es_impar 
   b umbral

es_negativo_lectura: 
   //negativo contar como fallo 
   add w3, w3, #1  
   add x9, x9, #1 
   b for_init

es_impar: 
   //error transmision 
   add w4, w4, #1 
   add x9, x9, #1 
   b for_init

umbral: 
   //si pasa las condiciones anteriores veamos su umbral 
   cmp w10, #120  
   b.gt sobrepresion  // w10 > 120 
   add w0, w0, w10 
   add w2, w2, #1 
   add x9, x9, #1 
   b for_init

sobrepresion: 
   //se apaga la bomba y termina el programa de inmediato 
   mov w6, #1 //apagamos bomba 
   mov x5, x9 //posicion donde se apago la bomba 
   b promedio // apagamos de inmediato 

for_final: 
promedio:
   cbz w2, fin // si el registro es 0 salta a la etiqueta 
   mov w11, #longitud
   udiv w7, w0, w2  //w13 tengo el promedio solo de cantidades validas
   msub w8, w7, w2, w0 
 
fin: 
   b fin 



   







