package robot is
      
      task type Robot_type(Id: Integer) is
         entry delivery(ProductType : Character; Ammount : Integer);
         entry EndRobot;
      end Robot_type;

end robot; 