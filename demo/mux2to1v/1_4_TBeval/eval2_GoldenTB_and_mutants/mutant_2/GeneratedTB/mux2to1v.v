module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);

	assign out = sel ? b : {a[98:0], a[99]}; // Change: rotated a to the right

endmodule
