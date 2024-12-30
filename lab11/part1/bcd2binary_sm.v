module bcd2binary_sm #(parameter N=8) (
	input [15:0] bcd,
	output [N-1:0] out
);

	assign out = bcd[15]*(8'b10000000) + bcd[11:8]*(8'b01100100) + bcd[7:4]*(8'b1010) + bcd[3:0];

endmodule
