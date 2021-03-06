////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc

////////////////////////////////////////////////////////////////////////////////

module D_FFRE(clk,r,en,d,q);
	parameter width = 1;
	input clk,r,en;
	input [width-1:0] d;
	output reg [width-1:0] q = 0;
	always @(posedge clk) begin
		if(r) q<={width{1'b0}};
		else if(en) q <= d;
		else q <= q;
	end
endmodule

