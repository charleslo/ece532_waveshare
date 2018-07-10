`timescale 1ns / 1ps
module ov5640_capture(
  input               pclk,
  input               vsync,
  input               href,
  input       [7:0]   d,
  output reg  [23:0]  dout,
  output              valid,
  output              last
);
  reg [1:0] cnt;
  reg r_href;
  reg we, r_we;

  assign last = ({href, r_href} == 2'b01) ? 1'b1 : 1'b0;
  assign valid = ({we, r_we} == 2'b10) ? 1'b1 : 1'b0;

  always @(posedge pclk)
  begin 
    r_href <= href;
    r_we <= we;
  
    if (vsync == 1)
    begin
      cnt <= 'd0;
      we <= 1'b0;
    end
    else
    begin
      if (href == 1'b1)
      begin
        if (cnt == 'd2)
        begin
          cnt <= 'd0;
          we <= 1'b1;
        end
        else
        begin
          cnt <= cnt + 'd1;
          we <= 1'b0;
        end
      end
  
      case (cnt)
        1 : begin
          dout[23:16] <= d;
        end
        2 : begin
          dout[15: 8] <= d;
        end
        0 : begin
          dout[ 7: 0] <= d;
        end
      endcase
    end
  end

endmodule
