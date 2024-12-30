module input_unit(
		input clk,
		input reset,
		
		input [3:0] row,
		output [3:0] col,
		
		output [7:0] out,
		output [3:0] value,
		output trig,
		output reg valid
	);
	wire [7:0] binary_sm;
	wire [15:0] bcd;
	
	//Keypad reading (we must store the value since it is not stored by the decoder)
	keypad_input(.clk(clk), .reset(reset), .row(row), .col(col), .out(bcd), .trig(trig), .value(value));
	
	//BCD to binary 2's complement
	bcd2binary_sm(.bcd(bcd), .out(binary_sm));
	sm2signed(.in(binary_sm), .out(out));
	
	//EXTRA FEATURE: Input validator
	always @ (bcd) begin
		if (bcd[15:12] == 4'b1110 && bcd[11:8] >= 1 && bcd[7:4] >= 2 && bcd[3:0] > 8) valid = 0; //128+
		else if (bcd[15:12] != 4'b1110 && bcd[11:8] >= 1 && bcd[7:4] >= 2 && bcd[3:0] > 7) valid = 0; //-129+
		else if (bcd[11:8] >= 1 && (bcd[7:4] > 2)) valid = 0; //1xx+
		else if (bcd[15:12] != 4'b1110 && bcd[15:12] != 4'b0000) valid = 0; //Invalid sign digit
		else valid = 1;
	end
	
	
endmodule
