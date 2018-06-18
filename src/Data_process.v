////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc
////////////////////////////////////////////////////////////////////////////////

module Data_process(area,data_a,data_b);
	input area;
	input [15:0] data_a;
	output reg [15:0] data_b;
	
	always @(area,data_a,data_b) begin
		if(area==1) data_b = data_a[15:0]+1;
		else data_b = data_a[15:0];
	end
endmodule

