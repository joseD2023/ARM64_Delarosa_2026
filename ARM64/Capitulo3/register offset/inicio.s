

ldr x3, [x2, x1, lsl #3]

/* Veamos que significa cada parte: desplaza el contenido de "x1" 3 bits hacia la izquierda, suma el resultado al contenido de 
"x2" y utiliza esa suma como una direccion de memoria desde la cual carga 8 bytes al registro "x3"  */