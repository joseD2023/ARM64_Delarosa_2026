/*direccionamiento indirecto  */


.data 

Num: .space 8 // 2222670000FFAADD  

.text  
 adr x0, Num
 ldr x1, [x0]


.data 

Num: .space 2222670000FFAADD 
 adr x0, Num 
 ldr x1, [x0]




 