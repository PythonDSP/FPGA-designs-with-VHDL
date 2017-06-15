// comparator1BitVerilog.v

module comparator1BitVerilog(
	input wire x, y,
	output wire eq
	);

wire s0, s1;

assign s0 = ~x & ~y; // (not x) and (not y)
assign s1 = x & y;  // x and y
assign eq = s0 | s1; // s0 or s1

endmodule