with Ada.Text_IO;
use Ada.Text_IO;
with warehouse;
with Types;

package body robot is
   task body Robot_type is
      current_product : Types.Dostawa;
      current_robot_status : Robot_Status := IDLE;
      warehouse_return_code : Integer;
   begin
      loop
         select
            when current_robot_status = IDLE =>
               accept odbior(d : Types.Dostawa) do
                  current_product := d;
                  current_robot_status := UNLOADING;
                  Put_Line ("[R" & Integer'Image(Id) & "] Odbiera produkt przez 1 sec");
               end odbior;
               delay 1.0;
               Put_Line ("[R" & Integer'Image(Id) & "] transportuje do magazynu");
               delay 2.0;
               warehouse.warehouse.pickup (current_product, warehouse_return_code);
               if warehouse_return_code = 1 then
                  Put_Line ("MAGAZYN dokonal zwrotu");
                  delay 2.0;
               end if;
               current_robot_status := IDLE;
         or
            accept Status(r_status : out Robot_Status) do
               r_status := current_robot_status;
            end Status;
         or
            delay 1.0;
            Put_Line ("[R" & Integer'Image(Id) & "] czeka na prace");
         or
            accept EndRobot do
               Put_Line ("[R" & Integer'Image(Id) & "] zakonczyl dzialanie.");
            end EndRobot;
            exit;
         end select;
      end loop;
   end Robot_type;

end robot;