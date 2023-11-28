`timescale 1ns / 1ps

//top module

module music_top#(
    bits_data_out = 1024
)(
    input clk,
    input button_action,
    input [3 : 0] sw,
    
    output signal,
    output sync,
    output sclk
);
    
logic [bits_data_out  - 1 : 0] data;
wire [5 : 0] note_state_wire;

ram_sinusoid ram_sinusoid(.clk(clk), .data(data));
unravel unravel(.clk(clk), .button_action(button_action), .note(note_state_wire), .sw(sw));
spi_master spi_master(.clk(clk), .button_action(button_action), .data(data), .note_state(note_state_wire), .mosi(signal), .sync(sync), .sclk(sclk));    
    
endmodule