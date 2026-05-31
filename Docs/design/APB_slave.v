module APB_slave #(parameter depth=256)(
	input PCLK,
	input PRESETn,
	input PSEL,
	input PENABLE,
	input PWRITE,
	input [8:0]PADDR,
	input [7:0]PWDATA,
	output reg [7:0]PRDATA,
	output PREADY
);
	
reg [7:0] mem[0:depth-1];
integer i;

assign PREADY = 1'b1; 

always @(posedge PCLK or negedge PRESETn)
begin
	if(!PRESETn)
		begin
			for(i=0; i<=depth-1; i=i+1)
			mem[i] <= 8'b0;
		end
    else
		begin
			if(PSEL && PENABLE && PWRITE)
			 mem[PADDR] <= PWDATA;
		
			else if(PSEL &&PENABLE && !PWRITE)
			 PRDATA <=mem[PADDR];
			 
			else
			 PRDATA<=0;
		end
end
endmodule
