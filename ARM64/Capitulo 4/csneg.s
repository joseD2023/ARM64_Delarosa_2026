/* 
   CSNEG: seleccion condicional con negacion aritmetica  
   
   csneg wd, wn, wm, condicion 
   
   - si la condicion es verdadera selecciona wn 
   - si la condicion es falsa entonces -wn  */

   mov w1, #10
   mov w2, #5
   cmp w1, w2
   csneg w0, w1, w2, eq

   /* Entonces aqui es la misma condicion que hemos venido haciendo solo con la diferencia que 
    como EQ es falsa entonces w2 = 5 ahora seria w2 = -5 en el complemento a 2 de los 32 bits  el patron de bits 
    corresponde a 0xFFFFFFFB que se interpreta como -5 con signo */


    