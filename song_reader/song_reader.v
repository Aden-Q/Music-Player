////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc
////////////////////////////////////////////////////////////////////////////////

module song_reader(clk,reset,play,song,note_done,song_done,note,duration,new_note);
	input clk,reset,play,note_done;
	input [1:0] song;
	output song_done,new_note;
	output [5:0] note, duration;
	wire co;			//address counter co
	wire [4:0] q; 		//decide which note, state for address counter
	wire [6:0] addr;	//song_rom address
	
	assign addr = {song[1:0], q[4:0]};
	
	//song_reader controler instance
	song_reader_controler song_reader_mcu(
								   .clk(clk),
								   .reset(reset),
								   .note_done(note_done),
								   .play(play),
								   .new_note(new_note)
								   );
	//address counter instance
	song_reader_address_counter address_counter(
												.clk(clk),
												.reset(reset),
												.note_done(note_done),
												.q(q),
												.co(co)
												);
	//song_rom instance
	song_rom song_info(
					   .clk(clk),
					   .dout({note,duration}),
					   .addr(addr)
					   );
	//judge if a note is endmodule
	note_end nend(
				  .clk(clk),
				  .in(co||(duration == 0)),
				  .out(song_done)
				  );
endmodule

