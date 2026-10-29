/* 
  Utilizacion CMP donde compara dos valores y afecta a las banderas NZVC  
  entonces lo que tenemos que imaginar es esta parte que comprueba si un numero 
  es mayor, menor o igual que otro.  */

  mov w1, #10 
  mov w2, #5 
  cmp w1, w2 

  /* 
    Aunque escribamos CMP internamente se comporta como una resta 
      10 - 5  = 5 
    pero prestemos atencion a esto no se guarda en ningun registro lo que se actualiza son las banderas 
    
    | bandera  |  significado 
    |  Z       |  zero: el resultado es cero 
    |  N       |  Negative: el resultado tiene el bit de signo activado 
    |  C       |  Carry: indica codnicones de acarreo; tambien permite determinar coparaciones sin signo 
    |  V       |  Overflow:  indica desbordamiento aritmetico con signo  */

 mov w1, #10 
 mov w2, #10 
 cmp w1, w2  

 /* La resta es 10 - 10 = 0 por lo que la bandera Z queda activada eso permite que la comparacion tome 
 una decision.  */

 
 mov w1, #10 
 mov w2, #10 
 cmp w1, w2  
 b.eq iguales  //salta a la etiqueta iguales si los valores comparados son iguales es decir si Z = 1 
 

