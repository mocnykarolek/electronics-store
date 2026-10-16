with Ada.Text_IO;
use Ada.Text_IO;
with warehouse;


package body robot is
      

      task body Robot_type is
         CurrentProduct : Character;
         ProductAmmount : Integer := 0;
      begin
         
         loop
            select

               accept delivery(ProductType : Character; Ammount : Integer) do 
                  Put_Line ("gegg");
               end delivery;

            or
               accept EndRobot do
                  Put_Line ("Robot o id " & Integer'Image(Id) & " zakonczyl dzialanie.");
                  
               end EndRobot;
               exit;
            or
               delay 1.0;

               Put_Line ("Robot o id" & Integer'Image(Id) & "czeka na prace");
               
               warehouse.warehouse.pickup (Id, 4);
               
               

            end select;
            
         end loop;
         

      end Robot_type;

end robot;