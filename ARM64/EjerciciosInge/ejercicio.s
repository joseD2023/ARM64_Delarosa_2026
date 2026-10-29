.data 

num: .quad 0x8000000000000000

.text  

/*Las instrucciones solo admiten los 4 bits por eso usamos indexaciones  Ldr y Adr  */
mov X0, xzr  // cargar un x0 cargarlo con un 0 
Adr x2, num  // 
Ldr x2, [x2] // cargar los 8 bytes  x2 = 0x8000000000000000
Ands x3, x3, x2  // x3 -> yo tengo un numero desconocido  x3 = XXXXXXX...........X y los de x2 = 1000000000000000000000..0000 que seria el 8 pero en 64 bits 
b.eq  loop;   // salte si la bandera esta activa  si todas las cadenas son 0 entonces seria salte a loop: 
Mov x0, #1  // si beq en la bandera no se activa entonces x0 es igual a 1 
Loop: 




/*

  x3 = XXXXXXX...........X
  x2 = 1000000...........0 
  
  complemento a dos se define con el bit mas significativo si es 1 es negativo osea posiblemente puede ser negativo 
  si es es todo la cadena 0 entonces se activa el loop  y salta a la otra etiqueta*/



/*Solucion alterna 

MOV X1, #0
MOVZ x2, #1, LSL#63

ANDS X2, X3, X2 
B.EQ Asignar_cero:

Asignar_cero:
MOV X1, #1

 */

