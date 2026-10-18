with Types;
package robot is
      type Robot_Status is (
            IDLE,
            CRASH,
            TRANSPORTATION,
            UNLOADING
         );

      task type Robot_type(Id: Integer) is
         entry odbior(d : Types.Dostawa);
         entry Status( r_status : out Robot_Status);
         entry EndRobot;
      end Robot_type;

end robot; 