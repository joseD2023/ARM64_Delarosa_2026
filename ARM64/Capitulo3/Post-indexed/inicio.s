/*La forma de implementarlo es:  */

ldr w0, [x1], #4 

/*La direncia clave es la particion del orden de los datos donde en: 
 POST-INDEXADO  
 basicamente su funcionamiento es que primero carga el valor al registro w0  
 - luego de hacerlo se desplaza x1 = x1 + 4  
 - En esta parte lo que tenemos que ver es que x1 si se actualiza y no regresa a su estado normal 
  es una sintaxis diferente pero que tiene el mismo funcionamiento
 
 
 a diferencia del pre-indexado que primero se desplazaba 
 - luego cargaba el numero tenerlo en cuenta  */

 