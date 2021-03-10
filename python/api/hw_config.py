#!/usr/bin/env python
import os
import sys
import time
from ev12aq600 import ev12aq600

app=ev12aq600()
app.start_serial()

# ref clk source internal (default)
app.ref_sel_ext(0)
# ref clk source external ref clk SMA EXT REF (default)
app.ref_sel(0)
# ADC CLK from PLL LMX2592
app.clk_sel(1)
# SYNCO ADC (default)
synco_sel(0) 
# SYNC FPGA (default)
sync_sel(0) 
# ref clk PLL power-down (default)
ref_clk_ratio(0, 0)

app.stop_serial()

