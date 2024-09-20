module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);

	assign out = sel ? {b[0], b[99:1]} : a; // Change: rotated b to the left

endmodule
