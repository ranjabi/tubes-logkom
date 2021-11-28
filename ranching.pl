/* File ranching.pl */
/* Menyimpan mekanisme ranching */

:- dynamic(isInRanch/1).

:- dynamic(isChickenSick/1).
:- dynamic(isSheepSick/1).
:- dynamic(isCowSick/1).

:- dynamic(waitTimeChicken/5). % (WaitTime, Hour, Minute, Day, Month)
:- dynamic(waitTimeSheep/5). % (WaitTime, Hour, Minute, Day, Month)
:- dynamic(waitTimeCow/5). % (WaitTime, Hour, Minute, Day, Month)

:- dynamic(level_hencoop/1).
:- dynamic(level_shear/1).
:- dynamic(level_bucket/1).

isInRanch(false).

/* Daftar waktu 'panen' berdasarkan level */
delayTime(0, 110). % 7210
delayTime(1, 50). % 2890
delayTime(2, 40). % 2170
delayTime(3, 30). % 1450
delayTime(4, 20). % 730

/* Daftar hewan ternak dan harga jual */
cattle('Chicken').
cattle('Sheep').
cattle('Cow').

/* Daftar hasil ternak dan harga jual */
yield('Egg', 50).
yield('Wool', 100).
yield('Milk', 150).

/* Daftar fakta initial */
isChickenSick(false).
isSheepSick(false).
isCowSick(false).

waitTimeChicken(0, 0, 0, 0, 0).
waitTimeSheep(0, 0, 0, 0, 0).
waitTimeCow(0, 0, 0, 0, 0).

initRanch :-
    /* for testing purposes */
    addItem(5, 'Chicken'),
    addItem(5, 'Sheep'),
    addItem(5, 'Cow').

ranch :-
    map_object(X, Y, 'P'),
    map_object(X, Y, 'R'),
    retract(isInRanch(false)),
    assertz(isInRanch(true)), !,
    write('Welcome to the ranch!'), nl,
    playerInventory(ListInventory),
    countItem('Chicken', ListInventory, I),
    countItem('Sheep', ListInventory, J),
    countItem('Cow', ListInventory, K),
    M is I + J + K,
    (
        M =:= 0, write('You don\'t have any cattle.');

        M > 0,
        write('You have:'), nl,
        write(I), write(' Chicken'), nl,
        write(J), write(' Sheep'), nl,
        write(K), write(' Cow'), nl,
        write('What do you want to do?')
    ),
    !.

ranch :-
    write('You\'re not in ranch.').

chicken :-
    /* no chicken */
    isInRanch,
    playerInventory(ListInventory),
    countItem('Chicken', ListInventory, I),
    I =:= 0,
    write('You don\'t have any Chicken.'),
    !.

chicken :-
    /* sick or not sick, waitTime = 0 */
    isInRanch,
    time(HourT, MinuteT),
    date(DayT, MonthT),
    waitTimeChicken(Time, HourC, MinuteC, DayC, MonthC),
    TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
    TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
    (TimeT-TimeC) >= Time,
    nl, incrementTime, decStamina(10), updateStamina, nl,
    playerInventory(ListInventory),
    countItem('Chicken', ListInventory, I),
    write('Your chicken lays '), write(I), write(' eggs.'), nl,
    write('You got '), write(I), write(' eggs'), nl,
    addItem(I, 'Egg'),
    RanchingExp is I*1,
    exp_ranching(CurrentExp),
    NewExp is CurrentExp + RanchingExp,
    retract(exp_ranching(_)),
    asserta(exp_ranching(NewExp)),
    write('You gained '), write(RanchingExp), write(' ranching exp!'), !, nl,
    level_ranching(CurrentLevel), % prosedur naik level
    random(17, 21, SickFactor),
    !,
    (
        SickFactor =:= 20 ->
        (
            isChickenSick(false) ->
            retract(isChickenSick(false)),
            asserta(isChickenSick(true));

            write('') % prevent invalid
        ),
        delayTime(0, TimeDelay),
        retract(waitTimeChicken(Time, HourC, MinuteC, DayC, MonthC)),
        asserta(waitTimeChicken(TimeDelay, HourT, MinuteT, DayT, MonthT));
        
        % else
        (
            isChickenSick(true) ->
            retract(isChickenSick(true)),
            asserta(isChickenSick(false));

            write('') % prevent invalid
        ),
        delayTime(CurrentLevel, TimeDelay),
        retract(waitTimeChicken(Time, HourC, MinuteC, DayC, MonthC)),
        asserta(waitTimeChicken(TimeDelay, HourT, MinuteT, DayT, MonthT))
    ),
    !.

