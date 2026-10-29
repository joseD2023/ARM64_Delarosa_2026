.section .data 
 ary: .quad 10, 11, 1, 2  // cramos nuestro propio arreglo [10,11, 1, 2]

.global _start 
.text 

_start: 
  mov x1, #2  // definimos el indice en cierto sentido es como si tuvieramos algo asi ary[x1] donde seria ary[2] = 1 
  adr x2, ary // colocamos la direccion base en el registro x2 
  ldr x3, [x2, x1, lsl #3] // cargamos el valor del indice 2 del arreglo y nos debe decir que en x3 <- 1 contiene esto 
  // solo que aqui el dato que vamos a cargar va a ir al registro del CPU 




/*Utilizacion de CPU a Memoria utilizando str 
  ejemplo sencillo de como funciona el str. 
  
  str x0, [x1]  donde 
  - x0 = valor que quiero guardar 
  - x1 = direccion de memoria donde quiero guardarlo  
  
  ldr x0, [x1] 
  - x1 = direccion de memoria donde quiero guardarlo 
  - x0 = valor que quiero guardar 
  
  */


_start: 
  mov x1, #2 
  adr x2, ary  
  str x3, [x2, x1, lsl #3]

  // solo que aqui el dato que vamos a cargar se va a la memoria RAM 




.data 
 ary: .quad 'A', 'B', 'C' 

.text 
  adr x1, ary 
  ldr x3, [x1, #0]! 
  ldr x3, [x1, #8]! 
  ldr x3, [x1, #8]! 





