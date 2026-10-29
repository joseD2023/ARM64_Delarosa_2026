

//Ejemplo: construir 0x123456789ABCDEF0 
// 12 34 56 78 9A BC DE F0 8 bytes 
// 1234  5678  9ABC  DEF0  tenemos 4 bloques de 16 bits podemos construir una instruccion MOVZ y tres MOVK 

/* 
    | Bits 63-48  |  Bits 47-32    | Bits 31-16    |  Bits 15-0   | 
 */



// 0000 | 0000 | 0000 | DEF0 
movz x0, #0xDEF0 
// 0000 | 0000 | 9ABC | DEF0 
movk x0, #0x9ABC, lsl #16  // nos movimos 16 bits Entonces basicamente agrego y conservo lo resto que tenia antes 
// 0000 | 5678 | 9ABC | DEF0 
movk x0, #0x5678, lsl #32 // basicamente seguimos conservando lo resto 
// 1234 | 0000 | 9ABC | DEF0 
movk x0, #0x1234, lsl #48 


//Clave es esta: MOVZ prepara el registro y MOVK completa los bloques que faltan sin borrar los anteriores




add x0, x1, x2 // Calcula, NO toca banderas 
adds x0, x1, x2 // Calcula y actualiza N,Z,C,V 
//Estas condiciones sirven para tomar decisiones despues  (saltos condicionales) por ejemplo un contador de ciclos. 



//Implementacion del acarreo si queremos sumar dos numeros grandes tipo de 128 bits cada uno 
Adds x0, x2, x4 // suma parte bajas, guarda el acarreo en C  
Adc x1, x3, x5 // suma parte altas + el acarreo de la anterior  


