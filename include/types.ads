package Types is

   type Products_Type is ('A', 'B', 'C', 'D');

   function Nazwa_Produktu(P : Products_Type) return String;
   subtype p_ammount is Integer range 1 .. 5;

   type Robot_Status is (
            IDLE,
            CRASH,
            TRANSPORTATION,
            UNLOADING,
            DISCHARGED
         );

   type Dostawa is record
      Id : Natural := 0;
      DostawaType : Products_Type;
      Ammount : p_ammount;
      Capacity : Integer;


   end record;

end Types;