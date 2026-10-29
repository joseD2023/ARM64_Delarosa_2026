/* 

  CSINV: seleccion condicional con inversion de bits 
  csinv wd, wn, wm, condicion 

  - si la condicion es verdadera selecciona wn 
  - si es falso selecciona el comportamiento bit a bit de wm 
   */

   mov w1, #10
   mov w2, #5
   cmp w1, w2
   csinv w0, w1, w2, eq

   /*como EQ es falsa toma w2 y invierte sus bits donde en 
   un registro de 32 bits el resultado es tipo 
    w0 = ~5 =  4294967290 
    aqui no es lo mismo que cambiar el signo de 5 aqui invierte los bits*/


    