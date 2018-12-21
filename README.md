# Simple WaveShare OV5640 Design for the Nexys 4 DDR

## Summary

Requirements:
* Vivado 2018.1

This design demonstrates how to capture images from the OV5640 camera and
write them to the VGA output on the Nexys 4 DDR board. Images are captured in
RGB888 format from the OV5640 and displayed using the Xilinx TFT Controller IP
at 640x40 resolution.

The design implements a simple passthrough from the OV5640 camera outputs to
the VGA output, with a detour through DDR memory. Only a single frame buffer is
used to store the image data in memory.

## Building the design:

1. Source the build_hw.tcl file in Vivado to build the bit stream.
2. Export the hardware and open SDK
3. Create a new C application and add the test.c file
4. Program the bitstream and run the software application

## Notes:

- The Nexys 4 DDR only connects four bits per colour channel to the VGA output.
Nonetheless, for image processing applications, it may be useful to have 8 bits
per channel as in this design.
- The AXI TFT controller expecteds RGB pixels to be encoded as 32-bit words.
However, they only look at six bits per colour channel.
- The PMOD Camera adapter should be connected to headers JA and JB on the
Nexys 4 DDR board.

## References

* AXI TFT Product Guide: https://www.xilinx.com/support/documentation/ip_documentation/axi_tft/v2_0/pg095-axi-tft.pdf
* Waveshare Resources: https://www.waveshare.com/wiki/OV5640_Camera_Board_(C)

