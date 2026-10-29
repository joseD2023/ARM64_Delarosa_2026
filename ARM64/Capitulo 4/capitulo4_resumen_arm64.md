# Capítulo 4 ARM64: resumen para consultar

> Idea de este archivo: que cuando se te olvide algo, lo busques aquí y en 30 segundos recuerdes **qué hace**, **para qué sirve** y **cómo se ve en código**. No es el libro completo, es lo esencial.

---

## 0. Las 5 ideas que sostienen todo el capítulo

1. **Las instrucciones de procesamiento de datos NO tocan la memoria.** Solo trabajan con registros e inmediatos. Si el dato está en memoria, primero `ldr`, después operas, y si hace falta `str`.
2. **Casi todas son de "3 direcciones":** `op destino, fuente1, fuente2`. Ejemplo: `add x0, x1, x2` -> `x0 = x1 + x2`. (La palabra "dirección" aquí no tiene nada que ver con memoria.)
3. **Cada instrucción mide 4 bytes (32 bits).** Por eso no cabe una constante de 64 bits dentro de una instrucción. De ahí salen `movz`/`movk` y `ldr x0, =valor`.
4. **El `s` al final** (`adds`, `subs`, `ands`...) hace que la instrucción **además** actualice las banderas NZCV. Sin `s`, solo calcula y guarda.
5. **Las banderas (NZCV) son la "memoria" de la última comparación**, y las usan los saltos (`b.eq`...) y las condicionales (`csel`, `cset`...).

---

## 1. Operand2: el segundo operando "con superpoderes"

El segundo operando (el último de la derecha) puede ser:

| Forma | Ejemplo | Qué hace |
|---|---|---|
| Inmediato de 12 bits | `add x0, x1, #5` | Constante de 0 a 4095 |
| Registro | `add x0, x1, x2` | Suma normal |
| Registro + desplazamiento | `add x0, x1, x2, lsl #3` | `x1 + (x2 * 8)` |
| Registro + extensión (+ shift de 0 a 4) | `add x0, x1, w2, sxtw #2` | Convierte `w2` a 64 bits y luego lo multiplica por 4 |

**Por qué importa:** en una sola instrucción haces "desplazar y sumar". Es la base de multiplicar por constantes sin `mul` y de recorrer arreglos.

### Desplazamientos y rotación

| Op | Qué hace | Equivale a |
|---|---|---|
| `lsl` | Mueve a la izquierda, entran 0s | Multiplicar por 2ⁿ |
| `lsr` | Mueve a la derecha, entran 0s | Dividir entre 2ⁿ **sin signo** |
| `asr` | Mueve a la derecha, entra **copia del bit de signo** | Dividir entre 2ⁿ **con signo** |
| `ror` | Rota a la derecha, lo que sale por la derecha entra por la izquierda | No se pierde nada |

- **`ror` solo en instrucciones lógicas** (`and`, `orr`, `eor`, `mvn`, `tst`...). No en `add` ni `cmp`.
- **Diferencia clave `lsr` vs `asr`:** con positivos dan lo mismo. Con negativos, `lsr` mete ceros y el número deja de ser negativo; `asr` mete unos y conserva el signo.
  - `11111000` (-8 en 8 bits): `asr 1` -> `11111100` (-4) ✔. `lsr 1` -> `01111100` (124) ✘.
- `asr` redondea hacia **menos infinito** (-7 >> 1 = -4), `sdiv` redondea hacia **cero** (-7 / 2 = -3).

### Extensiones (para agrandar un dato pequeño a 64 bits)

| Prefijo | Rellena con |
|---|---|
| `uxt...` (unsigned) | Ceros |
| `sxt...` (signed) | Copias del bit de signo |

Sufijos: `b` = byte (8 bits), `h` = half-word (16), `w` = word (32), `x` = double-word (64).

- **Caso típico:** tienes un índice de 32 bits con signo (`w3`) y una dirección base de 64 bits (`x2`): `ldr w1, [x2, w3, sxtw]`.
- **No se usan en instrucciones lógicas** (ahí va `ror`).
- `sxtx`/`uxtx` con registro de 64 bits no hacen nada útil. Lo mismo `sxtw`/`uxtw` con `w`.

### Inmediatos

