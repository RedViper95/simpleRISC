module controlUnit(opcode,I,isSt,isLd,isBeq,isBgt,isRet,isImmediate,isWb,isUBranch,
	isCall,isAdd,isSub,isCmp,isMul,isDiv,isMod,isLsl,isLsr,isAsr,
	isOr,isAnd,isNot,isMov);
	input [4:0] opcode;
	input I;
	output isSt,isLd,isBeq,isBgt,isRet,isImmediate,isWb,isUBranch,
	isCall,isAdd,isSub,isCmp,isMul,isDiv,isMod,isLsl,isLsr,isAsr,
	isOr,isAnd,isNot,isMov;
	
	assign isSt = (opcode==5'b01111)?1:0;
	assign isLd = (opcode==5'b01110)?1:0;
	assign isBeq = (opcode==5'b10000)?1:0;
	assign isBgt = (opcode==5'b10001)?1:0;
	assign isRet = (opcode==5'b10100)?1:0;
	assign isImmediate = (I)?1:0;
	assign isWb = (
	(opcode==5'b00000)||
	(opcode==5'b00001)||
	(opcode==5'b00010)||
	(opcode==5'b00011)||
	(opcode==5'b00100)||
	(opcode==5'b00110)||
	(opcode==5'b00111)||
	(opcode==5'b01000)||
	(opcode==5'b01001)||
	(opcode==5'b01110)||
	(opcode==5'b01010)||//lsl
	(opcode==5'b01011)||
	(opcode==5'b01100)||
	(opcode==5'b10011)
	)?1:0;
	assign isUBranch = ((opcode==5'b10010)||(opcode==5'b10011)||(opcode==5'b10100))?1:0;
	assign isCall = (opcode==5'b10011)?1:0;
	assign isAdd = ((opcode==5'b00000)||(opcode==5'b01110)||(opcode==5'b01111))?1:0;
	assign isSub = (opcode==5'b00001)?1:0;
	assign isCmp = (opcode==5'b00101)?1:0;
	assign isMul = (opcode==5'b00010)?1:0;
	assign isDiv = (opcode==5'b00011)?1:0;
	assign isMod = (opcode==5'b00100)?1:0;
	assign isLsl = (opcode==5'b01010)?1:0;
	assign isLsr = (opcode==5'b01011)?1:0;
	assign isAsr = (opcode==5'b01100)?1:0;
	assign isOr = (opcode==5'b00111)?1:0;
	assign isAnd = (opcode==5'b00110)?1:0;
	assign isNot = (opcode==5'b01000)?1:0;
	assign isMov = (opcode==5'b01001)?1:0;
	
endmodule

module tb_controlUnit;
	reg [4:0] opcode;
	reg I;
	wire isSt,isLd,isBeq,isBgt,isRet,isImmediate,isWb,isUBranch,
	isCall,isAdd,isSub,isCmp,isMul,isDiv,isMod,isLsl,isLsr,isAsr,
	isOr,isAnd,isNot,isMov;
	
	controlUnit cu_instance(opcode,I,isSt,isLd,isBeq,isBgt,isRet,isImmediate,isWb,isUBranch,
	isCall,isAdd,isSub,isCmp,isMul,isDiv,isMod,isLsl,isLsr,isAsr,
	isOr,isAnd,isNot,isMov);
	
	initial begin
		//-----------
		I = 0;
		opcode = 5'b00000; //add
		#10
		opcode = 5'b00001; //sub
		#10		
		opcode = 5'b00010; //mul
		#10
		opcode = 5'b00011; //div
		#10
		opcode = 5'b00100; //mod
		#10
		opcode = 5'b00101; //cmp
		#10
		opcode = 5'b00110; //and
		#10
		opcode = 5'b00111; //or
		#10
		opcode = 5'b01000; //not
		#10
		opcode = 5'b01001; //mov
		#10
		opcode = 5'b01010; //lsl
		#10
		opcode = 5'b01011; //lsr
		#10
		opcode = 5'b01100; //asr
		#10
		opcode = 5'b01101; //nop
		#10
		opcode = 5'b01110; //ld
		#10
		opcode = 5'b01111; //st
		#10
		opcode = 5'b10000; //beq
		#10
		opcode = 5'b10001; //bgt
		#10
		opcode = 5'b10010; //b
		#10
		opcode = 5'b10011; //call
		#10
		opcode = 5'b10100; //ret
		#10
		opcode = 5'b01101; 
		I = 1;
		#10
		$finish;
		//-----------
	end
	
endmodule
