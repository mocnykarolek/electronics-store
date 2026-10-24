with Types;
package manager is

   task manager is
      entry Start;
      entry Nowa_dostawa(D : Types.Dostawa);
      entry Status( r_status : Types.Robot_Status; Id : Integer);
      entry Zakoncz;
   end manager;

end manager;