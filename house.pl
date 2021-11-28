/* File house.pl */
/* Menyimpan aktivitas di house */

:- dynamic(isInHouse/1).
:- dynamic(playerDiary/1).
:- dynamic(diary/2).

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
    write('4. exitHouse'),nl.

house :-
    write('You are not at your house, use \'map.\' to see where you are right now').

/* Perintah sleep, bangun esok hari pukul 08:00 dan recharge stamina */
sleep :-
    isInHouse(true), !,
    write('You went to sleep...'),nl,nl,
    nextDay,
    rechargeStamina,
    day(Days),
    date(Day, Month),
    month(Month, MonthName, Season),
    write('Day '), write(Days), write(', '), write(Season), write('.'), nl,
    write(Day), write(' '), write(MonthName), write('. '),
    write('8:00.'), nl.

sleep :-
    write('You are not in your house, use \'house.\' to enter your house').

/* Menambah day ke list diary */
addDiary(X, [], [X]) :- !.

addDiary(X, [H|T], [H|L]) :- addDiary(X,T,L).

/* Menuliskan list day yang memiliki diary */
printDiary([]) :- !.

printDiary([Head|Tail]) :-
    write('- Day '), write(Head), nl,
    printDiary(Tail).

/* Mengecek keberadaan day */
searchDiary(X, [X|_], true) :- !.

searchDiary(_, [], false) :- !.

searchDiary(X, [Head|Tail], Found) :-
    searchDiary(X, Tail, Found).

/* Perintah writeDiary */
writeDiary :-
    day(Days),
    playerDiary(ListDiary),
    searchDiary(Days, ListDiary, Found),
    (
        Found = true,
        !, write('You have wrote a diary today'), fail;

        Found = false,
        write('Write your diary for Day '), write(Days), nl,
        write('> '), read(Diary),
        addDiary(Days, ListDiary, NewList),
        retract(playerDiary(ListDiary)),
        assertz(playerDiary(NewList)),
        assertz(diary(Days,Diary))
    ).

/* Perintah readDiary */
readDiary :-
    write('Here are the list of your entries:'), nl,
    playerDiary(ListDiary),
    printDiary(ListDiary), nl,
    write('Which entry do you want to read?'), nl,
    write('> '), read(Days), nl,
    playerDiary(ListDiary),
    searchDiary(Days, ListDiary, Found),
    (
        Found = false,
        !, write('Diary not available'), fail;

        Found = true,
        diary(Days, Diary),
        write('Here is your entry for Day '), write(Days), write(':'), nl,
        write(Diary)
    ).

/* Perintah exitHouse */
exitHouse :-
    isInHouse(true),
    retract(isInHouse(true)),
    asserta(isInHouse(false)), !,
    write('Have a wonderful day!').

exitHouse :-
    write('You are not in your house, use \'house.\' to enter your house').