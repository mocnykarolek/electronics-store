with Ada.Text_IO;
use Ada.Text_IO;
with tools;
use tools;



procedure Shop is
   type Dostawa is record
      Id: Integer;
      

   end record;

   Dos: Dostawa;
   
   

   

   Result: Integer := Add(3,5);
begin
   Dos.Id := 1;
   Put_Line ("Test");

   
   Print(Dos.Id);

   null;
end Shop;
