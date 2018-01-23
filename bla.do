restart
force -freeze sim:/bomberman_ent/clk 1 0, 0 {5 ps} -r 10
force -freeze sim:/bomberman_ent/rst 1 0
force -freeze sim:/bomberman_ent/p1_bomb 1 0
force -freeze sim:/bomberman_ent/p1_bomb 0 0 -cancel 100
force -freeze sim:/bomberman_ent/p1_right 0 0
run 2000