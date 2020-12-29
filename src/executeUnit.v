`timescale 1us/1us
`define flags_E flags[0]
`define flags_GT flags[1]

module executeUnit(clk,isBeq,isUBranch,
isBgt,isRet,isImmediate,isAdd,isSub,isCmp,
isMul,isDiv,isMod,isLsl,isLsr,isAsr,isOr,
isNot,isAnd,isMov,branchTarget,immx,op1,op2,
isBranchTaken,branchPc,aluResult,flags);

	input clk,isBeq,isUBranch,isBgt,isRet,isImmediate,isAdd,isSub,isCmp;
	input isMul,isDiv,isMod,isLsl,isLsr,isAsr,isOr,isNot,isAnd,isMov;
	input [31:0] branchTarget;
	input signed [31:0] immx,op1,op2;
	output isBranchTaken;
	output [31:0] branchPc,aluResult;
	output [7:0] flags;
	
	//output reg [31:0] branchPc;
	//output reg signed [31:0] aluResult;
	//output reg [7:0] flags; //It acts as input for branch unit and output for ALU
	
	wire [7:0] input_flags;
	
	assign input_flags = flags;
	
	branchUnit bu_instance(.clk(clk),.flags(input_flags),.isBeq(isBeq),.isUBranch(isUBranch),.isBgt(isBgt),
	.branchTarget(branchTarget),.op1(op1),.isRet(isRet),.branchPc(branchPc),
	.isBranchTaken(isBranchTaken));

	aluUnit alu_instance(.clk(clk),.immx(immx),.op1(op1),.op2(op2),.isImmediate(isImmediate),
	.isAdd(isAdd),.isSub(isSub),.isCmp(isCmp),.isMul(isMul),.isDiv(isDiv),
	.isMod(isMod),.isLsl(isLsl),.isLsr(isLsr),.isAsr(isAsr),.isOr(isOr),
	.isNot(isNot),.isAnd(isAnd),.isMov(isMov),.flags(flags),.aluResult(aluResult));
	
endmodule

module tb_executeUnit;
	reg isBeq,isUBranch,isBgt,isRet,isImmediate,isAdd,isSub,isCmp,isMul,isDiv,isMod,isLsl,isLsr,isAsr,isOr,isNot,isAnd,isMov;
	reg [31:0] branchTarget;
	reg [31:0] op1,op2,immx;
	wire [31:0] aluResult;
	wire isBranchTaken;
	wire [31:0] branchPc;
	
	wire [7:0] flags;
		
	executeUnit eu_instance(.isBeq(isBeq),.isUBranch(isUBranch),.isBgt(isBgt),.isRet(isRet),
	.isImmediate(isImmediate),.isAdd(isAdd),.isSub(isSub),.isCmp(isCmp),.isMul(isMul),.isDiv(isDiv),.isMod(isMod),
	.isLsl(isLsl),.isLsr(isLsr),.isAsr(isAsr),.isOr(isOr),.isNot(isNot),.isAnd(isAnd),.isMov(isMov),.branchTarget(branchTarget),
	.immx(immx),.op1(op1),.op2(op2),.isBranchTaken(isBranchTaken),.branchPc(branchPc),.aluResult(aluResult),.flags(flags));
	
	initial begin
		$display("\n---Inside begin within initial statement---");
		// Dump waves
		$dumpfile("dump.vcd");
		$dumpvars(1);
		
		//-Initialization-
		isBeq = 0;
		isUBranch = 0;
		isBgt = 0;
		isRet = 0;
		isImmediate = 0;
		isAdd = 0;
		isSub = 0;
		isCmp = 0;
		isMul = 0;
		isDiv = 0;
		isMod = 0;
		isLsl = 0;
		isLsr = 0;
		isAsr = 0;
		isOr = 0;
		isNot = 0;
		isAnd = 0;
		isMov = 0;
		branchTarget = 32'b00000000000000000000000000000000;
		op1 = 32'b00000000000000000000000000000000;
		op2 = 32'b00000000000000000000000000000000;
		immx = 32'b00000000000000000000000000000000;
		#10
		//----------------
		//-ALU-testing----
		op1 = 32'b00000000000000000000000000000000;
		op2 = 32'b00000000000000000000000000000001;
		immx = 32'b00000000000000000000000000000010;
		#10
		isAdd = 1;
		#10
		isImmediate = 1;
		#10
		isImmediate = 0;
		isAdd = 0;
		isSub = 1;
		#10
		isSub = 0;
		isCmp = 1;
		#10
		op1 = 32'b00000000000000000000000000000001;
		op2 = 32'b00000000000000000000000000000000;
		#10
		op1 = 32'b00000000000000000000000000000001;
		op2 = 32'b00000000000000000000000000000001;
		#10
		op1 = 32'b10000000000000000000000000001111;
		op2 = 32'b00000000000000000000000000000001;
		isCmp = 0;
		isLsl = 1;
		#10
		isLsl = 0;
		isLsr = 1;
		#10
		isLsr = 0;
		isAsr = 1;
		#10
		isAsr = 0;
		//-Branch-Unit-testing
		branchTarget = 32'b00000000000000000000000000000001;
		op1 = 32'b00000000000000000000000000000010;
		op2 = 32'b00000000000000000000000000000000;
		immx = 32'b00000000000000000000000000000000;
		#10
		isBeq = 0;
		isBgt = 0;
		isRet = 1;
		isUBranch = 0;		
		#10
		isBeq = 1;
		isBgt = 0;
		isRet = 0;
		isUBranch = 0;
		#10
		isBeq = 0;
		isBgt = 1;
		isRet = 0;
		isUBranch = 0;
		#10
		//--------------------
		
		$finish;
		$display("\n---Inside end within initial statement---");		
	end
	
endmodule

module branchUnit(clk,flags,isBeq,isUBranch,isBgt,branchTarget,
op1,isRet,branchPc,isBranchTaken);
	input [7:0] flags;
	input clk,isBeq,isUBranch,isBgt,isRet;
	input [31:0] branchTarget,op1;
	output isBranchTaken;
	output reg [31:0] branchPc;

	always @ (*) begin
		if(isRet==1)
			branchPc = op1;
		else
			branchPc = branchTarget;
	end
	
	wire equalTo,greaterThan;
	assign equalTo = isBeq && `flags_E;
	assign greaterThan = isBgt && `flags_GT;
	assign isBranchTaken = equalTo || greaterThan || isUBranch;
	
endmodule

module tb_branchUnit;
	reg [7:0] flags;
	reg isBeq,isUBranch,isBgt,isRet;
	reg [31:0] branchTarget,op1;
	wire isBranchTaken;
	wire [31:0] branchPc;
	
	branchUnit bu_instance(.flags(flags),.isBeq(isBeq),.isUBranch(isUBranch),
	.isBgt(isBgt),.branchTarget(branchTarget),.op1(op1),
	.isRet(isRet),.branchPc(branchPc),.isBranchTaken(isBranchTaken));
	
	initial begin
		$display("\n---Inside begin within initial statement---");
		// Dump waves
		$dumpfile("dump.vcd");
		$dumpvars(1);
		
		//-----------
		flags = 8'b00000001;
		branchTarget = 32'b00000000000000000000000000000001;
		op1 = 32'b00000000000000000000000000000010;
		isBeq = 0;
		isBgt = 0;
		isRet = 0;
		isUBranch = 0;
		#10
		isBeq = 0;
		isBgt = 0;
		isRet = 1;
		isUBranch = 0;		
		#10
		isBeq = 1;
		isBgt = 0;
		isRet = 0;
		isUBranch = 0;
		#10
		flags = 8'b00000010;
		isBeq = 0;
		isBgt = 1;
		isRet = 0;
		isUBranch = 0;
		#10
		//-----------
		
		$finish;
		$display("\n---Inside end within initial statement---");		
	end
	
endmodule

//op1 is rport1_data, op2 is rport2_data

module aluUnit(clk,immx,op1,op2,isImmediate,isAdd,
isSub,isCmp,isMul,isDiv,isMod,isLsl,isLsr,isAsr,
isOr,isNot,isAnd,isMov,flags,aluResult);
	input signed [31:0] op1,op2,immx; //Use signed to store op1, op2. This will primarily be useful for asr operation.
	input clk,isImmediate,isAdd,isSub,isCmp,isMul,isDiv,isMod,isLsl,isLsr,isAsr,isOr,isNot,isAnd,isMov;
	//inout [7:0] flags;
	output reg [7:0] flags;
	output reg signed [31:0] aluResult;
	
	wire [12:0] aluSignals;
	reg signed [31:0] a,b;
	reg flags_assigned;
	assign aluSignals = {isAdd,isSub,isCmp,isMul,isDiv,isMod,isLsl,isLsr,isAsr,isOr,isNot,isAnd,isMov};

	always @ (*) begin
		a = op1;
		if(isImmediate)
			b = immx;
		else
			b = op2;
		
		if(flags_assigned != 1'b1)
			flags = 8'b00000000;
	end
	
	always @ (*) begin
		case(aluSignals)
			13'b1000000000000: aluResult = a+b; //add
			13'b0100000000000: aluResult = a-b; //sub
			13'b0010000000000: begin
										aluResult = a; //cmp
										/*flags_monitor <= 2'b00;
										if(a>b)
											flags_monitor <= 2'b10;
										if(a==b)
											flags_monitor <= 2'b11;
										if(a<b)
											flags_monitor <= 2'b01;*/
										flags = 8'b00000000;
										if(a>b)
											flags = 8'b00000010;
										if(a==b)
											flags = 8'b00000001;
										flags_assigned = 1'b1; //Signifies that flags have been assigned atleast once.
									 end
			13'b0001000000000: aluResult = a*b; //mul
			13'b0000100000000: aluResult = a/b; //div
			13'b0000010000000: aluResult = a%b; //mod
			13'b0000001000000: aluResult = a<<b; //lsl
			13'b0000000100000: aluResult = a>>b; //lsr
			13'b0000000010000: aluResult = a>>>b; //asr
			13'b0000000001000: aluResult = a|b; //or
			13'b0000000000100: aluResult = ~b; //not
			13'b0000000000010: aluResult = a&b; //and
			13'b0000000000001: aluResult = b; //mov
		endcase
	end
	
	//assign flags = (flags_monitor!=2'b00)?((flags_monitor==2'b10)?8'b00000010:((flags_monitor==2'b11)?8'b00000001:8'b00000000)): 8'bzzzzzzzz;
	
endmodule

module tb_aluUnit;
	reg [31:0] op1,op2,immx;
	reg isImmediate,isAdd,isSub,isCmp,isMul,isDiv,isMod,isLsl,isLsr,isAsr,isOr,isNot,isAnd,isMov;
	wire [7:0] flags;
	wire [31:0] aluResult;
	
	aluUnit alu_instance(.immx(immx),.op1(op1),.op2(op2),.isImmediate(isImmediate),.isAdd(isAdd),
	.isSub(isSub),.isCmp(isCmp),.isMul(isMul),.isDiv(isDiv),.isMod(isMod),.isLsl(isLsl),.isLsr(isLsr),
	.isAsr(isAsr),.isOr(isOr),.isNot(isNot),.isAnd(isAnd),.isMov(isMov),.flags(flags),
	.aluResult(aluResult));
	
	initial begin
		$display("\n---Inside begin within initial statement---");
		// Dump waves
		$dumpfile("dump.vcd");
		$dumpvars(1);
		
		//-----------
		op1 = 32'b00000000000000000000000000000000;
		op2 = 32'b00000000000000000000000000000001;
		immx = 32'b00000000000000000000000000000010;
		isImmediate = 0;
		isAdd = 0;
		isSub = 0;
		isCmp = 0;
		isMul = 0;
		isDiv = 0;
		isMod = 0;
		isLsl = 0;
		isLsr = 0;
		isAsr = 0;
		isOr = 0;
		isNot = 0;
		isAnd = 0;
		isMov = 0;
		#100
		isAdd = 1;
		#100
		isImmediate = 1;
		#100
		isImmediate = 0;
		isAdd = 0;
		isSub = 1;
		#100
		isSub = 0;
		isCmp = 1;
		#100
		op1 = 32'b00000000000000000000000000000001;
		op2 = 32'b00000000000000000000000000000000;
		#100
		op1 = 32'b00000000000000000000000000000001;
		op2 = 32'b00000000000000000000000000000001;
		#100
		op1 = 32'b10000000000000000000000000001111;
		op2 = 32'b00000000000000000000000000000001;
		isCmp = 0;
		isLsl = 1;
		#100
		isLsl = 0;
		isLsr = 1;
		#100
		isLsr = 0;
		isAsr = 1;
		#100
		isAsr = 0;
		//-----------
		
		$finish;
		$display("\n---Inside end within initial statement---");		
	end	
endmodule
