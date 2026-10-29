

.text 

  mov x0, #0x1000 
  br x0 

  /* Entonces el program Counter contiene la parte ahora de pc = 0x1000 
   Entonces en pocas palabras cambiamos el timon del manejo de instrucciones en el CPU  */



   /* Podemos trabajarlo como un switch a la directiva br vamos como.  */


.section .data 
 tabla: .quad caso0  // 0x5000 
        .quad caso1  // 0x5008 
        .quad caso2  // 0x5010 


.global _start 

.text 
  mov x0, #2  

  adr x1, tabla 
  ldr x10, [x1, x0, lsl #3] // vamos a encontrar el indice tabla[2] 
  br x10  // entonces el cotenido es 0x6040 pero se encuentra en la direccion 0x5010  


  caso0: 
   mov x2, #100 
   b fin 

  caso1: 
   mov x2, #200 
   b fin 
  
  caso2: 
   mov x2, #300 
   b fin  

  fin: 
   b fin 




