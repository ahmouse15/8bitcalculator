module fulladder (
	input a, b, cin,
	output reg s,
	output reg cout
);
	always @ (a,b,cin)
		case ({a,b,cin})
			7'b000: begin cout = 0; s = 0; end
			7'b001: begin cout = 0; s = 1; end
			7'b010: begin cout = 0; s = 1; end
			7'b011: begin cout = 1; s = 0; end
			7'b100: begin cout = 0; s = 1; end
			7'b101: begin cout = 1; s = 0; end
			7'b110: begin cout = 1; s = 0; end
			7'b111: begin cout = 1; s = 1; end
		endcase
endmodule
