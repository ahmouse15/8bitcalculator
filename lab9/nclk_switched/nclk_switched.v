module nclk_switched #(parameter f = 1, parameter inputhz = 50000000) (
	input clk,
	input enable,
	
	output reg clk_out);
	
	reg [25:0] count = 0;
	
	parameter T = inputhz/f;
	
	always @ (posedge clk, negedge enable) begin
	
		if (enable == 0) clk_out = 0;
		else begin
			if (count == (T >> 1) ) begin
				count = 0;
				clk_out = ~clk_out;
			end
			else count = count + 1;
		end
		
	end
endmodule
