module test_generator(
	input clk,
	input enable,
	input reset,
	
	output reg [7:0] out
);
	
	
	always @ (posedge clk, negedge reset) begin
		if (reset == 0) out = 0;
		else if (enable == 1) out = out + 1;
	end
	
	
endmodule
