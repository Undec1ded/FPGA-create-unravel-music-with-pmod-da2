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
        7'b0000001: frequency_note = 18601;  //ESub_note 
        7'b0000010: frequency_note = 17756;  //FSub_note 
        7'b0000011: frequency_note = 16983;  //FhSub_note
        7'b0000100: frequency_note = 15625;  //GSub_note 
        7'b0000101: frequency_note = 15024;  //GhSub_note
        7'b0000110: frequency_note = 13951;  //ASub_note 
        7'b0000111: frequency_note = 13470;  //AhSub_note
        7'b0001000: frequency_note = 12601;  //BSub_note 

        7'b0001001: frequency_note = 11837;  //CCont_note   
        7'b0001010: frequency_note = 11161;  //ChCont_note  
        7'b0001011: frequency_note = 10557;  //DCont_note   
        7'b1111111: frequency_note = 10016;  //DhCont_note   
        7'b0000000: frequency_note =  9527;  //ECont_note   
        7'b0001100: frequency_note =  8878;  //FCont_note   
        7'b0001101: frequency_note =  8492;  //FhCont_note 
        7'b0001110: frequency_note =  7972;  //GCont_note  
        7'b0001111: frequency_note =  7512;  //GhCont_note 
        7'b0010000: frequency_note =  7102;  //ACont_note  
        7'b0010001: frequency_note =  6735;  //AhCont_note  
        7'b0010010: frequency_note =  6300;  //BCont_note   
 
        7'b0010011: frequency_note =  6010;  //CBig_note  
        7'b0010100: frequency_note =  5661;  //ChBig_note 
        7'b0010101: frequency_note =  5279;  //DBig_note  
        7'b0010110: frequency_note =  5008;  //DhBig_note 
        7'b0010111: frequency_note =  4764;  //EBig_note  
        7'b0011000: frequency_note =  4490;  //FBig_note   
        7'b0011001: frequency_note =  4200;  //FhBig_note 
        7'b0011010: frequency_note =  3986;  //GBig_note  
        7'b0011011: frequency_note =  3756;  //GhBig_note 
        7'b0011100: frequency_note =  3551;  //ABig_note   
        7'b0011101: frequency_note =  3339;  //AhBig_note  
        7'b0011110: frequency_note =  3176;  //BBig_note  
 
        7'b0011111: frequency_note =  2982;  //CSmall_note  
        7'b0100000: frequency_note =  2810;  //ChSmall_note 
        7'b0100001: frequency_note =  2639;  //DSmall_note  
        7'b0100010: frequency_note =  2540;  //DhSmall_note 
        7'b0100011: frequency_note =  2367;  //ESmall_note  
        7'b0100100: frequency_note =  2232;  //FSmall_note  
        7'b0100101: frequency_note =  2111;  //FhSmall_note 
        7'b0100110: frequency_note =  1993;  //GSmall_note  
        7'b0100111: frequency_note =  1887;  //GhSmall_note 
        7'b0101100: frequency_note =  1776;  //ASmall_note  
        7'b0101101: frequency_note =  1677;  //AhSmall_note 
        7'b0101110: frequency_note =  1581;  //BSmall_note  
 
        7'b0101111: frequency_note =  1491;  //C1_note 
        7'b0110000: frequency_note =  1410;  //Ch1_note
        7'b0110001: frequency_note =  1329;  //D1_note 
        7'b0110010: frequency_note =  1256;  //Dh1_note
        7'b0110011: frequency_note =  1184;  //E1_note  
        7'b0110100: frequency_note =  1119;  //F1_note  
        7'b0110101: frequency_note =  1056;  //Fh1_note 
        7'b0110110: frequency_note =   996;  //G1_note  
        7'b0110111: frequency_note =   941;  //Gh1_note 
        7'b0111000: frequency_note =   888;  //A1_note  
        7'b0111001: frequency_note =   838;  //Ah1_note 
        7'b0111010: frequency_note =   791;  //B1_note  
 
        7'b0111011: frequency_note =   747;  //C2_note   
        7'b0111100: frequency_note =   705;  //Ch2_note  
        7'b0111101: frequency_note =   665;  //D2_note   
        7'b0111110: frequency_note =   628;  //Dh2_note  
        7'b0111111: frequency_note =   592;  //E2_note   
        7'b1000000: frequency_note =   560;  //F2_note   
        7'b1000001: frequency_note =   528;  //Fh2_note  
        7'b1000010: frequency_note =   498;  //G2_note   
        7'b1000011: frequency_note =   470;  //Gh2_note  
        7'b1000100: frequency_note =   444;  //A2_note   
        7'b1000101: frequency_note =   419;  //Ah2_note  
        7'b1000110: frequency_note =   395;  //B2_note   
  
        7'b1000111: frequency_note =   373;  //C3_note   
        7'b1001000: frequency_note =   352;  //Ch3_note  
        7'b1001001: frequency_note =   332;  //D3_note   
        7'b1001010: frequency_note =   314;  //Dh3_note  
        7'b1001011: frequency_note =   296;  //E3_note   
        7'b1001100: frequency_note =   280;  //F3_note   
        7'b1001101: frequency_note =   264;  //Fh3_note  
        7'b1001110: frequency_note =   249;  //G3_note   
        7'b1001111: frequency_note =   235;  //Gh3_note  
        7'b1010000: frequency_note =   227;  //A3_note   
        7'b1010001: frequency_note =   209;  //Ah3_note  
        7'b1010010: frequency_note =   198;  //B3_note   
  
        7'b1010011: frequency_note =   187;  //C4_note  
        7'b1010100: frequency_note =   176;  //Ch4_note  
        7'b1010101: frequency_note =   166;  //D4_note
        7'b1010110: frequency_note =   157;  //Dh4_note  
        7'b1010111: frequency_note =   148;  //E4_note 
        7'b1011000: frequency_note =   140;  //F4_note 
        7'b1011001: frequency_note =   132;  //Fh4_note
        7'b1011010: frequency_note =   125;  //G4_note
        7'b1011011: frequency_note =   117;  //Gh4_note
        7'b1011100: frequency_note =   114;  //A4_note
        7'b1011101: frequency_note =   105;  //Ah4_note
        7'b1011110: frequency_note =   99;   //B4_note
  
        7'b1011111: frequency_note =   93;   //C5_note    
        7'b1100000: frequency_note =   88;   //Ch5_note   
        7'b1111110: frequency_note =   83;   //D5_note 
        7'b1100001: frequency_note =   78;   //Dh5_note   
        7'b1100010: frequency_note =   47;   //E5_note    

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
