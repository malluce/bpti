do sheet1/scripts/open_compile.do
if {$argc == 5} {
 do sheet1/scripts/simulate.do $1 $2 $3 $4 $5
} elseif {$argc == 6} {
 do sheet1/scripts/simulate.do $1 $2 $3 $4 $5 $6
} else {
 error "Too few arguments for simulate.do. Expected 5 or 6 arguments"
}
