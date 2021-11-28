/* File stamina.pl */
/* Menyimpan sistem stamina player */

:- dynamic(stamina/1).
:- dynamic(isNotifyStamina/3). % (notif50, notif25, notif10), in 0 or 1

incStamina(Inc) :-
    stamina(Stamina),
    retract(stamina(Stamina)),
    NewStamina is Stamina + Inc,
    (
        NewStamina > 100 ->
        FinalStamina is 100;

        % else
        FinalStamina is NewStamina
    ),
    assertz(stamina(FinalStamina)).

decStamina(Dec) :-
    stamina(Stamina),
    retract(stamina(Stamina)),
    NewStamina is Stamina - Dec,
    (
        NewStamina < 0 ->
        FinalStamina is 0;

        % else
        FinalStamina is NewStamina
    ),
    assertz(stamina(FinalStamina)).

decGold(Dec) :-
    gold(Gold),
    retract(gold(Gold)),
    NewGold is Gold - Dec,
    /*
    (
        NewGold < 0 ->
        FinalGold is 0;

        % else
        FinalGold is NewGold
    ),
    */
    assertz(gold(NewGold)).

skipSickTime :-
    time(Hour, Minute),
    date(Day, Month),
    retract(date(Day, Month)),
    NewDay is Day + 5,
    ( 
        NewDay > 30 ->
        FinalDay is NewDay - 30,
        FinalMonth is Month + 1;

        % else
        FinalDay is NewDay,
        FinalMonth is Month
    ),
    assertz(date(FinalDay, FinalMonth)),
    month(FinalMonth, MonthName),
    write(FinalDay), write(' '), write(MonthName), write('. '),
    write(Hour), write(':'), write(Minute), write('.'), nl.

updateStamina :-
    stamina(Stamina),
    isNotifyStamina(Notif50, Notif25, Notif10),
    retract(isNotifyStamina(Notif50, Notif25, Notif10)),
    (
        Stamina > 40,
        Stamina =< 50,
        Notif50 =:= 0 ->
        nl, write('Kerja boleh, tapi jangan lupa istirahat ya, sayang.'), nl,
        write('Stamina kamu kurang dari 50%.'), nl,
        assertz(isNotifyStamina(1, Notif25, Notif10));

        Stamina > 15,
        Stamina =< 25,
        Notif25 =:= 0 ->
        nl, write('Buat apa banyak duit tapi sering sakit, mas.'), nl,
        write('Stamina kamu kurang dari 25%.'), nl,
        assertz(isNotifyStamina(Notif50, 1, Notif10));

        Stamina > 0,
        Stamina =< 10,
        Notif10 =:= 0 ->
        nl, write('Letakkan cangkulmu, tidurlah bersamaku.'), nl,
        write('Stamina kamu kurang dari 10%.'), nl,
        assertz(isNotifyStamina(Notif50, Notif25, 1));

        Stamina =:= 0 ->
        nl, write('Nah, tepar kan lo.'), nl,
        write('Stamina kamu 0%.'), nl, nl,
        write('Waktu telah 5 hari berlalu...'), nl,
        nl, skipSickTime, nl,
        decGold(10000),
        incStamina(100),
        write('Gold berkurang 10000 untuk pengobatan.'), nl,
        write('Stamina kamu sekarang kembali 100%.'), nl,
        assertz(isNotifyStamina(0, 0, 0));

        % else
        write(''),
        assertz(isNotifyStamina(Notif50, Notif25, Notif10))
    ).

rechargeStamina :-
    retract(stamina(_)),
    assertz(stamina(100)).