I performed a Logic Equivalence Check (LEC) to verify that the gate-level netlist of the convolutional block synthesized with Cadence Genus is functionally identical to the RTL Verilog code, checking that no logical errors were introduced during synthesis.

The Simulation snapshots for both the Accurate and Approximate designs are provided above in their respective folders, and the snapshot description for the reference is given below.

```
Description
1. compare_golden_and_revised
- It tells  whether the synthesized netlist (Revised) is functionally equivalent to the RTL description (Golden), checking that both designs have the same number of mapped inputs, outputs, and flip-flops, and no such discrepancies.

2. HDL_rule_manager
- Checks the functional mismatches between RTL and the synthesized netlist; a few warnings might exist (multiple non-blocking assignments, bit truncation risk, and blackboxed cells), which can be ignored.

3. Mapping_Manager 
- It shows detailed mapped points between the Golden and Revised designs.

4. Report_compare 
- Results after running the compare command.

5. Report_statistics 
- Provides a final statistical breakdown of the mapped and equivalent points.

6. Report_verification 
- Final high-level verification report.
```
