`timescale 1ns / 1ps

//values of the output voltage from the pmode da2
//an array of 1024 bits represents the voltage value to create a sinusoid of 64 points
//the formula for calculating the output voltage: Vout = Vin*(D/4095)

module ram_sinusoid#(
    parameter bits_data_out = 1024,
    parameter bits_data = 16
)(
    input clk,

    output logic [bits_data_out - 1 : 0] data
);

reg [bits_data - 1 : 0] data0  = 16'b1000_100000000001;
reg [bits_data - 1 : 0] data1  = 16'b0000_100011001100;
reg [bits_data - 1 : 0] data2  = 16'b0000_100110010110;
reg [bits_data - 1 : 0] data3  = 16'b0000_101001011100;
reg [bits_data - 1 : 0] data4  = 16'b0000_101100011011;
reg [bits_data - 1 : 0] data5  = 16'b0000_101111010100;
reg [bits_data - 1 : 0] data6  = 16'b0000_101111010100;
reg [bits_data - 1 : 0] data7  = 16'b0000_110100100100;
reg [bits_data - 1 : 0] data8  = 16'b0000_110110111010;
reg [bits_data - 1 : 0] data9  = 16'b0000_111001000010;
reg [bits_data - 1 : 0] data10 = 16'b0000_111010111001;
reg [bits_data - 1 : 0] data11 = 16'b0000_111100011111;
reg [bits_data - 1 : 0] data12 = 16'b0000_111101110010;
reg [bits_data - 1 : 0] data13 = 16'b0000_111110100001;
reg [bits_data - 1 : 0] data14 = 16'b0000_111111100000;
reg [bits_data - 1 : 0] data15 = 16'b0000_111111111010;
reg [bits_data - 1 : 0] data16 = 16'b0000_111111111111;
reg [bits_data - 1 : 0] data17 = 16'b0000_111111110000;
reg [bits_data - 1 : 0] data18 = 16'b0000_111111001100;
reg [bits_data - 1 : 0] data19 = 16'b0000_111110010110;
reg [bits_data - 1 : 0] data20 = 16'b0000_111101001010;
reg [bits_data - 1 : 0] data21 = 16'b0000_111011101101;
reg [bits_data - 1 : 0] data22 = 16'b0000_111001111111;
reg [bits_data - 1 : 0] data23 = 16'b0000_111000000000;
reg [bits_data - 1 : 0] data24 = 16'b0000_110101110001;
reg [bits_data - 1 : 0] data25 = 16'b0000_110011010101;
reg [bits_data - 1 : 0] data26 = 16'b0000_110000101100;
reg [bits_data - 1 : 0] data27 = 16'b0000_101101111000;
reg [bits_data - 1 : 0] data28 = 16'b0000_101010111101;
reg [bits_data - 1 : 0] data29 = 16'b0000_100111111010;
reg [bits_data - 1 : 0] data30 = 16'b0000_100100110001;
reg [bits_data - 1 : 0] data31 = 16'b0000_100001100110;
reg [bits_data - 1 : 0] data32 = 16'b0000_011110011010;
reg [bits_data - 1 : 0] data33 = 16'b0000_011011001111;
reg [bits_data - 1 : 0] data34 = 16'b0000_011000000110;
reg [bits_data - 1 : 0] data35 = 16'b0000_010101000011;
reg [bits_data - 1 : 0] data36 = 16'b0000_010010001000;
reg [bits_data - 1 : 0] data37 = 16'b0000_001111010100;
reg [bits_data - 1 : 0] data38 = 16'b0000_001100101011;
reg [bits_data - 1 : 0] data39 = 16'b0000_001010001111;
reg [bits_data - 1 : 0] data40 = 16'b0000_001000000000;
reg [bits_data - 1 : 0] data41 = 16'b0000_000110000001;
reg [bits_data - 1 : 0] data42 = 16'b0000_000100010011;
reg [bits_data - 1 : 0] data43 = 16'b0000_000010110110;
reg [bits_data - 1 : 0] data44 = 16'b0000_000001101010;
reg [bits_data - 1 : 0] data45 = 16'b0000_000000110011;
reg [bits_data - 1 : 0] data46 = 16'b0000_000000001111;
reg [bits_data - 1 : 0] data47 = 16'b0000_000000000001;
reg [bits_data - 1 : 0] data48 = 16'b0000_000000000101;
reg [bits_data - 1 : 0] data49 = 16'b0000_000000100000;
reg [bits_data - 1 : 0] data50 = 16'b0000_000001001100;
reg [bits_data - 1 : 0] data51 = 16'b0000_000010001110;
reg [bits_data - 1 : 0] data52 = 16'b0000_000011100001;
reg [bits_data - 1 : 0] data53 = 16'b0000_000101000111;
reg [bits_data - 1 : 0] data54 = 16'b0000_000110111110;
reg [bits_data - 1 : 0] data55 = 16'b0000_001001000101;
reg [bits_data - 1 : 0] data56 = 16'b0000_001011011100;
reg [bits_data - 1 : 0] data57 = 16'b0000_001101111110;
reg [bits_data - 1 : 0] data58 = 16'b0000_010000101100;
reg [bits_data - 1 : 0] data59 = 16'b0000_010011100101;
reg [bits_data - 1 : 0] data60 = 16'b0000_010110100101;
reg [bits_data - 1 : 0] data61 = 16'b0000_011001101010;
reg [bits_data - 1 : 0] data62 = 16'b0000_011100110101;
reg [bits_data - 1 : 0] data63 = 16'b0000_000110111111;

reg [bits_data_out - 1 : 0] data_out = {data0, data1, data2 , data3, data4, data5, data6, data7, data8, data9,
                                        data10, data11, data12, data13, data14, data15, data16, data17, data18, data19,
                                        data20, data21, data22, data23, data24, data25, data26, data27, data28, data29,
                                        data30, data31, data32, data33, data34, data35, data36, data37, data38, data39,
                                        data40, data41, data42, data43, data44, data45, data46, data47, data48, data49,
                                        data50, data51, data52, data53, data54, data55, data56, data57, data58, data59,
                                        data60, data61, data62, data63};
                                        
always @(posedge clk) begin
    data = data_out;
end

endmodule