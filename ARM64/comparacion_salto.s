

    mov x1, #8 
    mov x2, #10 
    cmp x1, x2 
    b.lt menor 
    mov w0, #0 
menor: 
    mov w0, #1 
fin: 


//ahora con la parte de cst 
    cmp x1, x2
    cset w0, lt // w0 = (x1 < x2) ? 1 : 0 entonces va a guardar el valor del resultado en w0 


// ahora con entero 
    cmp  x0, #0
    cset w0, eq        // w0 = (x0 == 0)

//ahora con flotantes 
    fcmp d0, d1
    cset w0, gt        // w0 = (d0 > d1)




    mov  x0, #5
    mov  x1, #9
    cmp  x0, x1        // 5 - 9 → los flags indican "menor"
    cset w2, lt        // ¿5 < 9? sí → w2 = 1
    cmp  x1, x0        // este cmp cambia los flags...
    cset w3, lt        // ¿9 < 5? no → w3 = 0


    