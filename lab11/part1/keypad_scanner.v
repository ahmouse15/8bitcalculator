module keypad_scanner(
	input clk,
	input [3:0] row,
	
	output reg [3:0] col,
	
	output reg [3:0] col_out,
	output reg [3:0] row_out
	);
	wire clk_slow;
	
	nclk #(50) (.clk(clk), .clk_out(clk_slow));
	
	reg [3:0] col_temp;
	
	
	initial col = 4'b1000;
	
	always @ (posedge clk_slow) begin
		//Activate the next column
		if (col == 4'b0000) begin col = 4'b1000; col_temp = 4'b1000; end
		else begin col = col >> 1; col_temp = col >> 1; end
		
	end
	
	always @ (row) begin
		if (row != 4'b1111) begin
			row_out = ~row;
			col_out = col;
		end
	end
	
endmodule
