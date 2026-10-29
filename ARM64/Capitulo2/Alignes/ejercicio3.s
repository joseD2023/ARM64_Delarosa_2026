/*Inicio = 0x3000 

.data

a: .byte 10
b: .byte 20
c: .byte 30

.align ?

d: .quad 1000 */

.data  

a: .byte 10  // 1 byte 0x3000
b: .byte 20  // 1 byte 0x3001
c: .byte 30  // 1 byte 0x3002 
//contador siguiente posicion 0x3003 
 .align 3      // 2 ^3 = 8  -> 0x3008  cuanto necesitamos  0x3008 - 0x3003 = 5 relleno
d: .quad 1000  // 8 bytes 


/* 
Supongamos que tenemos bancos y cada banco es de 1 byte 
[1byte][1byte][1byte][1byte]
[1byte][1byte][1byte][1byte]
[ 0   ][ 0   ][0    ][ 0   ]
[ 0   ][1byte][1byte][1byte]  
                       ^
                       | */