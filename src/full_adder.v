////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qzc
////////////////////////////////////////////////////////////////////////////////

module full_adder(a,b,s,ci,co);
	parameter n = 22;
	input [n-1:0] a,b;
	output reg [n-1:0] s;
	input ci;
	output co;
	
	integer il
	reg [n-1:0] s;
	reg [n:0] c;
	
	assign co = c[n];
	
	always @(*) begin
		c[0] = ci;
		for(i = 0;i <= n-1;i = i+1) begin
			s[i] = a[i] ^ b[i] ^ c[i];			//当前位
			c[i+1] = a[i] && b[i] || a[i]&&c[i] || b[i] && c[i];	//进位
		end
	end
endmodule

