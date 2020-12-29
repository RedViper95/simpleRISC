`timescale 1us/1us

module memoryAccess(clk,op2,aluResult,isLd,isSt,ldResult,mar,mdr);
	input [31:0] op2,aluResult;
	input clk,isLd,isSt;
	output [31:0] ldResult;
	//output reg [31:0] ldResult;
	output [31:0] mar,mdr;
	reg [31:0] data_mem [31:0]; //32 x 32bit memory
	
	assign mar = (isSt||isLd)?aluResult:32'bz;
	assign mdr = (isSt)?op2:32'bz;
	assign ldResult = (isLd)?data_mem[mar]:32'bz;
	
	/*always @ (negedge clk) begin
		//To avoid race conditions in case ldResult is a register..
		//We must load at negedge because new instruction will be fetched at next posedge.
		if(isLd) begin
			count = count+1;
			$sformat(filename,"log_loading_%d.txt",count);
			f = $fopen(filename,"w");
			ldResult <= data_mem[mar];
			$fwrite(f,"\nLoading %b from address %b. ldResult: %b",data_mem[mar],mar,ldResult);
			$fclose(f);
		end
	end*/

	always @ (posedge clk) begin
		if(isSt) begin
			data_mem[mar] <= mdr;
		end
	end
	
	/*always @ (clk) begin
		data_mem_file = $fopen("data_mem.txt","w");
		for (i = 0; i<32; i=i+1)
			$fwrite(data_mem_file,"\nData_mem at %d : %b",i,data_mem[i]);
		$fclose(data_mem_file);	
	end*/
	
	/*always @ (posedge clk) begin
		if(isLd||isSt) begin
			count = count+1;
			$sformat(filename,"log_%d.txt",count);
			f = $fopen(filename,"w");
			if(isSt) begin
				data_mem[mar] = mdr;
				$fwrite(f,"\nStoring %b at address %b",mdr,mar);
			end
			if(isLd) begin
				ldResult = data_mem[mar];
				$fwrite(f,"\nLoading %b from address %b. ldResult: %b",data_mem[mar],mar,ldResult);	
			end
			$fclose(f);
			
			f = $fopen("data_mem.txt","w");
			for (i = 0; i<32; i=i+1)
				$fwrite(f,"\nData_mem at %d : %b",i,data_mem[i]);
			$fclose(f);
		end
	end*/
	
endmodule

module tb_memoryAccessUnit;
	reg isLd,isSt;
	reg [31:0] op2,aluResult;
	wire [31:0] ldResult,mar,mdr;
	
	memoryAccess ma_instance(.op2(op2),.aluResult(aluResult),.isLd(isLd),
	.isSt(isSt),.ldResult(ldResult),.mar(mar),.mdr(mdr));
	
	initial begin
		//-----------
		isLd = 0;
		isSt = 0;

		//Store
		op2 = 32'b11111111111111111111111111111111;
		aluResult = 32'b00000000000000000000000000011000;
		#20
		isSt = 1;
		#20
		isSt = 0;
		op2 = 32'b11111111111111111111111111100011;
		aluResult = 32'b00000000000000000000000000010100;
		#20
		isSt = 1;
		#20
		isSt = 0;
		//------
		#40
		//Load
		aluResult = 32'b00000000000000000000000000011000;
		isLd = 1;
		#20
		isLd = 0;
		#20;
		aluResult = 32'b00000000000000000000000000010100;
		isLd = 1;
		#20
		isLd = 0;
		#20;		
		//------
		
	end
endmodule
