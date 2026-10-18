with Types;

package warehouse is

   task warehouse is 
      entry pickup(dostawa: types.Dostawa ; retCode : out Integer);
      entry check_warehouse_state(sta : out Integer);
      entry Zakoncz;

   end warehouse;

end warehouse;