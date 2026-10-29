/*  
   ORR -> OR 
   OR: compara los bits de ambos operandos. el resultado es 1 cuando al menos  uno de los dos bits es 1 
   y 0 cuando ambos son 0 
    tabla de verdad 
    | bit A  | bit B  | resultado 
    |  0     |  0     |  0 
    |  0     |  1     |  1 
    |  1     |  1     |  1 
    |  1     |  1     |  1 


   
    */

    mov w1, #12 // 1100 
    mov w2, #10 // 1010 
    orr w0, w1, w2 

    /* 

      1 1 0 0 
      1 0 1 0 
      _________ 
      1 1 1 0 = 14 en decimal 

      Para que sirve? cuando queremos activar bits especificos sin desactivar los que y aestan activos. 
      por ejemplo, imagina que un registro tiene configuradas ciertas opciones y queres activar una 
      opcion adicional. podemos utilizar ORR con una mascara que tenga 1 en el bite que queremos activar
     */

     