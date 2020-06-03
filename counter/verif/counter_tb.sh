#!/bin/bash

# Compile
iverilog \
    -g2012 \
    -o counter_tb.vvp \
    counter_tb.sv \
    ../rtl/counter.sv

# Simulate
vvp counter_tb.vvp > counter_tb.log