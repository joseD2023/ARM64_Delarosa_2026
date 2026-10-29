/* 
  Cargar constantes. Escribe las instrucciones mínimas (usando movz/movk) para cargar en x2 el valor 0x00A100000000BEEF. 
  Explica qué hace movz y qué hace movk, y por qué no se puede hacer con un solo mov.

  | Bits 63-48  |  Bits 47-32    | Bits 31-16    |  Bits 15-0   | 
  | 0 0 A 1     |  0 0 0 0       | 0 0 0 0       |   0 0 0 0    | 


 */

  movz x0, #0x0000
  movk x0, #0x0000, lsl #16 
  movk x0, #0x0000, lsl #32 
  movk x0, #0x00A1, lsl #48  