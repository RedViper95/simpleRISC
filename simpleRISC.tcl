# Copyright (C) 2020  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and any partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel FPGA IP License Agreement, or other applicable license
# agreement, including, without limitation, that your use is for
# the sole purpose of programming logic devices manufactured by
# Intel and sold by Intel or its authorized distributors.  Please
# refer to the applicable agreement for further details, at
# https://fpgasoftware.intel.com/eula.

# Quartus Prime: Generate Tcl File for Project
# File: simpleRISC.tcl
# Generated on: Sat Jan 02 13:28:44 2021

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "simpleRISC"]} {
		puts "Project simpleRISC is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists simpleRISC]} {
		project_open -revision simpleRISC simpleRISC
	} else {
		project_new -revision simpleRISC simpleRISC
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "MAX 10 FPGA"
	set_global_assignment -name DEVICE 10M50DAF484C7G
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 16.0.0
	set_global_assignment -name LAST_QUARTUS_VERSION "20.1.1 Lite Edition"
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "11:04:09 JANUARY 02,2021"
	set_global_assignment -name DEVICE_FILTER_PACKAGE FBGA
	set_global_assignment -name DEVICE_FILTER_PIN_COUNT 484
	set_global_assignment -name DEVICE_FILTER_SPEED_GRADE 7
	set_global_assignment -name VERILOG_FILE simpleRISC.v
	set_global_assignment -name VERILOG_FILE src/processor.v
	set_global_assignment -name VERILOG_FILE src/instructionFetchUnit.v
	set_global_assignment -name VERILOG_FILE src/operandFetchUnit.v
	set_global_assignment -name VERILOG_FILE src/memoryAccess.v
	set_global_assignment -name VERILOG_FILE src/executeUnit.v
	set_global_assignment -name VERILOG_FILE src/registerWriteBack.v
	set_global_assignment -name VERILOG_FILE src/registerFile.v
	set_global_assignment -name VERILOG_FILE src/controlUnit.v
	set_global_assignment -name SDC_FILE simpleRISC.SDC
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
	set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name EDA_SIMULATION_TOOL "ModelSim-Altera (Verilog)"
	set_global_assignment -name EDA_OUTPUT_DATA_FORMAT "VERILOG HDL" -section_id eda_simulation
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[7]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[7]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[7]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[7]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[7]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[7]
	set_location_assignment PIN_C14 -to HEX0[0]
	set_location_assignment PIN_E15 -to HEX0[1]
	set_location_assignment PIN_C15 -to HEX0[2]
	set_location_assignment PIN_C16 -to HEX0[3]
	set_location_assignment PIN_E16 -to HEX0[4]
	set_location_assignment PIN_D17 -to HEX0[5]
	set_location_assignment PIN_C17 -to HEX0[6]
	set_location_assignment PIN_D15 -to HEX0[7]
	set_location_assignment PIN_C18 -to HEX1[0]
	set_location_assignment PIN_D18 -to HEX1[1]
	set_location_assignment PIN_E18 -to HEX1[2]
	set_location_assignment PIN_B16 -to HEX1[3]
	set_location_assignment PIN_A17 -to HEX1[4]
	set_location_assignment PIN_A18 -to HEX1[5]
	set_location_assignment PIN_B17 -to HEX1[6]
	set_location_assignment PIN_A16 -to HEX1[7]
	set_location_assignment PIN_B20 -to HEX2[0]
	set_location_assignment PIN_A20 -to HEX2[1]
	set_location_assignment PIN_B19 -to HEX2[2]
	set_location_assignment PIN_A21 -to HEX2[3]
	set_location_assignment PIN_B21 -to HEX2[4]
	set_location_assignment PIN_C22 -to HEX2[5]
	set_location_assignment PIN_B22 -to HEX2[6]
	set_location_assignment PIN_A19 -to HEX2[7]
	set_location_assignment PIN_F21 -to HEX3[0]
	set_location_assignment PIN_E22 -to HEX3[1]
	set_location_assignment PIN_E21 -to HEX3[2]
	set_location_assignment PIN_C19 -to HEX3[3]
	set_location_assignment PIN_C20 -to HEX3[4]
	set_location_assignment PIN_D19 -to HEX3[5]
	set_location_assignment PIN_E17 -to HEX3[6]
	set_location_assignment PIN_D22 -to HEX3[7]
	set_location_assignment PIN_F18 -to HEX4[0]
	set_location_assignment PIN_E20 -to HEX4[1]
	set_location_assignment PIN_E19 -to HEX4[2]
	set_location_assignment PIN_J18 -to HEX4[3]
	set_location_assignment PIN_H19 -to HEX4[4]
	set_location_assignment PIN_F19 -to HEX4[5]
	set_location_assignment PIN_F20 -to HEX4[6]
	set_location_assignment PIN_F17 -to HEX4[7]
	set_location_assignment PIN_J20 -to HEX5[0]
	set_location_assignment PIN_K20 -to HEX5[1]
	set_location_assignment PIN_L18 -to HEX5[2]
	set_location_assignment PIN_N18 -to HEX5[3]
	set_location_assignment PIN_M20 -to HEX5[4]
	set_location_assignment PIN_N19 -to HEX5[5]
	set_location_assignment PIN_N20 -to HEX5[6]
	set_location_assignment PIN_L19 -to HEX5[7]
	set_instance_assignment -name IO_STANDARD "3.3 V SCHMITT TRIGGER" -to KEY[0]
	set_instance_assignment -name IO_STANDARD "3.3 V SCHMITT TRIGGER" -to KEY[1]
	set_location_assignment PIN_B8 -to KEY[0]
	set_location_assignment PIN_A7 -to KEY[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[7]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[8]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[9]
	set_location_assignment PIN_A8 -to LEDR[0]
	set_location_assignment PIN_A9 -to LEDR[1]
	set_location_assignment PIN_A10 -to LEDR[2]
	set_location_assignment PIN_B10 -to LEDR[3]
	set_location_assignment PIN_D13 -to LEDR[4]
	set_location_assignment PIN_C13 -to LEDR[5]
	set_location_assignment PIN_E14 -to LEDR[6]
	set_location_assignment PIN_D14 -to LEDR[7]
	set_location_assignment PIN_A11 -to LEDR[8]
	set_location_assignment PIN_B11 -to LEDR[9]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[7]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[8]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[9]
	set_location_assignment PIN_C10 -to SW[0]
	set_location_assignment PIN_C11 -to SW[1]
	set_location_assignment PIN_D12 -to SW[2]
	set_location_assignment PIN_C12 -to SW[3]
	set_location_assignment PIN_A12 -to SW[4]
	set_location_assignment PIN_B12 -to SW[5]
	set_location_assignment PIN_A13 -to SW[6]
	set_location_assignment PIN_A14 -to SW[7]
	set_location_assignment PIN_B14 -to SW[8]
	set_location_assignment PIN_F15 -to SW[9]
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
