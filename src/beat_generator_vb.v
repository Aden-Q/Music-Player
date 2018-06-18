`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc
////////////////////////////////////////////////////////////////////////////////

module beat_generator_tb_v;
	reg clk,ci;
	wire co;
	beat_generator #(.n(5),.counter_bits(3)) uut (
		.clk(clk),
		.ci(ci),
		.co(co)
		);
		
	always #5 clk = ~clk;
	
	initial begin
		clk = 0;
		ci = 1;
		#(10*15+5);
		repeat (15) begin
		#(10*3) ci = 1;
		#10 ci = 0;
		end
		#10 $stop
	end
endmodule

