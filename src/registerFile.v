`timescale 1us/1us

module registerFile(clk,rport1_addr,rport1_data,rport2_addr,rport2_data,
wport_enable,wport_addr,wport_data);

  input [3:0] rport1_addr,rport2_addr,wport_addr;
  input [31:0] wport_data;
  input clk,wport_enable;
  output [31:0] rport1_data,rport2_data;
  
  reg [31:0] registerArray [15:0];
  
  always @(posedge clk) begin
    if(wport_enable) begin
		registerArray[wport_addr] <= wport_data;
		//$display("writing at wport_addr: %b",wport_addr);
    end
  end

  /*initial begin
  		$display("Reading at rport1_addr: %b, rport2_addr",rport1_addr,rport2_addr);
  end*/
  
  assign rport1_data = registerArray[rport1_addr];
  assign rport2_data = registerArray[rport2_addr];
  
endmodule

module tb_registerFile;
  reg clk,wport_enable;
  reg [3:0] rport1_addr,rport2_addr,wport_addr;
  reg [31:0] wport_data;
  
  wire [31:0] rport1_data,rport2_data;
  
  registerFile rf_instance(.clk(clk),.rport1_addr(rport1_addr),.rport1_data(rport1_data),.rport2_addr(rport2_addr),.rport2_data(rport2_data),.wport_enable(wport_enable),.wport_addr(wport_addr),.wport_data(wport_data));
  
  always
    #5 clk = ~clk;
  
  initial begin
	 $display("\n---Inside begin within initial statement---");
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    clk = 0;
    //-----------
    wport_addr=4'b0000;
    wport_data=32'b11110000000010101111000000001010;
    wport_enable=1;
    #10
    wport_enable=0;
    wport_addr=4'b0010;
    wport_data=32'b11111111111111111111111111111111;
    wport_enable=1;
    #10
    wport_enable=0;
    //-----------

    //-----------
	 rport1_addr = 4'b0100;
    rport2_addr = 4'b0001;
    #10
	 rport1_addr = 4'b0000;
    rport2_addr = 4'b0010;
    #10
    //-----------

    $finish;
    $display("\n---Inside end within initial statement---");      
  end
endmodule
