/* 
  EON -> Negacion XOR 
    */

  mov w1, #12 // 1100 
  mov w2, #10 // 1010 
  eon w0, w1, w2 

  /* 
    1 0 1 0 
    -> Negar(1010) -> 01010 
    
    ahora aplicamos el xor 

     1 1 0 0 
     0 1 0 1 
     _________ 
     1 0 0 1 = 9 en decimal 


     cuando se utiliza? se utiliza cuando una operacion necesita combinar xor con el compelmento de una 
     mascara, es menos habitual que EOR, peropuede simpliciare determinadas operaciones de manipulacion de bits
     */

     