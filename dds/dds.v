////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc
////////////////////////////////////////////////////////////////////////////////

module dds(clk,reset,k,sampling_pulse,sample_ready,sample);
	input clk,reset,sampling_pulse;
	input [21:0] k;
	output sample_ready;
	output [15:0] sample;
	wire [21:0] raw_addr,addr;
	
	//full_adder实例
	full_adder #(.n(22)) adder(.a(raw_addr),
							   .b(k),
							   .s(addr),
							   .ci(1'b0),
							   .co()
							   );
			
	//D filp flop
	D_FFRE #(.width(22)) dffre1(.clk(clk),
							   .r(reset),
							   .en(sampling_pulse),
							   .d(addr),
							   .q(raw_addr)
							   );
	
	//D filp flop
	wire area;
	D_FFR #(.width(1)) dffr1(.clk(clk),
							.r(reset),
							.d(raw_addr[21]),
							.q(area)
							);
							
	//地址处理模块
	wire [9:0] rom_addr;
	Addr_process addr_process(.addr_raw(raw_addr[20:10]),
							  .addr_rom(rom_addr)
							  );
	
	//从正弦信号表中读取数据
	wire [15:0] raw_data;
	sine_rom srom(.clk(clk),
				  .addr(rom_addr),
				  .dout(raw_data)
				  );
				  
	//数据处理模块
	wire [15:0] data;
	Data_process data_process(.area(area),
							  .data_a(raw_data),
							  .data_b(data)
							  );
						
	//D flip flop
	D_FFRE #(.width(16)) dffre2(.clk(clk),
								.r(reset),
								.en(sampling_pulse),
								.d(data),
								.q(sample)
								);
	
	//D flip flop
	D_FFR #(.width(1)) dffr2(.clk(clk),
							 .r(reset),
							 .d(sampling_pulse),
							 .q(sample_ready)
							 );
endmodule

