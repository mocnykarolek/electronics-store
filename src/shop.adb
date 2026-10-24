with Ada.Text_IO;
use Ada.Text_IO;

with manager;
with tools;
use tools;
with robot;
use robot;
with delivery;
use delivery;
with warehouse;
with Types;



procedure Shop is
   

   

begin

   manager.manager.Start;
   
   delay 20.0;

   manager.manager.Zakoncz;


   
end Shop;
