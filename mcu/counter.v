////////////////////////////////////////////////////////////////////////////////
// Company: qzc
// Engineer:zju
////////////////////////////////////////////////////////////////////////////////

module counter(en,clk,clr,q);
	parameter N = 4;			//default N states
	parameter CounterBit = 2;	//default 2 Bits counter
	input en,clk,clr;
	output reg [CounterBit-1:0] q = 0;
	always @(posedge clk) begin
		if(clr) q = 0;
		else if(en) begin
			if(q==N-1) q=0;		//one cycle completed
			else q = q + 1;		//add 1
		end
	end
endmodule

