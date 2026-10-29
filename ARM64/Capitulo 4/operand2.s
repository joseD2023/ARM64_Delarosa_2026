

add x0, x1, x2, lsl #3 



/* lsr vs asr (con negativos) 
   
   tomemos  0b11110000 que como numero con signo es -16 

   Entonces: siusamos lsr #2 (mete ceros por la izquierda ): 
   11110000 -> 00111100 = 60  
   ya no es -16 ya que qeudo un numero positivo proque el bit de signo se volvio cero 

*/


/*  LSR: no sabe de negativos, solo mueve los bits y mete ceros. por eso un numero que era negativo terminan viendose 
    positivo. 
    
    ASR: en cambio se copia el bit de signo asi que si el numero era negativo se sigue viendo negativo 
    solo que mas pequeño como una division entre potencia de dos.  */



/*  Truco para resolver o entender como funciona LSL y LSR 
   LSL: vamos a desplazar por la izquierda eso quiere decir que vamos a colocar ceros que entran por la derecha 
   entonces los bits menos significativos se pierden. 

   LSR: vamos a desplazar por la derecha eso quiere decir que vamos a colocar ceros que entren por la izquierda 
   entonces los bits mas significativos se pierden. 

   Lo que debemos recorda a donde vamos a desplazarnos y la parte contraria ahi vamos a colocar los ceros y ver como 
   estamos colocando nuestro LSB (Bits menos significativo) Y MSB (bits mas significativos)

 */

 


