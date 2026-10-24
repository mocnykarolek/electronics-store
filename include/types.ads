package Types is

   type Products_Type is ('A', 'B', 'C', 'D');
   subtype p_ammount is Integer range 1 .. 5;

   type Robot_Status is (
            IDLE,
            CRASH,
            TRANSPORTATION,
            UNLOADING
         );

   type Dostawa is record
      
      DostawaType : Products_Type;
      Ammount : p_ammount;
      Capacity : Integer;


   end record;

end Types;