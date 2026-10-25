with Ada.Text_IO;
use Ada.Text_IO;
with Types;
use type Types.Products_Type;

package body warehouse is
   task body warehouse is
      type warehouse_state is record
      A_ammount : Integer :=0;
      B_ammount : Integer :=0;
      C_ammount : Integer :=0;
      D_ammount : Integer :=0;

   end record;

   warehouse_state_var : warehouse_state;
   Capacity : Integer := 50;
   Space_left : Integer := Capacity;
   selected_type : Types.Products_Type;
   Dostepne: Integer;

   procedure print_warehouse_status is
   begin 
      Put_Line ("#####################################################################################################################################################");
      Put_Line (" Produktow Ladowarki jest : " & Integer'Image(warehouse_state_var.A_ammount) & " i zajmuja " & Integer'Image(warehouse_state_var.A_ammount*1) & " miejsca.");
      Put_Line (" Produktow Telefony jest : " & Integer'Image(warehouse_state_var.B_ammount) & " i zajmuja " & Integer'Image(warehouse_state_var.B_ammount*2) & " miejsca.");
      Put_Line (" Produktow Komputery jest : " & Integer'Image(warehouse_state_var.C_ammount) & " i zajmuja " & Integer'Image(warehouse_state_var.C_ammount*3) & " miejsca.");
      Put_Line (" Produktow Lodowki jest : " & Integer'Image(warehouse_state_var.D_ammount) & " i zajmuja " & Integer'Image(warehouse_state_var.D_ammount*4) & " miejsca.");
      Put_Line ("#####################################################################################################################################################");

   end print_warehouse_status;


   begin

      loop
            select
               
               accept pickup (dostawa: types.Dostawa; retCode : out Integer ) do
                  if Space_left - dostawa.Ammount*dostawa.Capacity >= 0 then
                     
                     if dostawa.DostawaType = 'A' then
                        selected_type := 'A';
                        warehouse_state_var.A_ammount := warehouse_state_var.A_ammount + dostawa.Ammount;
                        
                     elsif dostawa.DostawaType = 'B' then
                        selected_type := 'B';
                        warehouse_state_var.B_ammount := warehouse_state_var.B_ammount + dostawa.Ammount;
                     elsif dostawa.DostawaType = 'C' then
                        selected_type := 'C';
                        warehouse_state_var.C_ammount := warehouse_state_var.C_ammount + dostawa.Ammount;
                     elsif dostawa.DostawaType = 'D' then
                        selected_type := 'D';
                        warehouse_state_var.D_ammount := warehouse_state_var.D_ammount + dostawa.Ammount;
                     end if;
                     Space_left := Space_left - dostawa.Ammount*dostawa.Capacity;

                     Put_Line ("Przyjeto: " & Integer'Image(dostawa.Ammount) & " produktow typu" & Types.Nazwa_Produktu(selected_type) & ". W magazynie zostalo : " & Integer'Image(Space_left) & " miejsca.");
                     retCode := 0;
                  else
                     Put_Line("Brak miejsca na magazynie. ZWROT");
                     retCode :=1;


                  end if;

                  

               end pickup;
            
            or
                  accept Zamow(Numer : Positive; Produkt : Types.Products_Type; Ilosc : Types.p_ammount; Udane : out Boolean) do

                     case Produkt is
                        when 'A' => Dostepne := warehouse_state_var.A_ammount;
                        when 'B' => Dostepne := warehouse_state_var.B_ammount;
                        when 'C' => Dostepne := warehouse_state_var.C_ammount;
                        when 'D' => Dostepne := warehouse_state_var.D_ammount;
                     end case;

                     if Dostepne >= Ilosc then

                        case Produkt is
                           when 'A' =>
                              warehouse_state_var.A_ammount := warehouse_state_var.A_ammount - Ilosc;
                              Space_left := Space_left + Ilosc;
                           when 'B' =>
                              warehouse_state_var.B_ammount := warehouse_state_var.B_ammount - Ilosc;
                              Space_left := Space_left + Ilosc * 2;
                           when 'C' =>
                              warehouse_state_var.C_ammount := warehouse_state_var.C_ammount - Ilosc;
                              Space_left := Space_left + Ilosc * 3;
                           when 'D' =>
                              warehouse_state_var.D_ammount := warehouse_state_var.D_ammount - Ilosc;
                              Space_left := Space_left + Ilosc * 4;
                        end case;

                        Udane := True;
                     else
                        Udane := False;
                     end if;

                  end Zamow;

            or
               accept check_warehouse_state(sta : out Integer) do
                  sta := Space_left;

               end check_warehouse_state;
               print_warehouse_status;
               
            or
               accept Zakoncz;
               Exit;



            end select;
      end loop;



   end warehouse;

end warehouse;
