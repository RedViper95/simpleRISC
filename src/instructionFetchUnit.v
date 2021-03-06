`timescale 1us/1us

module instructionFetchUnit(clk,reset,isBranchTaken,branchPc,pc,instruction,done);
	input clk,reset,isBranchTaken;
	input [31:0] branchPc;
	output [31:0] instruction;
	output reg [31:0] pc;
	output reg done;
	
	/*instructionMemory im_instance(.address(pc[4:0]),.clock(clk),.q(instruction));
		[0..25]  :   01101000000000000000000000000000;
	26  :   01001100010000000000000000011111;
	27  :   01001100100000000000000000011001;
	28  :   00010000110001001000000000000000;
	29  :   00001101000011000000000000110010;
	30  :   01111100110001000000000000001010;
	31  :   01111101000001000000000000001011;
	*/
	
	reg [31:0] rom [31:0];
	
	always @(posedge clk) begin
		if(reset) begin
			pc <= 32'b00000000000000000000000000000000;
			rom[0] <= 32'b01101000000000000000000000000000;
			rom[1] <= 32'b01101000000000000000000000000000;
			rom[2] <= 32'b01101000000000000000000000000000;
			rom[3] <= 32'b01101000000000000000000000000000;	
			rom[4] <= 32'b01101000000000000000000000000000;
			rom[5] <= 32'b01101000000000000000000000000000;
			rom[6] <= 32'b01101000000000000000000000000000;
			rom[7] <= 32'b01101000000000000000000000000000;
			rom[8] <= 32'b01101000000000000000000000000000;
			rom[9] <= 32'b01101000000000000000000000000000;
			rom[10] <= 32'b01101000000000000000000000000000;
			rom[11] <= 32'b01101000000000000000000000000000;
			rom[12] <= 32'b01101000000000000000000000000000;
			rom[13] <= 32'b01101000000000000000000000000000;	
			rom[14] <= 32'b01101000000000000000000000000000;
			rom[15] <= 32'b01101000000000000000000000000000;
			rom[16] <= 32'b01101000000000000000000000000000;
			rom[17] <= 32'b01101000000000000000000000000000;
			rom[18] <= 32'b01101000000000000000000000000000;
			rom[19] <= 32'b01101000000000000000000000000000;	
			rom[20] <= 32'b01101000000000000000000000000000;
			rom[21] <= 32'b01101000000000000000000000000000; //nop
			rom[22] <= 32'b01001100010000000000000000011111; //mov r1 31
			rom[23] <= 32'b01001100100000000000000000011001; //mov r2 29
			rom[24] <= 32'b00010000110001001000000000000000; //mul r3 r1 r2
			rom[25] <= 32'b00001101000011000000000000110010; //sub r4 r3 50
			rom[26] <= 32'b01001100000000000000000000000000; //mov r0 0
			rom[27] <= 32'b01111100110000000000000000001010; //st r3 10[r0]
			rom[28] <= 32'b01111101000000000000000000001011; //st r4 11[r0]
			rom[29] <= 32'b01101000000000000000000000000000; //nop
			rom[30] <= 32'b01110101010000000000000000001011; //ld r5 11[r0]
			rom[31] <= 32'b00000001100101000100000000000000; //add r6 r5 r1
			done <= 0;
		end
		else if(isBranchTaken) begin
			if(branchPc<32)
				pc <= branchPc;
			else
				done <= 1;
		end
		else begin
			if(pc<32)
				pc <= pc+32'b00000000000000000000000000000001;
			else
				done <= 1;
		end
	end
	
	assign instruction = rom[pc];
	
endmodule

module tb_instructionFetchUnit;
	reg clk,reset,isBranchTaken;
	reg [31:0] branchPc;
	wire [31:0] pc,instruction;
	
	always begin
		clk <= 0;
		#10;
		clk <= 1;
		#10;
	end
	
	instructionFetchUnit ifu_instance(.clk(clk),.reset(reset),.isBranchTaken(isBranchTaken),
	.branchPc(branchPc),.pc(pc),.instruction(instruction));
	
	initial begin
		//-----------
		reset = 0;
		isBranchTaken = 0;
		branchPc = 32'b00000000000000000000000000001111;
		@(posedge clk);
		#5 reset = 1; //required to start pc
		@(posedge clk);
		#5 reset = 0;
		//isBranchTaken = 1;
		//#20
		//isBranchTaken = 0;
		//#200
		//-----------
	end
	
endmodule
