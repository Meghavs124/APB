module apb_protocol(
    input PCLK,
    input PRESETn,
    input transfer,
    input READ_WRITE,
    input [7:0] apb_write_paddr,
    input [7:0] apb_write_data,
    input [7:0] apb_read_paddr,

    output [7:0] apb_read_data_out
);

wire PWRITE;
wire PSEL1;
wire PSEL2;
wire PENABLE;
wire [7:0] PADDR;
wire [7:0] PWDATA;

wire [7:0] PRDATA1;
wire [7:0] PRDATA2;

wire PREADY1;
wire PREADY2;

wire [7:0] PRDATA;
wire PREADY;


APB_master uut( .PCLK(PCLK), .PRESETn(PRESETn), .transfer(transfer), .READ_WRITE(READ_WRITE), .apb_write_paddr(apb_write_paddr), .apb_write_data(apb_write_data), .apb_read_paddr(apb_read_paddr),.PREADY(PREADY),.PRDATA(PRDATA),.PWRITE(PWRITE),.PSEL1(PSEL1),.PSEL2(PSEL2),.PENABLE(PENABLE),.PWDATA(PWDATA), .PADDR(PADDR),.apb_read_data_out(apb_read_data_out));

APB_slave slave1(.PCLK(PCLK), .PRESETn(PRESETn), .PSEL(PSEL1), .PENABLE(PENABLE), .PWRITE(PWRITE), .PADDR(PADDR), .PWDATA(PWDATA), .PRDATA(PRDATA1), .PREADY(PREADY1));


APB_slave slave2( .PCLK(PCLK),.PRESETn(PRESETn), .PSEL(PSEL2),  .PENABLE(PENABLE), .PWRITE(PWRITE), .PADDR(PADDR), .PWDATA(PWDATA), .PRDATA(PRDATA2), .PREADY(PREADY2) );

assign PRDATA = (PSEL1) ? PRDATA1 : (PSEL2) ? PRDATA2 : 8'h00;

assign PREADY = (PSEL1) ? PREADY1 : (PSEL2) ? PREADY2 :  1'b1;
                
endmodule
