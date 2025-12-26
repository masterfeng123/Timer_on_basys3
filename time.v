`timescale 1ns / 1ps

module top_time(
    input  clk,
    input clk_long,
    input reset,
    input set_signal,
    input set_s, set_m, set_h,
    input btn_long_signal,
    output reg [5:0]s,
    output reg [5:0]m,
    output reg [4:0]h
);

    reg s_to_m;
    reg m_to_h;
    
    always@ (*)begin
        if(m == 6'd59 && s == 6'd59)
            m_to_h = 1'b1;
        else
            m_to_h = 1'b0;
    end
    
    always@ (*)begin
        if(s == 6'd59)
            s_to_m = 1'b1;
        else
            s_to_m = 1'b0;
    end
         
    always@ (posedge clk or posedge reset) begin
        if(reset)
            s <= 6'b0;
        else if (set_s || set_m || set_h)begin
             if(set_s && set_signal) begin
                if(s < 6'd59)begin
                s <= s+1;
                end

                else begin
                    s <= 6'd0;
                end
             end
             else if(set_s && btn_long_signal) begin
                //if(clk_long) begin
                    if(s < 6'd59)begin
                        s <= s+1;
                    end
                    else begin
                        s <= 6'd0;
                    end
                //end
             end 
             else s <= s;
        end
        else if (s == 6'd59)
            s <= 6'b0;
        else
            s <= s+1;
    end
    
    always@ (posedge clk or posedge reset) begin
        if(reset)
            m <= 6'b0;
        else if (set_s || set_m || set_h)begin
             if(set_m && set_signal) begin
                if(m == 6'd59)m <= 6'd0;
                else m <= m+1;
             end

             else if(set_m && btn_long_signal) begin
                //if(clk_long) begin
                    if(m < 6'd59)begin
                        m <= m+1;
                    end
                    else begin
                        m <= 6'd0;
                    end
                //end
             end             
             else m <= m;
        end
        else if (m == 6'd59 && s == 6'd59 )
            m <= 6'b0;
        else if (s_to_m)
            m <= m+1;
    end
    
    always@ (posedge clk or posedge reset) begin
        if(reset)
            h <= 5'b0;
        else if (set_s || set_m || set_h)begin
             if(set_h && set_signal) begin
                if(h == 5'd23)h <= 5'd0;
                else h <= h+1;
             end
             else if(set_h && btn_long_signal) begin
                //if(clk_long) begin
                    if(h < 6'd23)begin
                        h <= h+1;
                    end
                    else begin
                        h <= 6'd0;
                    end
                //end
             end             
             else h <= h;
        end
        else if (h == 5'd23 && m == 6'd59 && s == 6'd59 )
            h <= 5'b0;
        else if (m_to_h)
            h <= h+1;
    end
   
endmodule
