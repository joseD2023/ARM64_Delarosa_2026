/* Enunciado del programa:
Diseñar un programa en lenguaje ensamblador ARM64 que sea capaz de manejar adecuadamente el llenado y el vaciado 
del depósito de agua mostrado. Asuma que la información de entrada de sensores del exterior se encuentra en el 
registro X0 en sus dos bits menos significativos y que es actualizada por medios fuera del presente contexto. 
Así la información de salida de activación o no de la bomba se encuentra en el registro X1 y al escribirla en el por medios 
no contemplados ella se actualizara en los puertos externos, así: 

X0 :          ------------------------- SS   SI
                                          D1   D0

X1:           ------------------------- B
                                          D0
                                          
Agua detectada: 1

Agua no detectada: 0

Bomba activada: 1

Bomba no activada: 0*/

//asumir la entrada en los sensores se encuentra en el registro x0 en sus dos bits menos significativos
//activacion de la bomba  en el registro x1  
/*Entonces la parte de los bits menos significativos del registro x0 van hacer los sensores  y x1 simplemente va a contener 
la parte de encendido o apagado nada mas cuidado ahi.  

  |      |   .....   |  D1   |   D0   |  -> 
                        SS       SI      ->  SS (superior)  |  SI (inferior) 
                        0000 0000 0000  0000  00 | 0 | 0 |  
                        */

 
   .global _start 
   .text 

_start: 
   mov x1, #0   // bomba apagada |  Manejo de la bomba 
   mov x2, #0  // agua no detectada  

   cmp w2, #0 // preguntaos hay agua dectectada o no 
   b.eq verificar 

   
