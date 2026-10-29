/*
write assembly code to declare variables equivalent to the following C code. 

Static int foo[3]; 
Static char bar[4]; 
Char barfoo; 
Int foobar;  */


.bss 

foo: .space 12 // reservamos 3 bytes  cada elemento seria 1 byte -> [ 0 , 1, 2] -> [4byte, 4byte, 4byte] por ser un int
bar: .space 4 // reservamos 4 bytes  al ser un char es un byte por caracters 
barfoo: .space 1 //reservamso 1 byte 
foobar: .space 4 // reservamos 4 bytes


/*Explicacacion de la solucion:  

static int foo[3] contiene un arreglo  [0,1,2,3,4] en C -> cada valor int contiene 32 bits o 4 byts 
entonces para reservar espacio necesitariamos saber cuantos elementos son y multiplicarlos por 4 que es la cantidad que 
ocupa un solo elemento seria entonces (3 elem * 4 bytes) ) 12 bytes en total necesitamos  


Static char bar[4] aqui contiene tipos char y no contiene tipo int asi se reduce la cantidad de bytes a utiilizar  
['a', 'b', 'c', 'd'] -> cada elemento contiene un byte de utilizacion entonces solo necesitamos 4 bytes  
 
 
barfoo: .space 1 //reservamso 1 byte 
foobar: .space 4 // reservamos 4 bytes

al final ya no tenemos un arreglo ya solo contenemos 1 declaracion no inicializada entonces contiene la cantidad exacta que va 
a utilizar su elemento int -> 4 bytes  char -> 1 byte*/



/*### Siguiente ejercicio

**Muestra cómo almacenar el siguiente texto como una sola cadena de caracteres en lenguaje ensamblador, manteniéndolo legible y haciendo que cada línea tenga menos de 80 caracteres:**

> Los tres objetivos de la misión son:
>
> 1.  Mantener cada línea de código por debajo de 80 caracteres, 
> 2.  Escribir comentarios legibles, 
> 3.  Aprender una habilidad valiosa para la legibilidad. qeu texto ?? */


.section .rodata 
texto: 
    .asciz "1. Mantener cada línea de código por debajo de 80 caracteres\n" 
    .asciz "2. Escribir comentarios legibles,\n"
    .asciz "3. Aprender una habilidad valiosa para la legibilidad. qeu texto ??"

