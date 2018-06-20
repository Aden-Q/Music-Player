////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc
////////////////////////////////////////////////////////////////////////////////

module Addr_process(addr_raw,addr_rom);
	input [10:0]  addr_raw;
	output reg[9:0] addr_rom;
	always @(addr_raw,addr_rom) begin
		if(addr_raw[10] == 0) addr_rom = addr_raw[9:0];
		else if(addr_raw == 1024) addr_rom = 1023;
		else addr_rom = ~addr_raw[9:0] + 1;
	end
endmodule

