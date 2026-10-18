with Ada.Text_IO;
use Ada.Text_IO;
with robot;
with Types;

package body manager is

      task body manager is
      akt_dostawa : Types.Dostawa;
      begin

            loop
               select
                  accept Nowa_dostawa(D : Types.Dostawa) do
                     akt_dostawa := D;
                  end Nowa_dostawa;


               or
                  accept Zakoncz;
                  





               end select;
            end loop;

      end manager;

         
   --  przyjmowanie samochodow

end manager;