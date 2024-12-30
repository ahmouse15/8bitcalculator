module main(
	input trig,
	input [3:0] value,
	input clk,
	input clr_entry,
	input clr_all,
	
	output reset,
	output load_a,
	output load_b,
	output addsub,
	output load_r,
	output iu_au
);
	
	control_unit cu1(
		.trig(trig),
		.value(value), //[3:0]
		.clk(clk),
		.clr_entry(clr_entry),
		.clr_all(clr_all),
		
		.reset(reset),
		.load_a(load_a),
		.load_b(load_b),
		.addsub(addsub),
		.load_r(load_r),
		.iu_au(iu_au)
	);
	
endmodule
