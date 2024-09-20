module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);

	assign out = sel ? a : b; // Change: swapped a and b in the ternary operation

endmodule
