`timescale 1ns/1ps

module approx_conv #
(
    parameter DATA_W = 8,       // Pixel and kernel weight bit-width
    parameter K_SIZE = 3        // Kernel size (e.g., 3x3)
)
(
    input clk,                              // Clock
    input rst,                              // Reset (active high)
    input start,                            // Start signal
    input [DATA_W-1:0] pixel_in,            // Single pixel input
    input [DATA_W*K_SIZE*K_SIZE-1:0] kernel,// Flattened kernel values
    output reg [2*DATA_W-1:0] pixel_out,    // Convolution output (approximate)
    output reg valid                        // Output valid flag
);

    integer i;
    reg [DATA_W-1:0] k;
    reg [2*DATA_W-1:0] acc;
    reg [2*DATA_W-1:0] mult;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            acc <= 0;
            pixel_out <= 0;
            valid <= 0;
        end else if (start) begin
            acc = 0;
            // Perform approximate convolution accumulation
            for (i = 0; i < K_SIZE*K_SIZE; i = i+1) begin
                // Verilog-2001 indexed part-select
                k = kernel[i*DATA_W +: DATA_W];
                mult = pixel_in * k;
                // Take only MSBs of multiplication (truncate LSBs)
                acc = acc + mult[2*DATA_W-1:DATA_W];
            end
            pixel_out <= acc;
            valid <= 1;
        end else begin
            valid <= 0;
        end
    end

endmodule
