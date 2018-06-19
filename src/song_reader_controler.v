////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc
////////////////////////////////////////////////////////////////////////////////

module song_reader_controler(clk,reset,note_done,play,new_note);
	parameter RESET = 2'b00, NEW_NOTE = 2'b01, WAIT = 2'b10, NEXT_NOTE = 2'b11;		//four states
	input clk, reset, note_done, play;
	output reg new_note = 0;
	reg[1:0] state;
	
	always @(posedge clk) begin
		if(reset) begin
			state <= RESET;
			new_note <= 0;
		end
		else if(play) begin
			case(state)
				RESET: begin
					state <= NEW_NOTE;
					new_note <= 1;
				end
				NEW_NOTE: begin
					state <= WAIT;
					new_note <= 0;
				end
				WAIT: begin
					begin if(note_done)
						state <= NEXT_NOTE;
						new_note <= 0;
					end
				end	
				NEXT_NOTE: begin
					state <= NEW_NOTE;
					new_note <= 1;
				end
				default: begin
					state <= RESET; new_note <=0;
				end	
			endcase
		end
		else begin
			state <= RESET;
			new_note <= 0;
		end
	end
endmodule