| Tipo | Para qué instrucciones | Regla |
|---|---|---|
| 12 bits sin signo | Todas las **no lógicas** (`add`, `sub`, `cmp`...) | Rango 0 a 4095 |
| Patrón de 13 bits | Solo **lógicas** (`and`, `orr`, `eor`, `tst`) | Un bloque de unos **consecutivos**, repetido 1, 2, 4, 8, 16 o 32 veces, y puede estar rotado |

- `#7` (`111`) ✔ válido. `#5` (`101`) ✘ no es un bloque consecutivo. `0xaaaaaaaa` ✔ (patrón `10` repetido). `#0xFF` ✔. `#0x700` ✔ (el 7 rotado).
- Si necesitas una máscara inválida, la cargas en un registro y usas la forma con dos registros.

---

## 2. Aritméticas: `add`, `adc`, `sub`, `sbc`, `neg`, `ngc`

| Instrucción | Calcula | Acepta Operand2 completo |
|---|---|---|
| `add Rd, Rn, Op2` | `Rn + Op2` | Sí |
| `sub Rd, Rn, Op2` | `Rn - Op2` | Sí |
| `adc Rd, Rn, Rm` | `Rn + Rm + C` | **No**, solo registros simples |
| `sbc Rd, Rn, Rm` | `Rn - Rm + C - 1` | **No**, solo registros simples |
| `neg Rd, Op2` | `-Op2` | Sí (es `sub Rd, xzr, Op2`) |
| `ngc Rd, Rm` | `-Rm + C - 1` | **No** (es `sbc Rd, xzr, Rm`) |

Con `s` al final (`adds`, `subs`, `adcs`, `sbcs`) actualizan banderas.

### Para qué sirven `adc` y `sbc`: números de más de 64 bits

Sumar dos números de 128 bits (x1:x0 + x3:x2):
```asm
adds x0, x0, x2     // parte baja; el acarreo se guarda en C
adc  x1, x1, x3     // parte alta + el acarreo de la baja
```
Restar:
```asm
subs x0, x0, x2     // parte baja
sbc  x1, x1, x3     // parte alta, usando el préstamo
```

### Ojo con la resta y la bandera C

En ARM64, en la resta, **C = 1 significa "NO hubo préstamo"** (al revés que en Intel). Por eso `sbc` es `Rn - Rm + C - 1`: si C=1, queda `Rn - Rm`, una resta normal.

### Ejemplos

```asm
add  x0, x1, x2          // x0 = x1 + x2 (no toca banderas)
subs x3, x3, #1          // x3 = x3 - 1 y actualiza NZCV  (típico contador que baja)
neg  x4, x5, lsl #4      // x4 = -(x5 << 4)
```

---

## 3. Lógicas: trabajan bit por bit

| Instrucción | Calcula | Para qué se usa |
|---|---|---|
| `and` | `Rn AND Op2` | **Apagar** bits / extraer con máscara |
| `orr` | `Rn OR Op2` | **Encender** bits (no toca los que ya están en 1) |
| `eor` | `Rn XOR Op2` | **Invertir** (toggle) bits específicos |
| `bic` | `Rn AND NOT Op2` | **Limpiar** bits específicos |
| `orn` | `Rn OR NOT Op2` | OR con el operando invertido |
| `eon` | `Rn XOR NOT Op2` | XOR con el operando invertido |
| `mvn` | `NOT Op2` | Invertir **todos** los bits (complemento a 1) |

- `mvn` es la única con un solo operando fuente (es `orn` con `xzr`).
- `ands` y `bics` actualizan banderas. `tst` es `ands` sin guardar resultado.
- Como inmediato (patrón), solo se permite en `and`, `ands`, `orr`, `eor`.

### Recetas de bits (las que más se usan)

```asm
orr x0, x0, #8           // ENCENDER el bit 3
eor x0, x0, #8           // INVERTIR el bit 3
and x1, x0, #0xF         // EXTRAER los 4 bits bajos
mov x2, #8
bic x0, x0, x2           // APAGAR el bit 3
```

---

## 4. Movimiento de datos: `mov`, `movz`, `movn`, `movk`

