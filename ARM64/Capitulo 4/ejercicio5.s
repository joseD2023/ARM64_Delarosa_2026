/*  
   Desplazamientos (8 bits). Sea x1 = 11111000.
   ¿Qué número decimal con signo representa?
   Resultado en binario y decimal de asr x1, x1, #2.
   Resultado en binario y decimal de lsr x1, x1, #2, tratándolo como sin signo.
   ¿Por qué no dan lo mismo?
 
  */

  mov x1, #0xb11111000

  /*  
  1 1 1 1 1 0 0 0 
  0 0 0 0 0 1 1 1 
  0 0 0 0 0 0 0 1 
  ________________
  0 0 0 0 1 0 0 0    = -8  */

  asr x1, x1, #2  

  /* 
   RECORDAR este operador trabaja con los bits originales no con el complemento a 2 
   1 1 1 1 1 1 1 0  // ahi le aplicamos asr x1, x1, #2 

   // usemo complemento a 2 
   1 1 1 1 1 1 1 0 
   0 0 0 0 0 0 0 1 
   0 0 0 0 0 0 0 1 
   _______________
   0 0 0 0 0 0 1 0  = -2 entonces ya tenemos e resultado al usar asr 
   
   */

   /* ahora la parte que le vale los signos y solo coloca ceros */
   lsr x1, x1, #2  

   /* 
   1 1 1 1 1 0 0 0  
   
   corrimiento 
   0 0 1 1 1 1 1 0  = 62 en decimal  */


   //No sale lo mismo porque el asr considere el signo y el lsr solo quiere desplzar entonces no le importa  
   // pero el asr usa potencia de 2 para reducir 

