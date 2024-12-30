module signed_addsub (
			input [3:0] a,
			input [3:0] b,
			input cin, // 0 => add, 1 => subtract
			
			output reg [3:0] r,
			output reg cout
		);
	
		wire [2:0] c;
		reg [3:0] b_val;
		wire [3:0] r_out;
		wire cout_out;
		
		initial b_val = b;
		
		fulladder fa0 (.a(a[0]), .b(b_val[0]), .cin(cin), .s(r_out[0]), .cout(c[0]));
		fulladder fa1 (.a(a[1]), .b(b_val[1]), .cin(c[0]), .s(r_out[1]), .cout(c[1]));
		fulladder fa2 (.a(a[2]), .b(b_val[2]), .cin(c[1]), .s(r_out[2]), .cout(c[2]));
		fulladder fa3 (.a(a[3]), .b(b_val[3]), .cin(c[2]), .s(r_out[3]), .cout(cout_out));
		
		always @ (a,b, cin) begin
			if (cin) b_val = ~b+1;
			else b_val = b;
			
			r = r_out;
			cout = cout_out;
		end
endmodule
