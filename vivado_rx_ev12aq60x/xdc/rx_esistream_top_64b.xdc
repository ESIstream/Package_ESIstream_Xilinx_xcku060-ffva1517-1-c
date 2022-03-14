create_clock -period 5.120 -name clk_mgtref -waveform {0.000 2.560} [get_ports sso_p]

set_property PACKAGE_PIN AH9 [get_ports sso_n]
set_property PACKAGE_PIN AH10 [get_ports sso_p]

set_property PACKAGE_PIN AL4 [get_ports {rxp[0]}]
set_property PACKAGE_PIN AL3 [get_ports {rxn[0]}]
set_property PACKAGE_PIN AK2 [get_ports {rxp[1]}]
set_property PACKAGE_PIN AK1 [get_ports {rxn[1]}]
set_property PACKAGE_PIN AJ4 [get_ports {rxp[2]}]
set_property PACKAGE_PIN AJ3 [get_ports {rxn[2]}]
set_property PACKAGE_PIN AH2 [get_ports {rxp[3]}]
set_property PACKAGE_PIN AH1 [get_ports {rxn[3]}]
set_property PACKAGE_PIN AG4 [get_ports {rxp[4]}]
set_property PACKAGE_PIN AG3 [get_ports {rxn[4]}]
set_property PACKAGE_PIN AF2 [get_ports {rxp[5]}]
set_property PACKAGE_PIN AF1 [get_ports {rxn[5]}]
set_property PACKAGE_PIN AD2 [get_ports {rxp[6]}]
set_property PACKAGE_PIN AD1 [get_ports {rxn[6]}]
set_property PACKAGE_PIN AC4 [get_ports {rxp[7]}]
set_property PACKAGE_PIN AC3 [get_ports {rxn[7]}]

# PL system clock:
set_property IOSTANDARD DIFF_HSTL_I [get_ports FABRIC_CLK_P]
set_property PACKAGE_PIN H19 [get_ports FABRIC_CLK_P]
set_property PACKAGE_PIN G19 [get_ports FABRIC_CLK_N]

create_clock -period 5.000 -name FABRIC_CLK_P [get_ports FABRIC_CLK_P]

set_property IOSTANDARD LVCMOS18 [get_ports {m2c_cfg[*]}]
set_property PACKAGE_PIN C32 [get_ports {m2c_cfg[1]}]
set_property PACKAGE_PIN C33 [get_ports {m2c_cfg[2]}]
set_property PACKAGE_PIN P29 [get_ports {m2c_cfg[3]}]
set_property PACKAGE_PIN N29 [get_ports {m2c_cfg[4]}]

set_property IOSTANDARD LVCMOS18 [get_ports {c2m_led[*]}]
set_property PACKAGE_PIN D39 [get_ports {c2m_led[1]}]
set_property PACKAGE_PIN C39 [get_ports {c2m_led[2]}]
set_property PACKAGE_PIN B30 [get_ports {c2m_led[3]}]
set_property PACKAGE_PIN A30 [get_ports {c2m_led[4]}]

set_property IOSTANDARD LVCMOS18 [get_ports spare_8_uart_tx]
set_property PACKAGE_PIN H39 [get_ports spare_8_uart_tx]
set_property IOSTANDARD LVCMOS18 [get_ports spare_9_uart_rx]
set_property PACKAGE_PIN D35 [get_ports spare_9_uart_rx]

set_property IOSTANDARD LVCMOS18 [get_ports {spare[*]}]
set_property PACKAGE_PIN A34 [get_ports {spare[1]}]
set_property PACKAGE_PIN J39 [get_ports {spare[2]}]
set_property PACKAGE_PIN J35 [get_ports {spare[3]}]
set_property PACKAGE_PIN J34 [get_ports {spare[4]}]
set_property PACKAGE_PIN D36 [get_ports {spare[5]}]
set_property PACKAGE_PIN H34 [get_ports {spare[6]}]
set_property PACKAGE_PIN C36 [get_ports {spare[7]}]

