/*

  Suponga que posee dos números A & B de 128 bits cada uno, alojados en memoria a través de dos vectores de 2 elementos 
  cada uno tamaño quad, el primer elemento de cada vector o numero representa los 64 bits menos significativos y el segundo elemento 
  de cada vector los 64 bits más significativos. Genere:

  1) La representación en memoria de la ubicación de ambos vectores
  2) El diseño del programa para sumar aritméticamente estos dos números
  3) A criterio decida e lugar donde usted alojara el resultado de esta suma, recuerde que puede existir rebalse

*/

  // 2 numeros (A y B) que van a tener dos elementos en sus listas simulando la parte LSB y MSB 
  .section .bss 
  C: .skip 128 

  .section .data 
  A: .quad 0x1122334455667788, 0x99AABBCCDDEEFF00 // 1 elementos -> LSB  ,  2 elemento -> MSB 
  B: .quad 0xFEDCBA9876543210, 0x0123456789ABCDEF 


  .global _start 
  .text 

_start: 
   adr x14, A 
   adr x15, B 
   ldr x4, [x14] // cargamos el valor A menos signfiicatio 
   ldr x5, [x14, #8] // cargamos el valor de A mas significativo 
   ldr x3, [x15]
   ldr x6, [x15, #8]  

   //entonces debemos sumar LSB con LSB y MSB con MSB 
   adds x1, x4, x3 
   adc x9, x5, x6 

   //guardar resultado de la suma 
   adr x11, C 
   str x1, [x11]  // colcamos en esa direccion de memoria el valor 
   str x9, [x11, #8] // colcamos el siguiente elemento 

fin: 
   b fin 




