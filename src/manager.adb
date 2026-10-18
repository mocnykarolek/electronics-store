with Ada.Text_IO;
use Ada.Text_IO;
with robot;
with Types;
use type robot.Robot_Status;
package body manager is


      task body manager is
      type robot_access is access robot.Robot_type;
      type robots_array_type is array (positive range <>) of robot_access;

      robots_array : robots_array_type(1 .. 4);

      akt_dostawa : Types.Dostawa;
      robot_stat : robot.Robot_Status;
      begin
            for i in robots_array'Range loop
               robots_array(i) := new robot.Robot_type(Id => i);
            end loop;

            loop
               select
                  accept Nowa_dostawa(D : Types.Dostawa) do
                     akt_dostawa := D;
                  end Nowa_dostawa;
                  for i in robots_array'Range loop
                     robots_array(i).Status (robot_stat);
                     if robot_stat = robot.IDLE then
                        robots_array(i).odbior (akt_dostawa);
                        exit;
                     end if;
                     
                  end loop;



               or
                  accept Zakoncz;
                  for i in robots_array'Range loop
                     robots_array(i).EndRobot;
                  end loop;
                  Exit;




               end select;
            end loop;

      end manager;

         
   --  przyjmowanie samochodow

end manager;