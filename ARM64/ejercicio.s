
.bss 

A: .SPACE 16 
B: .SPACE 16 

.text 

.global suma 

suma : 

 Adr x0, A
 Adr x1, B 
 Ldr x2, [x0] // 
 Ldr x3, [x1] // valores temporales 

// suma sin carray
 Adds x4, x2, x3 
 Ldr x2, [x0+8] 
 Ldr x8, [x1+8]

//Instruccion de suma  
 Adcs x5, x2, x3 

// acarreos 
 Mov x6, xzr //xzr es un cero 
 Adc x6,x6,xzr // pag 55. ahi vemos el xzr
 //Adc x6,x6,0 // trampa para volver al carry que es booleano al quad 
 Ret 
 .size suma,(. -suma)





