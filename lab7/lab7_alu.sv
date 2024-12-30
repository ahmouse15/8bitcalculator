module alu (
		input [7:0] in,
		input loadA, 						//Load input register B
		input loadB, 						//Load input register A
		input out, 							//Load output register
		
		input clear, 						//Clear all registers
		input mode, 						// 0 => addition, 1 => subtraction
		
		output [7:0] result,				//Result
		output [3:0] flags				//Condition codes/flags
	);
	
	wire [7:0] aout;
	wire [7:0] bout;
	
	//wire [3:0] cc_reg;
	
	wire [7:0] adder_out;
	wire [3:0] cc_out;
	wire [7:0] cout;
	
	//Connect inputs/outputs to registers
	register r_a (.in(in), .load(loadA), .clear(clear), .out(aout));
	register r_b (.in(in), .load(loadB), .clear(clear), .out(bout));
	register r_r (.in(adder_out), .load(out), .clear(clear), .out(result));
	register r_cc (.in(cc_out), .load(out), .clear(clear), .out(flags));
	
	//Connect adder-subtractor
	ripple_addsub adder (.a(aout), .b(bout), .mode(mode), .out(adder_out), .cout(cout));
	
	//Send outputs to LEDs
	//flags = cc_reg;
	
	//Condition codes
	always @ (cout, adder_out) begin
		cc_out[3] = cout[7];						//COUT
		cc_out[2] = (cout[7] != cout[6]);  	//OVR
		cc_out[1] = adder_out[7]; 				//NEG
		cc_out[0] =	(adder_out == '0);		//ZERO
	end
	
endmodule
