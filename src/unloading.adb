
with Ada.Text_IO;
use Ada.Text_IO;

with Types;
with Manager;

package body Unloading is

   task body Stanowisko is
      Towar : Types.Dostawa;
   begin

      loop
         select

            accept Rozladuj(D : in Types.Dostawa) do

               Put_Line(
                  "[ROZLADUNEK] Rozpoczeto D" &
                  Natural'Image(D.Id)
               );

               delay 0.5 + Duration(D.Ammount) * 0.4;

               Put_Line(
                  "[ROZLADUNEK] Zakonczono D" &
                  Natural'Image(D.Id)
               );

               Towar := D;

            end Rozladuj;

            Manager.Manager.Nowa_dostawa(Towar);

         or

            accept Zakoncz do
               Put_Line("[ROZLADUNEK] Stanowisko zamkniete");
            end Zakoncz;

            exit;

         end select;
      end loop;

   end Stanowisko;

end Unloading;
