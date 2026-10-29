        .text
        .type main, %function
        .global main
main:
        stp     x29, x30, [sp, #-16]!

        mov     x0, #9          // a baja
        mov     x1, #2          // a alta
        mov     x2, #4          // b baja
        mov     x3, #2          // b alta

        //Entonces nos preguntabamos si son iguales 
        cmp     x1, x3          // altas
        ccmp    x0, x2, #0, eq  // bajas (solo si las altas son iguales)
        cset    x4, eq          // x4 = 1 si a == b

        // Comparar a contra b y dejar el resultado en PSTATE
        cmp     x0, x2          // resta las bajas
        sbcs    xzr, x1, x3     // resta las altas con el borrow

        cbnz    x4, igual       // a == b
        b.lt    menor           // a < b

mayor:  mov     w0, #1          // a > b
        b       fin
menor:  mov     w0, #2          // a < b
        b       fin
igual:  mov     w0, #0          // a == b

fin:    ldp     x29, x30, [sp], #16
        ret
        .size main, (. - main)