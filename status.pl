/* File : status.pl */
/* Menyimpan tampilan status pemain */

status :- 
    isStart(true), !,
    playerLevelUp(_,MaxExp),
    write('Your status:'),nl,
    write('Job: '), specialty(Spec), write(Spec), nl,
    write('Level: '), level_player(LvP), write(LvP), nl,
    write('Level farming: '), level_farming(LvFarm), write(LvFarm), nl,
    write('Exp farming: '), exp_farming(ExpFarm), write(ExpFarm), nl,
    write('Level fishing: '), level_fishing(LvFish), write(LvFish), nl,
    write('Exp fishing: '), exp_fishing(ExpFish), write(ExpFish), nl,
    write('Level ranching: '), level_ranching(LvRanch), write(LvRanch), nl,
    write('Exp ranching: '), exp_ranching(ExpRanch), write(ExpRanch), nl,
    write('Exp: '), exp_total(Exp), write(Exp), write('/'), write(MaxExp), nl,
    write('Gold: '), gold(Gold), write(Gold), nl,
    write('Stamina: '), stamina(Stamina), write(Stamina), nl.

status :-
    isStart(false), !,
	write('Game has not started, use \"start.\" to play the game').