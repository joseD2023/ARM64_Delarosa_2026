
/*Como manejar el pre indexado con ldr  */

.data 
ary: .word 1,2,3,4 

.global _start 
.text 

_start: 
  adr x0, ary 
  ldr w0, [x0, #0]! // -> supongamos en la posicion 0x1000 
  add w1, w1, w0  
  ldr w0, [x0, #4]! 
  add w1, w1, w0 // -> suma ahora tendriamos 3 osea vamos sumando cada componente