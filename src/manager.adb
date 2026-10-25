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

      robots_array : robots_array_type(1 .. 3);

      Czy_Wolna_Ladowarka : Boolean := True;
      akt_dostawa : Types.Dostawa;
      robot_stats : Robot_Statuses_Array_Type(1 .. 3);
      Repair_ID : Integer := -1;
      END_Timer : Integer := -1;
      begin
            for i in robots_array'Range loop
               robots_array(i) := new robot.Robot_type(Id => i);
               robot_stats(i) := Types.IDLE;
            end loop;

            loop
               select
                  accept Nowa_dostawa(D : Types.Dostawa) do
                     akt_dostawa := D;
                  end Nowa_dostawa;
                  if END_Timer < 0 then
                     for i in robots_array'Range loop
                        if robot_stats(i) = Types.IDLE then
                           robots_array(i).odbior (akt_dostawa);
                           robot_stats(i) := Types.UNLOADING;
                           exit;
                        end if;
                     end loop;
                  end if;


               or
                  accept Status(r_status : Types.Robot_Status; Id : Integer) do
                     Repair_ID := -1;
                     robot_stats(Id) := r_status;
                     if r_status = Types.CRASH then
                        Repair_ID := Id;
                     end if;
                  end Status;
                  if Repair_ID /= -1 and END_Timer < 0 then
                     robots_array(Repair_ID).naprawa;
                  end if;
               
               or
                  accept Wolna_Ladowarka_State (stan : Boolean) do
                     Czy_Wolna_Ladowarka := stan;
                  end Wolna_Ladowarka_State;
               or
                  accept Zakoncz;
                     Put_Line ("-----------koniec------------");
                     END_Timer := 9;
               end select;

               for i in robots_array'Range loop
                  if Czy_Wolna_Ladowarka = True then
                     if robot_stats(i) = Types.DISCHARGED then
                        Czy_Wolna_Ladowarka := False;
                        robots_array(i).DostempDoLadowania;
                     end if;
                  end if;
               end loop;

               if END_Timer > 0 then
                  delay 0.2;
                  END_Timer := END_Timer - 1;
                  Put_Line(Integer'Image(END_Timer));
               end if;
               if END_Timer = 0 then
                  for i in robots_array'Range loop
                     robots_array(i).EndRobot;
                  end loop;
                  Exit;
               end if;

            end loop;

      end manager;

         
   --  przyjmowanie samochodow

end manager;