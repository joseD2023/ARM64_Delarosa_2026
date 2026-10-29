# Conceptos Interesantes para el ARM64 

#### Valores que nos puede ayudar a comprender cuanto Byte Manejar cuando utilicemos una reserva de Espacio. 

1. `int` Cuando tengamos que utilizarlo para reservar un elemento debemos conocer que cada elemento `int` contiene individualmente 4 bytes. 
2. `char`Cuando tengamos que utilizarlo para reservar un elemetno debemos conocer que cada elemento `char` contiene individualmente 1 byte. 

Veamos un ejemplo sencillo de como se trabaja al trasladar el lenguaje C a ensamblador. 

```c
static int foo[3]; 
static char bar[4]; 
char barfoo; 
int foobar;
```

Entonces en `C` basicamente vamos a reservar un arreglo estatico `int` y `char`, entonces es aqui donde debemos tener cuidado con la parte del ensamblador ya que como hemos mencionado antes la parte de ensamblador trabaja segune l byte de cada elemento. 

hagamos la parte de **static int foo[3];** que es como la parte mas importante referirno o entender el funcionamiento porque podrianos perdernos al momento de reservar en memoria. 

> Actualmente el arreglo contiene 3 elementos que podrian ser [1,2,3] entonces cada elemetento al ser de tipo int en ensamblador esto los toma individualmente como 4 bytes

Entonces como cada elemento individual es de 4 bytes entonces en ensamblador lo que deberiamos hacer en calcular el total de `bytes` a utilizar. 

Calculo: 

- elemento1: 4 byte
- elemento2: 4 byte 
- elemento3: 4 byte 

total = 4 + 4 + 4 = 12 bytes de utilizacion. 

```asm  
.bss 

 foo: .space 12 // reserva 12 bytes en memoria 
```

y lo mismo pasaria con los otros tipo de datos que manejen los lenguajes de programacon en este caso `C` entonces debemos solo enforcarnos en lo individual y luego ver cuantos elementos son. 


#### Pregunta : ¿Se puede Reservar Espacio en memoria en una directiva .data, si sabemos que lo mas adecuado es una directiva .bss?

De acuerdo a informacion dada si es posible reservar o definir una etiqueta con `.space` o `.skip` dentro de la seccion directiva `.data` (por ejemplo: mi_variable : .space 15 ) no es algo exclusivo de la directiva .bss 

La diferencia real entre hacerlo en .data o en .bss **no está en la sintaxis**, sino en como el sistema operativo maneja el archivo ejecutable. 

###### ¿Que pasa si lo colocamos en el .data? 

cuando escribimos etiqueta: .space 15 en `.data`el ensamblador genera 15 bytes reales llenos de cero (0x00) dentro del archivo binario en el disco duro. 

Funciona exactamente como si lo tuvieramos en un `.bss` ya que podemos leer o escribir. 

**La Desventaja**: si en lugar de utilizar 15 bytes utilizamos 10000000000000....0000 (un megabyte) el archivo ejecutable pesara un megabyte mas en el disco, llenos de puros ceros o sea espacio temporalmente sin utilizar y que afecta al rendimiento. 


###### ¿Que pasa si lo colocamos en el .bss? 

Esta parte o seccion `.bss` esta diseñada precisamente para datos no incializados o inicializados en cero, si ponemos **etiqueta: .space 15** en `.bss` el archivo en el disco no crece , solo se guarda como nota que hay un espacio reservado es tipo cuando el programa se ejecute, el sistema operativo debe reservar 15 bytes limpios en la RAM para esta etiqueta


