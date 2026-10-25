
with Ada.Text_IO;
use Ada.Text_IO;

package body charger is

   task body charger is
   begin

      loop
         select

            accept Ladowanie(ID : Integer) do

               Put_Line(
                  "[LADOWARKA] Robot R" &
                  Integer'Image(ID) &
                  " rozpoczal ladowanie"
               );

               delay 5.0;

               Put_Line(
                  "[LADOWARKA] Robot R" &
                  Integer'Image(ID) &
                  " zakonczyl ladowanie"
               );

            end Ladowanie;

         or

            accept Zakoncz do
               Put_Line(
                  "[LADOWARKA] Koniec pracy"
               );
            end Zakoncz;

            exit;

         end select;
      end loop;

   end charger;

end charger;
