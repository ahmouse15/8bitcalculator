module bcd2seven (
		input [3:0] in,
		output reg [6:0] out
	);

	initial begin
		out = 7'b0000001;
	end
	
	always @ (in) begin
		case (in)
			4'h0: out = 7'b0000001;
			4'h1: out = 7'b1001111;
			4'h2: out = 7'b0010010;
			4'h3: out = 7'b0000110;
			4'h4: out = 7'b1001100;
			4'h5: out = 7'b0100100;
			4'h6: out = 7'b0100000;
			4'h7: out = 7'b0001111;
			4'h8: out = 7'b0000000;
			4'h9: out = 7'b0000100;
			default: out = 7'b1111111;
		endcase
	end
	
endmodule