chicken :-
    /* sick, waitTime != 0 */
    isInRanch,
    isChickenSick(true),
    time(HourT, MinuteT),
    date(DayT, MonthT),
    waitTimeChicken(Time, HourC, MinuteC, DayC, MonthC),
    TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
    TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
    (TimeT-TimeC) < Time,
    TimeLeft is (Time) - (TimeT - TimeC),
    write('Your chicken is sick for another '), write(TimeLeft), write(' minutes.'), nl,
    write('Please check again later.'),
    !.

chicken :-
    /* not sick, waitTime != 0 */
    isInRanch,
    isChickenSick(false),
    time(HourT, MinuteT),
    date(DayT, MonthT),
    waitTimeChicken(Time, HourC, MinuteC, DayC, MonthC),
    TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
    TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
    (TimeT-TimeC) < Time,
    TimeLeft is (Time) - (TimeT - TimeC),
    write('Your chicken won\'t produce any egg for another '), write(TimeLeft), write(' minutes.'), nl,
    write('Please check again later.'),
    !.

chicken :-
    /* not in ranch */
    write('You\'re not in ranch.').

sheep :-
    /* no sheep */
    isInRanch,
    playerInventory(ListInventory),
    countItem('Sheep', ListInventory, I),
    I =:= 0,
    write('You don\'t have any Sheep.'),
    !.

sheep :-
    /* sick or not sick, waitTime = 0 */
    isInRanch,
    time(HourT, MinuteT),
    date(DayT, MonthT),
    waitTimeSheep(Time, HourC, MinuteC, DayC, MonthC),
    TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
    TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
    (TimeT-TimeC) >= Time,
    nl, incrementTime, decStamina(10), updateStamina, nl,
    playerInventory(ListInventory),
    countItem('Sheep', ListInventory, I),
    write('Your sheep produces '), write(I), write(' wool.'), nl,
    write('You got '), write(I), write(' wool'), nl,
    addItem(I, 'Wool'),
    RanchingExp is I*1,
    exp_ranching(CurrentExp),
    NewExp is CurrentExp + RanchingExp,
    retract(exp_ranching(_)),
    asserta(exp_ranching(NewExp)),
    write('You gained '), write(RanchingExp), write(' ranching exp!'), !, nl,
    level_ranching(CurrentLevel), % prosedur naik level
    random(17, 21, SickFactor),
    !,
    (
        SickFactor =:= 20 ->
        (
            isSheepSick(false) ->
            retract(isSheepSick(false)),
            asserta(isSheepSick(true));

            write('') % prevent invalid
        ),
        delayTime(0, TimeDelay),
        retract(waitTimeSheep(Time, HourC, MinuteC, DayC, MonthC)),
        asserta(waitTimeSheep(TimeDelay, HourT, MinuteT, DayT, MonthT));
        
        % else
        (
            isSheepSick(true) ->
            retract(isSheepSick(true)),
            asserta(isSheepSick(false));

            write('') % prevent invalid
        ),
        delayTime(CurrentLevel, TimeDelay),
        retract(waitTimeSheep(Time, HourC, MinuteC, DayC, MonthC)),
        asserta(waitTimeSheep(TimeDelay, HourT, MinuteT, DayT, MonthT))
    ),
    !.

sheep :-
    /* sick, waitTime != 0 */
    isInRanch,
    isSheepSick(true),
    time(HourT, MinuteT),
    date(DayT, MonthT),
    waitTimeSheep(Time, HourC, MinuteC, DayC, MonthC),
    TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
    TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
    (TimeT-TimeC) < Time,
    TimeLeft is (Time) - (TimeT - TimeC),
    write('Your sheep is sick for another '), write(TimeLeft), write(' minutes.'), nl,
    write('Please check again later.'),
    !.

