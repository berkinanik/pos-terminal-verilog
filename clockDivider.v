module clockDivider(clockIn, clockOut);
	input clockIn; // 50 Mhz
	output reg clockOut = 0;
	
	parameter divValue = 0;
	
	// Output value will be
	// divValue = 50 / (2*clockOut) - 1
	
	integer counterValue = 0;
	
	always @(posedge clockIn) begin
		if (counterValue == divValue)
			counterValue <= 0;
		else
			counterValue <= counterValue+1;
	end
	
	always @(posedge clockIn) begin
		if (counterValue == divValue)
			clockOut <= ~clockOut;
		else
			clockOut <= clockOut;
	end
endmodule

module clockDivider_testbench;
	reg clockIn;
	wire clockOut;
	
	clockDivider DUT (.clockIn(clockIn), .clockOut(clockOut));
	
	initial begin
		clockIn = 0;
	end
	
	always begin
		clockIn <= 0; #10; clockIn <= 1; #10;
	end
endmodule
