/*

Inicio = 0x6000


.data

a: .byte 1

.align 3

b: .quad 20

c: .word 30

d: .byte 40
e: .byte 50

.align ?

f: .quad 100

g: .byte 60
h: .byte 70
i: .byte 80

.align ?

j: .word 900 */

.data 

a: .byte 1 // -> 0x6000
 .align 3  // -> 0x6001 -> 0x6002 -> 0x6003 -> 0x6004 -> 0x6005 -> 0x6006 -> 0x6007
b: .quad 20 // -> 0x6008 -> 0x6009 -> 0x600A -> 0x600B -> 0x600C -> 0x600D -> 0x600E -> 0x600F 
c: .word 30 // -> 0x6010 -> basicamente o visualmente seria la posicion 16 -> 0x6011 -> 0x6012 -> 0x6013 
d: .byte 40 // -> 0x6014
e: .byte 50 // -> 0x6015
.align 3 // -> 0x6016 -> 0x6017
f: .quad 100 // -> 0x6018 -> 0x6019 -> 0x601A -> 0x601B -> 0x601C -> 0x601D -> 0x601E -> 0x601F
g: .byte 60 // -> 0x6020
h: .byte 70 // -> 0x6021
i: .byte 80 // -> 0x6022
  .align 2  // -> multiplo de 4 -> 0x6023
j: .word 900 // -> 0x6024 -> 0x6025 -> 0x6026 -> 0x6027 

//El align solo mire direcciones de memoria no posiciones siempre mira direcciones 
