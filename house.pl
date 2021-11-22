/* File house.pl */
/* Menyimpan aktivitas di house */
:- [dynamic].

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
    write('You went to sleep').

sleep :-
    write('You are not in your house, use \'house.\' to enter your house').

exit :-
    isInHouse(true),
    retract(isInHouse(true)),
    asserta(isInHouse(false)), !,
    write('Have a wonderful day!').

exit :-
    write('You are not in your house, use \'house.\' to enter your house').