set_property IOSTANDARD LVCMOS18 [get_ports fpga_ref_clk]
set_property PACKAGE_PIN F38 [get_ports fpga_ref_clk]

set_property IOSTANDARD LVCMOS18 [get_ports ref_sel_ext]
set_property PACKAGE_PIN L37 [get_ports ref_sel_ext]

set_property IOSTANDARD LVCMOS18 [get_ports ref_sel]
set_property PACKAGE_PIN K37 [get_ports ref_sel]

set_property IOSTANDARD LVCMOS18 [get_ports clk_sel]
set_property PACKAGE_PIN L38 [get_ports clk_sel]

set_property IOSTANDARD LVCMOS18 [get_ports synco_sel]
set_property PACKAGE_PIN K38 [get_ports synco_sel]

set_property IOSTANDARD LVCMOS18 [get_ports sync_sel]
set_property PACKAGE_PIN J38 [get_ports sync_sel]

set_property IOSTANDARD LVCMOS18 [get_ports hmc1031_d1]
set_property PACKAGE_PIN H37 [get_ports hmc1031_d1]

set_property IOSTANDARD LVCMOS18 [get_ports hmc1031_d0]
set_property PACKAGE_PIN H38 [get_ports hmc1031_d0]

set_property IOSTANDARD LVCMOS18 [get_ports pll_muxout]
set_property PACKAGE_PIN E36 [get_ports pll_muxout]

set_property IOSTANDARD LVDS [get_ports clkoutB_p]
set_property PACKAGE_PIN H32 [get_ports clkoutB_p]
set_property PACKAGE_PIN G32 [get_ports clkoutB_n]

set_property IOSTANDARD LVCMOS18 [get_ports rstn]
set_property PACKAGE_PIN G39 [get_ports rstn]

set_property IOSTANDARD LVCMOS18 [get_ports adc_sclk]
set_property PACKAGE_PIN E37 [get_ports adc_sclk]

set_property IOSTANDARD LVCMOS18 [get_ports adc_cs_u]
set_property PACKAGE_PIN G34 [get_ports adc_cs_u]

set_property IOSTANDARD LVCMOS18 [get_ports adc_mosi]
set_property PACKAGE_PIN F35 [get_ports adc_mosi]

set_property IOSTANDARD LVCMOS18 [get_ports adc_miso]
set_property PACKAGE_PIN G35 [get_ports adc_miso]

set_property IOSTANDARD LVCMOS18 [get_ports csn_pll]
set_property PACKAGE_PIN B34 [get_ports csn_pll]

set_property IOSTANDARD LVCMOS18 [get_ports sclk]
set_property PACKAGE_PIN E35 [get_ports sclk]

set_property IOSTANDARD LVCMOS18 [get_ports miso]
set_property PACKAGE_PIN B36 [get_ports miso]

set_property IOSTANDARD LVCMOS18 [get_ports mosi]
set_property PACKAGE_PIN A32 [get_ports mosi]

set_property IOSTANDARD LVCMOS18 [get_ports csn]
set_property PACKAGE_PIN B32 [get_ports csn]

set_property IOSTANDARD LVDS [get_ports synctrig_p]
set_property PACKAGE_PIN L35 [get_ports synctrig_p]
set_property PACKAGE_PIN K35 [get_ports synctrig_n]

set_property IOSTANDARD LVDS [get_ports synco_p]
set_property PACKAGE_PIN D29 [get_ports synco_p]
set_property PACKAGE_PIN C29 [get_ports synco_n]

set_false_path -from [get_clocks rx_usrclk] -to [get_clocks clk_out1_clk_wiz_0]
set_false_path -from [get_clocks clk_out1_clk_wiz_0] -to [get_clocks rx_usrclk]
set_false_path -from [get_clocks clk_mgtref] -to [get_clocks clk_out1_clk_wiz_0]
set_false_path -from [get_clocks clk_out1_clk_wiz_0] -to [get_clocks clk_mgtref]
#set_false_path -from [get_clocks rx_usrclk] -to [get_clocks clk_mgtref]
#set_false_path -from [get_clocks clk_mgtref] -to [get_clocks rx_usrclk]
