# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 100ps us (10 MHz)
    clock = Clock(dut.clk, 100, units="ps")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    # # Set the input values you want to test
    # dut.ui_in.value = 20
    # dut.uio_in.value = 30

    # # Wait for one clock cycle to see the output values
    # await ClockCycles(dut.clk, 1)

    # # The following assersion is just an example of how to check the output values.
    # # Change it to match the actual expected output of your module:
    # assert dut.uo_out.value == 50

    shift = [0]*13
    for i in range(30):
        dut.ui_in.value = i
        await ClockCycles(dut.clk, 25)
        output = ((dut.uo_out.value << 8) | dut.uio_out.value)
        #await ClockCycles(dut.clk, 10)
        value = fir(shift, i)
        print(f"fir_python(shift,{i}): {value}, fir_verilog{i}: {output}" )
        assert (output == value)

    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.

def fir(shift, x):
    coef = [1, 0, 10, 0, 20, 0, 50, 0, 20, 0, 10, 0, 1]
    y = 0
    for i in range(len(coef)-1, -1, -1):
        if i == 0:
            shift[i] = x
        else:
            shift[i] = shift[i-1]
        y += shift[i]*coef[i]
    return y
