with Ada.Text_IO;
use Ada.Text_IO;
with robot;
with manager;

package body charger is
   task body charger is
   
   begin
      loop
         accept Ladowanie(ID : Integer) do
            Put_Line ("[R" & Integer'Image(ID) & "] laduje sie");
            delay 5.0;
            Put_Line ("[R" & Integer'Image(ID) & "] zostal naladowany");
         end Ladowanie;
         manager.manager.Wolna_Ladowarka_State(True);
      end loop;
   end charger;
end charger;