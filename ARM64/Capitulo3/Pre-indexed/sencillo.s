

.section .data 
 lista: .quad 4, 5, 6 // Es como si tuvieramos -> [4,5,6] guardado pero en bytes cada elemento de 8 byte 

.global _start 
.text 

_start: 
  adr x0, lista // apuntamos a una direccion de memoria de lista supongamos -> 0x1000  
  ldr x1, [x0, #0]! // cargamos el primer elemento a x1 -> 4 como contenemos la parte de ! entonces va actualizar la parte del 
  //nueva posicion en memoria del x1 pero como aqui no hay desplazamiento con #0  
  ldr x1, [x0, #8]! // -> aqui si aqui cambia la forma en lo que hacemos desplazamos 8 bytes entonces  
  //cargamos la parte de x1 <- 5 y ahora x0 <- x0 + 8 bytes = 0x1000 + 0x0008 = 0x1008  

/*Entoncees veamos la parte de Entonces de como funciona el pre-indexado 
 1. actualiza la direccion x0 <- actualiza siempre 
 2. carga el dato luego en este caso a x1  */


//-----------------------------------------------------------------------------------------------------------

.section .data 
 lista: .quad 4, 5, 6 // Es como si tuvieramos -> [4,5,6] guardado pero en bytes cada elemento de 8 byte 

.global _start 
.text 

_start: 
  adr x0, lista // apuntamos a una direccion de memoria de lista supongamos -> 0x1000  
  ldr x1, [x0], #0 // cargamos el primer elemento a x1 -> 4 como contenemos la parte de ! entonces va actualizar la parte del 
  //nueva posicion en memoria del x1 pero como aqui no hay desplazamiento con #0  
  ldr x1, [x0], #8 // -> aqui si aqui cambia la forma en lo que hacemos desplazamos 8 bytes entonces  
  //cargamos la parte de x1 <- 5 y ahora x0 <- x0 + 8 bytes = 0x1000 + 0x0008 = 0x1008  

/*Entoncees veamos la parte de Entonces de como funciona el pre-indexado 
 1. carga el dato luego en este caso a x1  
 2. actualiza la direccion x0 <- actualiza siempre */


 