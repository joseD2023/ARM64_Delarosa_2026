
  .global _start 
  .text 

_start: 
    mov x1, #0xB0
    mov x2, #90 
    adds x0, x1, x2  // para que active las banderas s  o sin s a la larga o importa ahorita o en este caso 

    /* 
       1 0 1 1 0 0 0 0 
       1 0 0 1 0 0 0 0
       _________________ 
     1 0 1 0 0 0 0 0 0  

     Banderas: 
     N: 0 (no es negativo)
     Z: 0 (no es todo cero)
     V: 0 (no hice el calculo porque son 8 bits tendria que hacer 2^8 entonces solo por ver el numero se que son 
     256 osea quizas no se salio )
     C: 1 (si hay carry )
     
     */


  