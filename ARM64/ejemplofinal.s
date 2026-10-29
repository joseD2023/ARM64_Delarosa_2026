
// [10,11,12,3] vamos a recorre toda la lista
.section .data 
 lista: .quad 10, 11, 12, 3  


.text 
 adr x1, lista  // supongamos que la lista comienza 0x10000 x1 <- 0x10000

 //1 elemetento 
 ldr x2, [x1, #0]!  //  x1 <- 0x100000  x2 <- 10 
 //2 elemento 
 ldr x3, [x1, #8]! //   x1 <- 0x10000 + 8 bytes = 0x10008   x3 <- 11 
 // 3 elemento
 ldr x4, [x1, #8]! // x1 <- 0x10008 + 8 bytes = 0x1010  x4 <- 12  

// y asi sucesivamente iriamos sucesivamente 

.section .data 
  lista2: .quad 20, 21, 14, 100 

.text 
 mov x0, #2  // 2 
 adr x1, lista2  // 0x1000
 ldr x2, [x1, x0, lsl #3] 

 // Entonces basicamente lo que va hacer el programa es que lo que este en el indice 2 de la lista2 lo va a cargar a x2 ose x2 <- 14 
 /* Como sucede pues seria tipo 
    2 * 8 = 16  y luego 
    0x1000 + 16 = 0x1010    entonces con esto tener la direccion de memoria del elemento del indice 2 y asi 
    obtenemos la parte de x2 <- 14  */

 
 