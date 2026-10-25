with Types;
package robot is

      task type Robot_type(Id: Integer) is
         entry odbior(d : Types.Dostawa);
         entry naprawa;
         entry EndRobot;
      end Robot_type;

end robot; 