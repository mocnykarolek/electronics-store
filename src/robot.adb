with Ada.Text_IO;
use Ada.Text_IO;
with Warehouse;

package body robot is
      

      task body Robot_type is
   
      begin
         
         loop
            Put_Line ("Robot pracuje o id" & Integer'Image(Id));
            delay 1.0;
            

         end loop;
         

      end Robot_type;

end robot;