<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

Our design, fir_filter_2, implements a 13-tap FIR filter that processes signals through a shift register mechanism. The filter maintains a register of recent input samples and predefined coefficients, inserting new samples at the beginning and shifting older samples down. By multiplying each sample with its corresponding coefficient and summing these products, the filter generates a filtered output that considers both current and historical input data.

## How to test

To test an FIR filter use a digital signal processor or microcontroller with analog input capabilities. Generate known input signals like sine waves or noise, applying the filter, and then comparing input and output signals using an oscilloscope or spectrum analyzer.

## External hardware

External hardware required for testing includes an Analog-to-Digital Converter (ADC), Digital-to-Analog Converter (DAC), signal generator, and a spectrum analysis tool.
