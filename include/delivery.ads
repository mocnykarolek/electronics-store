
package Delivery is

   task type Samochod (Numer : Positive) is
         entry Zakoncz;
   end Samochod;


   D1 : Samochod (1);
   D2 : Samochod (2);
   D3 : Samochod (3);

end Delivery;
