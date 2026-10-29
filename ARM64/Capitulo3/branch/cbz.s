
.global _start 
.text 
  mov x0, #0 

  cbz x0, es_cero   // si x0 <- 0 entonces salta directamente a la etiqueta 

  mov x1, #10 
  b fin 

  es_cero: 
    mov x1, #20 
    
  fin: 



.global _start 
.text 
  mov x0, #1 

  cbnz x0, no_es_cero   // si x0 <- 1 entonces salta directamente a la etiqueta 

  mov x1, #10 
  b fin 

  no_es_ceroes_cero: 
    mov x1, #20 
    
  fin: 



  loop: 
    cbnz x0, loop  

