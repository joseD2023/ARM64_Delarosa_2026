/*Supongamos que .data comienza en la dirección 0x1000.

.data

a: .byte 10

.align ?

b: .word 20 */

.data 

a: .byte 10 // reservamos 10 bytes 
 .align 2  
b: .word 20 // reservamos 4 bytes 

