with Ada.Text_IO;
use Ada.Text_IO;
with robot;
with Ada.Numerics.Discrete_Random;
with types;
package body delivery is
      

      task body delivery_type is
         --  type generateinput is (RandomTime, RandomProduct, RandomAmmount);

         function GenerateRandomProduct return  types.Dostawa is
            
            retVal : Types.Dostawa;

            package RandInt is new Ada.Numerics.Discrete_Random(Integer);
            package RandProd is new Ada.Numerics.Discrete_Random(Types.Products_Type);

            GenInt : RandInt.Generator;
            GenProd : RandProd.Generator;

            
            
         begin
            

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
            delay Duration(random_time);


         end loop;
         

      end delivery_type;

end delivery;