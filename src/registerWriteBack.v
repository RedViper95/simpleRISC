`timescale 1us/1us

module registerWriteBackUnit(clk,aluResult,ldResult,pc,isLd,isCall,instruction,isWb,wport_enable,wport_addr,wport_data);
	input [31:0] aluResult, ldResult, pc, instruction;
	input clk,isLd, isCall, isWb;
	output wport_enable;
	output [3:0] wport_addr;
	output reg [31:0] wport_data;
	
	/*always @ (posedge clk) begin
		if(isCall==1)
			addrMuxResult = 4'b1111; //corresponds to ra/return address register/register 15
		else
			addrMuxResult = instruction[25:22];
	end*/
	assign wport_addr = (isCall)?4'b1111:instruction[25:22];
	assign wport_enable = isWb;
	
	wire [1:0] dataMuxCase;
	assign dataMuxCase = {isCall, isLd};
	
	always @ (*) begin
		case(dataMuxCase)
			2'b01: begin
						wport_data = ldResult; //Not getting loaded as isLd - 0 when ldR is high.
					 end
			2'b10: wport_data = pc+32'b00000000000000000000000000000001;
			default: begin
							wport_data = aluResult;
						end
		endcase
	end
	
endmodule

module tb_registerWriteBackUnit;
	reg [31:0] aluResult, ldResult, pc, instruction;
	reg isLd, isCall, isWb;
	wire wport_enable;
	wire [3:0] wport_addr;
	wire [31:0] wport_data;

	registerWriteBackUnit rWBU_instance(.aluResult(aluResult),
	.ldResult(ldResult),.pc(pc),.isLd(isLd),.isCall(isCall),.instruction(instruction),
	.isWb(isWb),.wport_enable(wport_enable),.wport_addr(wport_addr),.wport_data(wport_data));
	
	initial begin
		$display("\n---Inside begin within initial statement---");
		// Dump waves
		$dumpfile("dump.vcd");
		$dumpvars(1);
		
		//-----------
		aluResult = 32'b11110000111100001111000011110000;
		ldResult = 32'b11110000111100001111000011110001;
		pc = 32'b00000000000000000000000000000000;
		instruction = 32'b11110100111100001111000011110000; //1001
		isCall = 0;
		isLd = 0;
		isWb = 0;
		#100
		isCall = 1;
		isLd = 0;
		isWb = 1;
		#100
		isCall = 0;
		isLd = 1;
		isWb = 1;
		#100
		//-----------
		
		$finish;
		$display("\n---Inside end within initial statement---");		
	end
	
endmodule
