////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc
////////////////////////////////////////////////////////////////////////////////

module music_player(clk,reset,play_pause,next,New_Frame,sample,play,song);
	parameter sim = 0;			//分频比控制参数
	input clk,reset,play_pause,next,New_Frame;
	output [15:0] sample;
	output play;
	output [1:0] song;
	
	//主控制器实例
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
	
	//song reader实例
	wire [5:0] note;
	wire [5:0] duration;
	wire new_note;
	wire note_done;
	song_reader sreader(
						.clk(clk),
						.reset(reset || reset_play),
						.play(play),
						.song(song),
						.song_done(song_done),
						.note(note),
						.duration(duration),
						.new_note(new_note),
						.note_done(note_done)
						);
						
	//note player实例
	wire beat;
	wire sampling_pulse;
	note_player note_player(
						    .clk(clk),
							.reset(reset || reset_play),
							.play_enable(play),
							.note_to_load(note),
							.duration_to_load(duration),
							.load_new_note(new_note),
							.note_done(note_done),
							.beat(beat);
							.sampling_pulse(sampling_pulse),
							.sample(sample),
							.sample_ready()
						    )
	//分频器实例
	beat_generator #(.n(sim?64:1000),.counter_bits(sim?6:10)) bgenerator(
															.clk(clk),
															.ci(sampling_pulse),
															.co(beat)
															);
	
	//同步化时钟实例
	synchronize sync(.clk(clk),
					 .in(New_Frame),
					 .out(sampling_pulse)
					 );
	
endmodule