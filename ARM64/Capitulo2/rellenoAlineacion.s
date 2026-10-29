/*Filling and Aligning 

La idea prinical de Aligning es que quede alineado en los bancos de memoria que utilice el CPU 
una analogia de lo que podriamos decir es que podriamos tener digamos un .byte y despues de eso un .word 
entonces la idea es que si nosotros venimos de un byte menor a uno de mayor escala entonces existe inestabilidad dentro 
de los bancos de memoria supongamos esto:  */

.data 

ch: .byte 'A' // cada uno es un byte  
ary: .word 0 // cada elemento es de 4 bytes eso quiere decir que son 32 bits


/*Entonces pasamos de 1 byte a uno de 4 byte graficamente se veria algo asi

A = 41  -> byte  

[ ][ ][ ][ ]
[ ][ ][ ][ ]
[ ][ ][ ][41]  <- empezamos aqui ahora seguiria la otra parte recordemos que son cada elemento de 4 byte entonces seria tipo 00000000

0 = 4 bytes de ceros 

[ ][ ][ ][ ]
[ ][ ][ ][00 ]
[00 ][00 ][00 ][41] 

Entonces como vemos no queda alineado la memoria en si porque tenemos la parte de que inicia pero no termina esa linea de memoria en la 
segunda columna  Entonces para ello usamos aligne para rellenar digamos antes de colocar el .word*/ 


ch: .byte 'A' 
 .align 2 
ary: .word 0 


/*
Regla General 

.align N  -> siguiente dato comienza en un multiplo de 2N
.align 1  -> 2 bytes
.align 2  -> 4 bytes
.align 3  -> 8 bytes */


