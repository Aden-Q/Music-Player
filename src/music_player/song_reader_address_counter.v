////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc
////////////////////////////////////////////////////////////////////////////////

module song_reader_address_counter(clk,reset,note_done,q,co);
	input clk,reset,note_done;
	output co;
	output reg[4:0] q;
	
	assign co = &q && note_done;		//歌曲播放结束的标志
	
	always @(posedge clk) begin
		if(reset) q = 0;
		else if(note_done) begin
			if(&q) q = 0;				//若计数到了最大值，则回到0
			else q = q + 1;				//否则计数加1
		end
	end
endmodule

