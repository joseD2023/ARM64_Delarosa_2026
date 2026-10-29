/*  
  MVN -> Invertir todos los bits  
  MVN: invierte cada bit del operando: los 0 se vuelven 1 y los 1 se vuelen 0  */

  mov w1, #10 
  mvn w0, w1 

  /* 
   w1 = 00000000 00000000 00000000 00001010
   w0 = 11111111 11111111 11111111 11110101  
   
   
   para que se utiliza? 
    - para invertir una mascara de bits 
    - para preparar mascaras que se usan con AND 
    - para operaciones de bajo nivel donde necesitaas complementar todos los bits*/

