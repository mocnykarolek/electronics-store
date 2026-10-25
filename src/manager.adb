
with Ada.Text_IO;
use Ada.Text_IO;

with Robot;
with Types;
with Charger;
with Warehouse;

use type Types.Robot_Status;

package body manager is

   task body manager is

      type Robot_Access is access Robot.Robot_type;

      type Robots_Array_Type is
        array (Positive range <>) of Robot_Access;

      type Statuses_Array_Type is
        array (Positive range <>) of Types.Robot_Status;

      Robots_Array : Robots_Array_Type(1 .. 3);
      Robot_Stats : Statuses_Array_Type(1 .. 3);

      Akt_Dostawa : Types.Dostawa;
      Dostawa_Czeka : Boolean := False;
      Zamykanie : Boolean := False;

      -- Czy wszystkie roboty sa wolne?
      function Wszystkie_Wolne return Boolean is
      begin
         for I in Robot_Stats'Range loop
            if Robot_Stats(I) /= Types.IDLE then
               return False;
            end if;
         end loop;

         return True;
      end Wszystkie_Wolne;

   begin

      -- Tworzenie robotow
      for I in Robots_Array'Range loop
         Robots_Array(I) :=
           new Robot.Robot_type(Id => I);

         Robot_Stats(I) := Types.IDLE;
      end loop;

      loop

         select

            -- Nowe dostawy
            when not Dostawa_Czeka and not Zamykanie =>
               accept Nowa_dostawa(D : Types.Dostawa) do

                  Akt_Dostawa := D;
                  Dostawa_Czeka := True;

                  Put_Line(  "[MANAGER] Dostawa" & Natural'Image(D.Id) & " oczekuje na robota" );

               end Nowa_dostawa;

         or

            -- Aktualizacja statusu robota
            accept Status( r_status : Types.Robot_Status; Id : Integer  ) do

               Robot_Stats(Id) := r_status;

               Put_Line( "[MANAGER] R" & Integer'Image(Id) & " status: " & Types.Robot_Status'Image(r_status) );

            end Status;

         or

            -- Rozpoczecie zamykania
            when not Zamykanie =>
               accept Zakoncz do

                  Zamykanie := True;

                  Put_Line( "[MANAGER] Rozpoczynam zamykanie");

               end Zakoncz;

         or

            delay 0.1;

         end select;

         -- Przydzielanie oczekujacej dostawy
         if Dostawa_Czeka then

            for I in Robots_Array'Range loop

               if Robot_Stats(I) = Types.IDLE then

                  select

                     Robots_Array(I).odbior(Akt_Dostawa);

                     Robot_Stats(I) :=
                       Types.TRANSPORTATION;

                     Dostawa_Czeka := False;

                     Put_Line(  "[MANAGER] Przydzielono dostawe" &   Natural'Image(Akt_Dostawa.Id) &  " robotowi R" & Integer'Image(I) );

                     exit;

                  else
                     null;
                  end select;

               end if;

            end loop;

         end if;

         -- Koniec dopiero po obsluzeniu dostaw
         -- i zwolnieniu wszystkich robotow
         if Zamykanie
           and then not Dostawa_Czeka
           and then Wszystkie_Wolne
         then
            exit;
         end if;

      end loop;

      Put_Line(
         "[MANAGER] Wszystkie transporty zakonczone"
      );

      -- Zatrzymanie robotow
      for I in Robots_Array'Range loop

         Robots_Array(I).EndRobot;

         Put_Line(
            "[MANAGER] Zatrzymano robota R" &
            Integer'Image(I)
         );

      end loop;

      -- Teraz nikt nie korzysta z ladowarki
      -- ani magazynu
      Charger.charger.Zakoncz;
      Warehouse.warehouse.Zakoncz;

      Put_Line(
         "[MANAGER] Wszystkie zadania zatrzymane"
      );

      -- Potwierdzenie dla programu glownego
      accept Gotowe;

   end manager;

end manager;
