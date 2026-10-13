with Ada.Text_IO;
use Ada.Text_IO;
with robot;


package body deliver is
      

      task body deliver_type is
   
      begin
         
         loop
            robot.Robot_type.deliver(4, 4);
            

            

         end loop;
         

      end deliver_type;

end deliver;