`timescale 1ns / 1ps

module fpgaDriver(clk, led0, led1, led2, led3, led4, led5, led6, led7, led8, led9,
	switch0, switch1, switch2, switch8, switch9,
	button0, button1, button2, button3,
	hex0, hex1, hex2, hex3, hex4, hex5
);
	input clk, switch0, switch1, switch2, switch8, switch9, button0, button1, button2, button3;
	output wire led0, led1, led2, led3, led4, led5, led6, led7, led8, led9;
	output wire [6:0] hex0, hex1, hex2, hex3, hex4, hex5;
	
	wire [1:0] deviceState;
	parameter showCartTotal = 'b01;
	parameter addItemToCart = 'b10;
	parameter removeItemFromCart = 'b11;
	
	assign led9 = deviceState[1];
	assign led8 = deviceState[0];
	
	assign deviceState[0] = switch8;
	assign deviceState[1] = switch9;
	
	wire inputState;
	assign led0 = inputState;
	assign inputState = switch0;
	
	reg [3:0] hexD0 = 'hb;
	reg [3:0] hexD1 = 'hb;
	reg [3:0] hexD2 = 'hb;
	reg [3:0] hexD3 = 'hb;
	reg [3:0] hexD4 = 'hb;
	reg [3:0] hexD5 = 'hb;
	
	sevenSegmentDriver sSegDriver0(hexD0, hex0);
	sevenSegmentDriver sSegDriver1(hexD1, hex1);
	sevenSegmentDriver sSegDriver2(hexD2, hex2);
	sevenSegmentDriver sSegDriver3(hexD3, hex3);
	sevenSegmentDriver sSegDriver4(hexD4, hex4);
	sevenSegmentDriver sSegDriver5(hexD5, hex5);
	
	reg [3:0] input3 = 'hb;
	reg [3:0] input2 = 'hb;
	reg [3:0] input1 = 'hb;
	reg [3:0] input0 = 'hb;
	reg [3:0] inputDisplay3 = 'hb;
	reg [3:0] inputDisplay2 = 'hb;
	reg [3:0] inputDisplay1 = 'hb;
	reg [3:0] inputDisplay0 = 'hb;
	reg [3:0] inputAmount = 'h0;
	reg [3:0] inputDisplayAmount = 'h0;
	reg inputCounter = 0;
	reg buttonPressed;
	reg [15:0] inputtedId = 'd0;
	reg [3:0] inputtedAmount = 'd0;
	reg success;
	
	assign led2 = ~button0;
	assign led3 = ~button1;
	assign led4 = ~button2;
	assign led5 = ~button3;
	
	always @(posedge clk) begin
		if (~button3 || ~button2 || ~button1 || ~button0) begin
			buttonPressed = 1;
		end
		else begin
			buttonPressed = 0;
		end
	end
	
	always @(posedge clk) begin
		if (inputState == 1 && deviceState == addItemToCart && inputCounter == 0) begin
			if (input3 == 'hb) begin
				if (~button0) begin
					input3 <= 'h4;
					inputDisplay3 <= 'h4;
				end
				else if (~button1) begin
					input3 <= 'h3;
					inputDisplay3 <= 'h3;
				end
				else if (~button2) begin
					input3 <= 'h2;
					inputDisplay3 <= 'h2;
				end
				else if (~button3) begin
					input3 <= 'h1;
					inputDisplay3 <= 'h1;
				end
			end
			else if (input2 == 'hb) begin
				if (~button0) begin
					input2 <= 'h4;
					inputDisplay2 <= 'h4;
				end
				else if (~button1) begin
					input2 <= 'h3;
					inputDisplay2 <= 'h3;
				end
				else if (~button2) begin
					input2 <= 'h2;
					inputDisplay2 <= 'h2;
				end
				else if (~button3) begin
					input2 <= 'h1;
					inputDisplay2 <= 'h1;
				end
			end
			else if (input1 == 'hb) begin
				if (~button0) begin
					input1 <= 'h4;
					inputDisplay1 <= 'h4;
				end
				else if (~button1) begin
					input1 <= 'h3;
					inputDisplay1 <= 'h3;
				end
				else if (~button2) begin
					input1 <= 'h2;
					inputDisplay1 <= 'h2;
				end
				else if (~button3) begin
					input1 = 'h1;
					inputDisplay1 = 'h1;
				end
			end
			else if (input0 == 'hb) begin
				if (~button0) begin
					input0 <= 'h4;
					inputDisplay0 <= 'h4;
				end
				else if (~button1) begin
					input0 <= 'h3;
					inputDisplay0 <= 'h3;
				end
				else if (~button2) begin
					input0 <= 'h2;
					inputDisplay0 <= 'h2;
				end
				else if (~button3) begin
					input0 <= 'h1;
					inputDisplay0 <= 'h1;
				end
			end
			else if (inputAmount == 'h0) begin
				if (~button0) begin
					inputAmount <= 'h4;
					inputDisplayAmount <= 'h4;
				end
				else if (~button1) begin
					inputAmount <= 'h3;
					inputDisplayAmount <= 'h3;
				end
				else if (~button2) begin
					inputAmount <= 'h2;
					inputDisplayAmount <= 'h2;
				end
				else if (~button3) begin
					inputAmount <= 'h1;
					inputDisplayAmount <= 'h1;
				end
			end
			else if (input3 != 'hb && input2 != 'hb && input1 != 'hb && input0 != 'hb && inputAmount != 'h0) begin
				inputtedId = input3 * 1000 + input2 * 100 + input1 * 10 + input0;
				inputtedAmount = inputAmount;
				addItemToCartTask(inputtedId, inputtedAmount, success);
				input3 <= 'hb;
				input2 <= 'hb;
				input1 <= 'hb;
				input0 <= 'hb;
				inputAmount <= 'h0;
			end
			inputCounter = 1;
		end
		else if (inputState == 1 && deviceState == removeItemFromCart && inputCounter == 0) begin
			if (input3 == 'hb) begin
				if (~button0) begin
					input3 <= 'h4;
					inputDisplay3 <= 'h4;
				end
				else if (~button1) begin
					input3 <= 'h3;
					inputDisplay3 <= 'h3;
				end
				else if (~button2) begin
					input3 <= 'h2;
					inputDisplay3 <= 'h2;
				end
				else if (~button3) begin
					input3 <= 'h1;
					inputDisplay3 <= 'h1;
				end
			end
			else if (input2 == 'hb) begin
				if (~button0) begin
					input2 <= 'h4;
					inputDisplay2 <= 'h4;
				end
				else if (~button1) begin
					input2 <= 'h3;
					inputDisplay2 <= 'h3;
				end
				else if (~button2) begin
					input2 <= 'h2;
					inputDisplay2 <= 'h2;
				end
				else if (~button3) begin
					input2 <= 'h1;
					inputDisplay2 <= 'h1;
				end
			end
			else if (input1 == 'hb) begin
				if (~button0) begin
					input1 <= 'h4;
					inputDisplay1 <= 'h4;
				end
				else if (~button1) begin
					input1 <= 'h3;
					inputDisplay1 <= 'h3;
				end
				else if (~button2) begin
					input1 <= 'h2;
					inputDisplay1 <= 'h2;
				end
				else if (~button3) begin
					input1 = 'h1;
					inputDisplay1 = 'h1;
				end
			end
			else if (input0 == 'hb) begin
				if (~button0) begin
					input0 <= 'h4;
					inputDisplay0 <= 'h4;
				end
				else if (~button1) begin
					input0 <= 'h3;
					inputDisplay0 <= 'h3;
				end
				else if (~button2) begin
					input0 <= 'h2;
					inputDisplay0 <= 'h2;
				end
				else if (~button3) begin
					input0 <= 'h1;
					inputDisplay0 <= 'h1;
				end
			end
			else if (input3 != 'hb && input2 != 'hb && input1 != 'hb && input0 != 'hb) begin
				inputtedId = input3 * 1000 + input2 * 100 + input1 * 10 + input0;
				removeItemFromCartTask(inputtedId, success);
				input3 <= 'hb;
				input2 <= 'hb;
				input1 <= 'hb;
				input0 <= 'hb;
			end
			inputCounter = 1;
		end
		else if (inputCounter == 1 && buttonPressed == 0) begin
			inputCounter = 0;
		end
		else if (~button3 && ~button2) begin
			input3 <= 'hb;
			input2 <= 'hb;
			input1 <= 'hb;
			input0 <= 'hb;
			inputAmount <= 'h0;
			inputDisplay3 <= 'hb;
			inputDisplay2 <= 'hb;
			inputDisplay1 <= 'hb;
			inputDisplay0 <= 'hb;
			inputDisplayAmount <= 'h0;
		end
	end
	
	always @(deviceState, buttonPressed) begin
		case (deviceState)
			showCartTotal:
				begin
					hexD0 <= cartTotal % 10;
					hexD1 <= (cartTotal % 100) / 10;
					hexD2 <= (cartTotal % 1000) / 100;
					hexD3 <= (cartTotal % 10000) / 1000 == 0 ? 'hb : (cartTotal % 10000) / 1000;
					hexD4 <= (cartTotal % 100000) / 10000 == 0 ? 'hb : (cartTotal % 100000) / 10000;
					hexD5 <= (cartTotal / 100000) == 0 ? 'hb : cartTotal / 100000;
				end
			addItemToCart:
				begin
					if (inputDisplay3 == 'hb) begin
						hexD0 <= 'h0;
						hexD1 <= 'h0;
						hexD2 <= 'ha;
						hexD3 <= 'hb;
						hexD4 <= 'hb;
						hexD5 <= 'hb;
					end
					else begin
						hexD0 <= inputDisplayAmount;
						hexD1 <= 'hb;
						hexD2 <= inputDisplay0;
						hexD3 <= inputDisplay1;
						hexD4 <= inputDisplay2;
						hexD5 <= inputDisplay3;
					end
				end
			removeItemFromCart:
				begin
					if (inputDisplay3 == 'hb) begin
						hexD0 <= 'hd;
						hexD1 <= 'he;
						hexD2 <= 'h0;
						hexD3 <= 'hb;
						hexD4 <= 'hb;
						hexD5 <= 'hb;
					end
					else begin
						hexD0 <= 'hb;
						hexD1 <= inputDisplay0;
						hexD2 <= inputDisplay1;
						hexD3 <= inputDisplay2;
						hexD4 <= inputDisplay3;
						hexD5 <= 'hb;
					end
				end
			default:
				begin
					hexD0 <= 'hb;
					hexD1 <= 'hb;
					hexD2 <= 'hb;
					hexD3 <= 'hb;
					hexD4 <= 'hb;
					hexD5 <= 'hb;
				end
		endcase
	end
	
	// Amount of items in Cart
	reg [3:0] bananaCount;
	reg [3:0] potatoCount;
	reg [3:0] tomatoCount;
	reg [3:0] peachCount;
	reg [3:0] appleCount;
	reg [3:0] pineappleCount;
	reg [3:0] orangeCount;
	reg [3:0] mandarinCount;
	reg [3:0] cherryCount;
	reg [3:0] grapeCount;
	reg [3:0] pearCount;
	reg [3:0] cucumberCount;
	
	// Cart Details
	reg [4:0] cartItemCount;
	reg [15:0] cartTotal;
	
	// System's Working Status and Mode Parameters
	// These are the states of the system depending on the switch positions
	parameter viewItemsMode = 1'b0;
	parameter viewCartMode = 1'b1;
	parameter addItemMode = 1'b0;
	parameter removeItemMode = 1'b1;
	
	// Item Barcode Numbers
	parameter bananaId = 'd3124;
	parameter potatoId = 'd4132;
	parameter tomatoId = 'd4133;
	parameter peachId = 'd3121;
	parameter appleId = 'd3133;
	parameter pineappleId = 'd3214;
	parameter orangeId = 'd1111;
	parameter mandarinId = 'd2222;
	parameter cherryId = 'd3333;
	parameter grapeId = 'd4444;
	parameter pearId = 'd1122;
	parameter cucumberId = 'd3344;
	
	// Item Predefined Prices (in Kurus 0.01₺ = 1)
	parameter bananaPrice = 'd250;
	parameter potatoPrice = 'd50 ;
	parameter tomatoPrice = 'd75;
	parameter peachPrice = 'd200;
	parameter applePrice = 'd100;
	parameter pineapplePrice = 'd995;
	parameter orangePrice = 'd450;
	parameter mandarinPrice = 'd300;
	parameter cherryPrice = 'd400;
	parameter grapePrice = 'd600;
	parameter pearPrice = 'd500;
	parameter cucumberPrice = 'd150;
	
	// Regulation Constants
	parameter maxItemTypeInCart= 'd6;
	parameter maxItemCountOfOneType = 'd4;
	
	// Method to add Item to Cart:
	// Takes item barcode number & item amount as input.
	// Necessary conditions and possible scenarios checked using if-else blocks.
	// Using switch case block updates necessary items amount count and also the cart details.
	// Depending on the process outputs success: 0 / 1.
	task addItemToCartTask;
		input [15:0] addedItemId;
		input [3:0] addedItemAmount;
		output success;
		begin
			if (cartItemCount < maxItemTypeInCart) begin
				case (addedItemId)
				bananaId:
					begin
						if (bananaCount < maxItemCountOfOneType) begin
							if ((bananaCount + addedItemAmount) <= maxItemCountOfOneType) begin
								if (bananaCount == 'd0) begin
									cartItemCount = cartItemCount + 'd1;
								end
								bananaCount = bananaCount + addedItemAmount;
								cartTotal = cartTotal + (addedItemAmount * bananaPrice);
								success = 'b1;
							end
							else begin
								success = 'b0;
							end
						end
						else begin
							success = 'b0;
						end
					end
				potatoId:
					begin
						if (potatoCount < maxItemCountOfOneType) begin
							if ((potatoCount + addedItemAmount) <= maxItemCountOfOneType) begin
								if (potatoCount == 'd0) begin
									cartItemCount = cartItemCount + 'd1;
								end
								potatoCount = potatoCount+ addedItemAmount;
								cartTotal = cartTotal + (addedItemAmount * potatoPrice);
								success = 'b1;
							end
							else begin
								success = 'b0;
							end
						end
						else begin
							success = 'b0;
						end
					end
				tomatoId:
					begin
						if (tomatoCount < maxItemCountOfOneType) begin
							if ((tomatoCount + addedItemAmount) <= maxItemCountOfOneType) begin
								if (tomatoCount == 'd0) begin
									cartItemCount = cartItemCount + 'd1;
								end
								tomatoCount = tomatoCount + addedItemAmount;
								cartTotal = cartTotal + (addedItemAmount * tomatoPrice);
								success = 'b1;
							end
							else begin
								success = 'b0;
							end
						end
						else begin
							success = 'b0;
						end
					end
				peachId:
					begin
						if (peachCount < maxItemCountOfOneType) begin
							if ((peachCount + addedItemAmount) <= maxItemCountOfOneType) begin
								if (peachCount == 'd0) begin
									cartItemCount = cartItemCount + 'd1;
								end
								peachCount = peachCount+ addedItemAmount;
								cartTotal = cartTotal + (addedItemAmount * peachPrice);
								success = 'b1;
							end
							else begin
								success = 'b0;
							end
						end
						else begin
							success = 'b0;
						end
					end
				appleId:
					begin
						if (appleCount < maxItemCountOfOneType) begin
							if ((appleCount + addedItemAmount) <= maxItemCountOfOneType) begin
								if (appleCount == 'd0) begin
									cartItemCount = cartItemCount + 'd1;
								end
								appleCount = appleCount+ addedItemAmount;
								cartTotal = cartTotal + (addedItemAmount * applePrice);
								success = 'b1;
							end
							else begin
								success = 'b0;
							end
						end
						else begin
							success = 'b0;
						end
					end
				pineappleId:
					begin
						if (pineappleCount < maxItemCountOfOneType) begin
							if ((pineappleCount + addedItemAmount) <= maxItemCountOfOneType) begin
								if (pineappleCount == 'd0) begin
									cartItemCount = cartItemCount + 'd1;
								end
								pineappleCount = pineappleCount + addedItemAmount;
								cartTotal = cartTotal + (addedItemAmount * pineapplePrice);
								success = 'b1;
							end
							else begin
								success = 'b0;
							end
						end
						else begin
							success = 'b0;
						end
					end
				orangeId:
					begin
						if (orangeCount < maxItemCountOfOneType) begin
							if ((orangeCount + addedItemAmount) <= maxItemCountOfOneType) begin
								if (orangeCount == 'd0) begin
									cartItemCount = cartItemCount + 'd1;
								end
								orangeCount = orangeCount + addedItemAmount;
								cartTotal = cartTotal + (addedItemAmount * orangePrice);
								success = 'b1;
							end
							else begin
								success = 'b0;
							end
						end
						else begin
							success = 'b0;
						end
					end
				mandarinId:
					begin
						if (mandarinCount < maxItemCountOfOneType) begin
							if ((mandarinCount + addedItemAmount) <= maxItemCountOfOneType) begin
								if (mandarinCount == 'd0) begin
									cartItemCount = cartItemCount + 'd1;
								end
								mandarinCount = mandarinCount + addedItemAmount;
								cartTotal = cartTotal + (addedItemAmount * mandarinPrice);
							end
							else begin
								success = 'b0;
							end
						end
						else begin
							success = 'b0;
						end
					end
				cherryId:
					begin
						if (cherryCount < maxItemCountOfOneType) begin
							if ((cherryCount + addedItemAmount) <= maxItemCountOfOneType) begin
								if (cherryCount == 'd0) begin
									cartItemCount = cartItemCount + 'd1;
								end
								cherryCount = cherryCount + addedItemAmount;
								cartTotal = cartTotal + (addedItemAmount * cherryPrice);
								success = 'b1;
							end
							else begin
								success = 'b0;
							end
						end
						else begin
							success = 'b0;
						end
					end
				grapeId:
					begin
						if (grapeCount < maxItemCountOfOneType) begin
							if ((grapeCount + addedItemAmount) <= maxItemCountOfOneType) begin
								if (grapeCount == 'd0) begin
									cartItemCount = cartItemCount + 'd1;
								end
								grapeCount = grapeCount + addedItemAmount;
								cartTotal = cartTotal + (addedItemAmount * grapePrice);
								success = 'b1;
							end
							else begin
								success = 'b0;
							end
						end
						else begin
							success = 'b0;
						end
					end
				pearId:
					begin
						if (pearCount < maxItemCountOfOneType) begin
							if ((pearCount + addedItemAmount) <= maxItemCountOfOneType) begin
								if (pearCount == 'd0) begin
									cartItemCount = cartItemCount + 'd1;
								end
								pearCount = pearCount + addedItemAmount;
								cartTotal = cartTotal + (addedItemAmount * pearPrice);
								success = 'b1;
							end
							else begin
								success = 'b0;
							end
						end
						else begin
							success = 'b0;
						end
					end
				cucumberId:
					begin
						if (cucumberCount < maxItemCountOfOneType) begin
							if ((cucumberCount + addedItemAmount) <= maxItemCountOfOneType) begin
								if (cucumberCount == 'd0) begin
									cartItemCount = cartItemCount + 'd1;
								end
								cucumberCount = cucumberCount + addedItemAmount;
								cartTotal = cartTotal + (addedItemAmount * cucumberPrice);
								success = 'b1;
							end
							else begin
								success = 'b0;
							end
						end
						else begin
							success = 'b0;
						end
					end
				endcase
			end
			else begin
				success = 'b0;
			end
		end
	endtask
	
	// Method to remove item from Cart:
	// Takes item barcode number.
	// Necessary conditions and possible scenarios checked using if-else blocks.
	// Using switch case block updates necessary items amount count and also the cart details.
	// Depending on the process outputs success: 0 / 1.
	task removeItemFromCartTask;
		input [15:0] removedItemId;
		output success;
		begin
			if (cartItemCount > 'd0) begin
				case (removedItemId)
				bananaId:
					begin
						if (bananaCount > 'd0) begin
							cartTotal = cartTotal - (bananaCount * bananaPrice);
							bananaCount = 'd0;
							cartItemCount = cartItemCount - 'd1;
							success = 'b1;
						end
						else begin
							success = 'b0;
						end
					end
				potatoId:
					begin
						if (potatoCount > 'd0) begin
							cartTotal = cartTotal - (potatoCount * potatoPrice);
							potatoCount = 'd0;
							cartItemCount = cartItemCount - 'd1;
							success = 'b1;
						end
						else begin
							success = 'b0;
						end
					end
				tomatoId:
					begin
						if (tomatoCount > 'd0) begin
							cartTotal = cartTotal - (tomatoCount * tomatoPrice);
							tomatoCount = 'd0;
							cartItemCount = cartItemCount - 'd1;
							success = 'b1;
						end
						else begin
							success = 'b0;
						end
					end
				peachId:
					begin
						if (peachCount > 'd0) begin
							cartTotal = cartTotal - (peachCount * peachPrice);
							peachCount = 'd0;
							cartItemCount = cartItemCount - 'd1;
							success = 'b1;
						end
						else begin
							success = 'b0;
						end
					end
				appleId:
					begin
						if (appleCount > 'd0) begin
							cartTotal = cartTotal - (appleCount * applePrice);
							appleCount = 'd0;
							cartItemCount = cartItemCount - 'd1;
							success = 'b1;
						end
						else begin
							success = 'b0;
						end
					end
				pineappleId:
					begin
						if (pineappleCount > 'd0) begin
							cartTotal = cartTotal - (pineappleCount * pineapplePrice);
							pineappleCount = 'd0;
							cartItemCount = cartItemCount - 'd1;
							success = 'b1;
						end
						else begin
							success = 'b0;
						end
					end
				orangeId:
					begin
						if (orangeCount > 'd0) begin
							cartTotal = cartTotal - (orangeCount * orangePrice);
							orangeCount = 'd0;
							cartItemCount = cartItemCount - 'd1;
							success = 'b1;
						end
						else begin
							success = 'b0;
						end
					end
				mandarinId:
					begin
						if (mandarinCount > 'd0) begin
							cartTotal = cartTotal - (mandarinCount * mandarinPrice);
							mandarinCount = 'd0;
							cartItemCount = cartItemCount - 'd1;
							success = 'b1;
						end
						else begin
							success = 'b0;
						end
					end
				cherryId:
					begin
						if (cherryCount > 'd0) begin
							cartTotal = cartTotal - (cherryCount * cherryPrice);
							cherryCount = 'd0;
							cartItemCount = cartItemCount - 'd1;
							success = 'b1;
						end
						else begin
							success = 'b0;
						end
					end
				grapeId:
					begin
						if (grapeCount > 'd0) begin
							cartTotal = cartTotal - (grapeCount * grapePrice);
							grapeCount = 'd0;
							cartItemCount = cartItemCount - 'd1;
							success = 'b1;
						end
						else begin
							success = 'b0;
						end
					end
				pearId:
					begin
						if (pearCount > 'd0) begin
							cartTotal = cartTotal - (pearCount * pearPrice);
							pearCount = 'd0;
							cartItemCount = cartItemCount - 'd1;
							success = 'b1;
						end
						else begin
							success = 'b0;
						end
					end
				cucumberId:
					begin
						if (cucumberCount > 'd0) begin
							cartTotal = cartTotal - (cucumberCount * cucumberPrice);
							cucumberCount = 'd0;
							cartItemCount = cartItemCount - 'd1;
							success = 'b1;
						end
						else begin
							success = 'b0;
						end
					end
				endcase
			end
			else begin
			success = 'b0;
			end
		end
	endtask
	
	initial begin
		// Initalization of system by giving all amounts as 0.
		bananaCount = 'd0;
		potatoCount = 'd0;
		tomatoCount = 'd0;
		peachCount = 'd0;
		appleCount = 'd0;
		pineappleCount = 'd0;
		orangeCount = 'd0;
		mandarinCount = 'd0;
		cherryCount = 'd0;
		grapeCount = 'd0;
		pearCount = 'd0;
		cucumberCount = 'd0;
		// Cart details also set to 0 initially.
		cartItemCount = 'd0;
		cartTotal = 'd0;
	end
	
endmodule