| Instrucción | Qué hace | Cuándo |
|---|---|---|
| `mov x0, x1` | Copia registro a registro | Pasar argumentos, guardar valores, mover desde/hacia `sp` |
| `mov x0, #5` | Carga un inmediato pequeño | Contadores, constantes |
| `movz x0, #imm16, lsl #n` | Pone 16 bits en la posición n y **borra el resto** (0s) | Primer paso para armar una constante grande |
| `movk x0, #imm16, lsl #n` | Cambia solo esos 16 bits y **conserva el resto** | Pasos siguientes |
| `movn x0, #imm16` | Carga el **NOT** del valor desplazado | Negativos, muchos unos. `-1` = `movn x0, #0` |

- `n` puede ser 0, 16, 32 o 48 (en `w` solo 0 o 16).
- `mov` es un **alias**: el ensamblador elige `orr`, `movz`, `movn` o `add` según el caso.
- Si el valor es un **patrón** (bloque repetido de unos), `mov` lo carga en una sola instrucción.

### Armar `0xFEDCBA0987654321`
```asm
movz x0, #0xfedc, lsl #48
movk x0, #0xba09, lsl #32
movk x0, #0x8765, lsl #16
movk x0, #0x4321
```

### Alternativa cómoda
```asm
ldr x0, =0xFEDCBA0987654321    // el ensamblador lo guarda en memoria (literal pool) y lo carga
```

---

## 5. Multiplicación

### Mismo tamaño: `mul`, `madd`, `msub`, `mneg`

| Instrucción | Calcula | Para qué |
|---|---|---|
| `mul Rd, Rn, Rm` | `Rn × Rm` | Multiplicar normal |
| `madd Rd, Rn, Rm, Ra` | `Ra + Rn × Rm` | Multiplicar y acumular (producto punto, `fila*cols + col`) |
| `msub Rd, Rn, Rm, Ra` | `Ra - Rn × Rm` | **Calcular el módulo** |
| `mneg Rd, Rn, Rm` | `-(Rn × Rm)` | Multiplicar y negar |

Si no cabe, **se pierden los bits altos** (sin aviso).

### Módulo (ARM64 no tiene instrucción de módulo)

`a mod b = a - (a / b) × b`
```asm
udiv x2, x0, x1          // x2 = a / b   (cociente entero)
msub x3, x2, x1, x0      // x3 = x0 - (x2 * x1) = a mod b
```

### Resultado de 64 bits desde 32: `smull`, `umull` y familia

Toman dos `w` y dan un `x`, así **no se desborda**. `s` = con signo, `u` = sin signo.

| Variante | Calcula |
|---|---|
| `smull` / `umull` | `Wn × Wm` |
| `smaddl` / `umaddl` | `Xa + Wn × Wm` |
| `smsubl` / `umsubl` | `Xa - Wn × Wm` |
| `smnegl` / `umnegl` | `-(Wn × Wm)` |

Úsalas cuando multiplicas dos `int` y necesitas el resultado completo como `long`.

### 128 bits: `umulh` y `smulh`

64×64 bits puede ocupar 128. Se necesitan dos instrucciones:
```asm
mul   x9, x0, x1         // 64 bits BAJOS
umulh x1, x0, x1         // 64 bits ALTOS   (smulh si es con signo)
```
Útil para: números enormes, criptografía y **detectar overflow** (si `umulh` no da 0, no cabía en 64 bits).

### Multiplicar por constantes sin `mul` (truco de examen)

Se combinan sumas con desplazamientos. Ejemplos:
```asm
// x * 9  =  x + x*8
add x0, x3, x3, lsl #3

// x * 12  =  x*3 * 4   ->  (x + x*2) y luego lsl #2
add x1, x3, x3, lsl #1
lsl x0, x1, #2
```
Receta: descompón la constante en potencias de 2 (o en productos de factores pequeños) y arma el resultado con `add`/`sub` + `lsl`.

---

## 6. División: `sdiv`, `udiv`

```asm
sdiv x0, x1, x2          // x0 = x1 / x2  (con signo)
udiv x0, x1, x2          // x0 = x1 / x2  (sin signo)
```
- Solo dan el **cociente entero**. El residuo sale con `msub`.
- **Dividir entre 0 NO da error**: el resultado es `0`. Si te importa, revisa antes con `cbz`.
- Es más lenta que `lsr`/`asr`: para dividir entre potencias de 2, mejor desplazar.
- `sdiv` vs `udiv` mal elegida da resultados raros con negativos.
- Se usa para promedios, convertir número a texto (dividir entre 10 y sacar dígitos) y módulo.

---

## 7. Comparación: `cmp`, `cmn`, `tst`

