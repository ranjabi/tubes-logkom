/* File time.pl */
/* Menyimpan sistem waktu */

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