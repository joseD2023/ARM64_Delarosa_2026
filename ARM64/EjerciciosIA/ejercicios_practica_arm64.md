# Ejercicios de práctica ARM64 (Capítulos 1 a 4)

Dos ejercicios del libro (4.8 y 4.9) y tres al estilo del inge (A, B y C). Solo usan los capítulos 1 a 4: sin subrutinas.

**Cómo probarlos en gdb sin hardware:** detén el programa en una etiqueta justo antes de leer la entrada y escribe el valor a mano, por ejemplo `set $x4 = 0x34`. Luego avanza y revisa la salida con `info registers x5`.

---

## Del libro

### Ejercicio 4.8

Sin usar ninguna instrucción `mul`, dé las instrucciones para multiplicar **x3** por las siguientes constantes, dejando el resultado en **x0**. Puede usar también x1 y x2 para resultados temporales, y no necesita conservar el contenido original de x3.

a. 10
b. 100
c. 575
d. 123

**Pistas:**

- Descompón cada constante en sumas y restas de potencias de 2 (por ejemplo, 7 = 8 − 1).
- El segundo operando desplazado de `add` y `sub` hace "sumar un múltiplo" en una sola instrucción. Busca usar pocas instrucciones.

**Verifica con x3 = 3:**

| Constante | Resultado en x0 |
|---|---|
| 10 | 30 |
| 100 | 300 |
| 575 | 1725 |
| 123 | 369 |

### Ejercicio 4.9

Suponga que **x0** guarda los 64 bits menos significativos de un entero de 128 bits **a**, y **x1** guarda los 64 bits más significativos. Igualmente, **x2** guarda los 64 bits menos significativos de un entero de 128 bits **b**, y **x3** los más significativos.

Muestre las secuencias de instrucciones **más cortas** para:

a. comparar a con b, actualizando las banderas de PSTATE,
b. desplazar a una posición a la izquierda y guardar el resultado en b,
c. sumar b a a,
d. restar b de a.

**Pistas:**

- Sumar 128 bits: suma las mitades bajas con una instrucción que deje el acarreo, y las altas con una instrucción que lo use (`adds` y `adc`).
- Restar y comparar 128 bits: la pareja equivalente para la resta (`subs` y `sbcs`). La comparación es una resta cuyo resultado se descarta.
- Desplazar 1 bit a la izquierda es multiplicar por 2, y multiplicar por 2 es sumar el número consigo mismo. Piensa en cómo pasar el bit que sale de la mitad baja a la mitad alta.

**Verifica con a = 0x1_FFFFFFFFFFFFFFFF (x1 = 1, x0 = todos unos) y b = 1 (x3 = 0, x2 = 1):**

| Operación | Resultado |
|---|---|
| a > b | sí |
| a << 1 | `0x3_FFFFFFFFFFFFFFFE` |
| a + b | `0x2_0000000000000000` |
| a − b | `0x1_FFFFFFFFFFFFFFFE` |

**Nota sobre el ejercicio de X0 × 5 del inge:** las instrucciones y los pasos que copiaste no coinciden. Dos desplazamientos (`lsl #1` y `lsl #2`) darían x0 × 8, y no aparece la suma final. Cópialo de nuevo de tu cuaderno. Por la nota "x0 × 4: x1 (64 bits MS) : x0 (64 bits LS)", parece que el inge guarda en x1 el posible desborde a 128 bits.

---

## Estilo del inge

### Ejercicio A: Alarma de una bodega

Diseñar un programa en ARM64 que controle la alarma de una bodega. Los sensores se leen **recurrentemente** en el registro **X0**, que se actualiza por medios externos, y las salidas se escriben en **X1**:

| Registro | D3 | D2 | D1 | D0 |
|---|---|---|---|---|
| **X0** (entradas) | ARM | MOV | VEN | PUE |
| **X1** (salidas) | | | LUZ | SIR |

- **Entradas:** ARM = 1 sistema armado; MOV = 1 movimiento detectado; VEN = 1 ventana abierta; PUE = 1 puerta abierta.
- **Sirena (SIR):** vale 1 si el sistema está **armado** y **al menos uno** de PUE, VEN o MOV vale 1.
- **Luz "listo para armar" (LUZ):** vale 1 si el sistema está **desarmado** y la puerta y la ventana están **cerradas**. El movimiento no afecta a esta luz.
- Los demás bits de X0 pertenecen a otros dispositivos y **no deben afectar** el resultado. Los demás bits de X1 deben quedar en **0**.

**Restricciones:** use filtrado con máscaras (AND, ORR) y no use `cmp`.

**Casos de prueba:**

