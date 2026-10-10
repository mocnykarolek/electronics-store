with Ada.Text_IO;
use Ada.Text_IO;

package body warehouse is

   task body Warehouse is
   
   begin
      loop
      
      accept pickup do
         Put_Line ("test");
      end pickup;

      end loop;
   end warehouse;


end warehouse;