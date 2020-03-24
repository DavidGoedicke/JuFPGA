module lvlmetere #(parameter COMP_VAL = 500) (
    input clk,
    input rst,
    input sensorval,
    output led
  );


  always @(*) begin
    if(sensorval>COMP_VAL)
    if (compare > ctr_q)
      led = 1'b1;
    else
      led = 1'b0;
  end



endmodule
