/* Utilizacion de MSUB: multiplicar y restar  */

 mov w1, #20
 mov w2, #3
 mov w3, #4

 msub w0, w1, w2, w3 

 /* 
   Formula:  w0 = w3 - (w1 - w2)
   Donde se utiliza ? 
   - calcular diferencias entre un valor y un producto 
   - implementar formulas matematicas como a - b * c 
   - calcular el residuo de una division 


   Como utilizar MSUB para calcular el modulo? 

    a mod b  =  a - ( a / b * b )

    Ej: 17 mod 5 = 2 porque  17 = 3 x 5 + 2 

  */

  mov w1, #17 
  mov w2, #5 

  udiv w3, w1, w2  // 17 / 5 -> 3 
  msub w0, w3, w2, w1 


  /* Entonces seria algo asi: 
    UDIV calcula 17 / 5 = 3 sin conservar la parte decimal 
    MSUB calcula 17 - (3 x 5) = 2  
    el resultado se guarda en w0
    
    Cosas a considerar: con valores positivos no hay problema pero con valores negativos hay que tener cuidado o 
    considerar las reglas de division  */


    





