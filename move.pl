/* File move.pl */
/* Menyimpan aturan perpindahan pemain (exploration mechanism) */
/* Pesan ketika menabrak sesuatu */
hit_fence :-
    write('You hit a fence, use \'map.\' to see where you are right now').

hit_water :-
    write('You can\'t get into water, use \'map.\' to see where you are right now').

/* Bergerak ke utara (atas) */
n :-       
	isStart(true),
    map_object(X,Y,'P'),
    YNew is Y-1,
    map_object(X, YNew, 'o'), !, hit_water, fail.

n :-       
	isStart(true),
    map_object(X,Y,'P'),
    YNew is Y-1,
    map_size(_, H),
    YNew > 0, YNew =< H, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(X,YNew,'P')),
    write('You moved north.').

n :-
    isStart(false), !,
	write('Game has not started, use \"start.\" to play the game"').

n :-
    hit_fence.

/* Bergerak ke timur (kanan) */
e :- 
	isStart(true),
    map_object(X,Y,'P'),
    XNew is X+1,
    map_object(XNew, Y, 'o'), !, hit_water, fail.

e :-
	isStart(true),
    map_object(X,Y,'P'),
    XNew is X+1,
    map_size(W, _),
    XNew > 0, XNew =< W, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(XNew,Y,'P')),
    write('You moved east.').

e :-
    isStart(false), !,
	write('Game has not started, use \"start.\" to play the game"').

e :-
    hit_fence.

/* Bergerak ke selatan (bawah) */
s :- 
	isStart(true),
    map_object(X,Y,'P'),
    YNew is Y+1,
    map_object(X, YNew, 'o'), !, hit_water, fail.

s :- 
	isStart(true),
    map_object(X,Y,'P'),
    YNew is Y+1,
    map_size(_, H),
    YNew > 0, YNew =< H, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(X,YNew,'P')),
    write('You moved south.').

s :-
    isStart(false), !,
	write('Game has not started, use \"start.\" to play the game"').

s :-
    hit_fence.

/* Bergerak ke barat(kiri) */
w :- 
	isStart(true),
    map_object(X,Y,'P'),
    XNew is X-1,
    map_object(XNew, Y, 'o'), !, hit_water, fail.

w :- 
	isStart(true),
    map_object(X,Y,'P'),
    XNew is X-1,
    map_size(W, _),
    XNew > 0, XNew =< W, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(XNew,Y,'P')),
    write('You moved west.').

w :-
    isStart(false), !,
	write('Game has not started, use \"start.\" to play the game"').

w :-
    hit_fence.