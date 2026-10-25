
with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Numerics.Discrete_Random;
with warehouse;
with Types;
with manager;
with charger;

use type Types.Robot_Status;

package body robot is

   task body Robot_type is

      Charge : Integer := 100;
      Current_Product : Types.Dostawa;
      Current_Status : Types.Robot_Status := Types.IDLE;
      Warehouse_Return_Code : Integer;

      subtype Crash_Chance is Integer range 1 .. 5;

      package Losowanie is new Ada.Numerics.Discrete_Random
        (Crash_Chance);

      Gen : Losowanie.Generator;

   begin

      Losowanie.Reset(Gen);

      loop

         -- AWARIA ROBOTA
         if Current_Status = Types.CRASH then

            Put_Line(
               "[R" & Integer'Image(Id) &
               "] Rozpoczeto naprawe"
            );

            delay 5.0;

            Put_Line(
               "[R" & Integer'Image(Id) &
               "] Naprawa zakonczona"
            );

            if Charge <= 55 then
               Current_Status := Types.DISCHARGED;
            else
               Current_Status := Types.IDLE;
            end if;

            manager.manager.Status(Current_Status, Id);

         -- LADOWANIE ROBOTA
         elsif Current_Status = Types.DISCHARGED then

            Put_Line(
               "[R" & Integer'Image(Id) &
               "] Oczekuje na ladowarke"
            );

            charger.charger.Ladowanie(Id);

            Charge := 100;
            Current_Status := Types.IDLE;

            Put_Line(
               "[R" & Integer'Image(Id) &
               "] Bateria: " & Integer'Image(Charge)
            );

            manager.manager.Status(Current_Status, Id);

         -- ROBOT WOLNY
         else

            select

               accept odbior(D : Types.Dostawa) do

                  Current_Product := D;
                  Current_Status := Types.TRANSPORTATION;

                  Charge := Charge - D.Ammount * 8;

                  Put_Line(
                     "[R" & Integer'Image(Id) &
                     "] Odebral towar. Bateria:" &
                     Integer'Image(Charge)
                  );

               end odbior;

               delay 1.0;

               Put_Line(
                  "[R" & Integer'Image(Id) &
                  "] Transport do magazynu"
               );

               delay 2.0;

               warehouse.warehouse.pickup(
                  Current_Product,
                  Warehouse_Return_Code
               );

               if Warehouse_Return_Code = 1 then
                  Put_Line(
                     "[R" & Integer'Image(Id) &
                     "] Magazyn odrzucil dostawe"
                  );
                  delay 2.0;
               end if;

               -- LOSOWANIE AWARII
               if Losowanie.Random(Gen) = 1 then

                  Current_Status := Types.CRASH;

                  Put_Line(
                     "[R" & Integer'Image(Id) &
                     "] AWARIA!"
                  );

               -- SPRAWDZENIE BATERII
               elsif Charge <= 55 then

                  Current_Status := Types.DISCHARGED;

                  Put_Line(
                     "[R" & Integer'Image(Id) &
                     "] Niski poziom baterii!"
                  );

               else

                  Current_Status := Types.IDLE;

               end if;

               manager.manager.Status(Current_Status, Id);

            or

               delay 1.0;

               Put_Line(
                  "[R" & Integer'Image(Id) &
                  "] Czeka na dostawe. Bateria:" &
                  Integer'Image(Charge)
               );

            or

               accept EndRobot do
                  Put_Line(
                     "[R" & Integer'Image(Id) &
                     "] Zakonczyl dzialanie"
                  );
               end EndRobot;

               exit;

            end select;

         end if;

      end loop;

   end Robot_type;

end robot;
