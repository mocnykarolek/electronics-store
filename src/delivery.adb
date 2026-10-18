with Ada.Text_IO;
use Ada.Text_IO;
with robot;
with Ada.Numerics.Discrete_Random;
with Types;
use Types;
with manager;

package body delivery is
      

      task body delivery is
         

         function GenerateRandomProduct return Dostawa is
            
            retVal : Dostawa;
            
            package RandInt is new Ada.Numerics.Discrete_Random(p_ammount);
            package RandProd is new Ada.Numerics.Discrete_Random(Products_Type);

            GenInt : RandInt.Generator;
            GenProd : RandProd.Generator;

            
            
         begin	
            
            RandProd.Reset(GenProd);
            RandInt.Reset(GenInt);

            retval.DostawaType := RandProd.Random(GenProd);
            retval.Ammount := RandInt.Random(GenInt);

            if retval.DostawaType = 'A' then
                  retVal.Capacity := 1;
            elsif retval.DostawaType = 'B' then
                  retVal.Capacity := 2;
            elsif retval.DostawaType = 'C' then
                  retVal.Capacity := 3;
            elsif retval.DostawaType = 'D' then
                  retVal.Capacity := 4;
            end if;

            return retVal;
         end GenerateRandomProduct;

         subtype random_time_range is Integer range 3 .. 6;
         
         
         
         package Losowanie is
            new Ada.Numerics.Discrete_Random(random_time_range);
         
         random_time : random_time_range;
         Gen : Losowanie.Generator;

      begin
         Losowanie.Reset(Gen);
         loop
            random_time := Losowanie.Random(Gen);
            Put_Line ("Dostawa czeka");
            --  pyta managera o wolnego robota
            --  jezeli nie znajdzie to wtedy jest to komunikowane i produkt jest gubiony
            delay Duration(random_time);


         end loop;
         

      end delivery;

end delivery;