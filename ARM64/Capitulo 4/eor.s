/* 
    EOR -> XOR 
    EOR: realiza una operacion XOR: el resulta es 1 cuando los dos bits son diferentes de 0 
    y 0 cuando son iguales  

    tabla de verdad 
    | bit A  | bit B  | resultado 
    |  0     |  0     |  0 
    |  0     |  1     |  1 
    |  1     |  1     |  1 
    |  1     |  1     |  0 

    Ej: 
 */

 mov w1, #12   // 1100 
 mov w2, #10   // 1010 
 eor w0, w1, w2 


 /* 
   1 1 0 0 
   1 0 1 0 
   _________ 
   0 1 1 0  = 6 en decimal 
   
   para que sirve? para dectectar diferencias entre dos conjuntos de bits 
   - para almacenar bits de un registro mediante una mascara 
   - en algoritmos de codificacion y procesamiento de datos  */