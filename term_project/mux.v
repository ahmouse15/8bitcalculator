module mux(
		input [7:0] a,
		input [7:0] b,
		input select,
		
		output reg [7:0] out
	);
	
	always @ (select, a, b) begin
		if (select == 1) out = b;
		else out = a;
	end
endmodule
