module FIFO_tb;
reg clk;
reg reset;
  reg [7:0]data_in;
reg wr_en;
reg rd_en;
  wire [7:0]data_out;
wire full;
wire empty;

FIFO uut(
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_out(data_out),
    .full(full),
    .empty(empty)
);

initial begin
    
    clk     = 0;
    reset   = 1;
    wr_en   = 0;
    rd_en   = 0;
    data_in = 8'h00;

    
    #10;
    reset = 0;


    wr_en = 1;
    rd_en = 0;

    data_in = 8'h11; #10;
    data_in = 8'h22; #10;
    data_in = 8'h33; #10;
    data_in = 8'h44; #10;
    data_in = 8'h55; #10;
    data_in = 8'h66; #10;
    data_in = 8'h77; #10;
    data_in = 8'h88; #10;

    
    wr_en = 0;
    rd_en = 1;

    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;

    rd_en = 0;

    #20;
   $finish;
end
always begin
    #5 clk = ~clk;
end
initial begin
    $monitor("count=%0d | wr_ptr=%0d | rd_ptr=%0d | data_out=%h | full=%b | empty=%b",
             uut.count,
             uut.wr_ptr,
             uut.rd_ptr,
             data_out,
             full,
             empty);
end
endmodule
