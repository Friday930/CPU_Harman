# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: C:\CPU_Harman\20250520_SPI_AXI4\vitis\hello_spi_mk3_system\_ide\scripts\systemdebugger_hello_spi_mk3_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source C:\CPU_Harman\20250520_SPI_AXI4\vitis\hello_spi_mk3_system\_ide\scripts\systemdebugger_hello_spi_mk3_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -filter {jtag_cable_name =~ "Digilent Basys3 210183BB7A24A" && level==0 && jtag_device_ctx=="jsn-Basys3-210183BB7A24A-0362d093-0"}
fpga -file C:/CPU_Harman/20250520_SPI_AXI4/vitis/hello_spi_mk3/_ide/bitstream/AXI_SPI_Master.bit
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
loadhw -hw C:/CPU_Harman/20250520_SPI_AXI4/vitis/AXI_SPI_Master/export/AXI_SPI_Master/hw/AXI_SPI_Master.xsa -regs
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
rst -system
after 3000
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
dow C:/CPU_Harman/20250520_SPI_AXI4/vitis/hello_spi_mk3/Debug/hello_spi_mk3.elf
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
con
