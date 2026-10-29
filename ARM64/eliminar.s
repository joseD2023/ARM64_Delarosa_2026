

.text 

 mov x0, #0xFF10 //Hexadecimal  
 mov x1, #10   //Decimal 
 mov x2, #0b0000000000000001 // Binario



.global _start 

.data 
 dato : .byte 'A'  //0x4100bc 

.text 

_start: 
  mov x0, #0x4100bc  
  ldr x1, [x0] 

// Me dio Error que lo podia manejar de manera sencilla entonces no se me ocurre algo que pudo haber pasado 
//Entonces hice esto 


.global _start 

.data 
 dato : .byte 'A'  //0x4100bc 

.text 

_start: 
  adr x0, dato  
  ldr x1, [x0] 

// si fucniono pero  en x1 me dio la direccion de memoria  y me dio un numero como 188978561089


.global _start 

.data 
 dato : .byte 'A'  
 matriz: .byte 'B', 'C' 

.text 

_start: 
  adr x0, dato  
  ldr x1, [x0] 
  adr x2, matriz 
  ldr x3, [x2] 

//Resultados  
// x3 -> 188978578242



//CPU a RAM 
.global _start 

.bss 
 espacio: .space 8 

.text 

_start: 
  ldr x0, =0x000000000000000A 
  adr x1, espacio 
  str x0, [x1]