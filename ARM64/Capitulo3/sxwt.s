
.section .data 
 lista: .quad 1,2,3,4,5 

.global _start 
.text 

_start: 
  mov w1, #1 
  adr x2, lista 
  ldr x3, [x2, w1, sxtw #3]  // aqui encontramos la direccion para tipo lista[1] = 2 

/* Funcionamiento: 

   tenemos un indice como tal de 32 bits en este caso w1 = 32 bits  
   adr donde x2 <- es de 64 bits  
   ldr carga lo que cotiene la direccion = x2 + w1   pero como usamos swtw entonces el de 32 bits se conviere en uo de 64 bits */




//OFFSET INMEDIATO  
ldr x0, [x1, #8] 

//REGISTER OFFSET 
ldr x0, [x1, x2, lsl #3] 

//PRE-INDEXADO 
ldr x0, [x1, #8]! 

//POST-INDEXADO 
ldr x0, [x1], #8 



