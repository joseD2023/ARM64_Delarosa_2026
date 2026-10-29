/*Regiones dentro de la Memoria 
-> Stack 
-> Heap 
-> .bss : variables globales no inicializadas 
-> .rodata : Dato solo lectura
-> .data : variable globales inicializadas 
-> .text : contiene instrucciones del programa */


.section .rodata 

mesg : .asciz "Hello World\n" // .asciz dice donde empieza a guardar los caracteres  

/*Los guardamso en Bytes Entonces 
mesg -> H = 48 Inicio de la reserva de memoria  
E = 65 
L = 6C 
L = 6C 
O = 6F 
byte Nulo  = 00  */

.text 
.global main  

main : stp x29, x30, [stp, #-16]

adr x0, mesg 
bl printf 
mov w0, #0 
ldp x29, x30, [sp], #16 
.size main,(.-main)