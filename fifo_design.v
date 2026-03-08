module fifo_design #(parameter DEPTH = 8, WIDTH = 8)(
input clk,rst,wr_en, rd_en,
input [WIDTH-1:0] data_in,
output full, empty,
output reg [WIDTH-1:0] data_out
);

localparam PTR_WIDTH = $clog2(DEPTH);

reg [WIDTH-1:0] FIFO_MEM [DEPTH-1:0];
reg [PTR_WIDTH:0] WPTR, RPTR;
wire wrap;

always @(posedge clk) begin
  if(rst) begin
    WPTR <= 0;
    RPTR <= 0;
    data_out <= 0;
  end
end

always @(posedge clk) begin
  if(wr_en && !full) begin
    FIFO_MEM[WPTR[PTR_WIDTH-1:0]] <= data_in;
    WPTR <= WPTR + 1;
  end
end

always @(posedge clk) begin
  if(rd_en && !empty) begin
    data_out <= FIFO_MEM[RPTR[PTR_WIDTH-1:0]];
    RPTR <= RPTR + 1;
  end
end

assign wrap = WPTR[PTR_WIDTH] ^ RPTR[PTR_WIDTH];

assign full  = wrap && (WPTR[PTR_WIDTH-1:0] == RPTR[PTR_WIDTH-1:0]);
assign empty = (WPTR == RPTR);

endmodule
