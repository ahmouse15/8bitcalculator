module ripple_addsub #(parameter WIDTH = 8) (
	input [WIDTH-1:0] a,
	input [WIDTH-1:0] b,
	input mode,
	
	output [WIDTH-1:0] out,
	output [WIDTH-1:0] cout
);
	reg [WIDTH-1:0] b_temp;
	
	/*reg cout_temp;
	
	//8-bit ripple carry adder, from LSB to MSB
	for (genvar i = 0; i < WIDTH; i = i + 1) begin
		if (i == 0) cout_temp = mode;
		else cout_temp = cout[i];
		//fulladder (.a(a[i]), .b(b_temp[i]), .cin(cout_temp), 	.s(out[i]), .cout(cout[i]));
	end*/
	
	fulladder fa0(.a(a[0]), .b(b_temp[0]), .cin(mode), 	.s(out[0]), .cout(cout[0]));
	fulladder fa1(.a(a[1]), .b(b_temp[1]), .cin(cout[0]), .s(out[1]), .cout(cout[1]));
	fulladder fa2(.a(a[2]), .b(b_temp[2]), .cin(cout[1]), .s(out[2]), .cout(cout[2]));
	fulladder fa3(.a(a[3]), .b(b_temp[3]), .cin(cout[2]), .s(out[3]), .cout(cout[3]));
	fulladder fa4(.a(a[4]), .b(b_temp[4]), .cin(cout[3]), .s(out[4]), .cout(cout[4]));
	fulladder fa5(.a(a[5]), .b(b_temp[5]), .cin(cout[4]), .s(out[5]), .cout(cout[5]));
	fulladder fa6(.a(a[6]), .b(b_temp[6]), .cin(cout[5]), .s(out[6]), .cout(cout[6]));
	fulladder fa7(.a(a[7]), .b(b_temp[7]), .cin(cout[6]), .s(out[7]), .cout(cout[7]));
	
	
	always @ (b, mode) begin
		if (mode == 1'b1) b_temp = ~b;
		else b_temp = b;
	end
	
endmodule
