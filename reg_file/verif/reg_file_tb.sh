#!/bin/bash

# Compile
iverilog \
    -g2012 \
    -o reg_file_tb.vvp \
    reg_file_tb.sv \
    ../rtl/reg_file.sv

# Simulate
vvp reg_file_tb.vvp > reg_file_tb.log