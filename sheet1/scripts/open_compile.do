# open project
project open /home/capplab10/Schreibtisch/bpti/bpti

# compile files
set files_list {21_and.vhd 
		21_not.vhd
		21_or.vhd
		22_nand_behav.vhd
		22_nand_struct.vhd
		22_nor_behav.vhd
		22_nor_struct.vhd
		23_impuls.vhd
		24_counter.vhd
		322_nand_testbench.vhd
}

foreach file $files_list {
	set root_dir "sheet1/task2_3_vhd/"
	append root_dir $file
	vcom $root_dir
}