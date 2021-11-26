/* File move.pl */
/* Menyimpan aturan perpindahan pemain (exploration mechanism) */
/* Pesan ketika menabrak sesuatu */

:- dynamic(time/2). % (hour, minute)
:- dynamic(date/2). % (day, month)

month(0, 'Summer').
month(1, 'Fall').
month(2, 'Winter').
month(3, 'Spring').
month(4, 'Summer').
month(5, 'Fall').
month(6, 'Winter').
month(7, 'Spring').

time(08, 00). % start at 8 oclock
date(01, 00). % start at 1 Summer

incrementTime :-
    time(Hour, Minute),
    date(Day, Month),
    retract(time(Hour, Minute)),
    retract(date(Day, Month)),
    NewMinute is Minute + 10,
    ( 
        NewMinute =:= 60 ->
        FinalMinute is 0,
        NewHour is Hour + 1;

        % else
        NewHour is Hour,
        FinalMinute is NewMinute
    ),
    (
        NewHour =:= 24 ->
        FinalHour is 0,
        NewDay is Day + 1;

        % else
        NewDay is Day,
        FinalHour is NewHour
    ),
    (
        NewDay =:= 31 ->
        FinalDay is 1,
        FinalMonth is mod(Month + 1, 8);

        % else
        FinalMonth is Month,
        FinalDay is NewDay
    ),
    assertz(time(FinalHour, FinalMinute)),
    assertz(date(FinalDay, FinalMonth)),
    month(FinalMonth, MonthName),
    write(FinalDay), write(' '), write(MonthName), write('. '),
    write(FinalHour), write(':'), write(FinalMinute), write('.'), nl.

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
    write('You moved north.'),
    nl, nl, incrementTime.

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
    write('You moved east.'),
    nl, nl, incrementTime.

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
    write('You moved south.'),
    nl, nl, incrementTime.

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
    write('You moved west.'),
    nl, nl, incrementTime.

w :-
    isStart(false), !,
	write('Game has not started, use \"start.\" to play the game"').

w :-
    hit_fence.

bengong :-
    nl, incrementTime.