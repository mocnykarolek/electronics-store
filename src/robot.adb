with Ada.Text_IO;
use Ada.Text_IO;
with warehouse;


package body robot is
      

      task body Robot_type is
   
      begin
         
         loop
            select

            accept deliver(Id : Integer; Ammount : Integer) do 
               Put_Line ("gegg");
            end deliver;
            or 
            
            Put_Line ("Robot pracuje o id" & Integer'Image(Id));
            delay 1.0;
            warehouse.warehouse.pickup (Id, 4);
            end select;
         end loop;
         

      end Robot_type;

end robot;