**No guardan resultado**, solo actualizan las banderas.

| Instrucción | Es alias de | Hace | Z=1 cuando... |
|---|---|---|---|
| `cmp Rn, Op2` | `subs` | `Rn - Op2` | `Rn == Op2` |
| `cmn Rn, Op2` | `adds` | `Rn + Op2` | `Rn == -Op2` |
| `tst Rn, Op2` | `ands` | `Rn AND Op2` | Ningún bit de la máscara está en 1 |

(`teq` aparece en el libro pero **no existe en AArch64**.)

### Las 4 banderas

| Bandera | Se activa cuando... |
|---|---|
| **N** | El resultado tiene el bit más alto en 1 (negativo) |
| **Z** | El resultado es cero (sobre el tamaño del operando, ignorando el acarreo) |
| **C** | Hubo acarreo en suma / **NO** hubo préstamo en resta |
| **V** | Desbordamiento **con signo** (el resultado no cumple la ley de signos) |

### Cómo sacar las banderas de una suma (tipo examen)

Ejemplo 8 bits: `0xC8 + 0x5D`
1. Sumas en binario: `11001000 + 01011101 = 1 00100101` (el 1 de la izquierda es acarreo).
2. **C** = 1 si hay acarreo. **Z** = 1 si los 8 bits del resultado son todos 0. **N** = bit más alto del resultado de 8 bits.
3. **V**: miras los signos. Si sumas dos positivos y da negativo, o dos negativos y da positivo, V=1. Si los signos de los operandos son distintos, V=0 siempre.

### `tst`: probar bits con una máscara

Máscara = número con 1s solo en los bits que quieres revisar. AND y mira si dio 0.

| Quiero saber... | Código | Salto |
|---|---|---|
| ¿Es impar? | `tst x0, #1` | `b.ne` |
| ¿Es par? | `tst x0, #1` | `b.eq` |
| ¿Bit n encendido? | `tst x0, #(1<<n)` | `b.ne` |
| ¿Múltiplo de 2ⁿ? | `tst x0, #(2ⁿ-1)` | `b.eq` |
| ¿Es cero? | `tst x0, x0` | `b.eq` |
| ¿Es negativo? | `tst x0, x0` | `b.mi` |

Máscaras de múltiplos: 4 -> `#3`, 8 -> `#7`, 16 -> `#15`, 32 -> `#31`. **Solo funciona con potencias de 2.**

### Códigos de condición (para `b.cond`, `csel`, `cset`...)

| Condición | Significa | Banderas |
|---|---|---|
| `eq` / `ne` | Igual / distinto | Z=1 / Z=0 |
| `mi` / `pl` | Negativo / positivo o cero | N=1 / N=0 |
| `vs` / `vc` | Overflow / sin overflow | V=1 / V=0 |
| **Con signo:** | | |
| `lt` | Menor que | N ≠ V |
| `le` | Menor o igual | Z=1 o N ≠ V |
| `gt` | Mayor que | Z=0 y N = V |
| `ge` | Mayor o igual | N = V |
| **Sin signo:** | | |
| `lo` (o `cc`) | Menor que | C=0 |
| `ls` | Menor o igual | C=0 o Z=1 |
| `hi` | Mayor que | C=1 y Z=0 |
| `hs` (o `cs`) | Mayor o igual | C=1 |

**Regla rápida:** si los números pueden ser negativos -> `lt/le/gt/ge`. Si son sin signo (direcciones, contadores) -> `lo/ls/hi/hs`.

---

## 8. Bucles y saltos (la plantilla)

Los saltos se usan con `cmp`/`tst`/`subs` antes. Patrón clave: **"salir si la condición falla"**, por eso en el salto de arriba va la condición **contraria**.

### `for (i = 0; i < 10; i++)`
```asm
    mov  w0, #0              // i = 0
loop:
    cmp  w0, #10
    b.ge endloop             // si i >= 10, salir
    // ... cuerpo ...
    add  w0, w0, #1          // i++
    b    loop
endloop:
```

### `while (x != 0)`
```asm
while:
    cbz  x0, fin             // si x0 == 0, salir
    // ... cuerpo ...
    b    while
fin:
```

### `do { } while (c != 'A')` (el cuerpo corre al menos una vez)
```asm
loop:
    bl   getchar             // devuelve el caracter en x0
    cmp  x0, x19             // x19 guarda 'A'
    b.ne loop                // repetir si NO es 'A'
```

