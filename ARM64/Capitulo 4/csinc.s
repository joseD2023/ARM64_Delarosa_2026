/* CSINC : selecion condicional con incremento 

   Formula: 
     csinc wd, wn, wm, condicion  

    La logica es esta: 
    - si la condicion es verdadera , selecciona wn 
    - si la condicion es falsa, seleccion wm + 1 

*/

  mov w1, #10 
  mov w2, #20 
  cmp w1, w2 // hace la resta 
  csinc w0, w1, w2, eq //como 10 no es igual a 10, EQ es falso por lo tanto, w0 = w2 + 1 = 21 

  //pero si fueran iguales entonces tomaria el valor de 10 sin incrementar

  


