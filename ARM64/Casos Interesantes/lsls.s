/*  

  Truco del desplazamiento (shift) con LSLS 
  donde si trabamos con 1 byte entonces aqui hay una forma para no utilziar UTBX 
  que no permite modificar los flags entonces para eso hacemos este tipo 
  de operacion, como un registro w tiene 32 bits y nosotros solo queremos evaluar 8 bits 
  entnces debemos desplzarnos 24 bits a la izquierda (32 - 8 = 24 ) obligamos a que cualquiere desborde 
  del byte pase a la posicion del carry de 32  */

  .section .data 
  etique1 : .byte 20 
  etique2 : .byte 10 


  .section .text
  .global main 

main: 
  ldr x1, =etique1 
  ldr x2, =etique2 
  ldrb w3, [x1] //cargamos solo un byte 
  ldrb w4, [x2] // cargamos solo un byte 

  add w5, w3, w4 

  cmp w5, #255 // si se paso hay un acarreo 



