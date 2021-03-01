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

set_false_path -from [get_clocks {rxoutclk_out[3]_1}] -to [get_clocks clk_out1_clk_wiz_0]
set_false_path -from [get_clocks clk_out1_clk_wiz_0] -to [get_clocks {rxoutclk_out[3]_1}]
set_false_path -from [get_clocks clk_out1_clk_wiz_frame_clk] -to [get_clocks clk_out1_clk_wiz_0]
set_false_path -from [get_clocks clk_out1_clk_wiz_0] -to [get_clocks clk_out1_clk_wiz_frame_clk]
set_false_path -from [get_clocks {rxoutclk_out[3]_1}] -to [get_clocks clk_out1_clk_wiz_frame_clk]
set_false_path -from [get_clocks clk_out1_clk_wiz_frame_clk] -to [get_clocks {rxoutclk_out[3]_1}]



create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 4 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list gen_esistream_hdl.rx_esistream_inst/i_rx_xcvr_wrapper/i_mmcm_frame_clk/inst/clk_out1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 12 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {data_out_12b[0][1][0]} {data_out_12b[0][1][1]} {data_out_12b[0][1][2]} {data_out_12b[0][1][3]} {data_out_12b[0][1][4]} {data_out_12b[0][1][5]} {data_out_12b[0][1][6]} {data_out_12b[0][1][7]} {data_out_12b[0][1][8]} {data_out_12b[0][1][9]} {data_out_12b[0][1][10]} {data_out_12b[0][1][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 12 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {data_out_12b[1][0][0]} {data_out_12b[1][0][1]} {data_out_12b[1][0][2]} {data_out_12b[1][0][3]} {data_out_12b[1][0][4]} {data_out_12b[1][0][5]} {data_out_12b[1][0][6]} {data_out_12b[1][0][7]} {data_out_12b[1][0][8]} {data_out_12b[1][0][9]} {data_out_12b[1][0][10]} {data_out_12b[1][0][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 12 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {data_out_12b[2][1][0]} {data_out_12b[2][1][1]} {data_out_12b[2][1][2]} {data_out_12b[2][1][3]} {data_out_12b[2][1][4]} {data_out_12b[2][1][5]} {data_out_12b[2][1][6]} {data_out_12b[2][1][7]} {data_out_12b[2][1][8]} {data_out_12b[2][1][9]} {data_out_12b[2][1][10]} {data_out_12b[2][1][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 12 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {data_out_12b[0][0][0]} {data_out_12b[0][0][1]} {data_out_12b[0][0][2]} {data_out_12b[0][0][3]} {data_out_12b[0][0][4]} {data_out_12b[0][0][5]} {data_out_12b[0][0][6]} {data_out_12b[0][0][7]} {data_out_12b[0][0][8]} {data_out_12b[0][0][9]} {data_out_12b[0][0][10]} {data_out_12b[0][0][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 12 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {data_out_12b[3][0][0]} {data_out_12b[3][0][1]} {data_out_12b[3][0][2]} {data_out_12b[3][0][3]} {data_out_12b[3][0][4]} {data_out_12b[3][0][5]} {data_out_12b[3][0][6]} {data_out_12b[3][0][7]} {data_out_12b[3][0][8]} {data_out_12b[3][0][9]} {data_out_12b[3][0][10]} {data_out_12b[3][0][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 12 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {data_out_12b[1][1][0]} {data_out_12b[1][1][1]} {data_out_12b[1][1][2]} {data_out_12b[1][1][3]} {data_out_12b[1][1][4]} {data_out_12b[1][1][5]} {data_out_12b[1][1][6]} {data_out_12b[1][1][7]} {data_out_12b[1][1][8]} {data_out_12b[1][1][9]} {data_out_12b[1][1][10]} {data_out_12b[1][1][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 12 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {data_out_12b[4][0][0]} {data_out_12b[4][0][1]} {data_out_12b[4][0][2]} {data_out_12b[4][0][3]} {data_out_12b[4][0][4]} {data_out_12b[4][0][5]} {data_out_12b[4][0][6]} {data_out_12b[4][0][7]} {data_out_12b[4][0][8]} {data_out_12b[4][0][9]} {data_out_12b[4][0][10]} {data_out_12b[4][0][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 12 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {data_out_12b[4][1][0]} {data_out_12b[4][1][1]} {data_out_12b[4][1][2]} {data_out_12b[4][1][3]} {data_out_12b[4][1][4]} {data_out_12b[4][1][5]} {data_out_12b[4][1][6]} {data_out_12b[4][1][7]} {data_out_12b[4][1][8]} {data_out_12b[4][1][9]} {data_out_12b[4][1][10]} {data_out_12b[4][1][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 12 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {data_out_12b[6][1][0]} {data_out_12b[6][1][1]} {data_out_12b[6][1][2]} {data_out_12b[6][1][3]} {data_out_12b[6][1][4]} {data_out_12b[6][1][5]} {data_out_12b[6][1][6]} {data_out_12b[6][1][7]} {data_out_12b[6][1][8]} {data_out_12b[6][1][9]} {data_out_12b[6][1][10]} {data_out_12b[6][1][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 12 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {data_out_12b[7][1][0]} {data_out_12b[7][1][1]} {data_out_12b[7][1][2]} {data_out_12b[7][1][3]} {data_out_12b[7][1][4]} {data_out_12b[7][1][5]} {data_out_12b[7][1][6]} {data_out_12b[7][1][7]} {data_out_12b[7][1][8]} {data_out_12b[7][1][9]} {data_out_12b[7][1][10]} {data_out_12b[7][1][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 12 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {data_out_12b[5][0][0]} {data_out_12b[5][0][1]} {data_out_12b[5][0][2]} {data_out_12b[5][0][3]} {data_out_12b[5][0][4]} {data_out_12b[5][0][5]} {data_out_12b[5][0][6]} {data_out_12b[5][0][7]} {data_out_12b[5][0][8]} {data_out_12b[5][0][9]} {data_out_12b[5][0][10]} {data_out_12b[5][0][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 12 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {data_out_12b[5][1][0]} {data_out_12b[5][1][1]} {data_out_12b[5][1][2]} {data_out_12b[5][1][3]} {data_out_12b[5][1][4]} {data_out_12b[5][1][5]} {data_out_12b[5][1][6]} {data_out_12b[5][1][7]} {data_out_12b[5][1][8]} {data_out_12b[5][1][9]} {data_out_12b[5][1][10]} {data_out_12b[5][1][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 8 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {valid_out[0]} {valid_out[1]} {valid_out[2]} {valid_out[3]} {valid_out[4]} {valid_out[5]} {valid_out[6]} {valid_out[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 12 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {data_out_12b[7][0][0]} {data_out_12b[7][0][1]} {data_out_12b[7][0][2]} {data_out_12b[7][0][3]} {data_out_12b[7][0][4]} {data_out_12b[7][0][5]} {data_out_12b[7][0][6]} {data_out_12b[7][0][7]} {data_out_12b[7][0][8]} {data_out_12b[7][0][9]} {data_out_12b[7][0][10]} {data_out_12b[7][0][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 12 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {data_out_12b[2][0][0]} {data_out_12b[2][0][1]} {data_out_12b[2][0][2]} {data_out_12b[2][0][3]} {data_out_12b[2][0][4]} {data_out_12b[2][0][5]} {data_out_12b[2][0][6]} {data_out_12b[2][0][7]} {data_out_12b[2][0][8]} {data_out_12b[2][0][9]} {data_out_12b[2][0][10]} {data_out_12b[2][0][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 12 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list {data_out_12b[3][1][0]} {data_out_12b[3][1][1]} {data_out_12b[3][1][2]} {data_out_12b[3][1][3]} {data_out_12b[3][1][4]} {data_out_12b[3][1][5]} {data_out_12b[3][1][6]} {data_out_12b[3][1][7]} {data_out_12b[3][1][8]} {data_out_12b[3][1][9]} {data_out_12b[3][1][10]} {data_out_12b[3][1][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 12 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list {data_out_12b[6][0][0]} {data_out_12b[6][0][1]} {data_out_12b[6][0][2]} {data_out_12b[6][0][3]} {data_out_12b[6][0][4]} {data_out_12b[6][0][5]} {data_out_12b[6][0][6]} {data_out_12b[6][0][7]} {data_out_12b[6][0][8]} {data_out_12b[6][0][9]} {data_out_12b[6][0][10]} {data_out_12b[6][0][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list be_status]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 1 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list cb_status]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 1 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list rx_lanes_ready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list rx_sync_in]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 1 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list valid_status]]
create_debug_core u_ila_1 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_1]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_1]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_1]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_1]
set_property C_INPUT_PIPE_STAGES 4 [get_debug_cores u_ila_1]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_1]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_1]
set_property port_width 1 [get_debug_ports u_ila_1/clk]
connect_debug_port u_ila_1/clk [get_nets [list i_pll_sys/inst/clk_out1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe0]
set_property port_width 1 [get_debug_ports u_ila_1/probe0]
connect_debug_port u_ila_1/probe0 [get_nets [list rx_ip_ready]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets sysclk]
