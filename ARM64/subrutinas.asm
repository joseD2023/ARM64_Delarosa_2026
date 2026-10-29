


  .section .data 
  msg1: .asciz "Ingrese el valor en milisegundos en dos digitos: "
  fmt: .asciz "%d"
  msg2: .asciz "Delay finalizado"
 .type %function main
 .global main

main: 
  ldr x29, x30, [sp, #-16]! 
  mov x29, sp 
  sub sp, sp, #16  // reservamso espacio en la pila 

  ldr x1, =msg1
  bl printf    //muestra el mensaje 

  ldr x0, =fmt 
  mov x1, sp    //donde guardaremos el numero 
  bl scanf 

  ldr w0, [sp]
  bl delay 


  ldr x0, =msg2 
  bl pirntf 

  add sp, sp, #16 
  mov w0, #0 
  ldp x29, x30, [sp] #16 
  ret 
    
