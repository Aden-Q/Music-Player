////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc

////////////////////////////////////////////////////////////////////////////////

module beat_generator(co,ci,clk);
	parameter n = 1000, counter_bits = 10;
	input clk,ci;
	output co;
	reg[counter_bits-1:0] q = 0;
	
	assign co = (q == N-1) && ci;
	
	always @(posedge clk) begin
		if(ci) begin
			if(q == n - 1) q = 0;
			else q = q + 1;
		end
	end
	
endmodule

