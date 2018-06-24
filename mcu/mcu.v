////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc
////////////////////////////////////////////////////////////////////////////////

module mcu(clk,reset,play_pause,next,play,reset_play,song_done,song);
	parameter RESET = 2'b00, PAUSE = 2'b01, NEXT = 2'b10, PLAY = 2'b11;
	input clk,reset,play_pause,next,song_done;
	output play,reset_play;
	output [1:0] song;
	wire en;
	
	//mcu_controler instance
	mcu_controler control(
						.clk(clk),
						.reset(reset),
						.play_pause(play_pause),
						.next(next),
						.song_done(song_done),
						.play(play),
						.reset_play(reset_play),
						.NextSong(en)
						);
	
	//2 bits mcu_counter
	counter #(.N(4),.CounterBit(2)) counter_2bits(
												  .en(en),
												  .clk(clk),
												  .clr(reset),
												  .q(song)
											      );
endmodule

