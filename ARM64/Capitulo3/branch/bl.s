
.text 

  mov x0, #10 

  bl funcion  // tamaño(funcion) -> supongamos 4 bytes entonces  x30 <- posicion actual + tamaño(funcion)

  add x0, x0, #10   // vuelve a su estado de flujo


  funcion: 
     mov x1, #10 
     mov x2, #20 
     sub x3, x2, x1  
     ret      // cuando termina entonces basicamente dice pc = x30 y donde ahora x30 va ser la siguiente instruccion


    
    