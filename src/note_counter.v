////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc
////////////////////////////////////////////////////////////////////////////////

module note_counter(clk,beat,duration_to_load,timer_clear,timer_done);
	input clk,beat,timer_clear;
	input [5:0] duration_to_load;
	output timer_done;
	reg [5:0] q;
	
	assign timer_done = ((q == duration_to_load) && beat);
	
	always @(posedge clk) begin
		if(timer_clear) begin
			q = 0;
		end
		else if(beat) begin
			if(q == duration_to_load) q = 0;			//重置
			else q = q+1;		//计数加1
		end
	end
	
endmodule

