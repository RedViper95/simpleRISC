`timescale 1us/1us

module processor(clk,reset);
	input clk,reset;

	//Control signals
	wire isBranchTaken,I,isBeq,isUBranch,isBgt,isRet,isImmediate,isAdd,
	isSub,isCmp,isMul,isDiv,isMod,isLsl,isLsr,isAsr,isOr,isNot,isAnd,isMov,isLd,isSt,
	isCall,isWb;
	
	//Register file variables
	wire wport_enable;
	wire [31:0] rport1_data,rport2_data,wport_data;
	wire [3:0] rport1_addr,rport2_addr,wport_addr;
	
	//Data path variables
	wire [31:0] pc,instruction,branchPc,branchTarget,ldResult,mar,mdr;
	wire [31:0] immx,op1,op2,aluResult;
	wire [7:0] flags;
	wire [4:0] opcode;
	
	assign opcode = {instruction[31:27]};
	assign op1 = rport1_data;
	assign op2 = rport2_data;
	
	//==================Datapath-Start================//
	instructionFetchUnit ifu_instance(.clk(clk),.reset(reset),.isBranchTaken(isBranchTaken),
	.branchPc(branchPc),.pc(pc),.instruction(instruction)); //contains instruction memory

	operandFetchUnit ofu_instance(.clk(clk),.pc(pc),.instruction(instruction),.isRet(isRet),.isSt(isSt),
	.immx(immx),.branchTarget(branchTarget),.opcode(opcode),.I(I),.rport1_addr(rport1_addr),.rport2_addr(rport2_addr));

	executeUnit eu_instance(.clk(clk),.isBeq(isBeq),.isUBranch(isUBranch),.isBgt(isBgt),.isRet(isRet),
	.isImmediate(isImmediate),.isAdd(isAdd),.isSub(isSub),.isCmp(isCmp),.isMul(isMul),.isDiv(isDiv),.isMod(isMod),
	.isLsl(isLsl),.isLsr(isLsr),.isAsr(isAsr),.isOr(isOr),.isNot(isNot),.isAnd(isAnd),.isMov(isMov),.branchTarget(branchTarget),
	.immx(immx),.op1(op1),.op2(op2),.isBranchTaken(isBranchTaken),.branchPc(branchPc),.aluResult(aluResult),.flags(flags));

	memoryAccess ma_instance(.clk(clk),.op2(op2),.aluResult(aluResult),.isLd(isLd),
	.isSt(isSt),.ldResult(ldResult),.mar(mar),.mdr(mdr)); //contains data memory

	registerWriteBackUnit rWBU_instance(.clk(clk),.aluResult(aluResult),
	.ldResult(ldResult),.pc(pc),.isLd(isLd),.isCall(isCall),.instruction(instruction),
	.isWb(isWb),.wport_enable(wport_enable),.wport_addr(wport_addr),.wport_data(wport_data));
	//==================Datapath-End=================//
	
	//=================Controlpath-start=============//
	controlUnit cu_instance(.opcode(opcode),.I(I),.isSt(isSt),.isLd(isLd),.isBeq(isBeq),.isBgt(isBgt),
	.isRet(isRet),.isImmediate(isImmediate),.isWb(isWb),.isUBranch(isUBranch),
	.isCall(isCall),.isAdd(isAdd),.isSub(isSub),.isCmp(isCmp),.isMul(isMul),
	.isDiv(isDiv),.isMod(isMod),.isLsl(isLsl),.isLsr(isLsr),.isAsr(isAsr),
	.isOr(isOr),.isAnd(isAnd),.isNot(isNot),.isMov(isMov));
	//=================Controlpath-end==============//
	
	//Register file
	registerFile rf_instance(.clk(clk),.rport1_addr(rport1_addr),.rport1_data(rport1_data),
	.rport2_addr(rport2_addr),.rport2_data(rport2_data),.wport_enable(wport_enable),
	.wport_addr(wport_addr),.wport_data(wport_data));
  
endmodule

module tb_processor;
	reg clk,reset;
	integer i,j,data_mem_file,register_file_contents;
	
	processor processor_unit(.clk(clk),.reset(reset));
	
	always begin
		clk <= 0;
		#10;
		clk <=1;
		#10;
	end
	
	always @(posedge clk) begin
		$display("\nAt posedge Instruction: %b op1: %b op2: %b aluResult: %b mar: %b mdr: %b ldResult: %b isSt: %b isLd: %b isWb: %b isImmediate: %b isAdd: %b isSub: %b isCmp: %b isMul: %b isDiv: %b isMod: %b isLsl: %b isLsr: %b isAsr: %b isOr: %b isNot: %b isAnd: %b isMov: %b",
		processor_unit.instruction,processor_unit.op1,processor_unit.op2,processor_unit.aluResult,processor_unit.mar,processor_unit.mdr,
		processor_unit.ldResult,processor_unit.isSt,processor_unit.isLd,processor_unit.isWb,processor_unit.isImmediate,processor_unit.isAdd,
		processor_unit.isSub,processor_unit.isCmp,processor_unit.isMul,processor_unit.isDiv,processor_unit.isMod,processor_unit.isLsl,
		processor_unit.isLsr,processor_unit.isAsr,processor_unit.isOr,processor_unit.isNot,processor_unit.isAnd,processor_unit.isMov);
		
		data_mem_file = $fopen("data_mem.txt","w");
		for(i=0; i<32; i=i+1)
			$fwrite(data_mem_file,"\nData_mem at %d : ",i);
		$fclose(data_mem_file);
		
		register_file_contents = $fopen("register_file.txt","w");
		for(i=0; i<16; i=i+1)
			$fwrite(register_file_contents,"\nRegister file contents at %d : %b",i,processor_unit.rf_instance.registerArray[i]);
		$fclose(register_file_contents);
	end
	
	always @ (negedge clk) begin
		$display("\n\nAt negedge Instruction: %b op1: %b op2: %b aluResult: %b mar: %b mdr: %b ldResult: %b isSt: %b isLd: %b isWb: %b isImmediate: %b isAdd: %b isSub: %b isCmp: %b isMul: %b isDiv: %b isMod: %b isLsl: %b isLsr: %b isAsr: %b isOr: %b isNot: %b isAnd: %b isMov: %b",
		processor_unit.instruction,processor_unit.op1,processor_unit.op2,processor_unit.aluResult,processor_unit.mar,processor_unit.mdr,
		processor_unit.ldResult,processor_unit.isSt,processor_unit.isLd,processor_unit.isWb,processor_unit.isImmediate,processor_unit.isAdd,
		processor_unit.isSub,processor_unit.isCmp,processor_unit.isMul,processor_unit.isDiv,processor_unit.isMod,processor_unit.isLsl,
		processor_unit.isLsr,processor_unit.isAsr,processor_unit.isOr,processor_unit.isNot,processor_unit.isAnd,processor_unit.isMov);
		
		data_mem_file = $fopen("data_mem.txt","w");
		for(i=0; i<32; i=i+1)
			$fwrite(data_mem_file,"\nData_mem at %d : %b",i,processor_unit.ma_instance.data_mem[i]);
		$fclose(data_mem_file);

		register_file_contents = $fopen("register_file.txt","w");
		for(i=0; i<16; i=i+1)
			$fwrite(register_file_contents,"\nRegister file contents at %d : %b",i,processor_unit.rf_instance.registerArray[i]);
		$fclose(register_file_contents);		
	end
	
	always @(clk) begin
	
	end
	
	initial begin
		reset = 1;
		#20;
		reset = 0;
		#20;
		//$monitor("wport_data: %b, wport_addr: %b",processor_unit.wport_data,processor_unit.wport_addr);
		//$monitor("processor pc: %b",processor_unit.pc);		
		//$monitor("MAR:%b MDR:%b",processor_unit.mar,processor_unit.mdr);
	end
	
endmodule
