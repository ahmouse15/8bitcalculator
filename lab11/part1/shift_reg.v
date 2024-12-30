module shift_reg #(
		parameter COUNT = 4,
		parameter WIDTH = 4
	)
	(
		input trig, reset, dir, // Left = 0, Right = 1
		input [WIDTH-1:0] in,
		output reg [(COUNT*WIDTH)-1:0] out
	);
	
	//EXTRA FEATURE: Don't require leading zeroes for negative input
	reg neg = 0;
	
	always @ (negedge trig, negedge reset) begin
		
		//EXTRA FEATURE: Don't require leading zeroes for negative input
		if (~reset) begin out <= 0; neg <= 0; end
		else begin
			if (in != 4'b1010 && in != 4'b1011 && in != 4'b1111) begin
				if (in == 4'b1110) neg = 1;
				else if (dir) begin // 1 = Right
					out <= out >> WIDTH;
					out[(COUNT*WIDTH)-
					1:((COUNT*WIDTH)-1)-WIDTH] <= in;
				end 
				else begin // 0 = Left
					out <= out << WIDTH;
					out[WIDTH-1:0] <= in;
				end
				//EXTRA FEATURE: Don't require leading zeroes for negative input
				if (neg) out[WIDTH*COUNT-1:WIDTH*(COUNT-1)] <= 4'b1110;
			end
		end
	end
	
endmodule
