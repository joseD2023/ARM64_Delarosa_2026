int x;
int y;
int z;

/*
 STACK
 sp/base
   ↓
 [ x ]  ← 0 bytes
 [ y ]  ← 4 bytes
 [ z ]  ← 8 bytes

 ldr w0, [sp, #4] // w0 <- y 
 ldr w0, [sp, #8] // w0 <- z 
 ldr w0, [sp, #0] // w0 <- x  

*/



