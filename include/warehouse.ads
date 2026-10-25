with Types;

package warehouse is

   task warehouse is 
      entry pickup(dostawa: types.Dostawa ; retCode : out Integer);
      entry check_warehouse_state(sta : out Integer);
      entry Zamow(Numer : Positive; Produkt : Types.Products_Type; Ilosc : Types.p_ammount; Udane : out Boolean);
      entry Zakoncz;

   end warehouse;

end warehouse;