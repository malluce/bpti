restart
force -freeze sim:/bomberman_ent/clk 1 0, 0 {5 ps} -r 10
force -freeze sim:/bomberman_ent/rst 1 0
force -freeze sim:/bomberman_ent/p1_up 1 0
force -freeze sim:/bomberman_ent/p1_right 0 0 -cancel 400
force -freeze sim:/bomberman_ent/p1_down 1 0
force -freeze sim:/bomberman_ent/p1_left 1 0
force -freeze sim:/bomberman_ent/p1_bomb 0 400 -cancel 50
force -freeze sim:/bomberman_ent/p2_up 1 0
force -freeze sim:/bomberman_ent/p2_right 0 0 -cancel 400
force -freeze sim:/bomberman_ent/p2_down 1 0
force -freeze sim:/bomberman_ent/p2_left 1 0
run 2000