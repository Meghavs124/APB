module APB_slave #(parameter depth=200)(
	input PCLK,
	input PRESETn,
	input PSEL,
	input PENABLE,
	input PWRITE,
	input [7:0]PADDR,
	input [7:0]PWDATA,
	output reg [7:0]PRDATA,
	output PREADY
);
	
reg [7:0] mem[0:depth-1];
integer i;
reg PSLVERR;

assign PREADY = 1'b1; 

always @(posedge PCLK or negedge PRESETn)
begin
	if(!PRESETn)
	begin
		for(i=0; i<=depth-1; i=i+1)
		begin
	    	mem[i] <= 8'b0;
			PRDATA <= 8'b0;
		end
	end
    else
	begin
	   if(PSEL && PENABLE && PWRITE)
	   mem[PADDR] <= PWDATA;
	end
end

always @(*)
begin
    if(PSEL &&PENABLE && !PWRITE)
	 PRDATA = mem[PADDR];
	 
	else
	  PRDATA =0;
		
end

always @(*)
begin
    PSLVERR=1'b0;
    if(PRDATA>depth-1)
    PSLVERR=1'b1;
end
endmodule
