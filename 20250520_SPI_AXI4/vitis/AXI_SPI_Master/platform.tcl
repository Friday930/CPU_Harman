# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\CPU_Harman\20250520_SPI_AXI4\vitis\AXI_SPI_Master\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\CPU_Harman\20250520_SPI_AXI4\vitis\AXI_SPI_Master\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {AXI_SPI_Master}\
-hw {C:\CPU_Harman\20250520_SPI_AXI4\vitis\AXI_SPI_Master.xsa}\
-fsbl-target {psu_cortexa53_0} -out {C:/CPU_Harman/20250520_SPI_AXI4/vitis}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {empty_application}
platform generate -domains 
platform active {AXI_SPI_Master}
platform generate -quick
catch {platform remove AXI_SPI_Master}
platform create -name {AXI_SPI_Master}\
-hw {C:\CPU_Harman\20250520_SPI_AXI4\vitis\AXI_SPI_Master.xsa}\
-fsbl-target {psu_cortexa53_0} -out {C:/CPU_Harman/20250520_SPI_AXI4/vitis}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform write
platform generate -quick
platform generate
