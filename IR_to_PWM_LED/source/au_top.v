module au_top(
    input clk,              // 100MHz clock
    input rst_n,            // reset button
    input vp_in,            // Dedicated analog input(+) 
    input vn_in,            // Dedicated analong input(-)
    output [7:0] led        // Use Au LEDs for debug output
   );
   
    wire rst = ~rst_n; // make reset active high
   
    wire enable;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              wire [6:0] channel;
    wire [15:0] XADC_out;
    reg [15:0] XADC_bytes;
    wire drdy;

    assign channel={8'b00000011};
    
   

    xadc_wiz_0 xadc_wiz_0
          (.daddr_in(channel),
           .dclk_in(clk),             // Clock input for the dynamic reconfiguration port
           .den_in(enable),           // Data enable
           .di_in(0),
           .dwe_in(0),                // Write enable
           .busy_out(),               // ADC Busy signal
           .channel_out(),            // Channel Selection Outputs
           .do_out(XADC_out),         // Data out
           .drdy_out(drdy),           // Data ready
           .eoc_out(enable),          // End of Conversion Signal
           .eos_out(),                // End of Sequence Signal
           .alarm_out(),              // OR'ed output of all the Alarms    
           .vp_in(vp_in),             // Dedicated Analog Input Pair
           .vn_in(vn_in));   
  
    always @(posedge clk) begin
     if(drdy==1) begin XADC_bytes=XADC_out; end // I don't strictly speaking know 
     end
    always @(*) begin                                            // if this line is necessary
    genvar i;
    generate
      for (i = 0; i < 8; i=i+1) begin: pwm_gen_loop
      pwm #(.CTR_LEN(8)) pwm (
        .clk(clk),
        .rst(rst),
        .compare(XADC_out[15:8]),
        .pwm(led[i])
      );
      end
    endgenerate
                                                            
     end
  
endmodule