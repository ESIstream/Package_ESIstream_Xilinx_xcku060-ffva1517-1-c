#!/usr/bin/env python
import os
import sys
import time
import csv
from ev12aq600 import ev12aq600
try:
    import openpyxl
    import matplotlib.pyplot as plt
    import numpy as np
    from scipy.fft import fft, fftfreq
    from scipy.signal import blackman
    from scipy.signal import hanning
    from scipy.signal import boxcar
    from tkinter import *
    from tkinter.tix import *
except:
    print (">> install openpyxl, use \"pip install openpyxl\" in a command prompt.")
    print (">> install matplotlib, use \"pip install matplotlib\" in a command prompt.")
    print (">> install numpy, use \"pip install numpy\" in a command prompt.")
    print (">> install scipy, use \"pip install scipy\" in a command prompt.")

dev_mode = False
"""  
#################################################################################
## OPEN SERIAL COMMUNICATION 
#################################################################################
"""
app=ev12aq600()

if dev_mode == False:
    if len(sys.argv) > 1:
        # Check 1st argument exists 
        com_port = sys.argv[1]
        print (">> Start serial with", com_port)
    else:
        com_port = "COM7"
        print (">> Start serial with", com_port)
    app.start_serial(com_port)
 
"""  
#################################################################################
## EV12AQ600-FMC-EVM FUNCTIONS 
#################################################################################
"""
def hw_config():
    # ref clk source internal (default)
    app.ref_sel_ext(0)
    # ref clk source external ref clk SMA EXT REF (default)
    app.ref_sel(0)
    # ADC CLK from PLL LMX2592
    app.clk_sel(1)
    # SYNCO ADC (default)
    app.synco_sel(0) 
    # SYNC FPGA (default)
    app.sync_sel(0) 
    # ref clk PLL power-down (default)
    app.ref_clk_ratio(0, 0)
    
def lmx2592_config():
    """
    ## argument: LMX2592 external PLL ADC CLK frequency [MHz]
    ##    4900: 4.9  GHz 
    ##    5000: 5.0  GHz 
    ##    6250: 6.25 GHz 
    ##    6400: 6.4  GHz 
    """
    fclk = float(e0.get())
    app.spi_ss_external_pll()
     
    if fclk == 4900.0:
        print(">> adc fclk: 4.9 GHz ")
        app.external_pll_configuration_4900()
    elif fclk == 5000.0:
        print(">> adc fclk: 5.0 GHz ")
        app.external_pll_configuration_5000()
    elif fclk == 6250.0:
        print(">> adc fclk: 6.25 GHz ")
        app.external_pll_configuration_6250()
    elif fclk == 6400.0:
        print(">> adc fclk: 6.4 GHz ")
        app.external_pll_configuration_6400()
    else:
        print(">> adc fclk: 6.4 GHz ")
        app.external_pll_configuration_6400()
        
    app.ev12aq600_rstn_pulse()
    time.sleep(0.5)
    app.esistream_reset_pulse()

def adc_config():
    """
    ## argument: channel mode
    ##    0: 1ch IN0")
    ##    1: 1ch IN3")
    ##    2: 2ch IN0 core A&B, IN3 core C&D
    ##    3: 2ch IN3 core A&B, IN0 core C&D
    ##    4: 4ch")
    ## argument: clk mode
    ##    0: all clocks are interleaved (default)
    ##    1: clock A=B, clock C=D
    ##    2: clock A=C, clock B=D
    ##    3: clock A=B=C=D , all clocks are identical, simulatenous sampling
    ## argument: adc mode
    ##    ramp: ramp test mode
    ##    normal: normal mode
    """
    ch_mode  = int(e1.get())
    clk_mode = int(e2.get())
    adc_mode = str(e3v.get())
    ## select SPI slave: EV12AQ600 ADC  
    app.spi_ss_ev12aq600()
    ## release ADC reset
    app.deactivate_ev12aq600_rstn()
    ## enable ESIstream PRBS
    app.rx_prbs_enable()
    ## sync mode
    app.sync_mode_training()
    #app.sync_mode_normal()
    app.sync_delay(0x32) # 48
     
    if adc_mode == "ramp":
        print(">> adc mode: ramp test mode")
        app.ramp_check_enable()
        app.ev12aq600_configuration_ramp_mode()
    else:
        ## adc_mode == "ramp":
        print(">> adc mode: normal mode")
        app.ev12aq600_configuration_normal_mode()
        
    print(">> clk mode: "+ str(clk_mode))
    app.ev12aq600_clk_mode_sel(clk_mode)
     
    print(">> channel mode: "+ str(ch_mode))
    app.ev12aq600_cps_ctrl(ch_mode)

