`timescale 1ns / 1ps

module de_clk(
    input wire clk_sourecs,
    input wire rest,
    output wire clk_1hz,
    output wire clk_display,
    output wire clk_blinking,
    output wire clk_long
);
        reg [31:0]hz;
        
        assign clk_1hz = hz[26];//26    4
        assign clk_display = hz[11];
        assign clk_blinking = hz[25];
        assign clk_long = hz[24];//24 1
        always@ (posedge clk_sourecs)begin
            if(rest)
                hz = 32'b0;
            else
                hz <= hz + 1'b1;    
        end
    
    
    
endmodule
