% Fakta terkait pemain kaya gini bukan?
speciality(Fisherman).
speciality(Farmer).
speciality(Rancher).
level_fisherman(1).
level_farmer(1).
level_rancher(1).
level_player(1).
exp_fisherman(0).
exp_farmer(0).
exp_rancher(0).
gold(0).

speciality(Fisherman):-
speciality(Farmer):-
speciality(Rancher):-
exptotal(N):-exp_fisherman + exp_farmer + exp_rancher