def adc_clk_config(adc_clk_sel):
    if adc_clk_sel == "PLL CLK":
        print(">> PLL_CLK")
        app.clk_sel(1)
    else:
        print(">> EXT CLK")
        app.clk_sel(0)
        
def ref_config(ref_sel):
    if ref_sel == "INT REF":
        app.ref_sel_ext(0)
        app.ref_sel(0)
    elif ref_sel == "EXT REF":
        app.ref_sel_ext(1)
        app.ref_sel(0)
    else:
        ## FPGA REF CLK
        app.ref_sel_ext(1)
        app.ref_sel(1)
        
def sync_config(sync_sel):
    if sync_sel == "FPGA SYNC":
        app.sync_sel(0)
    else:
        app.sync_sel(1)
        
def synco_config(synco_sel):
    if synco_sel == "FPGA SYNCO":
        app.synco_sel(0)
    else:
        app.synco_sel(1)
        
def calset_config(calset_sel):
    if calset_sel == "CalSet0":
        app.ev12aq600_cal_set_sel(0)
    elif calset_sel == "CalSet1":
        app.ev12aq600_cal_set_sel(1)
    elif calset_sel == "CalSet2":    
        app.ev12aq600_cal_set_sel(2)
    else:    
        app.ev12aq600_cal_set_sel(3)
