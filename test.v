`timescale 1ns/1ps
module test;
  
  reg clk, wr_en, rd_en, rst;
  reg [7:0] data_in;
  wire [7:0] data_out;
  wire full, empty;
  
  fifo_design fifo(clk, rst, wr_en, rd_en, data_in, full, empty, data_out);
  
  always #2 clk = ~clk;
  initial begin
    clk = 0;
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    #3 rst = 0;
    execute(20);
    execute(30);
    $finish;
  end
  
  task push();
    if(!full) begin
    wr_en <= 1'b1;
    data_in <= $random;
    
    #1;
      $display("Pushed Data ; %d, wr_en : %b, rd_en : %b\n",data_in, wr_en, rd_en);
    end
    else $display("FIFO is Full, Cant push items!");
    
  endtask
  
  task pop();
    if(!empty) begin
    rd_en <= 1'b1;
    
    #1;
      $display("Popped Data ; %d, wr_en : %b, rd_en : %b\n",data_out, wr_en, rd_en);
    end
    else $display("FIFO is Empty, Cant pop items!");
    
  endtask
  
  task execute(int delay);
    wr_en = 0; rd_en = 0;
    
    fork
      begin
        repeat(10) begin @(posedge clk)push();end
        wr_en = 0;
      end
      #delay;
      begin
        repeat(10) begin @(posedge clk)pop();end
        rd_en = 0;
      end
    join
  endtask
  
    initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
  
  
  
endmodule
