/* Implementacion CMN: comparar mediante una suma 
funciona como una suma que actualiza las banderas sin guardar el resultado 

  La idea es la misma con la de CMP que si Z = 1 cuando el resultado de la operacion es 0  
  
  Lo que cambia es basciamente la manera d ela operacion */

    mov w1, #5 
    mov w2, #3 
    cmn w1, w2 

    /* La operacion conceptual es : 
       5 + 3 = 8 
       las banderas se actualizan segun el resultado, no se modifca w1 ni se guarda el 8 en algun registro 
       de destino.   */

    mov x0, #5 
    mov x1, #-5 
    cmn x0, x1 // 5 + (-5) = 0 -> Z = 1 
    b.eq son_opuestos 


    mov x0, #7 
    cmn x0, #3  // 7 + 3 = 10 -> Z = 0  no son opuestos  


    /* Entonces para que sirve? 
      para comparar contrar un negativo sin que te estober el inmediato 
      los inmediatos de cmp no pueden ser negativos.  */


