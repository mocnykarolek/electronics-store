with Ada.Text_IO;
use Ada.Text_IO;

package body warehouse is
   Capacity : Integer := 50;
   Space_left : Integer := Capacity;
   task body warehouse is
   
   begin
      loop

      accept pickup (Id : Integer; Ammount : Integer) do
         if Space_left - Ammount > 0 then
            Space_left := Space_left - Ammount;
            Put_Line ("Przyjeto towar. Zostalo: " & Integer'Image(Space_left));


         else
            Put_Line ("Brak miejsca na magazynie(zwrot)" & Integer'Image(Id));
         end if;
         
      end pickup;

      end loop;
   end warehouse;

end warehouse;
