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
		output reg iu_au // 0 => input unit, 1 => arithmetic unit
	);
	
	parameter 	S0 = 3'b000, S1 = 3'b001, S2 = 3'b011,
					S3 = 3'b010, S4 = 3'b110, S5 = 3'b111;

	reg [2:0] state = S0;
	
	initial begin
		reset = 1;
		load_a = 1;
		load_b = 1;
		load_r = 1;
		iu_au = 0;
	end

	//Input detection
	always @ (posedge clk) begin
		if (clr_all == 0) state <= S0;
		else if (clr_entry == 0) begin
			if (state == S1) state <= S0;
			else if (state == S3) state <= S2;
		end
		else if (trig) begin
			case (state)
				S0: 	state <= S1;
				S1: 	begin
							if (value == 4'b1010) begin
								state <= S2;
								addsub <= 0; //Add
							end 
							else if (value == 4'b1011) begin
								state <= S2;
								addsub <= 1; //Sub
							end 
						end
				S2: 	state <= S3;
				S3: 	if (value == 4'b1111) state <= S4;
				S4: 	state <= S5;
			endcase
		end
		
	end
	
	always @ (state) begin
		case (state)
				S0: 	begin
							load_a = 1;
							load_b = 1;
							load_r = 1;
							iu_au = 0;
							reset = 0;
						end
				S1: 	begin
							load_a = 1;
							load_b = 1;
							load_r = 1;
							iu_au = 0;
							reset = 1;
						end
				S2: 	begin
							load_a = 0;
							load_b = 1;
							load_r = 1;
							iu_au = 0;
							reset = 0;
						end
				S3: 	begin
							load_a = 0;
							load_b = 1;
							load_r = 1;
							iu_au = 0; 
							reset = 1;
						end
				S4: 	begin
							load_a = 1;
							load_b = 0;
							load_r = 1;
							iu_au = 0;
							reset = 1;
						end
				S5:	begin
							load_a = 1;
							load_b = 1;
							load_r = 0;
							iu_au = 1;
							reset = 1;
						end
				
				default: begin
								reset = 1;
								load_a = 1;
								load_b = 1;
								load_r = 1;
								iu_au = 0;
							end
		endcase
	end
		
	//Outputs using combinational logic
	/*assign reset  =  ~(~state[2] && ~state[1] && ~state[0]);
	assign load_a =  ~(~state[2] && ~state[1] && state[0]);
	assign load_b =  ~(~state[2] && state[1] && state[0]);
	assign load_r =  ~(state[2] && state[1] && ~state[0]);
	assign iu_au  =  state[2] && state[1] && ~state[0];*/

endmodule
