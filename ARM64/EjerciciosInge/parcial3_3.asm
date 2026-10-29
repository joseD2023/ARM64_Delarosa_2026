/*
 Aquí tienes el texto de la nueva imagen:

**EJERCICIO:**
Utilizando instrucciones de suma, resta, corrimiento y 
rotación si fuera necesario, ejecute la multiplicación 
aritmética de valor numérico almacenado con antelación en el 
registro X0, así:

X0 * 5

Dejo a criterio el lugar que prefieran para depositar 
el resultado

*/


   mov x0, #1 
   add x2, x0, x0, lsl #2  

   /* x2 =  
      x0 = 10  
      lsr x0 = 0000 0001       num  <-1
      lsr x0 = 0000 0010  1ro  num  <-2
      lsr x0 = 0000 0100  2do  num  <-4   
      
      entonces un registro x0 = 1 y otro registro x0 = 4 y cuando lo sumemos nos va a dar 5 osea es como si tuvieramso 
      x0 * 5 */
