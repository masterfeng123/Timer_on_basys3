`timescale 1ns / 1ps

module btn_system(
    input  clk, reset,
    input  btn,
    output reg flag_short, flag_long, flag_double, flag_triple, flag_four, btn_long
);  

    parameter LONG_1s = 32'd100000000;   //8
    parameter LONG_3s = 32'd300000000;   //16   
    parameter BTN_DOUBLE = 2;
    parameter BTN_TRIPLE = 3;
    parameter BTN_FOUR = 4;    
    parameter BTN_ONE = 1;
    parameter RELEASE = 24;//24 pass  4

    reg [2:0] btn_counter;
    reg [RELEASE:0] btn_release;
    reg [31:0] btn_state;
    wire one_btn;

    always@(posedge clk or posedge reset) begin
        if(reset) begin
            btn_release <= 0;
        end else if(!btn && !btn_release[RELEASE])begin
            btn_release <= btn_release+1;
        end else begin
            btn_release <= 0;
        end
    end

    always@(posedge clk or posedge reset) begin
        if(reset) begin
            btn_long <=0;
        end else if(btn_state >= LONG_3s) begin
            btn_long <= 1;
        end else begin
            btn_long <= 0;
        end
    end

    debounce m0(
    .clr(1'b0),
    .clk(clk),
    .inp(btn),
    .out_1p(one_btn)
    );

    always@(posedge clk or posedge reset) begin
        if(reset) begin
            btn_counter <= 0;
        end else if(one_btn && !btn_release[RELEASE]) begin
                btn_counter <= btn_counter+1; 
        end else if (btn_release[RELEASE])begin
            btn_counter <= 0;
        end else begin
            btn_counter <= btn_counter;
        end
    end

    always@(posedge clk or posedge reset) begin
        if(reset) begin
            btn_state <= 0;
        end else if (btn)begin
            btn_state <= btn_state+1;
        end else if (btn_release[RELEASE])begin
            btn_state <= 0;
        end else begin
            btn_state <= btn_state;
        end
    end

    always@(posedge clk or posedge reset) begin
        if(reset) begin
            flag_short <= 0;
            flag_long <= 0;
            flag_double <= 0;
            flag_triple <= 0;
            flag_four <= 0;  
        end else if (btn_release[RELEASE])begin
            if(btn_counter == BTN_DOUBLE) begin
                flag_short <= 0;
                flag_long <= 0;
                flag_double <= 1;
                flag_triple <= 0;
                flag_four <= 0;                
            end else if (btn_counter == BTN_TRIPLE) begin
                flag_short <= 0;
                flag_long <= 0;
                flag_double <= 0;
                flag_triple <= 1;
                flag_four <= 0;
            end else if (btn_counter == BTN_FOUR) begin
                flag_short <= 0;
                flag_long <= 0;
                flag_double <= 0;
                flag_triple <= 0;
                flag_four <= 1;
            end else if (btn_state >= LONG_1s && btn_state <= LONG_3s) begin
                flag_short <= 0;
                flag_long <= 1;
                flag_double <= 0;
                flag_triple <= 0;
                flag_four <= 0;                
            end else if (btn_counter == BTN_ONE && !btn_long) begin
                flag_short <= 1;
                flag_long <= 0;
                flag_double <= 0;
                flag_triple <= 0;
                flag_four <= 0;                
            end else begin
                flag_short <= 0;
                flag_long <= 0;
                flag_double <= 0;
                flag_triple <= 0;
                flag_four <= 0;                
            end
        end else begin
            flag_short <= 0;
            flag_long <= 0;
            flag_double <= 0;
            flag_triple <= 0;
            flag_four <= 0;            
        end
    end



    


    
endmodule
