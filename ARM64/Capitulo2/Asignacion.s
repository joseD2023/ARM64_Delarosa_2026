/*Asignacion de Espacio para variables y costantes  
Existen directivas que nos permite reservar e inicializar espacio de almacenamiento ESTATICOS para variables 
y constantes. Donde ensamblador admite bytes, tipos enteros, punto flotantes y cadenas

Ejemplo: 
//Todas estan inicializadas 
static int i = 0;  -> variable inicializada 
static int j = 1;  -> variable inicializada 
static char fmt[] = "Hello\n"; -> Lectura 
static char ch[] = {'A', 'B', 0} -> cada son un byte 
static int ary[] = { 0, 1, 2, 3, 4} */


.data 

i: .word 0 // 4Bytes tambien lo podemos colcoar como .word 0000 
j: .word 1 
fmt: .asciz "Hello\n" 
ch:  .byte 'A', 'B', 0
ary: .word 0, 1, 2, 3, 4 // -> es .word porque cada elemento ocupa 4 bytes 


/* Entonces contenemos la parte de 
.byte expresiones 
.byte 
Espera cero o mas expresiones separadas por coma cada expresion produce un byte de dato  


.2byte expresiones 
.hword expresiones 
.short expresiones  
Espera cero o mas expresiones separadas por comas y genera un numbero de 16 bits 


.4byte expresiones 
.word expresiones 
.long expresiones 
Espera cero o mas expresiones separadas por comas por cada y genera 4 bytes por cada expresion dada (si no se da una expresion no avanza en el contador)


.8byte expresion 
.quad expresion 
Espera cero o mas expresiones separadas por comas y generan 8 bytes por cada expresion dada  


.ascii espera cero o mas cadena de texto cada uno entre comillas y separadas por comas. (ensambla cada cadena sin el caracter ascii Nulo al final)
.asciz "cadena"
.string "cadena" 
Ambas directivas son similares pero cada uno va seguida de un caracter ASCII NULO cero al final 


.double numeros  
la directiva .double espera cero o mas numeros de punto flotante separados por comas se almacen con numeros de 8 bytesde doble precision */

