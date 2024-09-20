module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);

	assign out = sel ? {b[99:50], a[49:0]} : a; // Change: mixed half of b and half of a when sel=1

endmodule
