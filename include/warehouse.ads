with Types;

package warehouse is

   task warehouse is 
      entry pickup(dostawa: types.Dostawa);
      entry check_warehouse_state(sta : out Integer);
      entry Zakoncz;

   end warehouse;

end warehouse;