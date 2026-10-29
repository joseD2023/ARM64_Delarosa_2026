/*Ejercicio 1 — Datos condicionales + símbolo de objeto

1. Antes de la sección .data, define .equ MODO_DEBUG, 1 (o coméntalo para desactivarlo).
2. En .data, declara una variable version: .word 3.
3. Usando .ifdef MODO_DEBUG / .else / .endif, si MODO_DEBUG está definido, declara además una variable buffer_log reservando 32 bytes con .skip 32, 0. Si no está definido, no reserves nada. 
4. Marca version con .type version, %object y .size version, . - version.
5. Si MODO_DEBUG está definido, marca también buffer_log con .type %object y .size.
6. Cambia manualmente el .equ (coméntalo/descoméntalo) y vuelve a ensamblar para comprobar que el tamaño del archivo objeto cambia.*/


  
  .equ MODO_DEBUG, 1  

.data 

  version: .word 3

  .ifdef MODO_DEBUG 
    buffer_log: .skip 32, 0 // hay que tener cuidado cuando usemos una reserva en un .data ya que no es lo ideal porque puede tomar tamaños muy pesaado
  .else 
  // no se reserva nada 
  .endif

  .type version, %object 
  .size version, (.-version)

  .ifdef MODO_DEBUG 
    .type buffer_log %object 
    .size buffer_log, (.-buffer_log)
  .endif 





  
  


