`timescale 1us/1us

//The register file will be connected to the operand fetch unit 
//at the top level.
//For now o/ps regarding this will just be op1,op2.

module operandFetchUnit(clk,pc,instruction,isRet,isSt,immx,branchTarget,
opcode,I,rport1_addr,rport2_addr);
	input [31:0] pc;
	input [31:0] instruction;
	input clk,isRet,isSt;
	output reg [31:0] immx,branchTarget;
	output [4:0] opcode;
	output I;
	output [3:0] rport1_addr,rport2_addr;
	
	wire [1:0] modifiers;
	reg [28:0] relative_offset_shorter;
	reg [31:0] relative_offset;
	
	//Computing opcode for the instruction
	assign opcode = instruction[31:27]; //32-28 bits are opcode
	
	//Immediate bit
	assign I = instruction[26]; //27th bit is the immediate bit
	
	/*Computing immx and branchTarget for the instruction.
	Both are calculated in advance and used as per necessity*/
	//Remember format to sign extend is the extension part must be contained in a {}
	//example: {16{0}}
	assign modifiers = {instruction[17],instruction[16]};
	always @ (*) begin
		case(modifiers) //always have a default option while using case statement or else this might cause a latch
			2'b01: begin
				immx = {{16{1'b0}},instruction[15:0]}; //'u' modifier
			end
			2'b10: begin
				immx = {instruction[15:0],{16{1'b0}}}; //'h' modifier
			end
			default: begin
				immx = {{16{instruction[15]}},instruction[15:0]}; //default with no modifier
			end
		endcase
	end
	
	always @ (*) begin
		relative_offset_shorter = instruction[26:0] << 2; //Makes it 29 bits
		relative_offset = {{3{relative_offset_shorter[28]}},relative_offset_shorter};
		branchTarget = relative_offset+pc; //Adding pc as the 32 bits are relative to pc
	end
	
	//Deciding on read port addresses to ping
	assign rport1_addr = (isRet) ? 4'b1111:instruction[21:18]; //ra/16th register in register file:rs1
	assign rport2_addr = (isSt) ? instruction[25:22]:instruction[17:14]; //rd:rs2
	
endmodule

module tb_operandFetchUnit;
	reg [31:0] pc,instruction;
	reg isRet,isSt;
	wire [31:0] immx,branchTarget;
	wire [4:0] opcode;
	wire I;
	wire [3:0] rport1_addr,rport2_addr;
	
	operandFetchUnit ofu_instance(.pc(pc),.instruction(instruction),.isRet(isRet),.isSt(isSt),
	.immx(immx),.branchTarget(branchTarget),.opcode(opcode),.I(I),.rport1_addr(rport1_addr),.rport2_addr(rport2_addr));
	
	initial begin
		$display("\n---Inside begin within initial statement---");
		// Dump waves
		$dumpfile("dump.vcd");
		$dumpvars(1);
		
		//-----------
		pc = 32'b00000000000000000000000000000000; //store
		instruction = 32'b01111110000010000000000000010100; // address (r2+immx(000000000000010100))<-r8 //ping contents of r2,r8 from reg file
		isRet = 0;
		isSt = 1;
		#10
		pc = 32'b00000000000000000000000000000000; //ret
		instruction = 32'b10100110000010000000000000010100;
		isRet = 1;
		isSt = 0;		
		#10
		pc = 32'b00000000000000000000000000000100; 
		instruction = 32'b00001000110010000100000000000000; //sub r3<= r2-r1
		isRet = 0;
		isSt = 0;
		#10
		pc = 32'b00000000000000000000000000000100;
		instruction = 32'b00000100100001010000000000001111; //add r1,immediate (modifier - 01/u) and put result in r2
		isRet = 0;
		isSt = 0;
		#10
		pc = 32'b00000000000000000000000000000100;
		instruction = 32'b00010100100001100000000000001111; //mul r1,immediate (modifier - 10/h) and put result in r2
		isRet = 0;
		isSt = 0;
		#10
		pc = 32'b00000000000000000000000000000100;
		instruction = 32'b00001100100001000000000000001111; //sub r1,immediate (modifier - 00/default) and put result in r2
		isRet = 0;
		isSt = 0;
		#10
		//-----------
		
		$finish;
		$display("\n---Inside end within initial statement---");
	end
	
endmodule
