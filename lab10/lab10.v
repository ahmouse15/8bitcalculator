module main(
	input [7:0] in,
	input clk,
	input reset,
	input mode,

	//output [0:6] displays [3:0]
	output [0:6] hex0,
	output [0:6] hex1,
	output [0:6] hex2,
	output sign
);

	wire [7:0] test;
	wire clk_out;

	reg [7:0] value;
	
	reg test_enable;
	
	
	//5hz clock source
	nclk #(5) (.clk(clk), .clk_out(clk_out));
	
	//Test input generator
	test_generator(.clk(clk_out), .enable(test_enable), .reset(reset), .out(test));
	
	//Output unit
	calculator_output(.in(value), .hex0(hex0), .hex1(hex1), .hex2(hex2), .sign(sign));
	
	
	//Handle switching between test generator and manual input
	always @ (mode, in, test) begin
		if (mode == 1) begin 
			value = test;
			test_enable = 1;
		end
		else begin 
			value = in;
			test_enable = 0;
		end
	end
	
endmodule
