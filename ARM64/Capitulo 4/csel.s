/* Utilizacion de CSEL: elegir entre dos registros 
   csel Rd, Rn, Rm, cond -> si la condicion se cumple Rd = Rn ; si no Rd = Rm 
    */

    cmp x0, x1
    csel x2, x0, x1, gt  // x2 = (x0 > x1) ? x0 : x1 

    /*Cuando utilizarlo, se usa en maximo y minimos y cualquier if / else simple que solo asigna 
    un valor. Evita saltos que son mas lentos si el procesador adivina mal 
    
    En pocas palabras cuando queremos comparar algo sin hacer el salto  como cmp | tst  */


    mov w1, #10 
    mov w2, #10 
    mov w3, #100 
    cmp w1, w2  // lo que haria 10 - 10 = 0  | Z = 1 se activa la bandera 
    //compara los valores para una resta conceptual 
    csel w0, w3, w2, eq //  w0 = ( w3 == w2 ) ? w3 : w2  |  w0 = (100 == 10) ?  100 : 10 
    //si la condicion es verdadera Rd = Rn si no Rd = Rm 

    /* Importante: aqui lo que nosotros debemos entender es la parte de que necesitamos del cmp 
    para que active las banderas en este caso Z porque si son iguales Z = 1 pero si no lo son Z = 0 entonces el caso 
    csel ve eso y dice  tipo = 1 | true  tipo = 0 | false entonces  si fueron iguales  entonces la bandera Z debio ser 1 
    por eso es la parte que debemos entender todo depende de la comparacion que hicimos inicialmente 
    pero no hace el salto si no que guarda el registro que queremos utilizar en otro registro  */






