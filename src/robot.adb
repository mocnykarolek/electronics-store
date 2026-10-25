with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with warehouse;
with Types;
with manager;
use type Types.Robot_Status;

package body robot is
   task body Robot_type is
      current_product : Types.Dostawa;
      current_robot_status : Types.Robot_Status := Types.IDLE;
      warehouse_return_code : Integer;
      subtype random_crash_chance is Integer range 1 .. 5;
      package Losowanie is new Ada.Numerics.Discrete_Random(random_crash_chance);
      Gen : Losowanie.Generator;
      x : random_crash_chance;
      Flaga_Statusu : Boolean := false;
   begin
      Losowanie.Reset(Gen);
      loop
         select
            when current_robot_status = Types.IDLE =>
               accept odbior(d : Types.Dostawa) do
                  current_product := d;
                  current_robot_status := Types.UNLOADING;
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
               current_robot_status := Types.IDLE;
               x := losowanie.Random(Gen);
               if x = 1 then
                  Put_Line ("[R" & Integer'Image(Id) & "] ulegl awarii");
                  current_robot_status := Types.CRASH;
               end if;
               manager.manager.Status (current_robot_status, Id);
         or
            when current_robot_status = Types.CRASH =>
               accept naprawa do
                  current_robot_status := Types.IDLE;
               end naprawa;
               delay 5.0;
               manager.manager.Status(current_robot_status, Id);
               Put_Line ("[R" & Integer'Image(Id) & "] zostal naprawiony");
         or
            delay 1.0;
            Put_Line ("[R" & Integer'Image(Id) & "] czeka na dostawe");
         or
            accept EndRobot do
               Put_Line ("[R" & Integer'Image(Id) & "] zakonczyl dzialanie.");
            end EndRobot;
            exit;
         end select;
      end loop;
   end Robot_type;

end robot;