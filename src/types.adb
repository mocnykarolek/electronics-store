
package body Types is

   function Nazwa_Produktu(P : Products_Type) return String is
   begin
      case P is
         when 'A' => return "Ladowarka";
         when 'B' => return "Telefon";
         when 'C' => return "Komputer";
         when 'D' => return "Lodowka";
      end case;
   end Nazwa_Produktu;

end Types;
