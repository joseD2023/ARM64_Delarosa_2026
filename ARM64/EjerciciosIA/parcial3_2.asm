/* 
  EJERCICIO 2
  El registro w0 contiene una cantidad de segundos entre 0 y 86,399 (un día completo).
  Diseñar un programa que convierta esa cantidad a horas, minutos y segundos y deje:
  las horas en w1,
  los minutos en w2,
  los segundos en w3.
  Restricción: no se puede usar ninguna instrucción de residuo (no existe en ARM64), por 
  lo que el residuo deberá obtenerse con las instrucciones aritméticas del capítulo 4.

*/

  .global _start 
  .text 

_start: 
   ldr w0, =86399  //definimos la cantidad de segundos 

   /*Como utiliza el algoritmo entonces tendriamos la parte de: 
     86399 / 3600 = 23.999  (23 * 3600 s) = 82,800 s usados

     Como ya utilizamos los 3600 segundos de la hora 
     86399 - 82,800 = 3599 segundos (lo que nos queda)  
     3599 / 60 =  59   -> esta seria 1 * 59 minutos   entonces 59s * 60 -> 3540 


     
     Entonces gastamos 3540 segundos en los minutos  3,599 - 3,540 = 59 segundos 
     hora : 23 
     min  : 59 
     seg  : 59    */

     // inicial w0 
     // dividir con los segundos de una hora 3600 

   mov w7, #3600
    
   udiv w1, w0, w7  // 86399 / 3600 -> hora 
   msub w4, w0, w1,w7 // 86399 - (23*3600 ) = 82800  
   sub w0, w0, w4 // w0 = 86399 - 82800 = 3599 -> los segundos restantes
   udiv w2, w0, #60 // 59 min 
   msub w3, w0, w2, #60 // me va a dar la cantidad de segundos 

fin: 
  b fin 



    






