/* Utilizacion de BIC - borrar bits en especificos  
   BIC: sirve para pagar determiandos bits sin moidficar los demas 
   
   operacion: Rd = Rn ^ ~Operand2  */

   //Eje: 
   mov w1, #15  // 1111
   mov w2, #5   // 0101  -> esta es la mascara qu ele queremos aplicar 
   bic w0, w1,w2 


   /* 
     Aqui seria como inversa es decir tipo cuando son  1 bic 1 = 0 pero si son 1 bic 0 entonces si son 1 
     en pocas palabras si los dos numero son iguales resultado 0 si son diferente resultado 1 o invertimos la mascara 
     tipo si nuestra mascar seri tipo 0 1 0 1 invertimos primero  y nos quedaria tipo  1 0 1 0 entonces al aplicar el AND
     entonces nos daria el resultado que tenemos. 

     
      1 1 1 1 
      0 1 0 1  -> mascara para poder filtrar y asi borrar literalmente los bits que necesitamos quitar
      ________ 
      1 0 1 0  =  10 en decimal  
      
      
      como utilizarlo?  imaginemos que un registro guarda permisos, opciones o estado de un dispositivo. 
      si queremos  desactivar algunas opciones sin tocar las otras, BIC es util.  */
