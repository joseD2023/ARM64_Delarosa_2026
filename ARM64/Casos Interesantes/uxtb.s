/* Usar el truco del limitador (UXTB) en la suma 
  ARM tiene una caracteristica genial: nso permite decirle a la instruccion ADDS 
  que trunque el segundo registro a un byte antes d eoeprar 
  Sintaxis:  */

  .section .data 
  etique1 : .byte 20 
  etique2 : .byte 10 

  .global main 

main: 
  ldr x1, =etique1 
  ldr x2, =etique2 
  ldrb w3, [x1] //cargamos solo un byte 
  ldrb w4, [x2] // cargamos solo un byte 

  /*Parte interesante si nosotros queremos sumar w3 y w4 tenemos un problema como nuestros 
  datos son de un byte entonces no vamos a saber si hay acarreo porque como estamos sumando la parte de 
  32 bits + 32 bits entonces no vamos a saber si hubo acarreo porque 1 byte es menor a 32 bits que son 4 bytes 
  entonces para resolver este problema podemo implementar UXTB que le dice al procesador haz la suma 
  forzando el comportamiento de un Unsigned Extension Truncated to Byte (8 bits) */

  add w5, w3, w4, UXTB // en pocas palabras obligamos al procesador hacer una suma de un byte


  /*Pero viene la pregunta o la referencia importante que aqui no nos permite utilizar los flags para 
  verificar si hubo un acarreo o no UXTB y adds no puede utilizarse al MISMO TIEMPO, entonces 
  el procesador solo deja usar UXTB con el nemonico ADD */