module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);

	assign out = sel ? {b[50:0], b[99:51]} : a; // Change: swapped the halves of b and made an off by one change

endmodule
