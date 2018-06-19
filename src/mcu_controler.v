////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc
////////////////////////////////////////////////////////////////////////////////

module mcu_controler(clk,reset,play_pause,next,play,reset_play,song_done,NextSong);
	parameter RESET = 2'b00, PAUSE = 2'b01, NEXT = 2'b10, PLAY = 2'b11;
	input clk,reset,play_pause,next,song_done;
	output reg play,reset_play,NextSong;
	reg[1:0] state = RESET;			//initialization
	
	always @(posedge clk) begin
		if(reset) begin
			state = RESET; play = 0; NextSong = 0; reset_play = 1;
		end
		else begin
			case(state)
				RESET: begin
					state = PAUSE; play = 0; NextSong = 0; reset_play = 0;
				end
				PAUSE: begin
					if(play_pause) begin
						state = PLAY; play = 1; NextSong = 0; reset_play = 0;
					end
					else if(next) begin
						state = NEXT; play = 0; NextSong = 1; reset_play = 1;
					end
				end
				NEXT: begin
					state = PLAY; play = 1; NextSong = 0; reset_play = 0;
				end
				PLAY: begin
					if(play_pause) begin
						state = PAUSE; play = 0; NextSong = 0; reset_play = 0;
					end
					else if(next) begin
						state = NEXT; NextSong = 1; play = 0; reset_play = 1;
					end
					else if(song_done) begin
                        state = RESET; NextSong = 0; play = 0; reset_play = 1;
                    end
				end
				default: begin
					state = PAUSE; NextSong = 0; play = 0; reset_play = 0;
				end
			endcase
		end
	end
endmodule

