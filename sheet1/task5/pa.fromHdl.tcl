
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name task5 -dir "/home/capplab10/Schreibtisch/bpti/sheet1/task5/planAhead_run_2" -part xc3sd1800afg676-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "led_pins.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {myDCM2.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../task2_3_vhd/24_counter.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {led_test.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top led_ent $srcset
add_files [list {led_pins.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3sd1800afg676-4
