module control_unit(
			input trig,
			input [3:0] value,
			input clk,
			input clr_entry,
			input clr_all,
			
			output reg reset,
			output reg load_a,
			output reg load_b,
			output reg addsub,
			output reg load_r,
			output reg load_ou,
			output reg iu_au // 0 => input unit, 1 => arithmetic unit
	);
	
	initial begin
		reset = 0;
		load_a = 1;
		load_b = 1;
		addsub = 0;
		load_r = 1;
		iu_au = 0;
	end
	
	always @ (posedge trig) begin
	
		/*if (~clr_all) begin
			reset = 0;
			load_a = 1;
			load_b = 1;
			addsub = 0;
			load_r = 1;
			iu_au = 0;
		end*/
		
		load_a <= ~load_a;
		
		if (value == 4'b1010) begin
			load_a <= 1;
			load_b <= 0;
			reset <= 0;
			
			addsub <= 0;
		end
		else if (value == 4'b1011) begin
			load_a <= 1;
			load_b <= 0;
			reset <= 0;
			
			addsub <= 1;
		end
		
		if (value == 4'b1111) load_r <= 0;
		
		reset <= 1;
		load_a <= ~load_a;

	end

endmodule
