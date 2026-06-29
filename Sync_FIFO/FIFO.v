// Code your design here
module FIFO #(
  parameter width = 8,
  parameter depth = 8
)(
  input clk,
  input reset,
  input [width-1:0] data_in,
  input wr_en,
  input rd_en,
  output reg [width-1:0] data_out,
  output full,
  output empty
);

  reg [width-1:0] mem [0:depth-1];

  reg [$clog2(depth)-1:0] wr_ptr;
  reg [$clog2(depth)-1:0] rd_ptr;
  reg [$clog2(depth):0] count;

  assign full  = (count == depth);
  assign empty = (count == 0);

  always @(posedge clk) begin
    if (reset) begin
      wr_ptr   <= 0;
      rd_ptr   <= 0;
      count    <= 0;
      data_out <= 0;
    end
    else begin

      //WRITE
      if (wr_en && !full) begin
        mem[wr_ptr] <= data_in;
        wr_ptr <= (wr_ptr == depth-1) ? 0 : wr_ptr + 1;
      end

      // READ
      if (rd_en && !empty) begin
        data_out <= mem[rd_ptr];
        rd_ptr <= (rd_ptr == depth-1) ? 0 : rd_ptr + 1;
      end

      // COUNT LOGIC
      case ({wr_en && !full, rd_en && !empty})
        2'b10: count <= count + 1; 
        2'b01: count <= count - 1; 
        default: count <= count;   
      endcase
    

    end
  end

endmodule