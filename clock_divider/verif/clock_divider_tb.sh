#!/bin/bash

# Compile
iverilog \
    -g2012 \
    -o clock_divider_tb.vvp \
    clock_divider_tb.sv \
    ../rtl/clock_divider.sv

# Simulate
vvp clock_divider_tb.vvp > clock_divider_tb.log