/* 
  Control de sensores
  Un dispositivo guarda dos lecturas de 8 bits en memoria. Tu programa debe cargarlas, sumarlas, revisar el 
  resultado y utilizar una máscara para extraer o apagar ciertos bits.
  LDR / STR
  ADD / SUBS
  AND / BIC
  CMP / B.EQ 
  
  Datos iniciales: 
  en memoria tenemos estas dos variables: 
  
  | variable    | Hexadecimal   | binario (8 bits)  |  Decimal | 
  |  lectura A  |  0xC8   |   11001000        |   200    | 
  |  lectura B  |  0x5D|   01011101   |    93    | 
  |  mascara    |  0x0F    | 00001111       |   15  | 
  
  */



  .section .data 
  lectura_A : .byte 0xC8 
  lectura_B : .byte 0x5D 
  mascara   : .byte 0x0F 
  resultado_and : .byte 0 
  marca: .word 0 


  .type %function
  .global main 
  .section .text 

main: 
    /*COMO SABER si tiene carry debemos ver con cuantos bytes estamos trabajando tambien tipo 
    1byte entonces serian 8 bits entonces 2^8 = 255 si se pasa de ese numero entonces surgio carry */
   //los registros que contiene direcciones de memoria siempre deben ser de 64 bits 
   ldr x1, =lectura_A 
   ldrb w2, [x1] // cargamos el valor  200 
   ldr x3, =lectura_B 
   ldrb w4, [x3] // cargamos el valor de 93
   add w5, w2, w4  // sumamos  
   // w5 = 293 aqui no deberia ser carry porque estamos manejando 4 bytes ahora 
   // w6 = 293 - 10 = 283 
   subs w6, w5, #10  //calcula y actualiza las banderas NZCV 

   //guardamos las banderas NZCV para inspecionarlas 
   mrs x7, NZCV  // -> NUEVA 

   // cargamso la mascara 
   mov w8, #0x0F 

   //Extraemos los 4 bits menos significativos 
   and w9, w5, w8  // w5 = resultado de la suma  y w8 = mascara para quitar  

   //apagar los 4 bits menos singificativos 
   bic w10, w5, w8  

   //guardar el resultado de AND en memoria 
   adr x11, resultado_and  
   strb w9, [x11]

   //comparamos la suma  original 
   cmp w5, #250 
   b.eq igual 

diferente: 
   adr x12, marca 
   mov w13, #2 
   str w13, [x12] 
   b fin 
igual: 
   adr x12, marca 
   mov w13, #1 
   str w13, [x12]

fin: 
   mov w0, #0 
   ret 















