/*

 Ejercicio A: Alarma de una bodega
Diseñar un programa en ARM64 que controle la alarma de una 
bodega. Los sensores se leen recurrentemente en el registro X0, 
que se actualiza por medios externos, y las salidas se escriben 
en X1:

Registro	D3	D2	D1	D0
X0 (entradas)	ARM	MOV	VEN	PUE
X1 (salidas)			LUZ	SIR
Entradas: ARM = 1 sistema armado; MOV = 1 movimiento detectado; 
VEN = 1 ventana abierta; PUE = 1 puerta abierta.
Sirena (SIR): vale 1 si el sistema está armado y 
al menos uno de PUE, VEN o MOV vale 1.
Luz "listo para armar" (LUZ): vale 1 si el sistema está 
desarmado y la puerta y la ventana están cerradas. 
El movimiento no afecta a esta luz.
Los demás bits de X0 pertenecen a otros dispositivos y no deben 
afectar el resultado. Los demás bits de X1 deben quedar en 0.
Restricciones: use filtrado con máscaras (AND, ORR) y no use 
cmp.

*/

// sensores se leen recurrentemente en el registro x0 
// salidas x1 ->  LUZ y SIR. 
/*  
             bit 3    bit 2    bit1     bit 0 
  x0 :    |  D3   |   D2   |   D1   |   D0   | 
             ARM  |  MOV   |   VEN  |   PUE  | */


   .global _start 
   .text 

_start: 

/*Tenemos dos estados en donde la sireana esta apagada y encendida 
lo mismo pasa con la luz cuando esta apgado o encendida */

   mov x1, #0 // entradas actualmente 
   and x2, x0, #15 //aplicamos a la mascara la filtracion 

   ands x5, x2, #0x7  // revisamos si mov o ven o pue esten activos 
   b.eq check_luz     // si no estan activos vamos a ver la luz 
   ands x5, x2, #0x8  // verificamos si esta armado el sistema 
   b.eq check_luz     // si no esta armado vamos a ver la luz 
   orr x1, x1, #0x1 

check_luz: 
   ands x5, x2, #0x3 // filtramos para la parte de 3 
   b.ne fin 
   ands x5, x2, #0x8 //sistema esta armado 
   b.ne fin 
   orr x1, x1, #0x2 

fin: 
  b fin 













