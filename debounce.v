`timescale 1ns / 1ps

module debounce(
    input wire inp,
    input wire clk,
    input wire clr,
    //output wire outp,
    output reg out_1p
);
    reg delay1;
    reg delay2;
    reg delay3;
    reg delay_reg;
    always @(posedge clk)begin
        if(clr)
            delay_reg <= 1'b0;
        else
            delay_reg <= outp;
    end
    always @(*)
        out_1p = ~delay_reg & outp;
    always @(negedge clk) begin
        if (clr)
            begin
                delay1 <= 1'b0;
                delay2 <= 1'b0;
                delay3 <= 1'b0;
            end 
        else    
            begin    
                delay1 <= inp;
                delay2 <= delay1;
                delay3 <= delay2;
            
            end 
    end    
    assign outp = delay1 & delay2 & delay3;    
endmodule