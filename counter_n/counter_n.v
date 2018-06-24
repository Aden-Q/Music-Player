
////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc
////////////////////////////////////////////////////////////////////////////////

module counter_n(clk,r,en,co,q);
	parameter n=5;
	parameter counter_bits=3;
	// Inputs
	input clk,en,r;
	// Outputs
	output co;
	output reg [counter_bits-1:0] q;
	assign co = (q == (n-1)) && en;
always @(posedge clk)
	case({clk,r,en})
	3'b110:q=0;
	3'b111:q=0;
	3'b101:q=(q+1) % n;
	endcase
endmodule

