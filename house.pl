/* File house.pl */
/* Menyimpan aktivitas di house */

:- dynamic(isInHouse/1).

isInHouse(false).

house :-
    map_object(X,Y,'H'),
    map_object(X,Y,'P'),
    retract(isInHouse(false)),
    asserta(isInHouse(true)), !,
    write('What do you want to do?'),nl,
    write('1. sleep'),nl,
    write('2. writeDiary'),nl,
    write('3. readDiary'),nl,
    write('4. exit'),nl.

house :-
    write('You are not at your house, use \'map.\' to see where you are right now').

sleep :-
    isInHouse(true), !,
    write('You went to sleep'),
    date(Day,Month), 
    (
        Day =:= 31, 
        Day1 is 1, 
        Month1 is mod(Month + 1, 8),
        assertz(date(Day1,Month1)),
        retract(date(Day,Month));

        Day < 31,
        Day1 is Day + 1,
        Month1 is Month,
        assertz(date(Day1,Month1)),
        retract(date(Day,Month))
    ).

sleep :-
    write('You are not in your house, use \'house.\' to enter your house').

exitHouse :-
    isInHouse(true),
    retract(isInHouse(true)),
    asserta(isInHouse(false)), !,
    write('Have a wonderful day!').

exitHouse :-
    write('You are not in your house, use \'house.\' to enter your house').