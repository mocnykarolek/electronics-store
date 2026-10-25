
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Types;
with Warehouse;

package body Klient is

   task body Klient is

      package Losuj_Produkt is new Ada.Numerics.Discrete_Random(Types.Products_Type);
      package Losuj_Ilosc is new Ada.Numerics.Discrete_Random(Types.p_ammount);

      Gen_Produkt : Losuj_Produkt.Generator;
      Gen_Ilosc : Losuj_Ilosc.Generator;

      Numer : Positive := 1;
      Produkt : Types.Products_Type;
      Ilosc : Types.p_ammount;
      Udane : Boolean;

   begin

      Losuj_Produkt.Reset(Gen_Produkt);
      Losuj_Ilosc.Reset(Gen_Ilosc);

      loop
         select
            accept Zakoncz;
            Put_Line("[KLIENT] Koniec pracy");
            exit;
         or
            delay 3.0;
         end select;

         Produkt := Losuj_Produkt.Random(Gen_Produkt);
         Ilosc := Losuj_Ilosc.Random(Gen_Ilosc);

         Put_Line("[KLIENT] Zamowienie nr" & Integer'Image(Numer) &  " produkt " & Types.Nazwa_Produktu(Produkt) & " ilosc" & Integer'Image(Ilosc));

         Warehouse.Warehouse.Zamow(Numer, Produkt, Ilosc, Udane);

         if Udane then
            Put_Line("[KLIENT] Zamowienie nr" & Integer'Image(Numer) & " zrealizowane");
         else
            Put_Line("[KLIENT] Zamowienie nr" & Integer'Image(Numer) & " odrzucone - brak towaru");
         end if;

         Numer := Numer + 1;
      end loop;

   end Klient;

end Klient;
