package robot is
      
      task type Robot_type(Id: Integer) is
         entry deliver(Id : Integer; Ammount : Integer);
      end Robot_type;

end robot; 