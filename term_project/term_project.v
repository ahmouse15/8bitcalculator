module term_project(
		input clr_entry,
		input clr_all,
		input clk_in,
		
		input [3:0] row,
		output [3:0] col,
		
		output [0:6] hex0,
		output [0:6] hex1,
		output [0:6] hex2,
		output sign,
		
		output ovr,
		output zero,
		output invalid
	);
	wire load_a, load_b, load_r, addsub;
	
	wire iu_au; //Output mux selector: 0 => load IU, 1 => load AU
	
	wire reset, trig, valid;
	
	wire [3:0] iu_value;
	
	wire [7:0] iu_out, au_out, mux_out;
	
	wire [3:0] flags;
	
	assign ovr = flags[2];
	assign zero = flags[0];
	assign invalid = ~valid;
	
	
	//Control unit
	control_unit (	.trig(trig), .clk(clk_in), .value(iu_value), .clr_entry(clr_entry), .clr_all(clr_all),
						.reset(reset), .load_a(load_a), .load_b(load_b), .addsub(addsub),
						.load_r(load_r), .iu_au(iu_au));
	
	//Input unit
	input_unit (.clk(clk_in), .reset(reset), .row(row), .col(col), 
					.out(iu_out), .value(iu_value), .trig(trig), .valid(valid));
	
	//Select from either IU or AU to output to display
	mux (.a(iu_out), .b(au_out), .select(iu_au), .out(mux_out));
	
	//Arithmetic Unit
	alu (	.in(iu_out), .loadA(load_a), .loadB(load_b), .out(load_r), .clear(clr_all), .mode(addsub),
			.result(au_out), .flags(flags));
	
	//Output unit
	output_unit (.in(mux_out), .hex0(hex0), .hex1(hex1), .hex2(hex2), .sign(sign));
	
endmodule
