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
    isInHouse(true), !,
    write('Use \'exitHouse.\' to exit your house').

n :-       
	isStart(true),
    isInMarket(true), !,
    write('Use \'exitShop.\' to exit the market').

n :-       
	isStart(true),
    isInRanch(true), !,
    write('Use \'exitRanch.\' to exit your ranch').

n :-       
	isStart(true),
    map_object(X,Y,'P'),
    YNew is Y-1,
    map_size(_, H),
    YNew > 0, YNew =< H, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(X,YNew,'P')),
    write('You moved north.'),
    nl, nl, incrementNTime(5), showTime, decStamina(1), updateStamina.

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
    isInHouse(true), !,
    write('Use \'exitHouse.\' to exit your house').

e :-       
	isStart(true),
    isInMarket(true), !,
    write('Use \'exitShop.\' to exit the market').

e :-       
	isStart(true),
    isInRanch(true), !,
    write('Use \'exitRanch.\' to exit your ranch').

e :-
	isStart(true),
    map_object(X,Y,'P'),
    XNew is X+1,
    map_size(W, _),
    XNew > 0, XNew =< W, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(XNew,Y,'P')),
    write('You moved east.'),
    nl, nl, incrementNTime(5), showTime, decStamina(1), updateStamina.

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
    isInHouse(true), !,
    write('Use \'exitHouse.\' to exit your house').

s :-       
	isStart(true),
    isInMarket(true), !,
    write('Use \'exitShop.\' to exit the market').

s :-       
	isStart(true),
    isInRanch(true), !,
    write('Use \'exitRanch.\' to exit your ranch').

s :- 
	isStart(true),
    map_object(X,Y,'P'),
    YNew is Y+1,
    map_size(_, H),
    YNew > 0, YNew =< H, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(X,YNew,'P')),
    write('You moved south.'),
    nl, nl, incrementNTime(5), showTime, decStamina(1), updateStamina.

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
    isInHouse(true), !,
    write('Use \'exitHouse.\' to exit your house').

w :-       
	isStart(true),
    isInMarket(true), !,
    write('Use \'exitShop.\' to exit the market').

w :-       
	isStart(true),
    isInRanch(true), !,
    write('Use \'exitRanch.\' to exit your ranch').

w :- 
	isStart(true),
    map_object(X,Y,'P'),
    XNew is X-1,
    map_size(W, _),
    XNew > 0, XNew =< W, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(XNew,Y,'P')),
    write('You moved west.'),
    nl, nl, incrementNTime(5), showTime, decStamina(1), updateStamina.

w :-
    isStart(false), !,
	write('Game has not started, use \"start.\" to play the game"').

w :-
    hit_fence.

bengong :-
    nl, incrementNTime(5), showTime.