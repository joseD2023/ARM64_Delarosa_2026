
/* 
  Ejercicio 2: Procesamiento de calificaciones con máscaras de bits
  Objetivo: practicar carga y almacenamiento en memoria, recorridos de arreglos, operaciones aritméticas, máscaras de bits, comparaciones y saltos condicionales en ARM64. */


 .section .data 
 calificaciones : .word 12, 27, 40, 15 
 acumulador : .word 0 


 .global main 
 .section .text 

main: 
  //direccion base 
  ldr x0, =calificaciones
  ldr x2, =acumulador  
  ldr x13, [x2]
  mov x1, #0  //indice del for supongamos asi i 
  mov x9, #0x3 

for_inicio: 
  cmp x1, #4 // i < 4 ?  
  b.ge for_fin   // si es mayor i o igual debe saltar  i>=4
  ldr x4, [x0, x1, lsl #3]
  cmp x4, #20 


  b.gt sumar   // si x4 <- calificaciones[1] <-27 > 20 sumarle 5 

  bic x10, x4, x9 // apagamos los bits menos significativo 
  str x10, [x2]
  add x13, x13, x10
  add x1, x1, #1 


sumar: 
   add x4, x4, #5 
   str x4, [x0, x1, lsl #3]
   add x1, x1, #1 
   add x13, x13, x4 
  b for_inicio

for_fin: 
  
  


