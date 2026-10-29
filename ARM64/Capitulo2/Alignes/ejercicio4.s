/*

Inicio = 0x5000

.data

a: .byte 1
b: .byte 2
c: .byte 3

.align ?

d: .word 100

.align ?

e: .quad 500 */

.data 

a: .byte 1 // 1 byte -> 0x5000
b: .byte 2 // 1 byte -> 0x5001
c: .byte 3 // 1 byte -> 0x5002

 .align 2  // relleno -> 0x5003 solo usa 1 byte 

d: .word 100 // 4 bytes -> 0x5004

 .align 3  // relleno -> 0x5005 -> 0x5006 -> 0x5007 

e: .quad 500 // 8 bytes -> 0x5008