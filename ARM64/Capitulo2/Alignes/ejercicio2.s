/*
Dirección inicial: 0x2000
.data

a: .byte 1
b: .byte 2

.align ?

c: .word 100 */

.data 

a: .byte 1  // 1 bytes  -> 0x2000
b: .byte 2  // 1 byte   -> 0x2001 
  //contador sube a 0x2002 -> siguiente byte 
 .align 2  // 2 ^ 2 = 4  entonces seria tipo 2 ^ n  donde n = 2  rellenaria 0x2004 - 0x2002 = 2 relleno

c: .word 100 // 4 Bytes -> 0x2004 


/* 
[     ][     ][     ][     ]
[1byte][1byte][1byte][1byte]
[ 0   ][ 0   ][1byte][1byte]  

*/