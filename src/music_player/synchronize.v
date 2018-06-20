////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc
////////////////////////////////////////////////////////////////////////////////

module synchronize(clk,in,out);
	input clk,in;
	output out;
	wire mq, eq;
	
	//D flip flop
	D_FFRE #(.width(1)) dffre1(.clk(clk),
			               .r(1'b0),
						   .en(1'b1),
			               .d(in),
			               .q(mq)
				           );
	
	D_FFRE #(.width(1)) diffe2(.clk(clk),
				           .r(1'b0),
					       .en(1'b1),
				           .d(mq),
				           .q(eq)
				           );
	assign out = (mq && (~eq));
endmodule

