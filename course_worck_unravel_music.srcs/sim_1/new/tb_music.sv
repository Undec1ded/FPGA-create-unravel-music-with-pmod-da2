`timescale 1ns / 1ps
module tb_music();

reg clk = 0;
reg button_action = 0;

wire signal;


music_top tb_music_top(
.clk(clk),
.button_action(button_action),
.signal(signal)
);

always#5 clk=!clk;
initial begin
    #500;
    button_action = 1;
end
endmodule

