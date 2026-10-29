/*Vamos a ver como podemos reservar espacios con una determinada cantidad de bytes y si mas adelante quiero llenarlo 
con un valor determinado.  

por ejemplo si usamos .skip 10 -> indicamos que vamos a reservar 10 byte 
[][][][][][][][][][] como no especificamos el valor de relleno todo van a ser 0 en bytes 


pero tambien tenemos la parte de podemo reservar espacio y colocar un dato predeterminado. 

.skip 10, 5 -> indicamos reserva lo 10 bytes y coloca el valor 5 en cada byte.
[05][05][05][05][05][05][05][05][05][05] 
 
 
basicamente nos sirve para declarar variables no inicializadas como si queremos reservar arreglos de 100 bytes 
entonces tendriamos algo tipo: */

.bss 
array: .skip 100 
vector: .space 100  

repetido: .skip 10, 5 // [05][05][05][05][05][05][05][05][05][05] osea rellenamos de una vez



/*Tambien existe simbolos que no ocupan memoria y que hacen como una referencia a un valor que hemso definido tipo 
constante. La idea es que un simbolo no siempre es memoria entonces podemos crear simbolos que solo son un numero 
no ocupan espacio pero el ensamblador los guarda en su tabla de simbolos y los remplaza donde los usemos 

Directivas */

//basicamente lo que hacemo es definir como una variable que puede utilizarse con ese valor en todos lados
.text // -> supongamos no es que vaya a funcionar  
.equ TAM, 20  // -> definimos un simbolo para utilizar en todas las partes del programa 
 mov x2, TAM 
 mov x4, TAM 
 add x0, x2, x3 


//equivalente  
.text 
mov x3, #20 
mov x5, #20  
add x1, x3, x5 



/*Ahora para cambiar el valor en el transcuro de la implementacion tambien tenemos una directiva que nos puede 
ayudar a manejar esta limitacion que tiene .equ 
 */

.text 
.set N, 1 
 mov x0, N // -> actualmente con el registro 0 y valor 1 
.set N, 5 
 mov x1, N  // -> actualmente con el registro 1 y valor 5 


 /*Ahora vamos con otra directiva que tiene el mismo funcionamiento que .equ pero tiene un modo de proteccion 
 ante simbolos iguales osea no permite tener con el mismo nombre esos simbolos */

.text 
.equiv LIMITE, 10 
 mov x0, LIMITE 
.equiv LIMITE, 20  // -> entonces aqui va a dar error porque ya existe ese simbolo como tal (symbol 'LIMITE' is defined)


/*Ahora nos vamos a centrar un tipo global que hace visible un simbolo para otros archivos, es como decir que 
puede utilizarlo otro archivo diferente a este es como un public class digamos asi.  */

//--------------------------------------------------------------------------------------------------
//Archivo 1 operaciones.s 
.global suma 
suma: 
  add x0, x1, x2 
  ret 

//--------------------------------------------------------------------------------------------------
//Archivo 2 main.s 
//supongamos que tengamos un archivo main.s (quin lo va a usar entonces lo debe de llamar tipo asi. )
bl suma // el linker conecta esto con suma de operaciones.s



/*Como reservar memoria sin utilizar .bss .skip .space  y lo vamos a utilizar con la directiva 
.comm que reserva bytes sin inicializar  */

.comm buffer, 64 //reservar 64 bytes llamadas buffer 
  ldr x0, =buffer // x0 = direccion del buffer


  

 