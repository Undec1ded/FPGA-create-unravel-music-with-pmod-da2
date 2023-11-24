`timescale 1ns / 1ps

//module for switching notes

module unravel#(
       
)(
    input clk,
    input button_action,
    output logic [5 : 0] note

);
reg [4 : 0] idle =  5'b00000;
reg [4 : 0] note1 = 5'b00001;
reg [4 : 0] note2 = 5'b00010;
reg [4 : 0] note3 = 5'b00011;
reg [4 : 0] note4 = 5'b00100;
reg [4 : 0] note5 = 5'b00101;
reg [4 : 0] note6 = 5'b00110;
reg [4 : 0] note7 = 5'b00111;
reg [4 : 0] note8 = 5'b01000;
reg [4 : 0] note9 = 5'b01001;
reg [4 : 0] note10 = 5'b01010;
reg [4 : 0] note11 = 5'b01011;
reg [4 : 0] note12 = 5'b01100;
reg [4 : 0] note13 = 5'b01101;
reg [4 : 0] note14 = 5'b01110;
reg [4 : 0] note15 = 5'b01111;
reg [4 : 0] note16 = 5'b10000;
reg [4 : 0] note17 = 5'b10001;
reg [4 : 0] note18 = 5'b10010;

reg [3 : 0] A1_note = 4'b0001;
reg [3 : 0] A2_note = 4'b0010;  
reg [3 : 0] B1_note = 4'b0011;
reg [3 : 0] C1_note = 4'b0100;
reg [3 : 0] D1_note = 4'b0101;
reg [3 : 0] E2_note = 4'b0110;
reg [3 : 0] G1_note = 4'b0111;
reg [3 : 0] G2_note = 4'b1000;
reg [3 : 0] F1_note = 4'b1001;
reg [3 : 0] F2h_note = 4'b1010;

reg [5 : 0] A3_note = 6'b001011;
reg [5 : 0] A4_note = 6'b001100;  
reg [5 : 0] B3_note = 6'b001101;
reg [5 : 0] C3_note = 6'b001110;
reg [5 : 0] D3_note = 6'b001111;
reg [5 : 0] E4_note = 6'b010000;
reg [5 : 0] G3_note = 6'b010001;
reg [5 : 0] G4_note = 6'b010010;
reg [5 : 0] F3_note = 6'b010011;
reg [5 : 0] F4h_note = 6'b010100;

reg [24 : 0] counter_sec = 0; 
reg [23 : 0] counter_time = 0;
reg time_driver = 0;
reg [3 : 0] state_note = 0;

//time_driver = 1/60 second
always@ (posedge clk) begin
    
    if ((counter_time != 21'b1_1001_0110_1110_0110_1010) & (button_action == 1)) begin
        time_driver = 0;
        counter_time = counter_time + 1;
    end
    else begin
        time_driver = 1;
        counter_time = 0;
end    
end

always@(posedge time_driver) begin
    if ((button_action) == 1 & (counter_sec != 9'b111100001)) begin
        counter_sec = counter_sec + 1;
    end
    else begin 
        counter_sec = 0;
    end  
    case (counter_sec)
        1'b0: state_note = idle;
        6'b111110: state_note = note1;    
        7'b1000100: state_note = note2;       
        7'b1001111: state_note = note3;
        7'b1111110: state_note = note4;
        8'b10000100: state_note = note5;
        8'b10001111: state_note = note6;
        8'b10111111: state_note = note7;
        8'b11001010: state_note = note8;
        8'b11111001: state_note = note9;
        9'b100000011: state_note = note10;
        9'b100000101: state_note = note11;
        9'b100101110: state_note = note12; 
        9'b100110000: state_note = note13; 
        9'b101000001: state_note = note14;  
        10'b101101011: state_note = note15; 
        10'b101110110: state_note = note16;  
        10'b101111100: state_note = note17; 
        10'b111100000: begin
            state_note = idle;
            counter_sec = 0;
        end
    endcase  
    
end

always @(posedge clk) begin
    
        case (state_note)
            idle:   note = 0;   
            note1:  note = G4_note;
            note2:  note = A4_note;
            note3:  note = G4_note;
            note4:  note = F4h_note;
            note5:  note = E4_note;
            note6:  note = A4_note;
            note7:  note = G4_note;
            note8:  note = F4h_note;
            note9:  note = E4_note;
            note10: note = 0;
            note11: note = E4_note;
            note12: note = D3_note;
            note13: note = 0;
            note14: note = D3_note;
            note15: note = C3_note;
            note16: note = D3_note;
            note17: note = B3_note;
            default: note = 0;             
        endcase
    end

endmodule