### Contador que baja a cero (el más compacto)
```asm
    mov  x0, #5
loop:
    // ... cuerpo ...
    subs x0, x0, #1          // resta y actualiza banderas
    b.ne loop
```

### Qué registro usar para el contador

| Situación | Registros |
|---|---|
| El bucle **no** llama funciones | `x0-x15` (menos `x8`) |
| El bucle llama funciones y necesitas conservar el valor | `x19-x28` (guardándolos antes en el stack y restaurándolos al final) |

---

## 9. Condicionales: decidir sin saltar (el `? :` de C)

Leen las banderas que dejó un `cmp`/`tst` y **eligen un valor**.

| Instrucción | Si cond es verdadera | Si es falsa |
|---|---|---|
| `csel Rd, Rn, Rm, cond` | `Rn` | `Rm` |
| `csinc Rd, Rn, Rm, cond` | `Rn` | `Rm + 1` |
| `csinv Rd, Rn, Rm, cond` | `Rn` | `~Rm` |
| `csneg Rd, Rn, Rm, cond` | `Rn` | `-Rm` |
| `cinc Rd, Rn, cond` | `Rn + 1` | `Rn` |
| `cinv Rd, Rn, cond` | `~Rn` | `Rn` |
| `cneg Rd, Rn, cond` | `-Rn` | `Rn` |
| `cset Rd, cond` | `1` | `0` |
| `csetm Rd, cond` | `0xFFFF...F` (todos 1) | `0` |

**Ojo:** en `csinc/csinv/csneg` la transformación va en el lado **falso**. En `cinc/cinv/cneg` va en el lado **verdadero**.

### Ejemplos útiles

```asm
// máximo de dos números (con signo)
cmp  x0, x1
csel x2, x0, x1, gt          // x2 = (x0 > x1) ? x0 : x1

// valor absoluto
cmp  x0, #0
cneg x0, x0, lt              // si x0 < 0 -> x0 = -x0

// guardar un booleano:  r = (a < b)
cmp  x0, x1
cset w2, lt                  // w2 = 1 o 0
```

### `ccmp` / `ccmn`: condiciones encadenadas (`&&`)

`ccmp Rn, Op, #nzcv, cond`: si `cond` se cumple (con las banderas anteriores), compara `Rn - Op`. Si no, **pone las banderas en el valor literal `#nzcv`** (orden: N Z C V).

```asm
// if (a == 5 && b == 7)
cmp  x0, #5
ccmp x1, #7, #0, eq          // si a==5, compara b con 7; si no, flags=0000 (Z=0)
b.eq los_dos                 // solo salta si AMBOS se cumplieron
```
`ccmn` es igual pero con suma. El inmediato de `ccmp` es de 5 bits (0 a 31).

### Ejemplo del libro: `flipFlop` (par -> +1, impar -> -1)
```asm
tst   w0, #1                 // mira el bit 0
add   w1, w0, #-1            // w1 = num - 1
csinc w0, w1, w0, ne         // impar (ne): w0 = w1   |   par: w0 = w0 + 1
ret
```

---

## 10. Instrucciones especiales

| Instrucción | Qué hace | Cuándo |
|---|---|---|
| `clz Rd, Rn` | Cuenta los ceros desde la izquierda hasta el primer 1 | Posición del bit más alto: `63 - clz(x)` = log₂ |
| `cls Rd, Rn` | Cuenta bits consecutivos iguales al de signo (sin contar el de signo) | Normalizar números con signo |
| `mrs x0, NZCV` | Lee las banderas a un registro | Guardar/inspeccionar banderas |
| `msr NZCV, x0` | Escribe un registro en las banderas | Restaurar/limpiar banderas |
| `svc #0` | Pide un servicio al sistema operativo (syscall) | Imprimir, abrir archivos, salir |
| `nop` | No hace nada (gasta un ciclo) | Retardos, relleno, depurar |

Banderas dentro de NZCV: **N = bit 31, Z = bit 30, C = bit 29, V = bit 28**.

### Syscalls en Linux ARM64

- **x8** = número de syscall. **x0-x5** = argumentos. Se ejecuta `svc #0`.
- Números que ya usamos: `write` = **64**, `exit` = **93**, `openat` = **56**.

