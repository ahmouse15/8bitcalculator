module nclk #(parameter f = 1, parameter inputhz = 50000000) (
		input clk,
		
		output reg clk_out
	);
	
	reg [25:0] count = 0;
	
	parameter T = inputhz/f;
	
	always @ (posedge clk) begin
		if (count == (T >> 1) ) begin
			count = 0;
			clk_out = ~clk_out;
		end
		else count = count + 1;
	end
endmodule
