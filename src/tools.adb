with Ada.Text_IO;
use Ada.Text_IO;


package body tools is 

   function Add(A,B : Integer) return Integer is
   begin 
      return A + B;


   end Add;

   procedure Print(X: Integer) is
   begin
      Put_Line(Integer'Image(X));
   end Print;


end tools;