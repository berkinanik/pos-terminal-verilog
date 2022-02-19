# pos-terminal-verilog
METU EE314 Digital Electronics Laboratory Verilog Design Term Project

This is the part of the verilog design I developed for the 2020-2021 Spring Term's EE314 course's term project.

It was expected to implement a basic Point-of-Sale terminal device using an Intel's Altera Cyclone FPGA.

### DESIGN APPROACH
Designing approach of the circuitry and necessary states for the wanted behavior of the POS machine as follows:
-	Device will have 3 main states:
    - Adding Item to Cart
    - Removing Item from Cart
    - Viewing Cart Total
-	Two switches will be used to determine these states.
-	For the item barcode number and amount inputs 4 push buttons on the FPGA board will be used.
-	6 7-Segment Display of the FPGA board is used the supply output of the machine and give user necessary feedback.
-	LEDs of the FPGA board are used the indicated position of switches: thus, the state of the machine and the button activation.
-	One more switch is used the enable button input for item barcode number and amount input.
-	For necessary operations, some other states and counters implemented in the logic design and development of the POS machine.

Design process, states and implemented logic behind POS machine discussed in detail in following section.
Top module of the project and the module driving the FPGA board is the fpgaDriver module.

Necessary pin connections are made using the PINs defined in the FPGA board’s user manual using ‘Pin Planner’ in the Quartus software. Clock, switches, and buttons of the FPGA board are the inputs of the module. LEDs and the 7-bit binary numbers namely hex[n] are the outputs of the module.
For the main states of the circuit and input/output of the FPGA board necessary registers are defined and some assignments are made between inputs/outputs of the FPGA board and registers.
Some registers are defined to store values of the inputted BCD digits as the item barcode number and item amounts. These registers are repeated for the visual feedback will be provided to user in the seven-segment display. Circuitry function resets these input registers after a complete input but display registers are continued to store to provide visual output.
Device states are predefined using above parameters namely: showCartTotal, addItemToCart, removeItemFromCart. 2-bit binary number is for the state representation. State is defined as a wire and assigned to 2-left most switches of the FPGA Board. 
Also, some LED outputs are assigned to switches to indicate both state of the circuit and the position of the switch. Registers used for the 7-segment display are defined and using the 7-segment driver (namely sevenSegmentDriver module) designed, 7-bit binary numbers is provided as the 7-segment display output values. 

7-Segment driver module used in the project are designed to display BCD digits and some letters will be used for the visual feedback. Having one input as a hexadecimal number and an output as the 7-bit binary number which is assigned to output of the fpgaDriver module design.

Some registers are defined to store amount of each item in the cart, total item count in the cart, cart total. 4-digit BCD item barcode numbers are predefined as parameters and used during necessary item adding to cart and removing from cart. Prices are also predefined as decimal numbers in Kurus. (995 = 9.95₺). With a VGA output listing items and prices of the items or, items in the cart would have been possible. For that design, some other parameters which would have been the state of the circuit with VGA output can be seen also.
One register which implies a button pressed state and one register which implies the active input process state of the circuit and button inputs are implemented to allow or block updating of the registers storing inputted values. One switch which is assigned to inputting state of the circuit is used to regulate allowance of button input. Device state about adding, removing, or viewing cart are also check for the correct input operation. Defined tasks for adding an item to cart and removing an item from cart are called after complete inputs and registers for inputted BCD digits are reset. 

Defined registers storing inputted BCD numbers are updated in the circuitry shown in the above code-snippet-8. Depending on the circuit’s state namely adding, removing or viewing cart mode different functioning of the 7-segment displays are obtained using predefined hexadecimal registers which are used in sevenSegmentDriver and 7-bit binary number outputs of that driver are assigned to fpgaDriver’s outputs and necessary PIN connections.
Adding an item to cart and removing an item from cart operation is obtained by defining two tasks in the fpgaDriver module. Depending on the stored amount counts and using the predefined item barcode numbers (e.g. bananaId) and item prices (e.g. bananaPrice) these two methods performs necessary condition checks using predefined regulation parameters such as max item in cart and max item for each type. Inputted item barcode numbers are checked in switch case blocks and compared with the predefined item id parameters. Using inputted barcode number and amounts related registers, cart total and item counts are updated. Related registers about item counts and cart total are initialized as 0s.
