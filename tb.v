`timescale 1ns / 1ps


module tb_top();
    reg clk,btn_reset, btn_set;
    wire [6:0]seg_led;
    wire [3:0]An;
    wire [5:0]led_t;
    wire state_moh,state_toa;
    
    top uut(
    .clk(clk),
    .btn_reset(btn_reset),
    .btn_set(btn_set),
    .seg_led(seg_led),
    .An(An),
    .led_t(led_t),
    .state_moh(state_moh),
    .state_toa(state_toa)
    );
    
    initial begin
        clk =0;
        btn_reset=1;
        btn_set=0;
        #102
        btn_reset=0;
        #200
        //初始
        //設定鬧鐘
        //short
        btn_set = 1;
        #50
        btn_set = 0;
        #400;
        //triple
        btn_set = 1;
        #50
        btn_set = 0;
        #50
        btn_set = 1;
        #50
        btn_set = 0;
        #50
        btn_set = 1;
        #50
        btn_set = 0;        
        #400          
        //short
        btn_set = 1;
        #50
        btn_set = 0;
        #400;
        ////初始
        //four
        btn_set = 1;
        #50
        btn_set = 0;
        #50
        btn_set = 1;
        #50
        btn_set = 0;
        #50
        btn_set = 1;
        #50
        btn_set = 0;
        #50
        btn_set = 1;
        #50
        btn_set = 0;
                
        #400   
//short
        btn_set = 1;
        #50
        btn_set = 0;
        #400;           
        //four
        btn_set = 1;
        #50
        btn_set = 0;
        #50
        btn_set = 1;
        #50
        btn_set = 0;
        #50
        btn_set = 1;
        #50
        btn_set = 0;
        #50
        btn_set = 1;
        #50
        btn_set = 0;
                
        #200          
        //long
        btn_set = 1;
        #110
        btn_set = 0;
        #200       
        //long over 2
        btn_set = 1;
        #500
        btn_set = 0;
        #200       
                  
        //double
        btn_set = 1;
        #50
        btn_set = 0;
        #50
        btn_set = 1;
        #50
        btn_set = 0;
        #200
        //short
        btn_set = 1;
        #50
        btn_set = 0;
        #200;
        //long
        btn_set = 1;
        #110
        btn_set = 0;
        #200          
        //triple
        btn_set = 1;
        #50
        btn_set = 0;
        #50
        btn_set = 1;
        #50
        btn_set = 0;
        #50
        btn_set = 1;
        #50
        btn_set = 0;        
        #200        
        //long
        btn_set = 1;
        #110
        btn_set = 0;
        #200
        //short
        btn_set = 1;
        #50
        btn_set = 0;
        #200;
        //short
        btn_set = 1;
        #50
        btn_set = 0;
        #200;
        
        //long
        btn_set = 1;
        #110
        btn_set =0;
        #200
        //long
        btn_set = 1;
        #110
        btn_set =0;
        #200
        //short
        btn_set = 1;
        #50
        btn_set = 0;
        #200;
        //short
        btn_set = 1;
        #50
        btn_set = 0;
        #200;
        
        
    end
    always #5 clk = ~clk;

endmodule