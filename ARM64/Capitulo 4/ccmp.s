/* CCMP: comparacion condicional, la idea es que realiza una comparacion solamente si se cumple una condicion previa, si es 
condicion previa no se cumple establece las banderas con un valor que nosotros especificamos. 

 ccmp wn, wm #inmediato, condicion  // sintaxis 

 wn , wm : registros que se comparan. 
 #inmediato : valor de 4 bits que se utiliza para establecer las banderas sin la condicion previa es falsa 
 condicion: condicion que determina si se realiza la comparacion o no. 
 */

 cmp  w1, w2
 ccmp w3, w4, #0, eq


 /* Como funciona: 
    CMP compara w1 y w2 y actualiza las banderas 
    CCMP revisa si eq cumple 
    si se cumple compara w3 y w4 
    si no se cumple establece las banderas segun #0 sin realizar la segunda operacion 
    
    Para que sirve? para combinar condiciones y tomar decisiones sin tener que realizar necesariamente un salto 
    entre cada comparacion.  osea es tipo verificar antes la condicion para y ano hacer salto de que fallo 
    y todo ello.  */


    

 
