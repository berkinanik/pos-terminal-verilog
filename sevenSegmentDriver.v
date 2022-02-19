module sevenSegmentDriver(
     hex,
     seg
);
  
	input [3:0] hex;
	output [6:0] seg;
	reg [6:0] seg;

	always @(hex)
	begin
		case (hex)
			'h0 : seg = 7'b1000000;
			'h1 : seg = 7'b1111001;
			'h2 : seg = 7'b0100100;
			'h3 : seg = 7'b0110000;
			'h4 : seg = 7'b0011001;
			'h5 : seg = 7'b0010010;
			'h6 : seg = 7'b0000010;
			'h7 : seg = 7'b1111000;
			'h8 : seg = 7'b0000000;
			'h9 : seg = 7'b0010000;
			'ha : seg = 7'b0001000; // "A"
			'hb : seg = 7'b1111111; // " "
			'hc : seg = 7'b1000110; // "K"
			'hd : seg = 7'b1000111; // "L"
			'he : seg = 7'b0000110; // "E"
			'hf : seg = 7'b0001110; // "F"
			default : seg = 7'b1111111; 
		endcase
	end
	
endmodule
