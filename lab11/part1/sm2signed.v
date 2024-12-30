module sm2signed(
	input [7:0] in,
	
	output reg [7:0] out
);
	
	always @ (in) begin
		if (in[7] == 1) out = ~({1'b0,in[6:0]}) + 1;
		else out = in;
	end
	
endmodule
