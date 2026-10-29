
.equ DEBUG 0 

.text 
.global main 

main: 
 //aqui el ensamblador decide que parte de las instrucciones conserva pero no es un if-else para eso tenemo cmp y b.eq eso si es un if else 
 .if DEBUG  // si debug es 0 se va al else y de ahi termina todo 
   mov x0, #20 
 .else 
   mov x0, #10  
 .endif 

  ret 

/*El ensamblador decide qué código entra al programa final y qué código descarta. */