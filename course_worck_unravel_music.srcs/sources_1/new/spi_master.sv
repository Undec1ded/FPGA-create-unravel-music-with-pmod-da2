`timescale 1ns / 1ps
    //  frequency_A1 = 440, 
    //  frequency_A2 = 880,
    //  frequency_Ah2 = 932,

    //  frequency_B1 = 494,
    //  frequency_C1 = 523,
    //  frequency_D1 = 294,
    //  frequency_E2 = 659,
    //  frequency_G1 = 392,
    //  frequency_G2 = 784,
    //  frequency_F1 = 349,
    //  frequency_F2h = 740,
    // 
        
    //  frequency_A3 = 1720,
    //  frequency_B3 = 1975,
    //  frequency_C4 = 2093,
    //  frequency_D3 = 1174,
    //  frequency_E4 = 2637,
    //  frequency_G3 = 1568,
    //  frequency_G4 = 3136,
    //  frequency_F3 = 1396,
    //  frequency_F4h = 2960

    // A1 = 440
    // Ah1 = 466
    // A2 = 880
    // Ah2 = 932
    // C2 = 523
    // C3 = 1047
    // D2 = 587
    // Dh2 = 622
    // D3 = 1174
    // F2 = 698
    // F3 = 1396
    // G1 = 392
    // G2 = 784
    // G3 = 1568
module spi_master#(
    parameter bit_data = 1024,
    parameter frequency_25MGz = 25000000
     
    )(
input clk,
input logic [5 : 0] note_state,
input button_action,
input logic [bit_data - 1 : 0] data,

output logic sync,
output logic mosi,
output logic sclk
    );

// frequency notes



reg [bit_data - 1 : 0] random_data = data;

reg [4 : 0] counter_shift_resolution = 5'b10000;
reg shift_resolution = 0;
reg time_one_bit = 0;
reg [20:0] counter_time_one_bit = 0;
reg [31:0] frequency_note = 0;
reg [3 : 0] state_sw;
reg sync_driver = 1'b0;
reg [20 : 0] counter_note = 0;
reg [20 : 0] note = 0;
reg [1 : 0] frequency_divider_25MGz = 2'b00;
reg driver_for_divider_25MGz = 0;
reg [5 : 0] note_state_chek = 0;


assign sclk = driver_for_divider_25MGz;

always_ff @(posedge clk) begin
    if (frequency_divider_25MGz != 2'b11) begin
        frequency_divider_25MGz = frequency_divider_25MGz + 1;
        driver_for_divider_25MGz = 0;
    end
    else begin 
     driver_for_divider_25MGz = 1;
    frequency_divider_25MGz = 0;
    end
end

//the parameters for the frequencies are calculated by the formula frequency_note = frequency_25MGz / (64 * frequency_A1),
//where frequency_A1 is the frequency of the note, 64 is the number of points of the reproduced sine wave

always@(posedge sclk) begin 
    case (note_state)
        6'b000001: frequency_note = 888; // frequency_A1 /628 /333
        6'b000010: frequency_note = 838; // frequency_Ah1
        6'b000011: frequency_note = 444; // frequency_A2 
        6'b000100: frequency_note = 419; // frequency_Ah2
        6'b000101: frequency_note = 747; // frequency_C2
        6'b000110: frequency_note = 373; // frequency_C3
        6'b000111: frequency_note = 665; // frequency_D2
        6'b001010: frequency_note = 560; // frequency_F2
        6'b001011: frequency_note = 279; // frequency_F3
        6'b001100: frequency_note = 996; // frequency_G1
        6'b001101: frequency_note = 498; // frequency_G2
        6'b001110: frequency_note =  249; // frequency_G3

        6'b001111: frequency_note = 1496;
        6'b010000: frequency_note = 1410;
        6'b010001: frequency_note = 705;
        6'b010010: frequency_note = 352;
        6'b010011: frequency_note = 187;
        6'b010100: frequency_note = 176;
        6'b010101: frequency_note = 1333;
        6'b010111: frequency_note = 1256;
        6'b011000: frequency_note = 628;
        6'b011001: frequency_note = 333;
        6'b011010: frequency_note = 319;
        6'b011011: frequency_note = 166;
        6'b011100: frequency_note = 157;
        6'b011101: frequency_note = 1187;
        6'b011110: frequency_note = 593;
        6'b011111: frequency_note = 296;
        6'b100000: frequency_note = 148;
        6'b100001: frequency_note = 1119;
        6'b100010: frequency_note = 1059;
        6'b100011: frequency_note = 529;
        6'b100101: frequency_note = 264;
        6'b100110: frequency_note = 140;
        6'b100111: frequency_note = 132;
        6'b100111: frequency_note = 941;
        6'b101000: frequency_note = 471;
        6'b101001: frequency_note = 235;
        6'b101010: frequency_note = 187;
        6'b101011: frequency_note = 177;
        6'b101100: frequency_note = 227;
        6'b101101: frequency_note = 210;
        6'b101110: frequency_note = 114;
        6'b101111: frequency_note = 105;
        6'b110000: frequency_note = 792;
        6'b110001: frequency_note = 396;
        6'b110010: frequency_note = 198;
        6'b110011: frequency_note = 99;
        6'b110100: frequency_note = 3004;
        6'b110101: frequency_note = 2831;
        6'b110110: frequency_note = 2657;
        6'b110111: frequency_note = 2520;
        6'b111000: frequency_note = 2382;
        6'b111001: frequency_note = 2245;
        6'b111010: frequency_note = 2111;
        6'b111011: frequency_note = 1993;
        6'b111100: frequency_note = 1887;
        6'b111101: frequency_note = 1776;
        6'b111110: frequency_note = 1677;
        6'b111111: frequency_note = 1588;
    default : frequency_note = frequency_25MGz;  
    endcase  
    

end

//logic signal out

always @(posedge sclk) begin
    if (counter_note < 16 & button_action == 1) begin
        shift_resolution <= 1;
        counter_note <=  counter_note + 1;
     end
    else if (note_state_chek != note_state & counter_note >= 16) begin
        counter_note = 0;
    end
    else if (counter_note != frequency_note & button_action == 1) begin
        shift_resolution <= 0;
        counter_note <=  counter_note + 1;
    end
    else counter_note <= 0;
    note_state_chek = note_state;

end
always@ (posedge sclk) begin

    if (counter_note == 0 & button_action == 1) begin
        sync = 1;
    end
    
    else sync = 0;
    
end

//spi

always@(posedge sclk)
    if (button_action != 1) begin
        random_data = 0;
        mosi = 0;
        
    end
    else if (random_data == 0) begin
            random_data = data;
    end
    else if (shift_resolution == 1) begin
            mosi = random_data[bit_data - 1];
            random_data = random_data << 1;
    end 
    else begin 
        mosi = 0;    
    end
    
endmodule
