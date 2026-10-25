
with Types;

package Unloading is

   task Stanowisko is
      entry Rozladuj(D : in Types.Dostawa);
      entry Zakoncz;
   end Stanowisko;

end Unloading;
