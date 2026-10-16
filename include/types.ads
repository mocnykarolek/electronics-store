package Types is

   type Products_Type is (A, B, C, D);

   type Dostawa is record
      
      DostawaType : Character;
      Ammount : Integer;
      Capacity : Integer;


   end record;

end Types;