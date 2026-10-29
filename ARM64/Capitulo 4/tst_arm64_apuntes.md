# `tst` en ARM64: probar bits

## 1. Qué es `tst`

`tst` hace un **AND** entre un registro y otro valor, **descarta el resultado** y solo actualiza las banderas. No modifica ningún registro.

Es alias de `ands`: es como hacer un `and` pero sin guardar el resultado en ningún lado.

## 2. Cómo se guarda un número: bits y posiciones

El computador guarda todo en binario (0s y 1s). Cada posición tiene un valor, y **se cuentan de derecha a izquierda empezando en 0**:

| posición (bit) | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
|---|---|---|---|---|---|---|---|---|
| valor que vale | 128 | 64 | 32 | 16 | 8 | 4 | 2 | 1 |

Un 1 en esa posición significa "suma este valor". Ejemplo, el **13**:

```
13 = 8 + 4 + 1

bit:    3  2  1  0
valor:  8  4  2  1
13:     1  1  0  1
```

En el 13: el bit 0 es 1, el bit 1 es 0, el bit 2 es 1 y el bit 3 es 1.

"Bit 0" es simplemente **el dígito de más a la derecha**.

## 3. El AND bit por bit

El AND deja un 1 solo donde **ambos** tienen 1:

```
  1011
& 0100
------
  0000   -> resultado 0 -> Z=1
```

```
  1011
& 0010
------
  0010   -> resultado distinto de 0 -> Z=0
```

## 4. La idea clave: la máscara

La **máscara** es el número que pones tú, con unos solo en los bits que quieres revisar. Es como una ventana: lo que no tiene 1 en la máscara se ignora (se vuelve 0).

`tst` hace el AND y mira si el resultado es cero o no:

- Resultado **cero** -> Z=1 -> `b.eq` salta -> todos los bits de la máscara estaban **apagados** (en 0).
- Resultado **distinto de cero** -> Z=0 -> `b.ne` salta -> al menos uno de esos bits estaba **encendido** (en 1).

## 5. Par o impar (bit 0)

Los valores de las posiciones son 1, 2, 4, 8, 16... Todos son pares **excepto el 1**. Entonces un número es impar **solo si el bit 0 está en 1**.

```
6  = 0110  -> bit 0 es 0 -> par
7  = 0111  -> bit 0 es 1 -> impar
```

`tst x0, #1` usa la máscara `0001`, que ignora todo menos el bit 0:

```
x0 = 7:   0111
máscara:  0001
AND:      0001  -> distinto de 0 -> Z=0 -> b.ne -> IMPAR

x0 = 6:   0110
máscara:  0001
AND:      0000  -> es 0 -> Z=1 -> b.eq -> PAR
```

```asm
tst x0, #1
b.eq es_par      // bit 0 en 0 -> par
b.ne es_impar    // bit 0 en 1 -> impar
```

## 6. Revisar un bit específico

Es lo mismo pero con otra máscara. Para revisar el **bit 3** necesitas una máscara con un 1 solo en esa posición: `1000`, que vale 8.

```
x0 = 13:  1101
máscara:  1000   (8)
AND:      1000  -> distinto de 0 -> el bit 3 ESTÁ encendido

x0 = 5:   0101
máscara:  1000
AND:      0000  -> es 0 -> el bit 3 está apagado
```

**Fórmula:** para revisar el bit n, la máscara es el valor de esa posición (bit 3 -> 8, bit 4 -> 16, bit 5 -> 32...).

```asm
tst x0, #8       // 8 = 0b1000, solo el bit 3
b.ne bit3_activo
```

## 7. Múltiplo de 8 (los 3 bits bajos)

Los múltiplos de 8 en binario:

```
 8 =  1000
16 = 10000
24 = 11000
40 = 101000
```

**Todos terminan en 000.** Es igual que en decimal: los múltiplos de 100 terminan en 00, porque 100 = 10². Aquí 8 = 2³, así que los múltiplos de 8 terminan en tres ceros.

Solo hay que verificar que los **3 bits de la derecha sean 0**. La máscara es `111` (que vale 7):

