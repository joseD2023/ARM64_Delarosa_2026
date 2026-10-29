/* Para esta directiva vamos a utilizar un simbolo y definir de que se trata si es un objeto 
o una funcion en terminos simple solo vamos a utilizar estas cuestiones */

       .type myfunc, %function  //definimos nuestro simbolos como una funcion 
       .global myfunc  // Lo hacemos global para otros archivos 

  myfunc:  
  // deberia ir el codigo que necesitamos hagamos algo 

  mov x1, #1 
  mov x2, #2 
  add x3, x1, x2 
  ret 

   .size myfunc, (.- myfunc) 

// . = ubicacion actual 
// myfunc = ubicacion donde comenzo el programa 
// . - myfunc = cuanto bytes avanzamos desde que comenzo myfunc 

// .size = le informa al archivo objeto cual es el tamaño del simbolo

