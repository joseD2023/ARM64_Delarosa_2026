/*Ejercicios del Inge: 

Sunponga que el registro A tiene el dato hexa C8 y el registro B tiene el dato hexa 5D, proceda a sumar aritmeticamente el registro A y el registro B posteriormente a ello indique por meido de un 1 o un 0 el valor booleano de las banderas N,C,Z,V 

Nota: 
 En el caso del veredicto para “V” razone sus respuestas.  */


  .global main: 

.text 

main: 
    
   mov x0, C8 
   mov x1, 5D 
   add x2, x0,x1 


/* A: 11001000  = 200  // este es un numero negativo  por que en su bits mas signtificativo es 1 CUIDADO con ello
   B: 01011100 = 93 
   
   A + B:  200 + 93 
    =01  00100101  // resultado positivo
    =293  

    (carry "C") = 1 
    (Zero  "Z") = 0 
    (Negativa "N" ) = 0 // su bits mas significativo es 0 entonces no se activa la bandera  
    (Overflow "V" ) =  0
    
    */
   