```
x0 = 24:  11000
máscara:  00111
AND:      00000  -> es 0 -> SÍ es múltiplo de 8

x0 = 20:  10100
máscara:  00111
AND:      00100  -> distinto de 0 -> NO es múltiplo
```

```asm
tst x0, #7       // 7 = 0b111
b.eq multiplo_de_8
```

Con múltiplos de 4 la máscara es `11` (3), con múltiplos de 16 es `1111` (15). Siempre es **(potencia de 2) - 1**.

## 8. ¿Es cero? `tst x0, x0`

Aquí la máscara es el mismo registro. Un número AND consigo mismo **da el mismo número**:

```
1 AND 1 = 1
0 AND 0 = 0
```

Entonces `x0 AND x0 = x0`, y ese resultado es 0 solo si `x0` ya era 0.

```asm
tst x0, x0
b.eq es_cero
```

## 9. ¿Es negativo? `tst x0, x0`

Los negativos se guardan en **complemento a dos**, y la regla clave es: **el bit más alto (el de más a la izquierda) es el bit de signo**. 1 significa negativo, 0 significa positivo.

Ejemplo con 8 bits para que se vea (en ARM64 es igual pero con 64):

```
 5  = 00000101   bit alto = 0 -> positivo
-1  = 11111111   bit alto = 1 -> negativo
-5  = 11111011   bit alto = 1 -> negativo
```

Como `x0 AND x0` da `x0`, el resultado tiene el mismo bit alto. La bandera **N** (negative) se copia del bit alto del resultado. Entonces:

- bit alto = 1 -> N=1 -> `b.mi` salta -> era negativo
- bit alto = 0 -> N=0 -> era positivo o cero

```asm
tst x0, x0
b.mi es_negativo
```

## 10. Banderas empaquetadas (uso muy común)

Un solo registro puede guardar varios "interruptores" en sus bits:

```
bit 0 = lectura
bit 1 = escritura
bit 2 = ejecución
```

```asm
tst x0, #1       // ¿tiene lectura?
b.eq sin_lectura

tst x0, #2       // ¿tiene escritura?
b.eq sin_escritura

tst x0, #4       // ¿tiene ejecución?
b.eq sin_ejecucion
```

Esto es lo que hacen los sistemas operativos con los permisos de archivos (rwx).

## 11. Por qué usar `tst` y no `and`

`and x1, x0, #1` calcula lo mismo, pero **guarda el resultado** en un registro. `tst` es para cuando solo te interesa la decisión (saltar o no):

- No gasta registros.
- No destruye datos (tu registro queda intacto).
- Es más corto que hacer `and` + `cmp`.

## 12. Resumen

| Quiero saber... | Máscara | Código |
|---|---|---|
| ¿Es impar? | 1 | `tst x0, #1` + `b.ne` |
| ¿Es par? | 1 | `tst x0, #1` + `b.eq` |
| ¿Está activo el bit n? | 2^n | `tst x0, #(1<<n)` + `b.ne` |
| ¿Es múltiplo de 8? | 7 | `tst x0, #7` + `b.eq` |
| ¿Es cero? | x0 | `tst x0, x0` + `b.eq` |
| ¿Es negativo? | x0 | `tst x0, x0` + `b.mi` |

**Idea central:**

1. Elijo una **máscara** con unos en los bits que me interesan.
2. `tst` hace AND y deja pasar solo esos bits.
3. Si el resultado es **0**, todos esos bits estaban apagados. Si es **distinto de 0**, al menos uno estaba encendido.

## 13. Ejercicio para practicar

¿Con qué máscara revisarías si el **bit 5** está encendido y qué instrucciones usarías?

(Pista: el valor de la posición 5 es 32.)




# Múltiplos de potencias de 2 con `tst`

## Idea principal

Para saber cuántos ceros debe tener al final un número en binario para ser múltiplo de una potencia de 2, se resuelve **2ⁿ = el número**.

Ejemplo: para el 8, 2ⁿ = 8, entonces n = 3 (log₂ 8 = 3). Se usa **logaritmo base 2**, no el natural. Con el natural se llega al mismo resultado haciendo ln(8)/ln(2), pero en la práctica casi nunca se calcula: basta memorizar las potencias de 2 (2, 4, 8, 16, 32...) y ver el exponente.

