with Ada.Text_IO;
use Ada.Text_IO;
with tools;
use tools;
with robot;
use robot;
with delivery;
use deliver;

procedure Shop is
   type Dostawa is record
      Id: Integer;
      

   end record;

   Dos: Dostawa;
   d1 : deliver_type;
   

   R1 : Robot_type(1);
   R2 : Robot_type(2);
   R3 : Robot_type(3);
   R4 : Robot_type(4);
   

   Result: Integer := Add(3,5);
begin
   Dos.Id := 1;
   Put_Line ("Test");

   
   Print(Dos.Id);

   null;
end Shop;
