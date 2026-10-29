/*  ORN -> Negacion(OR) 
    ORN: invierte los bits dle segundo operando y despues aplicar OR  */

    mov w1, #12 // 1100 
    mov w2, #10 // 1010 
    orn w0, w1, w2  
    
    /*  
      1 1 0 0 
      
      Macara(1010) -> negamos -> 0101 
      
      1 1 0 0 
      0 1 0 1 
      ________ 
      1 1 0 1   = 13 en decimal  
      
      
      Cuando se utiliza: cuando necesitamos combinar un OR con una mascara invertida. al igual que EON no suele 
      ser la primera instruccion que aprender pero puede ahorrar instrucciones cuando trabajas direcamente con bits*/


