/* TST: como funciona 

   1 0 1 1 
  &0 1 0 0 
  _________ 
   0 0 0 0  -> resultado 0 entonces Z = 1 
   
   1 0 1 1 
  &0 0 1 0 
   _________
   0 0 1 0 -> resultado de 0 entonces Z = 0 
   
   casos de uso: 
   tst x0, #1  
   b.eq es_par // bit 0 en 0 -> par  
   b.ne es_impar // bit 0 en 1 -> impar 
   
   Basicamente esto cuando necesitemos tomar decisiones para hacer algun tipo de salto 
   
   */

   //Es par o impar 
   tst x0, #1 
   b.eq es_par   // bit 0 en 0 -> par 
   b.ne es_impar // bit 0 en 1 -> impar 

   //esta encendido un bit especifico por ejemplo el bit 3 
   tst x0, #8 // 8 = 0b1000, solo el bit 3 
   b.ne bit3_activo  

   //es multiplo de 8 los 3 bits bajos deben ser 0 
   tst x0, #7 // 7 = 0b111 
   b.eq multiplo_de_8 

   // es cero tst x0, #0 hace x0 AND x0 queda da 0 solo si x0 es 0 
   tst x0, #0 
   b.eq es_cero 

   //es negativo con tst x0, x0 la bandera N queda en 1 si el bit mas alto esta en 1 
   tst x0, x0 
   b.mi es_negativo




/* Casos que debemos entender bien como funcion tst  para los tipos de algoritmos

   posicion (bit):     7     6     5     4     3      2     1     0 
   valor que vale     128    64    32    16    8      4      2    1 
   
   un 1 en esa posicion significa suma este valor  
   
   12 = 8 + 4 + 1  
   bit:   3  2  1  0 
   valor: 8  4  2  1 
   13:    1  1  0  1  
   
   bits 0 es el digito de mas a la derecha.   */

/* Entonces la idea es ver el bits 0 dentro de las posiciones de nuestro valor. 
   Entonces si miramos las posiciones 1,2,4,8,16 todos son pares menos el 1 entonces el numero es impar 
   solo si el bit 0 es 1 
   
   6 = 0110 -> bit 0 es 0 -> par 
   7 = 0111 -> bit 0 es 1 -> impar
   
   
   x0 = 7: 0 1 1 1 
   Mascara = 0 0 0 1 
   AND =    0 0 0 1  -> distinto de 0 -> entonces Z = 0 -> b.ne -> es impar

   x0 = 6: 0 1 1 0
   Mascara = 0 0 0 1 
   AND =    0 0 0 0  -> distinto de 0 -> entonces Z = 1 -> b.ne -> es par
   
    */

    