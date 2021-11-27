/* File player.pl */
/* Menyimpan mekanisme kenaikan level dan exp pemain */

:- dynamic(specialty/1).
:- dynamic(level_fishing/1).
:- dynamic(level_fishing_rod/1).
:- dynamic(level_farming/1).
:- dynamic(level_ranching/1).
:- dynamic(level_player/1).
:- dynamic(exp_fishing_rod/1).
:- dynamic(exp_fishing/1).
:- dynamic(exp_farming/1).
:- dynamic(exp_ranching/1).
:- dynamic(exp_total/1).
:- dynamic(gold/1).

level_up_fishing :-
    level_fishing(N),
    N1 is N+1,
    assertz(level_fishing(N1)),
    retract(level_fishing(N)).

level_up_fishing_rod :-
    level_fishing_rod(N),
    N1 is N+1,
    assertz(level_fishing_rod(N1)),
    retract(level_fishing_rod(N)).

level_up_farming :-
    level_farming(N),
    N1 is N+1,
    assertz(level_farming(N1)),
    retract(level_farming(N)).

level_up_ranching :-
    level_ranching(N),
    N1 is N+1,
    assertz(level_ranching(N1)),
    retract(level_ranching(N)).

level_up_player:-
    level_player(N),
    N1 is N+1,
    assertz(level_player(N1)),
    retract(level_player(N)).

gain_exp_fishing(V) :-
    exp_fishing(N),
    exp_total(M),
    N1 is N + V,
    M1 is M + V,
    assertz(exp_total(M1)),
    assertz(exp_fishing(N1)),
    retract(exp_fishing(N)),
    retract(exp_total(M)).

gain_exp_farming(V) :-
    exp_farming(N),
    exp_total(M),
    N1 is N + V,
    M1 is M + V,
    assertz(exp_total(M1)),
    assertz(exp_farming(N1)),
    retract(exp_farming(N)),
    retract(exp_total(M)).

gain_exp_ranching(V) :-
    exp_ranching(N),
    exp_total(M),
    N1 is N + V,
    M1 is M + V,
    assertz(exp_total(M1)),
    assertz(exp_ranching(N1)),
    retract(exp_ranching(N)),
    retract(exp_total(M)).
