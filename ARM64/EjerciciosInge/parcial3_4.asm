/* 

  EJERCICIO:
  Diseñar un programa en ARM64 por medio del cual se emule un decodificador de línea en lógica positiva de 4 x 16.
  Asuma que las salidas del decodificador de línea se deberán manifestar (escribir por Usted) en los 16 bits menos 
  significativos del registro X5, mientras las 4 entradas del decodificador en cuestión deberán ser leídas recurrentemente 
  en el registro X4, ellas se validan automáticamente allí y su ubicación es así: la menos significativa “A” en el bit D0, luego “B” 
  en el bit D1, luego “C” en el bit D2 y finalmente “D” en el bit D3.

  Funcionamiento del Decodificador: Es un circuito que toma un codigo binario y lo convierte en la activacion de 
  un sola linea de salida, la regla de oro para cada combinacion de entrada solo una salida se enciende (los demas se apagan)

  1. asumir que las salidas del decoficador son los 16 bits menos singificativos del registro x5 
  2. las entradas del decodificador en cuestion deberan ser leidas recurrentemente en el registro x4, se validan ubicacion: 
  | D3  | D2  | D1  | D0 | LSB -> D0  MSB -> D3 
  | D   | C   | B   | A  | 

*/

   .global _start 
   .text 

_start: 
   mov x4, #3   // entrada caso tipo 0011 
   mov x0, #1  // salida incializadas   0000 0000 .... 0000 0000 0000 0000 
   lsl x5, x0, x4 // desplaza el bit para prenderlo en cierto sentido 

fin: 
   b fin 