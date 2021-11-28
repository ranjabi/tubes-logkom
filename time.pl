/* File time.pl */
/* Menyimpan sistem waktu */

:- dynamic(time/2). % (hour, minute)
:- dynamic(date/2). % (day, month)
:- dynamic(day/1).

month(0, 'January', 'Winter').
month(1, 'February', 'Winter').
month(2, 'March', 'Spring').
month(3, 'April', 'Spring').
month(4, 'May', 'Spring').
month(5, 'June', 'Summer').
month(6, 'July', 'Summer').
month(7, 'August', 'Summer').
month(8, 'September', 'Fall').
month(9, 'October', 'Fall').
month(10, 'November', 'Fall').
month(11, 'December', 'Winter').

incrementTime :-
    time(Hour, Minute),
    date(Day, Month),
    day(Days),
    retract(time(Hour, Minute)),
    retract(date(Day, Month)),
    retract(day(Days)),
    NewMinute is Minute + 1,
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
        NewDay is Day + 1,
        NewDays is Days + 1;

        % else
        NewDay is Day,
        NewDays is Days,
        FinalHour is NewHour
    ),
    (
        NewDay =:= 31 ->
        FinalDay is 1,
        FinalMonth is mod(Month + 1, 12);

        % else
        FinalMonth is Month,
        FinalDay is NewDay
    ),
    assertz(time(FinalHour, FinalMinute)),
    assertz(date(FinalDay, FinalMonth)),
    assertz(day(NewDays)).

incrementNTime(0).
incrementNTime(N) :-
    N > 0,
    incrementTime,
    N1 is N - 1,
    incrementNTime(N1), !.

showTime :-
    time(Hour, Minute),
    month(Month, MonthName, Season),
    date(Day, Month),
    day(DayC),
    write('Day '), write(DayC), write(', '), write(Season), write('.'), nl,
    write(Day), write(' '), write(MonthName), write('. '),
    write(Hour), write(':'), write(Minute), write('.'), !, nl.

nextDay :-
    date(Day, Month),
    day(Days),
    (
        Day =:= 31,
        Day1 is 1,
        Month1 is mod(Month + 1, 12),
        NewDays is Days + 1,
        assertz(date(Day1,Month1)),
        retract(date(Day,Month)),
        assertz(day(NewDays)),
        retract(day(Days));

        Day < 31,
        Day1 is Day + 1,
        Month1 is Month,
        NewDays is Days + 1,
        assertz(date(Day1,Month1)),
        retract(date(Day,Month)),
        assertz(day(NewDays)),
        retract(day(Days))
    ),
    retract(time(_,_)),
    assertz(time(08,00)).