"""  
#################################################################################
## PLOT FUNCTIONS 
#################################################################################
"""
def core_fft(core_list, f_s, adc_resolution, window_enable):
    np_core_data = np.array(core_list)
    # Number of sample points
    N = len(core_list)
    # sample spacing
    T = 1.0 / f_s
    x = np.linspace(0.0, N*T, N, endpoint=False)
    y = np_core_data/(2**(adc_resolution))
    w = blackman(N)
    #w = hanning(N)
    #w = boxcar(N)
    
    if window_enable:
        yf = fft(y*w)
    else:
        yf = fft(y)
        
    #yf = 2.0/N*np.abs(yf[0:N//2])
    yf = 4.0/N*np.abs(yf[0:N//2])
    yf = 20*np.log10(yf)
    xf = fftfreq(N, T)[:N//2]
    return xf, yf

def close_iladata():
    while(plt.get_fignums()):
        # window(s) open
        plt.close()
        
def plot_iladata():
    fclk = float(e0.get())
    ch_mode = int(e1.get())
    devkit = str(e4v.get())
    clk_mode = int(e2.get())
    nb_samples = int(e5.get())
    deser_width = str(e6v.get())
    ila_file_name = str(e7.get())
    if (ch_mode == 1) | (ch_mode == 0):
        ch_mode = 1
    elif (ch_mode == 2) | (ch_mode == 3):
        ch_mode = 2
    else:
        ch_mode = 4
    close_iladata()
        
    with open(ila_file_name, newline='') as csvfile:
        data = list(csv.reader(csvfile))
     
    if ch_mode == 1:
        f_s = fclk*1e6
    elif ch_mode == 2:
        f_s = fclk*1e6/2
    else:
        f_s = fclk*1e6/4
    print (">> adc fs [Hz]: "+str(f_s))
    print (">> channel mode: "+str(ch_mode))
    adc_resolution = 12
    if deser_width == "64-bit":
        ## DESER WIDTH = 64-bit
        deser_coef = 1
    else:
        ## DESER WIDTH = 32-bit
        deser_coef = 2
    window_enable = False
    pure_sinus = False
     
    #########################################
    print (">> Build lane samples vector")
    #########################################
    lane_data= [] 
    for lane in range(0, 8):
        data_out_12b = []
        for row in range(2, 2+nb_samples):
            ## also convert csv hexadecimal values to decimal using: int(hexvalue,16)
            data_out_12b.append(int(data[row][3+lane*int(4/deser_coef)],16))
            data_out_12b.append(int(data[row][4+lane*int(4/deser_coef)],16))
            if deser_coef == 1:
                data_out_12b.append(int(data[row][5+lane*4],16))
                data_out_12b.append(int(data[row][6+lane*4],16))
        lane_data.append(data_out_12b)
        
    #########################################
    print (">> Build lane swapped")
    #########################################
    ## Versal VCK190 - EV12AQ600-FMC-EVM:
    if devkit == "vck190":
        lane_swap = [2, 3, 0, 1, 6, 5, 4, 7]
    elif devkit == "kcu105":
        lane_swap = [6, 7, 4, 5, 1, 2, 0, 3]
    elif devkit == "ada-sdev-kit2":
        lane_swap = [2, 3, 0, 1, 6, 5, 4, 7]
    else:
        lane_swap = [2, 3, 0, 1, 6, 5, 4, 7]
        
    lane_data_swap= [] 
    for lane in range(0, 8):
        lane_data_swap.append(lane_data[lane_swap[lane]])
        
    #########################################
    print (">> Build core samples vector")
    #########################################
    core_data = [] 
    for core in range(0, 4):
        data_out = []
        # print (core)
        for index in range(0, int(4/deser_coef)*nb_samples):
            data_out.append(lane_data_swap[2*core][index])
            data_out.append(lane_data_swap[2*core+1][index])
        core_data.append(data_out)

    if ch_mode == 1 and clk_mode != 3:
        """ 1 CH MODE """
        #########################################
        print (">> Build 1ch samples vector")
        #########################################
        data_1ch = []
        # C -> D -> A -> B
        # print (core)
        for index in range(0, int(8/deser_coef)*nb_samples):
            for core in [2,3,0,1]:
                data_1ch.append(core_data[core][index])
         
        #########################################
        print (">> Create time vector")
        #########################################
        time = []
        for t in range (0, int(8/deser_coef)*4*nb_samples):
            time.append(t/f_s)
        if pure_sinus:
            fsinus = 5.011e9 
            for index in range(0, int(8/deser_coef)*4*nb_samples):
                data_1ch[index] = 2048+(2**(adc_resolution-1)-1)*np.sin(2.0*np.pi*fsinus*float(time[index])) 
        #########################################
        print (">> Create fft")
        #########################################
        xf, yf = core_fft(data_1ch, f_s, adc_resolution, window_enable)
        #########################################
        ## plot fft and time
        #########################################
        fig1, ((axa, axb)) = plt.subplots(2)
        fig1.suptitle('1CH mode')
        axa.step(xf, yf, 'tab:blue')
        axa.set_title("FFT")
        axa.grid()
        axb.step(time, data_1ch, 'tab:green')
        axb.set_xlabel('Time')
        axb.set_ylabel('Samples')
        
    else:
        """ 4 CH MODE """
        if clk_mode == 3:
            print (">> Simultaneous sampling")
            data_averaging = []
            for index in range(0, int(8/deser_coef)*nb_samples):
                average = 0
                for core in [0,1,2,3]:
                    average = average + core_data[core][index]
                data_averaging.append(average/4)
            
        #########################################
        print (">> Create time vector")
        #########################################
        time = []
        for t in range (0, int(8/deser_coef)*nb_samples):
            time.append(t/f_s)
        #########################################
        print (">> Create fft")
        #########################################
        xfa, yfa = core_fft(core_data[0], f_s, adc_resolution, window_enable) 
        xfb, yfb = core_fft(core_data[1], f_s, adc_resolution, window_enable) 
        xfc, yfc = core_fft(core_data[2], f_s, adc_resolution, window_enable) 
        xfd, yfd = core_fft(core_data[3], f_s, adc_resolution, window_enable) 
        if clk_mode == 3:
            xf, yf = core_fft(data_averaging, f_s, adc_resolution, window_enable)
        #########################################
        ## plot fft
        #########################################
        fig1, ((axa, axb), (axc, axd)) = plt.subplots(2, 2)
        fig1.suptitle('Cores FFT')
        axa.step(xfa, yfa, 'tab:blue')
        if clk_mode == 3:
            axa.step(xf, yf, 'tab:gray')
        axa.set_title("Core A")
        axa.grid()
        axb.step(xfb, yfb, 'tab:orange')
        if clk_mode == 3:
            axb.step(xf, yf, 'tab:gray')
        axb.set_title("Core B")
        axb.grid()
        axc.step(xfc, yfc, 'tab:green')
        if clk_mode == 3:
            axc.step(xf, yf, 'tab:gray')
        axc.set_title("Core C")
        axc.grid()
        axd.step(xfd, yfd, 'tab:red')
        if clk_mode == 3:
            axd.step(xf, yf, 'tab:gray')
        axd.set_title("Core D")
        axd.grid()
        #########################################
        ## plot time
        #########################################
        fig2, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2)
        fig2.suptitle('Cores samples')
        ax1.step(time, core_data[0], 'tab:blue')
        if clk_mode == 3:
            ax1.step(time, data_averaging, 'tab:grey')
        ax1.set_title("Core A")
        ax2.step(time, core_data[1], 'tab:orange')
        if clk_mode == 3:
            ax2.step(time, data_averaging, 'tab:grey')
        ax2.set_title("Core B")
        ax3.step(time, core_data[2], 'tab:green')
        if clk_mode == 3:
            ax3.step(time, data_averaging, 'tab:grey')
        ax3.set_title("Core C")
        ax4.step(time, core_data[3], 'tab:red')
        if clk_mode == 3:
            ax4.step(time, data_averaging, 'tab:grey')
        ax4.set_title("Core D")


    plt.show()


"""  
#################################################################################
## EV12AQ600 ADC INIT
#################################################################################
"""
if dev_mode == False:
    app.deactivate_ev12aq600_rstn()
    time.sleep(0.1)
    app.ev12aq600_otp_load()
    hw_config()

"""  
#################################################################################
## GUI  
#################################################################################
"""
root_path = os.path.realpath(__file__)
root_path = root_path.replace(sys.argv[0], '')
print(root_path)
root = Tk()
root.title('EV12AQ600 GUI v0.0.0')
root.iconphoto(False, PhotoImage(file=root_path+"te2v.png"))
root.geometry("400x400")
root['bg'] = 'white'

button_width = 15
entry_width = 18
menu_width = 11
##-------------------------------------------------------------------------------
## Column 0 Label + Column 1 (field / Option Menu /...)
##-------------------------------------------------------------------------------
r = 0
r = r + 1
text = "ADC CLK frequency [MHz]"
label0 = Label(root, text=text, bg="white").grid(row=r)
##-------------------------------------------------------------------------------
e0 = Entry(root, width = entry_width)
e0.insert(END, '5000.0')
e0.grid(row = r, column = 1)
##-------------------------------------------------------------------------------
e03_options_list = ["CalSet0", "CalSet1", "CalSet2", "CalSet3"]
e03v = StringVar(root)
e03v.set("CalSet0")
e03 = tkinter.OptionMenu(root, e03v, *e03_options_list, command=calset_config)
e03.config(width=menu_width)
e03.grid(row = r, column = 2)
##-------------------------------------------------------------------------------
## New row
##-------------------------------------------------------------------------------
r = r + 1
text = "ADC Channel mode [0,1,2,3,4]"
label1 = Label(root, text=text, bg="white").grid(row=r)
##-------------------------------------------------------------------------------
e1 = Entry(root, width = entry_width)
e1.insert(END, '0')
e1.grid(row = r, column = 1)
tooltip1 = Balloon()
tooltip1.bind_widget(e1, balloonmsg="0: 1ch IN0 \n1: 1ch IN3 \n2: 2ch IN0 core A&B, IN3 core C&D \n3: 2ch IN3 core A&B, IN0 core C&D \n4: 4ch")
##-------------------------------------------------------------------------------
text = "OTP Load"
button002 = Button(root, text=text, width = button_width, command=app.ev12aq600_otp_load, activebackground='green')
button002.grid(row = r, column = 2)
##-------------------------------------------------------------------------------
## New row
##-------------------------------------------------------------------------------
r = r + 1
text = "ADC CLK mode [0,1,2,3]"
label2 = Label(root, text=text, bg="white").grid(row=r)
##-------------------------------------------------------------------------------
e2 = Entry(root, width = entry_width)
e2.insert(END, '0')
e2.grid(row = r, column = 1)
tooltip2 = Balloon()
tooltip2.bind_widget(e2, balloonmsg="0: all clocks are interleaved (default) \n1: clock A=B, clock C=D \n2: clock A=C, clock B=D \n3: clock A=B=C=D , all clocks are identical, simulatenous sampling")
##-------------------------------------------------------------------------------
## New row
##-------------------------------------------------------------------------------
r = r + 1
text = "ADC mode"
label3 = Label(root, text=text, bg="white").grid(row=r)
##-------------------------------------------------------------------------------
e3_options_list = ["normal", "ramp"]
e3v = StringVar(root)
e3v.set("normal")
e3 = tkinter.OptionMenu(root, e3v, *e3_options_list)
e3.config(width=menu_width)
e3.grid(row = r, column = 1)
##-------------------------------------------------------------------------------
## New row
##-------------------------------------------------------------------------------
r = r + 1
text = "FPGA devkit"
label4 = Label(root, text=text, bg="white").grid(row=r)
##-------------------------------------------------------------------------------
e4_options_list = ["kcu105", "vck190", "vc709", "ada-sdev-kit2"]
e4v = StringVar(root)
e4v.set("kcu105")
e4 = tkinter.OptionMenu(root, e4v, *e4_options_list)
e4.config(width=menu_width)
e4.grid(row = r, column = 1)
##-------------------------------------------------------------------------------
## New row
##-------------------------------------------------------------------------------
r = r + 1
text = "RX DESER_WIDTH"
label4 = Label(root, text=text, bg="white").grid(row=r)
##-------------------------------------------------------------------------------
e6_options_list = ["32-bit", "64-bit"]
e6v = StringVar(root)
e6v.set("64-bit")
e6 = tkinter.OptionMenu(root, e6v, *e6_options_list)
e6.config(width=menu_width)
e6.grid(row = r, column = 1)
##-------------------------------------------------------------------------------
## New row
##-------------------------------------------------------------------------------
r = r + 1
text = "ILA buffer depth"
label5 = Label(root, text=text, bg="white").grid(row=r)
##-------------------------------------------------------------------------------
e5 = Entry(root, width = entry_width)
e5.insert(END, "1024")
e5.grid(row = r, column = 1)
##-------------------------------------------------------------------------------
## New row
##-------------------------------------------------------------------------------
r = r + 1
text = "ILA file name"
label7 = Label(root, text=text, bg="white").grid(row=r)
##-------------------------------------------------------------------------------
e7 = Entry(root, width = entry_width)
e7.insert(END, "iladata.csv")
e7.grid(row = r, column = 1)
##-------------------------------------------------------------------------------
## New row
##-------------------------------------------------------------------------------
r = r + 1
text = "ADC RSTN"
button2 = Button(root, text=text, width = button_width, command=app.ev12aq600_rstn_pulse, activebackground='red')
button2.grid(row = r, column = 0)
##
text = "Show ILA data" 
button0 = Button(root, text=text, width = button_width, command=plot_iladata, activebackground='blue')
button0.grid(row = r, column = 1)
##
e21_options_list = ["INT REF", "EXT REF", "FPGA REF"]
e21v = StringVar(root)
e21v.set("INT REF")
e21 = tkinter.OptionMenu(root, e21v, *e21_options_list, command=ref_config)
e21.config(width=menu_width)
e21.grid(row = r, column = 2)
##-------------------------------------------------------------------------------
## New row
##-------------------------------------------------------------------------------
r = r + 1
text = "Program PLL"
button000 = Button(root, text=text, width = button_width, command=lmx2592_config, activebackground='green')
button000.grid(row = r, column = 0)
##
text = "Close ILA data"
button1 = Button(root, text=text, width = button_width, command=close_iladata, activebackground='blue')
button1.grid(row = r, column = 1)
##
e22_options_list = ["PLL CLK", "SMA CLK"]
e22v = StringVar(root)
e22v.set("PLL CLK")
e22 = tkinter.OptionMenu(root, e22v, *e22_options_list, command=adc_clk_config)
e22.config(width=menu_width)
e22.grid(row = r, column = 2)
##-------------------------------------------------------------------------------
## New row
##-------------------------------------------------------------------------------
r=r+1
text = "ADC config"
button102 = Button(root, text=text, width = button_width, command=adc_config, activebackground='green')
button102.grid(row = r, column = 0)
##
e23_options_list = ["FPGA SYNC", "EXT SYNC"]
e23v = StringVar(root)
e23v.set("FPGA SYNC")
e23 = tkinter.OptionMenu(root, e23v, *e23_options_list, command=sync_config)
e23.config(width=menu_width)
e23.grid(row = r, column = 2)
##-------------------------------------------------------------------------------
## New row
##-------------------------------------------------------------------------------
r = r + 1
text = "SYNC"
button003 = Button(root, text=text, width = button_width, command=app.sync_pulse, activebackground='green')
button003.grid(row = r, column = 0)
##
e24_options_list = ["FPGA SYNCO", "EXT SYNCO"]
e24v = StringVar(root)
e24v.set("FPGA SYNCO")
e24 = tkinter.OptionMenu(root, e24v, *e24_options_list, command=synco_config)
e24.config(width=menu_width)
e24.grid(row = r, column = 2)
r = r + 1
##-------------------------------------------------------------------------------
text = "RST ESI"
button004 = Button(root, text=text, width = button_width, command=app.esistream_reset_pulse, activebackground='green')
button004.grid(row = r, column = 1)
##-------------------------------------------------------------------------------
root.mainloop()

"""  
#################################################################################
## CLOSE SERIAL
#################################################################################
"""
if dev_mode == False:
    print (">> Stop serial")
    app.stop_serial()
