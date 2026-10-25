
with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Numerics.Discrete_Random;
with Ada.Strings;
with Ada.Strings.Fixed;

with Types;
with Unloading;

package body Delivery is

   task body Samochod is

      subtype Random_Time_Range is Integer range 2 .. 4;

      package Rand_Time is new Ada.Numerics.Discrete_Random
        (Random_Time_Range);

      package Rand_Amount is new Ada.Numerics.Discrete_Random
        (Types.p_ammount);

      package Rand_Product is new Ada.Numerics.Discrete_Random
        (Types.Products_Type);

      Gen_Time    : Rand_Time.Generator;
      Gen_Amount  : Rand_Amount.Generator;
      Gen_Product : Rand_Product.Generator;

      Towar : Types.Dostawa;
      Numer_Dostawy : Positive := 1;

      function Napis(N : Integer) return String is
      begin
         return Ada.Strings.Fixed.Trim
           (Integer'Image(N), Ada.Strings.Both);
      end Napis;

   begin

      Rand_Time.Reset(Gen_Time);
      Rand_Amount.Reset(Gen_Amount);
      Rand_Product.Reset(Gen_Product);

      loop
         select
            accept Zakoncz do
                  Put_Line( "[SAMOCHOD D" & Napis(Numer) & "] Konczy prace");
            end Zakoncz;
            exit;

         or
         -- Losowy czas do kolejnego przyjazdu
         delay Duration(Rand_Time.Random(Gen_Time));

         end select;
         -- Losowanie towaru
         Towar.DostawaType :=
           Rand_Product.Random(Gen_Product);

         Towar.Ammount :=
           Rand_Amount.Random(Gen_Amount);

         -- Okreslenie zajmowanego miejsca
         case Towar.DostawaType is
            when 'A' => Towar.Capacity := 1;
            when 'B' => Towar.Capacity := 2;
            when 'C' => Towar.Capacity := 3;
            when 'D' => Towar.Capacity := 4;
         end case;

         -- Unikalny identyfikator dostawy
         Towar.Id := 3 * (Numer_Dostawy - 1) + Numer;
         Numer_Dostawy := Numer_Dostawy + 1;

         Put_Line(
            "[SAMOCHOD D" & Napis(Numer) &"] Przyjazd dostawy nr " & Napis(Towar.Id) &" | Produkt: " &Types.Products_Type'Image(Towar.DostawaType) & " | Ilosc: " & Napis(Towar.Ammount)
         );

         Put_Line("[SAMOCHOD D" & Napis(Numer) &"] Oczekuje na rozladunek");

         -- Samochod czeka na stanowisko
         loop
            select

               -- Stanowisko przyjelo samochod
               Unloading.Stanowisko.Rozladuj(Towar);

               exit;

            or

               -- Stanowisko nie przyjelo samochodu
               -- w ciagu 1 sekundy
               delay 1.0;

               Put_Line(
                  "[SAMOCHOD D" & Napis(Numer) &
                  "] Stanowisko zajete - nadal oczekuje"
               );

            end select;
         end loop;

         Put_Line("[SAMOCHOD D" & Napis(Numer) &"] Rozladowany, odjezdza");

      end loop;

   end Samochod;

end Delivery;
