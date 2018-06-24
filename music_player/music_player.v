////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc
////////////////////////////////////////////////////////////////////////////////

module music_player(clk,reset,play_pause,next,NewFrame,sample,play,song);
	parameter sim = 0;			//counter_n control parameter
	input clk,reset,play_pause,next,NewFrame;
	output [15:0] sample;
	output play;
	output [1:0] song;
	
	//mcu instance
	wire reset_play, song_done;
	mcu umcu(
			.clk(clk),
			.reset(reset),
			.play_pause(play_pause),
			.next(next),
			.play(play),
			.reset_play(reset_play),
			.song(song),
			.song_done(song_done)
			);
	
	//song_reader instance
	wire [5:0] note;
	wire [5:0] duration;
	wire new_note;
	wire note_done;
	song_reader sreader(
						.clk(clk),
						.reset(reset_play),
						.play(play),
						.song(song),
						.song_done(song_done),
						.note(note),
						.duration(duration),
						.new_note(new_note),
						.note_done(note_done)
						);
						
	//note_player instance
	wire beat;
	wire sampling_pulse;
	note_player note_player(
						    .clk(clk),
							.reset(reset_play),
							.play_enable(play),
							.note_to_load(note),
							.duration_to_load(duration),
							.load_new_note(new_note),
							.note_done(note_done),
							.beat(beat),
							.sampling_pulse(sampling_pulse),
							.sample(sample),
							.sample_ready()
						    );
	//conter_n instance
	counter_n	#(.n(sim?64:1000),.counter_bits(sim?6:10)) counter_n(
															.clk(clk),
															.r(reset),
															.en(sampling_pulse),
															.co(beat),
															.q()
															);
	
	//synchronize clk instance
	synchronize sync(.clk(clk),
					 .in(NewFrame),
					 .out(sampling_pulse)
					 );
	
endmodule