| X0 | X1 |
|---|---|
| 0x00 | 2 |
| 0x01 | 0 |
| 0x04 | 2 |
| 0x08 | 0 |
| 0x09 | 1 |
| 0x0A | 1 |
| 0x0C | 1 |
| 0x0F | 1 |
| 0xF0 | 2 |
| 0xA8 | 0 |

---

### Ejercicio B: Contador de cajas en una banda

Una banda transportadora tiene un sensor que vale 1 mientras una caja pasa frente a él. El programa lee **recurrentemente** X0 (cada vuelta del lazo es una **lectura**) y escribe en X1:

| Registro | D1 | D0 |
|---|---|---|
| **X0** | PARO | SEN |
| **X1** | | LOTE |

**Reglas:**

1. Una caja se cuenta **solo cuando el sensor pasa de 0 a 1** (flanco de subida). Mientras el sensor se mantenga en 1, no se vuelve a contar.
2. Al contar la **4.ª caja**, LOTE vale 1 **únicamente en esa lectura**, y el contador vuelve a 0. En cualquier otra lectura, LOTE vale 0.
3. Si PARO = 1: el contador se pone en 0, LOTE vale 0 y no se cuenta ninguna caja.
4. El valor anterior del sensor se actualiza en **todas** las lecturas, incluso durante el paro. Al inicio vale 0.
5. Los demás bits de X0 deben ignorarse.

**Casos de prueba** (cada fila es una lectura consecutiva):

| Lectura | X0 | Contador al terminar | LOTE |
|---|---|---|---|
| 0 | 0x00 | 0 | 0 |
| 1 | 0x01 | 1 | 0 |
| 2 | 0x01 | 1 | 0 |
| 3 | 0x00 | 1 | 0 |
| 4 | 0x01 | 2 | 0 |
| 5 | 0x00 | 2 | 0 |
| 6 | 0x01 | 3 | 0 |
| 7 | 0x01 | 3 | 0 |
| 8 | 0x00 | 3 | 0 |
| 9 | 0x01 | 0 | 1 |
| 10 | 0x01 | 0 | 0 |
| 11 | 0x00 | 0 | 0 |
| 12 | 0x01 | 1 | 0 |
| 13 | 0x03 | 0 | 0 |
| 14 | 0x01 | 0 | 0 |
| 15 | 0x00 | 0 | 0 |
| 16 | 0x01 | 1 | 0 |
| 17 | 0xF1 | 1 | 0 |
| 18 | 0xF0 | 1 | 0 |
| 19 | 0xF1 | 2 | 0 |

**Pregunta:** ¿por qué contar cada lectura con SEN = 1 daría resultados incorrectos? Use la lectura 2 como ejemplo.

---

### Ejercicio C: Display de 7 segmentos

Diseñar un programa que maneje un display de 7 segmentos (lógica positiva, 1 = encendido). La entrada se lee **recurrentemente** en los 4 bits menos significativos de **X4** (D3 a D0, valor de 0 a 15) y la salida se escribe en los 8 bits menos significativos de **X5**:

| Bit de X5 | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 |
|---|---|---|---|---|---|---|---|---|
| Segmento | a | b | c | d | e | f | g | punto |

**Segmentos encendidos por dígito:**

| Dígito | Segmentos |
|---|---|
| 0 | a b c d e f |
| 1 | b c |
| 2 | a b d e g |
| 3 | a b c d g |
| 4 | b c f g |
| 5 | a c d f g |
| 6 | a c d e f g |
| 7 | a b c |
| 8 | a b c d e f g |
| 9 | a b c d f g |

**Reglas adicionales:**

- Si la entrada es de **10 a 15**, todo el display se apaga, **incluido el punto**.
- El **punto decimal** se enciende si el dígito es **impar** (y es válido).
- Los demás bits de X4 son de otros dispositivos y se ignoran. Los demás bits de X5 deben quedar en 0.

**Restricciones:** guarde la tabla de segmentos en memoria, acceda a ella por **índice** con el modo de registro desplazado del capítulo 3, valide el rango con `cmp` y un salto condicional, y detecte lo impar revisando un bit directamente.

**Casos de prueba:**

| X4 | X5 |
|---|---|
| 0x00 | 0x3F |
| 0x01 | 0x86 |
| 0x02 | 0x5B |
| 0x07 | 0x87 |
| 0x08 | 0x7F |
| 0x09 | 0xEF |
| 0x0A | 0x00 |
| 0x0F | 0x00 |
| 0xF5 | 0xED |
| 0x34 | 0x66 |
| 0x3C | 0x00 |

**Pregunta:** ¿por qué hay que filtrar X4 antes de usarlo como índice de la tabla?
