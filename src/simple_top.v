module ov5640_top(
  output [12:0]DDR2_0_addr,
  output [2:0]DDR2_0_ba,
  output DDR2_0_cas_n,
  output [0:0]DDR2_0_ck_n,
  output [0:0]DDR2_0_ck_p,
  output [0:0]DDR2_0_cke,
  output [0:0]DDR2_0_cs_n,
  output [1:0]DDR2_0_dm,
  inout [15:0]DDR2_0_dq,
  inout [1:0]DDR2_0_dqs_n,
  inout [1:0]DDR2_0_dqs_p,
  output [0:0]DDR2_0_odt,
  output DDR2_0_ras_n,
  output DDR2_0_we_n,
  inout IIC_0_scl_io,
  inout IIC_0_sda_io,

  input reset,
  input sys_clock,

  // VGA Interface
  output [3:0]vga_blue,
  output [3:0]vga_green,
  output [3:0]vga_red,
  output vga_hsync,
  output vga_vsync,

  // Camera Interface
  input pclk,
  output xclk,
  input  OV5640_VSYNC,
  input  OV5640_HREF,
  //input  OV5640_PCLK,
  input [7:0] OV5640_D,
  output [1:0] dout_0
);

wire [3:0]frame_in_tkeep;
wire [31:0]frame_in_tdata;
wire [23:0] data_out;
(* mark_debug = "true" *) wire frame_in_tlast;
(* mark_debug = "true" *) wire frame_in_tready;
(* mark_debug = "true" *) wire [0:0]frame_in_tuser;
(* mark_debug = "true" *) wire frame_in_tvalid;

wire [5:0] w_vga_green;
wire [5:0] w_vga_red;
wire [5:0] w_vga_blue;

assign dout_0[0] = 1'b1;
assign dout_0[1] = 1'b0;
assign vga_blue = w_vga_blue[5:2];
assign vga_red = w_vga_red[5:2];
assign vga_green = w_vga_green[5:2];

design_1_wrapper (
    .DDR2_0_addr    (DDR2_0_addr),
    .DDR2_0_ba      (DDR2_0_ba),
    .DDR2_0_cas_n   (DDR2_0_cas_n),
    .DDR2_0_ck_n    (DDR2_0_ck_n),
    .DDR2_0_ck_p    (DDR2_0_ck_p),
    .DDR2_0_cke     (DDR2_0_cke),
    .DDR2_0_cs_n    (DDR2_0_cs_n),
    .DDR2_0_dm      (DDR2_0_dm),
    .DDR2_0_dq      (DDR2_0_dq),
    .DDR2_0_dqs_n   (DDR2_0_dqs_n),
    .DDR2_0_dqs_p   (DDR2_0_dqs_p),
    .DDR2_0_odt     (DDR2_0_odt),
    .DDR2_0_ras_n   (DDR2_0_ras_n),
    .DDR2_0_we_n    (DDR2_0_we_n),
    .IIC_0_scl_io   (IIC_0_scl_io),
    .IIC_0_sda_io   (IIC_0_sda_io),
    .frame_in_tdata (frame_in_tdata),
    .frame_in_tkeep (frame_in_tkeep),
    .frame_in_tlast (frame_in_tlast),
    .frame_in_tready(frame_in_tready),
    .frame_in_tuser (frame_in_tuser),
    .frame_in_tvalid(frame_in_tvalid),
    .s2mm_fsync_0   (OV5640_VSYNC),
    .pclk           (pclk),
    .reset          (reset),
    .sys_clock      (sys_clock),
    .vga_blue       (w_vga_blue),
    .vga_clk        (),
    .vga_de         (),
    .vga_dps        (),
    .vga_green      (w_vga_green),
    .vga_hsync      (vga_hsync),
    .vga_red        (w_vga_red),
    .vga_vsync      (vga_vsync),
    .xclk           (xclk));

assign frame_in_tdata = {8'b0, data_out};
assign frame_in_tkeep = 4'b1111;
assign frame_in_tuser = 4'b0001;

 ov5640_capture capture(
 		.pclk  (pclk),
 		.vsync (OV5640_VSYNC),
 		.href  (OV5640_HREF),
 		.d     (OV5640_D),
 		.dout  (data_out),
 		.valid (frame_in_tvalid),
    .last  (frame_in_tlast)
 	);


endmodule
