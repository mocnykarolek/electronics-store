with Ada.Text_IO;
use Ada.Text_IO;
with tools;
use tools;
with robot;
use robot;
with delivery;
use delivery;
with warehouse;
with Types;


procedure Shop is
   

   d1 : delivery_type(4);
   

   R1 : Robot_type(1);
   R2 : Robot_type(2);
   R3 : Robot_type(3);
   R4 : Robot_type(4);
   

begin


   
   delay 20.0;

   R1.EndRobot;
   R2.EndRobot;
   R3.EndRobot;
   R4.EndRobot;

   
end Shop;
