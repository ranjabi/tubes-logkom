:- dynamic(level_fisherman/2).
:- dynamic(level_farmer/2).
:- dynamic(level_rancher/2).
:- dynamic(level_player/1).
:- dynamic(exp_fisherman/1).
:- dynamic(exp_farmer/1).
:- dynamic(exp_rancher/1).
:- dynamic(exp_total/1).
:- dynamic(gold/1).

speciality(fisherman).
speciality(farmer).
speciality(rancher).
level_fisherman(1,4).
level_farmer(1,6).
level_rancher(1,2).
level_player(1).
exp_fisherman(0).
exp_farmer(0).
exp_rancher(0).
exp_total(0).
gold(0).

level_up_fisherman:-
    level_fisherman(N,M),
    N1 is N+1,
    M1 is M*2,
    assertz(level_fisherman(N1,M1)),
    retract(level_fisherman(N,M)),!.

level_up_farmer:-
    level_farmer(N,M),
    N1 is N+1,
    M1 is M*3,
    assertz(level_farmer(N1,M1)),
    retract(level_farmer(N,M)),!.

level_up_rancher:-
    level_rancher(N,M),
    N1 is N+1,
    M1 is M*2,
    assertz(level_rancher(N1,M1)),
    retract(level_rancher(N,M)),!.

level_up_player:-
    level_player(N),
    N1 is N+1,
    assertz(level_player(N1)),
    retract(level_player(N)),!.

gain_exp_fisherman(V):-
    exp_fisherman(N),
    exp_total(M),
    N1 is N + V,
    M1 is M + V,
    assertz(exp_total(M1)),
    assertz(exp_fisherman(N1)),
    retract(exp_fisherman(N)),
    retract(exp_total(M)),!.

gain_exp_farmer(V):-
    exp_farmer(N),
    exp_total(M),
    N1 is N + V,
    M1 is M + V,
    assertz(exp_total(M1)),
    assertz(exp_farmer(N1)),
    retract(exp_farmer(N)),
    retract(exp_total(M)),!.

gain_exp_rancher(V):-
    exp_rancher(N),
    exp_total(M),
    N1 is N + V,
    M1 is M + V,
    assertz(exp_total(M1)),
    assertz(exp_rancher(N1)),
    retract(exp_rancher(N)),
    retract(exp_total(M)),!.
