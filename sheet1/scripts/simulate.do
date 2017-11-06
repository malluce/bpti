if {$argc < 3} {error "Too few arguments. Usage: simulate <file_name> <entity_name> <architecture_name>"}


# open file for sim
set file $1
set root_dir "sheet1/task2_3_vhd/"
append root_dir $file
vsim $root_dir

# load design
set ent $2
set arch $3
set work "work."
append work $ent
append work "("
append work $arch
append work ")"
vsim $work


# stuff for view
view wave

puts $argc

# show signals in wave
for {set i 4} {$i <= $argc} {incr i} {
	set var "$"
	append var $i
	puts $var
	add wave $var
}

#add wave $4
#add wave $5
#add wave $6
#add wave $7

# run simulation
run 100 ns