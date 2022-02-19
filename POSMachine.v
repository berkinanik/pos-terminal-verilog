module POSMachine(clk, cartTotal);
	input clk;
	
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
	output reg [15:0] cartTotal;
	
	// System's Working Status & Modes and Input Memories
	reg switchOneItemsCart;
	reg switchTwoAddRemove;
	reg [15:0] inputtedItemId;
	reg [3:0] inputtedItemAmount;
	reg [15:0] selectedItemToRemoveId;
	
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
	task addItemToCart;
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
	task removeItemFromCart;
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
		// System's Working Status & Modes and Input Memories
		switchOneItemsCart = viewItemsMode;
		switchTwoAddRemove = addItemMode;
		inputtedItemId = 'd0;
		inputtedItemAmount = 'd0;
		selectedItemToRemoveId = 'd0;
	end
	
	// Clock design to detect perform operations
	always @(posedge clk) begin
		// Checked if device in viewing items mode and adding item to cart mode.
		if ((switchOneItemsCart == viewItemsMode) && (switchTwoAddRemove == addItemMode)) begin
			// If Item to be added and amount of item inputted correctly perform add to cart task.
			if ((inputtedItemAmount > 'd0) && (inputtedItemAmount > 'd0)) begin
				// success implemented in addItemToCart method can be used to give user feedback after adding operation.
				reg tempSuccess;
				addItemToCart(inputtedItemId, inputtedItemAmount, tempSuccess);
				if (tempSuccess) begin
					inputtedItemAmount <= 'd0;
					inputtedItemId <= 'd0;
				end
			end
		end
		// Checked if device in viewing cart mode and removing item from cart mode.
		else if ((switchOneItemsCart == viewItemsMode) && (switchTwoAddRemove == removeItemMode)) begin
			// If item to be removed from cart is selected correctly perform remove item from cart task.
			if (selectedItemToRemoveId > 'd0) begin
				// success implemented in removeItemFromCart method can be used to give user feedback after removing operation.
				reg tempSuccess;
				removeItemFromCart(selectedItemToRemoveId, tempSuccess);
				if (tempSuccess) begin
					selectedItemToRemoveId <= 'd0;
				end
			end
		end
	end
	
endmodule
