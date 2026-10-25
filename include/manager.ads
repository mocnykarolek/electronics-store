with Types;
package manager is

   task manager is
      entry Nowa_dostawa(D : Types.Dostawa);
      entry Status( r_status : Types.Robot_Status; Id : Integer);
      entry Wolna_Ladowarka_State(stan : Boolean);
      entry Zakoncz;
   end manager;

end manager;