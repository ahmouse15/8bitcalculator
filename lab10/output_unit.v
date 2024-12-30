module output_unit(
		input [7:0] in,

		output [0:6] hex0,
		output [0:6] hex1,
		output [0:6] hex2,
		output reg sign
	);
	
	reg [7:0] magnitude;
	
	wire [3:0] first;
	wire [3:0] second;
	wire [1:0] third;
	
	reg [3:0] second_reg;
	reg [3:0] third_reg;
	
	//Convert magnitude to BCD
	binary2bcd(.in(magnitude), .first(first), .second(second), .third(third));
	
	//Seven-segment display drivers
	bcd2seven(.in(first), .out(hex0)); //LSB
	bcd2seven(.in(second_reg), .out(hex1));
	bcd2seven(.in(third_reg), .out(hex2)); //MSB
	
	//EXTRA FEATURE: Suppress leading zeroes
	always @ (second, third) begin
		if (second == 0 && third == 0) second_reg = 4'ha;
		else second_reg = second;
		
		if (third == 0) third_reg = 4'ha;
		else third_reg = third;
	end
	
	always @ (in) begin
		// Twos-complement
		if(in[7] == 1) begin magnitude = ~in + 1; sign = 0; end //Sign is active-low
		else begin magnitude = in; sign = 1; end
	end

endmodule
