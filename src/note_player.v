////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc
////////////////////////////////////////////////////////////////////////////////

module note_player(clk,reset,play_enable,note_to_load,duration_to_load,load_new_note,
				   note_done,sampling_pulse,beat,sample,sample_ready);
	input clk,reset,play_enable,load_new_note,sampling_pulse,beat;
	input [5:0] note_to_load,duration_to_load;
	output note_done,sample_ready;
	output [15:0] sample;
	wire load,timer_done,timer_clear;
	wire [5:0] addr;
	wire [19:0] dout;
	wire [21:0] k;

	assign k[21:20]=2'b00;
	assign k[19:0]=dout;
	//controler instance
	note_play_controler(
						.clk(clk),
						.reset(reset),
						.play_enable(play_enable),
						.load_new_note(load_new_note)
						.load(load),
						.timer_done(timer_done),
						.timer_clear(timer_clear),
						.note_done(note_done)
						);
		
	//note counter
	note_counter ncounter(
						  .clk(clk),
						  .beat(beat),
						  .timer_clear(timer_clear),
						  .duration_to_load(duration_to_load),
						  .timer_done(timer_done)
						  );
						  
	//D flip flop
	D_FFRE #(.width(6)) DFF(
							.clk(clk),
							.r(reset || (~play_enable)),
							.en(load),
							.d(note_to_load),
							.q(addr)
							);
	
	//frequency rom
	frequency_rom f_rom(
						.clk(clk),
						.dout(dout),
						.addr(addr)
						);
	
	//dds instance
	dds ince_dds(
				.clk(clk),
				.reset(reset || (~play_enable)),
				.k(k),
				.sampling_pulse(sampling_pulse),
				.sample_ready(sample_ready),
				.sample(sample)
				);					
endmodule

