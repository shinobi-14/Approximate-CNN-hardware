This sub-repo contains constraints files, tickle file and synthesis results for Accurate and Approximate CNN.

### Accurate-Design
1. Area Report: The synthesized accurate_conv module requires a total cell area of 2431.163 units and is composed of 213 logic cells. This establishes a baseline for the physical size of the accurate design.

2. Power Report: The total power consumption is approximately 1.345e-04 W. The breakdown reveals that registers are the dominant source of power consumption, while internal logic accounts for the majority of the internal and switching power consumption, with internal power being the largest component overall at 74.62%.

3. Timing Report: The design successfully meets its timing constraints, indicated by a positive slack of 3835 ps. The critical path (longest delay path) originates from a kernel[65] input and ends at an internal register (acc_reg), taking 5931 ps to propagate through a series of adders (ADDFX1, ADDFXL) and logic gates.

4. Gates Report: The design is primarily composed of logic cells (162 such instances) and sequential cells (33 such instances). Among individual gates, adders (ADDFX1, ADDFXL) and flip-flops (SDFFRHQX1) contribute most significantly to the total number of gates, which is expected for a design performing multiply-accumulate operations.

5. Netlist View: The netlist visualization shows a moderately complex and structured design.


### Approximate-Design 
1. Area Report: The synthesized approx_conv module is composed of 221 logic cells and occupies a total cell area of 2391.047 units. This provides a quantitative measure of the approximate design's physical size compared to the accurate design.

2. Power Report: The total power consumption is approximately 2.014e-04 W. The approximate design has lower leakage and switching power, but leakage is the dominant power component in the approximate model, accounting for nearly 80% of its total consumption.

3. Timing Report: The design meets its timing requirements with a positive slack of 4311 ps. The approximate design has better timing performance than the accurate design, as indicated by its larger positive slack. This successfully demonstrates the intended performance-for-accuracy trade-off.

4. Gates Report: The design's area is primarily made up of logic cells (164 such instances) and sequential cells (41 such instances). The design achieves a smaller total area but paradoxically uses more individual logic cells, with a notable shift towards a higher percentage of sequential logic (flip-flops).

5. Netlist View: The netlist visualization shows a circuit with significant structural complexity, in contrast to the accurate design.
