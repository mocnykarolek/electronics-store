with Ada.Text_IO;
use Ada.Text_IO;
with robot;
with Types;
use type Types.Robot_Status;
package body manager is


      task body manager is
      type robot_access is access robot.Robot_type;
      type robots_array_type is array (positive range <>) of robot_access;
      type Robot_Statuses_Array_Type is array (positive range <>) of Types.Robot_Status;

      robots_array : robots_array_type(1 .. 4);

      akt_dostawa : Types.Dostawa;
      robot_stats : Robot_Statuses_Array_Type(1 .. 4);
      begin
            accept Start;

            for i in robots_array'Range loop
               robots_array(i) := new robot.Robot_type(Id => i);
               robot_stats(i) := Types.IDLE;
            end loop;

            loop
               select
                  accept Nowa_dostawa(D : Types.Dostawa) do
                     akt_dostawa := D;
                  end Nowa_dostawa;
                  for i in robots_array'Range loop
                     if robot_stats(i) = Types.IDLE then
                        robots_array(i).odbior (akt_dostawa);
                        exit;
                     end if;
                     
                  end loop;


               or

                  accept Status(r_status : Types.Robot_Status; Id : Integer) do
                     robot_stats(Id) := r_status;
                  end Status;

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