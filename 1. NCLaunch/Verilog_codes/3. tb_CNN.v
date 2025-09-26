`timescale 1ns/1ps

module tb_CNN;

  // Parameters
  parameter DATA_W = 8;
  parameter K_SIZE = 3;

  // Signals
  reg clk, rst, start;
  reg [DATA_W-1:0] pixel_in;
  reg [DATA_W*K_SIZE*K_SIZE-1:0] kernel;

  wire [2*DATA_W-1:0] pixel_out_acc, pixel_out_approx;
  wire valid_acc, valid_approx;

  // Instantiate Accurate Module
  accurate_conv uut_acc (
    .clk(clk),
    .rst(rst),
    .start(start),
    .pixel_in(pixel_in),
    .kernel(kernel),
    .pixel_out(pixel_out_acc),
    .valid(valid_acc)
  );

  // Instantiate Approximate Module
  approx_conv uut_approx (
    .clk(clk),
    .rst(rst),
    .start(start),
    .pixel_in(pixel_in),
    .kernel(kernel),
    .pixel_out(pixel_out_approx),
    .valid(valid_approx)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;  // 10ns period

  // Pixel memory for predictable inputs
  reg [DATA_W-1:0] pixel_mem [0:15]; // 16 pixels for more visible waveforms
  integer i;

  // Testbench
  initial begin
    // Initialize
    rst = 1; start = 0; pixel_in = 0;
    kernel = {
        8'd9,8'd8,8'd7,
        8'd6,8'd5,8'd4,
        8'd3,8'd2,8'd1
    };

    // Define pixel sequence
    pixel_mem[0] = 8'd10;  pixel_mem[1] = 8'd50;
    pixel_mem[2] = 8'd200; pixel_mem[3] = 8'd255;
    pixel_mem[4] = 8'd128; pixel_mem[5] = 8'd64;
    pixel_mem[6] = 8'd15;  pixel_mem[7] = 8'd90;
    pixel_mem[8] = 8'd30;  pixel_mem[9] = 8'd70;
    pixel_mem[10]= 8'd180; pixel_mem[11]=8'd220;
    pixel_mem[12]= 8'd40;  pixel_mem[13]=8'd110;
    pixel_mem[14]= 8'd75;  pixel_mem[15]=8'd5;

    #20 rst = 0; // release reset

    // Apply pixels sequentially with start pulses
    for (i = 0; i < 16; i = i + 1) begin
        @(negedge clk);
        pixel_in = pixel_mem[i];
        start = 1;
        @(negedge clk);
        start = 0;
        // small wait for valid to pulse
        @(posedge clk);
    end

    // Keep simulation running for observation
    #500 $finish;
  end

  // Monitor outputs
  initial begin
    $monitor("Time=%0t | Pixel_in=%0d | Accurate=%0d | Approx=%0d | Error=%0d",
             $time, pixel_in, pixel_out_acc, pixel_out_approx,
             pixel_out_acc - pixel_out_approx);
  end

endmodule
