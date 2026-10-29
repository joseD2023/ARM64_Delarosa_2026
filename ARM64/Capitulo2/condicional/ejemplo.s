/* Contenemos directivas de esta manera. 

.if expresion  solo entra si el argumento es distinto a cero
.else  si la condicion es falsa podemos utilizar else 
.ifdef  symbol  ensambla la siguiente seccion  si el symbolo ha sido definido 
.ifndef symbol  ensambla la siguiente seccion  si el symbolo no ha sido definido 
.endif   terminacion del bloque  */


.equ DEBUG, 1 

.text 

.global main 

main: 

  .if DEBUG  // si DEBUG es 1 entonces entra y hace la operacion 
    mov x0, #1 
    mov x1, #2 
    add x2, x0, x1 
  .endif 

  ret 



