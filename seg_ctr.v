`timescale 1ns / 1ps


module seg_ctr(
    input wire [3:0] data0,
    input wire [3:0] data1,
    input wire [3:0] data2,
    input wire [3:0] data3,
    input wire rest,
    input wire clk,
    input wire clk_1hz,
    input wire blinking,
    input wire dis_moh,
    input wire led_alarm,
    input [2:0]set_time,
    input [2:0]set_alarm,
    output reg [6:0] seg_led,
    output reg[3:0]An
);  
    reg [1:0]display_an;
    reg [3:0]display_data;
    

    always@(posedge clk or posedge rest) begin
        if(rest)
            display_an <= 2'b0;
        else 
            display_an <= display_an + 1'b1; 
    end
    always@ (*)begin
        case (display_an) 
            2'b00 : begin
                        if((led_alarm || (!dis_moh && set_time[0]) || (!dis_moh && set_alarm[0])) && blinking)begin
                            An = 4'b1111;
                        end
                        else 
                        An = 4'b1110;
                        display_data = data0;
                    end  
            2'b01 : begin
                        if((led_alarm || (!dis_moh && set_time[0]) || (!dis_moh && set_alarm[0])) && blinking)begin
                            An = 4'b1111;
                        end
                        else 
                        An = 4'b1101;
                        display_data = data1;
                     end  
            2'b10 : begin
                        if((led_alarm || set_time[1] || set_time[2] || set_alarm[1] || set_alarm[2]) && blinking)begin
                            An = 4'b1111;
                        end
                        else 
                        An = 4'b1011;
                        display_data = data2;
                     end
            2'b11 : begin
                        if((led_alarm || set_time[1] || set_time[2] || set_alarm[1] || set_alarm[2]) && blinking)begin
                            An = 4'b1111;
                        end
                        else 
                        An = 4'b0111;
                        display_data = data3;
                     end  
        endcase
    end
    always@ (*)begin
        case (display_data) 
            4'h0 : seg_led = 7'b0000001;
            4'h1 : seg_led = 7'b1001111;
            4'h2 : seg_led = 7'b0010010;
            4'h3 : seg_led = 7'b0000110;
            4'h4 : seg_led = 7'b1001100;
            4'h5 : seg_led = 7'b0100100;
            4'h6 : seg_led = 7'b0100000;
            4'h7 : seg_led = 7'b0001111;
            4'h8 : seg_led = 7'b0000000;
            4'h9 : seg_led = 7'b0001100;
            4'ha : seg_led = 7'b0001000;
            4'hb : seg_led = 7'b1100000;
            4'hc : seg_led = 7'b0110001;
            4'hd : seg_led = 7'b1000010;
            4'he : seg_led = 7'b0110000;
            4'hf : seg_led = 7'b0111000;
    
        endcase
    end
    
endmodule