```asm
// escribir un texto
mov x0, #1               // 1 = stdout
adr x1, msg              // dirección del texto
mov x2, #39              // cuántos bytes
mov x8, #64              // write
svc #0

// salir
mov x0, #0               // código de salida
mov x8, #93              // exit
svc #0
```

---

## 11. Plantilla de `main` (prólogo y epílogo)

```asm
main:
    stp x29, x30, [sp, #-16]!    // guarda FP y LR (dirección de retorno) en el stack
    // ... tu código ...
    mov w0, #0                   // return 0
    ldp x29, x30, [sp], #16      // restaura FP y LR
    ret                          // vuelve a quien llamó (usa x30)
```
- `bl` sobrescribe `x30`, por eso hay que guardarlo antes si `main` llama funciones.
- Si usas `x19-x28`, también se guardan en el stack y se restauran antes del `ret`.
- `stp ..., [sp, #-16]!` = pre-indexado (primero baja `sp`, luego guarda). `ldp ..., [sp], #16` = post-indexado (primero carga, luego sube `sp`).

---

## 12. Tabla maestra: "necesito... uso..."

| Necesito... | Uso |
|---|---|
| Cargar constante pequeña | `mov x0, #5` |
| Cargar constante grande | `movz` + `movk`, o `ldr x0, =valor` |
| Cargar -1 | `movn x0, #0` |
| Multiplicar/dividir por 2ⁿ | `lsl` / `lsr` / `asr` |
| Multiplicar por constante sin `mul` | `add` + `lsl` combinados |
| Acceder a `arr[i]` (8 bytes) | `ldr x3, [x1, x0, lsl #3]` |
| Acumular `a + b×c` | `madd` |
| `a % b` | `udiv` + `msub` |
| Producto de 128 bits | `mul` + `umulh` |
| Sumar/restar 128 bits | `adds` + `adc` / `subs` + `sbc` |
| Saber si es par/impar | `tst x0, #1` |
| Encender / apagar / invertir un bit | `orr` / `bic` / `eor` |
| Máximo, mínimo, abs | `cmp` + `csel` / `cneg` |
| Guardar resultado de comparación | `cset` |
| `if` con `&&` sin saltos | `cmp` + `ccmp` |
| Posición del bit más alto | `clz` |
| Leer o escribir banderas | `mrs` / `msr` |
| Imprimir sin `printf` | `svc` con x8 = 64 |
| Contador que baja a 0 | `subs` + `b.ne` |

---

## 13. Errores del libro (para no confundirte)

- `movk`: dice que cambia "cuatro bits"; son **16 bits**.
- Ejemplo del `for`: el comentario dice "Exit loop if r0 > 10", pero `bge` sale si es **mayor o igual** (>= 10).
- Ejemplo do-while: guarda `x19` pero restaura con `ldr x20`; debería ser `x19`.
- `teq` aparece en la tabla de comparación pero **no existe en AArch64**.
- `ccmp x4, #31, ...` comenta `x4 - 32`; en realidad compara con 31.
- `ngc`: la fórmula usa `Rn`, pero en realidad es `-Rm + C - 1`.
- Un `bge` o `b.eq` después de `cmn` no significa "mayor/menor" de forma intuitiva: las banderas se calcularon con una **suma**.

---

## 14. Cómo atacar un ejercicio (checklist)

1. **Traduce el problema a pasos simples** (como si fuera pseudocódigo en C).
2. **Decide registros:** ¿hay llamadas a funciones? Si sí, contadores en `x19+`.
3. **¿Hay datos en memoria?** Primero `adr` + `ldr`. Escoge el `lsl` según el tamaño (8 bytes -> 3, 4 bytes -> 2, 2 bytes -> 1).
4. **¿Hay decisión?** `cmp` o `tst` + salto (o `csel`/`cset` si es un valor simple).
5. **¿Hay bucle?** Plantilla de la sección 8, con la condición contraria para salir.
6. **¿Es con signo o sin signo?** Elige `lt/gt` o `lo/hi`, y `sdiv` o `udiv`.
7. **Haz una tabla de traza** con 2 o 3 casos a mano y verifica que tu código da lo mismo.
8. **Revisa lo típico:** ¿olvidaste incrementar el contador? ¿usaste `w` donde iba `x`? ¿restauraste `x30`/`x19`? ¿la máscara de `tst` es la correcta?