sheep :-
    /* not sick, waitTime != 0 */
    isInRanch,
    isSheepSick(false),
    time(HourT, MinuteT),
    date(DayT, MonthT),
    waitTimeSheep(Time, HourC, MinuteC, DayC, MonthC),
    TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
    TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
    (TimeT-TimeC) < Time,
    TimeLeft is (Time) - (TimeT - TimeC),
    write('Your sheep won\'t produce any wool for another '), write(TimeLeft), write(' minutes.'), nl,
    write('Please check again later.'),
    !.

sheep :-
    /* not in ranch */
    write('You\'re not in ranch.').


cow :-
    /* no cow */
    isInRanch,
    playerInventory(ListInventory),
    countItem('Cow', ListInventory, I),
    I =:= 0,
    write('You don\'t have any Cow.'),
    !.

cow :-
    /* sick or not sick, waitTime = 0 */
    isInRanch,
    time(HourT, MinuteT),
    date(DayT, MonthT),
    waitTimeCow(Time, HourC, MinuteC, DayC, MonthC),
    TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
    TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
    (TimeT-TimeC) >= Time,
    nl, incrementTime, decStamina(10), updateStamina, nl,
    playerInventory(ListInventory),
    countItem('Cow', ListInventory, I),
    write('Your cow produces '), write(I), write(' milk.'), nl,
    write('You got '), write(I), write(' milk'), nl,
    addItem(I, 'Milk'),
    RanchingExp is I*1,
    exp_ranching(CurrentExp),
    NewExp is CurrentExp + RanchingExp,
    retract(exp_ranching(_)),
    asserta(exp_ranching(NewExp)),
    write('You gained '), write(RanchingExp), write(' ranching exp!'), !, nl,
    level_ranching(CurrentLevel), % prosedur naik level
    random(17, 21, SickFactor),
    !,
    (
        SickFactor =:= 20 ->
        (
            isCowSick(false) ->
            retract(isCowSick(false)),
            asserta(isCowSick(true));

            write('') % prevent invalid
        ),
        delayTime(0, TimeDelay),
        retract(waitTimeCow(Time, HourC, MinuteC, DayC, MonthC)),
        asserta(waitTimeCow(TimeDelay, HourT, MinuteT, DayT, MonthT));
        
        % else
        (
            isCowSick(true) ->
            retract(isCowSick(true)),
            asserta(isCowSick(false));

            write('') % prevent invalid
        ),
        delayTime(CurrentLevel, TimeDelay),
        retract(waitTimeCow(Time, HourC, MinuteC, DayC, MonthC)),
        asserta(waitTimeCow(TimeDelay, HourT, MinuteT, DayT, MonthT))
    ),
    !.

cow :-
    /* sick, waitTime != 0 */
    isInRanch,
    isCowSick(true),
    time(HourT, MinuteT),
    date(DayT, MonthT),
    waitTimeCow(Time, HourC, MinuteC, DayC, MonthC),
    TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
    TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
    (TimeT-TimeC) < Time,
    TimeLeft is (Time) - (TimeT - TimeC),
    write('Your cow is sick for another '), write(TimeLeft), write(' minutes.'), nl,
    write('Please check again later.'),
    !.

cow :-
    /* not sick, waitTime != 0 */
    isInRanch,
    isCowSick(false),
    time(HourT, MinuteT),
    date(DayT, MonthT),
    waitTimeCow(Time, HourC, MinuteC, DayC, MonthC),
    TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
    TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
    (TimeT-TimeC) < Time,
    TimeLeft is (Time) - (TimeT - TimeC),
    write('Your cow won\'t produce any milk for another '), write(TimeLeft), write(' minutes.'), nl,
    write('Please check again later.'),
    !.

cow :-
    /* not in ranch */
    write('You\'re not in ranch.').

skipTime :-
    /* for testing purposes */
    retract(waitTimeChicken(_)),
    asserta(waitTimeChicken(0)).

addTime :-
    /* for testing purposes */
    retract(waitTimeChicken(0)),
    asserta(waitTimeChicken(1)).

exitRanch :-
    isInRanch(true),
    retract(isInRanch(true)),
    asserta(isInRanch(false)), !,
    write('Thanks for coming!').

exitRanch :-
    write('You are not in the ranch, use \'ranch.\' to enter the ranch').