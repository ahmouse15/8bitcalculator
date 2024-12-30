module register #(parameter WIDTH = 8) (
	input [WIDTH-1:0] in,
	input load,
	input clear,
	
	output reg [WIDTH-1:0] out
);
	
	always @ (negedge load, negedge clear) begin
		if (clear == 1'b0) out <= '0; 		//Active-low clear
		else if (load == 1'b0) out <= in; 	//Active-low load
	end
	
endmodule
	