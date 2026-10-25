with Ada.Text_IO;
use Ada.Text_IO;

with Delivery;
with Unloading;
with Manager;
with Klient;

procedure Shop is
   

   

begin
   
   delay 15.0;
   Delivery.D1.Zakoncz;
   Delivery.D2.Zakoncz;
   Delivery.D3.Zakoncz;

   Unloading.Stanowisko.Zakoncz;

   Klient.Klient.Zakoncz;

   manager.manager.Zakoncz;
   Manager.Manager.Gotowe;

   
end Shop;
