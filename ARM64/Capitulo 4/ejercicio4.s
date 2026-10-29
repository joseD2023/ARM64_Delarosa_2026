/* 

  tst y máscaras. Sea x0 = 0x68.
  Pásalo a binario y marca qué bits están en 1.
  Para cada pregunta, escribe la instrucción tst con su máscara, di cuánto da el AND, el valor de Z 
  y qué salto se toma (b.eq o b.ne):
  ¿Es par?
  ¿Es múltiplo de 8?
  ¿Es múltiplo de 16?
  ¿Está encendido el bit 5?

 */

   mov x0, #0x68  

 /*  
   7 6 5 4 3 2 1 0
   0 1 1 0 1 0 0 0  
    */


    /* 1. Es par o impar: entonces debemos ver la parte de 
    el bit 0 para confirmar  
    
    0 1 1 0 1 0 0 0 
    0 0 0 0 0 0 0 1  
    ________________ 
    0 0 0 0 0 0 0 0 = -> Z = 1  */

    tst x0, #1  
    b.eq par 
    b.ne impar 


    /* 2. Es Multiplo de 8, donde n = 3  
    0 1 1 0 0 0 0 0 
    0 0 0 0 0 1 1 1    */

    tst x0, #7 
    b.eq es_multiplo_8 


    /* 3. Es multiplo de 16 donde n = 4 
    0 1 1 0 0 0 0 0
    0 0 0 0 1 1 1 1 
     */

    tst x0, #15 
    b.eq es_multiplo_16 


    /* 4. Esta encendido el bit 5  ojo aqui 
    cuando habla del bit 5 habla de la posicion relativa 
    en base 2  
    
    0 1 1 0 0 0 0 0 
    0 0 1 0 0 0 0 0 */

    tst x0, #32  
    b.ne bit5_activo // si es diferente de 5 esta activo 

    

