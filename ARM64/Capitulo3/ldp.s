/*Implementacion Nueva de lo que es los registros tenemos como primera parte al 
  LDP (ldp) 

  Antes teniamos que hacer algo asi: 

  ldr x0, [sp]  
  ldr x1, [sp, #8]  

  entonces nosotros en memoria podriamos tener asi  

  direccion  contenido 
  sp + 0         A 
  sp + 8         B  

  entonces si queremos ambos datos tenemso que hacer dos lineas de instrucciones. 

  ldr x0, [sp]  
  ldr x1, [sp, #8]   // donde ahora  x0 <- A   x1 <- B 

  Entonces aparece ldp  (load pair), por lo tanot podemos escribir 

  ldp x0, x1, [sp]  // donde en su interior hace tipo 

  x0 <- Memoria[sp] 
  x1 <- Memoria[sp + 8] // suma el tamño del primer registro sin decirle nada entonces comdo x0 es de 8 byte por eso hace sp + 8 


  ADEMAS QUE TAMBIEN LO PODEMOS HACER TAMBIEN CON EL STP (str) CPU a Memoria  
  stp x0, x1, [sp]  

  los valores del registro x0 y x1 vas a colocarlo en memoria y toma en cuenta la mismo funcionamiento de que  seria tipo 
  sp <- x0 
  [sp + tamaño(x0)] <- x1  

  donde x0 <- 10  and  x1 <- 20 


  */


.data 
  lista: .word 1,3,5,7

.text 
 adr x0, lista 
 ldp w1, w2, [x0]


/*Resultado Esperado: Basicamente aqui lo que vamos hacer es que en una solo linea de codigo 
 vamos asignarle a ambos registros los valores de 1 y 3 
 - w1 <- 1 
 - w2 <- 3 */


//ALTERNATIVA
.data 
  lista: .word 1,3,5,7

.text 
 adr x0, lista 
 ldr w1, [x0]
 ldr w2, [x0, #4]
