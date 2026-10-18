with Ada.Text_IO;
use Ada.Text_IO;


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



   procedure print_warehouse_status is
   begin 
      Put_Line ("#####################################################################################################################################################");
      Put_Line (" Produktów A jest : " & Integer'Image(warehouse_state_var.A_ammount) & " i zajmują " & Integer'Image(warehouse_state_var.A_ammount*1) & " miejsca.");
      Put_Line (" Produktów B jest : " & Integer'Image(warehouse_state_var.B_ammount) & " i zajmują " & Integer'Image(warehouse_state_var.B_ammount*2) & " miejsca.");
      Put_Line (" Produktów C jest : " & Integer'Image(warehouse_state_var.C_ammount) & " i zajmują " & Integer'Image(warehouse_state_var.C_ammount*3) & " miejsca.");
      Put_Line (" Produktów D jest : " & Integer'Image(warehouse_state_var.D_ammount) & " i zajmują " & Integer'Image(warehouse_state_var.D_ammount*4) & " miejsca.");
      Put_Line ("#####################################################################################################################################################");

   end print_warehouse_status;

   begin

      loop
            select
               
               accept pickup (dostawa: types.Dostawa) do
                  if Space_left - dostawa.Ammount*dostawa.Capacity >= 0 then
                     selected_type : Types.Products_Type;
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

                     Put_Line ("Przyjeto: " & Integer'Image(dostawa.Ammount) & " produktów typu" & Types.Products_Type'Image(selected_type) & ". W magazynie zostało : " & Integer'Image(Space_left) & " miejsca.");
                  else
                     Put_Line("Brak miejsca na magazynie");


                  end if;

                  

               end pickup;
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
