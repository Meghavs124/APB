module APB_master(
	input PCLK,
	input PRESETn,
	input transfer,
	input READ_WRITE,
	input [8:0] apb_write_paddr,
	input [7:0] apb_write_data,
	input [8:0] apb_read_paddr,
	input PREADY,
	input [7:0]PRDATA,
	output reg PWRITE,
	output reg PSEL1,
	output reg PSEL2,
	output reg PENABLE,
	output reg [7:0]PWDATA,
	output reg [8:0]PADDR,
	output [7:0] apb_read_data_out
);

parameter IDLE=2'b00, SETUP=2'b01, ACCESS=2'b10;

reg [1:0]c_state,n_state;

always @(posedge PCLK or negedge PRESETn)
begin
	if(!PRESETn)
	c_state<=IDLE;
	else
	c_state <=n_state;
end

always @(*) 
begin
	if(!PRESETn)
	begin
	PENABLE = 0;
	n_state=IDLE;
	end
	
	else
	begin
		case(c_state)
		IDLE : begin
			if(transfer==0)
			begin
				PENABLE=0;
				n_state=IDLE;
			end
			else
			begin
				n_state=SETUP;
				PENABLE=0;
			end
		end
		
		SETUP :begin
			PENABLE=0;
			n_state=ACCESS;
			end
           
		
		ACCESS :begin
			if(PREADY==0)
			begin
			PENABLE=1;
			n_state=ACCESS;
			end
			
            else if(transfer==1 && PREADY==1)
			begin
			PENABLE=1;
			n_state=SETUP;
			end
			
			else
			begin
			n_state=IDLE;
			PENABLE=1;
            end			
        end
		
		default :begin
				PENABLE=0;
				n_state=IDLE;
		end
		
		endcase
    end
end

always @(*)
begin
	PWRITE = 1'b0;
    PWDATA = 8'b0;
    PADDR  = 9'b0;
	
	if(READ_WRITE)
		begin
		PWRITE = 1'b1;
		PWDATA = apb_write_data;
        PADDR = apb_write_paddr;
		end
	else
		begin
		PWRITE = 1'b0;
		PADDR = apb_read_paddr;
		end
end

always @(*)
begin
	PSEL1 = 1'b0;
	PSEL2 = 1'b0;
	
	if(c_state == SETUP)
	begin
		if (PADDR[8]==0)
			begin
			PSEL1=1;
			PSEL2=0;
			end
		else
			begin
			PSEL1=0;
			PSEL2=1;
			end
	end

	else if (c_state == ACCESS)
	begin
		if (PADDR[8]==0)
			begin
			PSEL1 = 1;
			PSEL2 = 0;
			end
		else
			begin
			PSEL1 = 0;
			PSEL2 = 1;
			end
	end

	else
		begin
		PSEL1=0;
		PSEL2=0;
		end
end

assign apb_read_data_out = PRDATA;

endmodule
