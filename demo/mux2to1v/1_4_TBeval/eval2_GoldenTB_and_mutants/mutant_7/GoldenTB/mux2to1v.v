module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);

	assign out = sel ? b : {a[49:0], a[99:50]}; // Change: swapped the halves of a

endmodule
