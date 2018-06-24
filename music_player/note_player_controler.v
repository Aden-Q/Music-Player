////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc
////////////////////////////////////////////////////////////////////////////////

module note_player_controler(clk,reset,play_enable,load_new_note,timer_done,timer_clear,load,note_done);
	parameter RESET = 2'b00, WAIT = 2'b01, DONE = 2'b10, LOAD = 2'b11;		//states
	input clk,reset,play_enable,load_new_note,timer_done;
	output reg note_done,timer_clear,load;
	
	reg [1:0] state = RESET;
	
	always @(posedge clk) begin
		if(reset) begin
			state = RESET;
			timer_clear = 1;
			load = 0;
			note_done = 0;
		end
		else begin
			case(state)
				RESET: begin
					state =WAIT;
					timer_clear = 0;
					load = 0;
					note_done = 0;
				end
				WAIT: begin
					if(~play_enable) begin
						state = RESET;
						timer_clear = 1;
						load = 0;
						note_done = 0;
					end
					else if(timer_done) begin
						state = DONE;
						timer_clear = 1;
						load = 0;
						note_done = 1;
					end
					else if(load_new_note) begin
						state = LOAD;
						timer_clear = 1;
						load = 1;
						note_done = 0;
					end
				end
				DONE: begin
					state = WAIT;
					timer_clear = 0;
					load = 0;
					note_done = 0;
				end
				LOAD: begin
					state = WAIT;
					timer_clear = 0;
					load = 0;
					note_done = 0;
				end
				default: begin
					state = WAIT;
					timer_clear = 0;
					load = 0;
					note_done = 0;
				end
			endcase
		end
	end
	
endmodule