## La regla (siempre los mismos 3 pasos)

1. Encuentra n tal que 2ⁿ = el número (cuántos ceros debe tener al final).
2. La máscara es **2ⁿ − 1** (n unos seguidos).
3. `tst x0, #máscara` y luego `b.eq` si es múltiplo.

**Importante:** este truco solo funciona para potencias de 2 (2, 4, 8, 16, 32...). Para múltiplos de 3, 5, 10, etc. no sirve y se usa `udiv` + `msub`.

## Tabla de casos

| Múltiplo de | n | Termina en | Máscara |
|---|---|---|---|
| 2 | 1 | 0 | 1 (`1`) |
| 4 | 2 | 00 | 3 (`11`) |
| 8 | 3 | 000 | 7 (`111`) |
| 16 | 4 | 0000 | 15 (`1111`) |
| 32 | 5 | 00000 | 31 (`11111`) |

## Ejemplo 1: ¿es múltiplo de 4? (n = 2, máscara 3)

```
x0 = 12:  1100
máscara:  0011
AND:      0000  -> es 0 -> SÍ es múltiplo de 4   (12 = 4×3 ✓)

x0 = 14:  1110
máscara:  0011
AND:      0010  -> distinto de 0 -> NO es múltiplo   (14 / 4 = 3.5 ✓)
```

```asm
tst x0, #3
b.eq multiplo_de_4
```

## Ejemplo 2: ¿es múltiplo de 8? (n = 3, máscara 7)

```
x0 = 40:  101000
máscara:  000111
AND:      000000  -> es 0 -> SÍ es múltiplo de 8   (40 = 8×5 ✓)

x0 = 44:  101100
máscara:  000111
AND:      000100  -> distinto de 0 -> NO es múltiplo   (44 / 8 = 5.5 ✓)
```

```asm
tst x0, #7
b.eq multiplo_de_8
```

## Ejemplo 3: ¿es múltiplo de 16? (n = 4, máscara 15)

```
x0 = 48:  110000
máscara:  001111
AND:      000000  -> es 0 -> SÍ es múltiplo de 16   (48 = 16×3 ✓)

x0 = 56:  111000
máscara:  001111
AND:      001000  -> distinto de 0 -> NO es múltiplo   (56 / 16 = 3.5 ✓)
```

```asm
tst x0, #15
b.eq multiplo_de_16
```

## Ejemplo 4: ¿es múltiplo de 32? (n = 5, máscara 31)

```
x0 = 96:  1100000
máscara:  0011111
AND:      0000000  -> es 0 -> SÍ es múltiplo de 32   (96 = 32×3 ✓)
```

```asm
tst x0, #31
b.eq multiplo_de_32
```

## Ejemplo completo con código

Revisar si un número es múltiplo de 8 y guardar 1 (sí) o 0 (no) en `x1`:

```asm
    mov  x0, #40          // número a revisar
    tst  x0, #7           // máscara 7 (los 3 bits bajos)
    b.eq si_multiplo      // si el AND dio 0 -> es múltiplo

    mov  x1, #0           // no es múltiplo
    b    fin

si_multiplo:
    mov  x1, #1           // sí es múltiplo

fin:
```

Con `x0 = 40` termina con `x1 = 1`. Si cambias a `x0 = 44`, termina con `x1 = 0`.

## Cómo comprobarlo a mano

Convierte el número a binario y mira los últimos n dígitos:

- **100** = 1100100 -> termina en `00` (2 ceros) -> múltiplo de 4 ✓, pero no de 8 ✗ (le faltaría un cero).
- **64** = 1000000 -> termina en `000000` (6 ceros) -> múltiplo de 2, 4, 8, 16, 32 y 64 ✓.

Un número con más ceros al final es múltiplo de más potencias de 2.

## Ejercicios para practicar

1. ¿Qué máscara usarías para saber si un número es múltiplo de **64**?
2. ¿Es 80 múltiplo de 16? Haz el AND a mano.
3. ¿Es 90 múltiplo de 4? Haz el AND a mano.
