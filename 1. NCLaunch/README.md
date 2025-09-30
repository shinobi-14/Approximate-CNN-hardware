```
Signal Definitions

1. DATA_W → Data width in bits

2. K_SIZE → Kernel size

3. clk → System clock

4. err → Error signal

5. kernel[7:0] → Kernel coefficient

6. pixel_in[7:0] → Input pixel value

7. pixel_out_acc[15:0] → Accurate accumulated output

8. pixel_out_approx[15:0] → Approximate accumulated output

9. rst → Reset signal

10. start → Start signal

11. valid_acc → Accurate output valid flag

12. valid_approx → Approximate output valid flag

```


## Observations
### 1. Waveform: Pixel1_FinalAccumulatedOutput
1. The data width is set to 8 bits (DATA_W = 8) and the kernel size is 3 (K_SIZE = 3).
2. At this snapshot, the input pixel is 24 (0x18) and the kernel value is ~1.0203.
3. The accurate output is 0x0654 (1620 in decimal), which looks correct based on the convolution calculation.
4. The approximate output is 0x0002 (2 in decimal), which is much smaller compared to the accurate result. This shows the error introduced by the aggressive-approximate computation (trading precision and accuracy for timing/area).
5. I noticed that the valid signals (valid_acc, valid_approx) are still low even though the outputs are already computed. I tried taking snapshots at different times, but every time the outputs were still not flagged as valid. I suppose there might be a small issue in the way I’m driving the start/valid handshake in the testbench
6. The err signal is undefined (x) in this snapshot. That likely means I haven’t reset or initialized it properly in my design or testbench.

### 2. CNN_Extended_Simulation
1. From the console simulation log, I can see that for every test pixel input (Pixel_in), the tool is printing the Accurate output, the Approximate output, and the Error (difference between accurate and approximate). This confirms that both the accurate and approximate datapaths are being exercised for all test inputs.
2. The Accurate output is consistently much larger than the Approximate output (e.g., for Pixel_in=50, Accurate=2250 vs Approx=4). This means the approximate computation is drastically underestimating the output compared to the accurate computation.  
3. The Error values are large whenever the approximate output is near zero, which highlights the quality loss introduced by approximation.
