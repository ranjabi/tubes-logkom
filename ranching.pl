/* File ranching.pl */
/* Menyimpan mekanisme ranching */

:- dynamic(isInRanch/1).

:- dynamic(isChickenSick/1).
:- dynamic(isSheepSick/1).
:- dynamic(isCowSick/1).

:- dynamic(waitTimeChicken/5). % (WaitTime, Hour, Minute, Day, Month)
:- dynamic(waitTimeSheep/5). % (WaitTime, Hour, Minute, Day, Month)
:- dynamic(waitTimeCow/5). % (WaitTime, Hour, Minute, Day, Month)

:- dynamic(boundRanching/1).
:- dynamic(boundHencoop/1).
:- dynamic(boundShear/1).
:- dynamic(boundBucket/1).
boundRanching(100).
boundHencoop(100).
boundShear(100).
boundBucket(100).

isInRanch(false).

/* Daftar waktu 'panen' berdasarkan level */
delayTime(0, 100). % 7210
delayTime(1, 40). % 2890
delayTime(2, 30). % 2170
delayTime(3, 20). % 1450
delayTime(4, 10). % 730

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

showStatusRanching :-
    /* for testing purposes only */
    exp_ranching(ExpRanch), exp_hencoop(ExpHencoop), exp_shear(ExpShear), exp_bucket(ExpBucket),
    boundRanching(BoundRanch), boundHencoop(BoundHencoop), boundShear(BoundShear), boundBucket(BoundBucket),
    level_ranching(LevelRanch), level_hencoop(LevelHencoop), level_shear(LevelShear), level_bucket(LevelBucket),
    write('Exp ranching  : '), write(ExpRanch), write('/'), write(BoundRanch), nl,
    write('Exp hencoop   : '), write(ExpHencoop), write('/'), write(BoundHencoop), nl,
    write('Exp shear     : '), write(ExpShear), write('/'), write(BoundShear), nl,
    write('Exp bucket    : '), write(ExpBucket), write('/'), write(BoundBucket), nl,  
    write('Level ranching: '), write(LevelRanch), nl,
    write('Level hencoop : '), write(LevelHencoop), nl,
    write('Level shear   : '), write(LevelShear), nl,
    write('Level bucket  : '), write(LevelBucket), nl.

levelUpRanching :-
    exp_ranching(CurExpRanch),
    level_ranching(CurLevelRanch),
    boundRanching(CurBound),
    (
        CurExpRanch < CurBound,
        write('');

        CurExpRanch >= CurBound,
        % NewExpRanch is CurExpRanch - CurBound,
        % retract(exp_ranching(CurExpRanch)),
        % assertz(exp_ranching(NewExpRanch)),
        % level_up_ranching,
        NewLevelRanch is CurLevelRanch + 1,
        NewBound is CurBound * 2,
        retract(level_ranching(CurLevelRanch)),
        assertz(level_ranching(NewLevelRanch)),
        retract(boundRanching(CurBound)),
        assertz(boundRanching(NewBound)),
        write('Congratulations! Ranching level has been levelled up from '), write(CurLevelRanch),
        write(' to '), write(NewLevelRanch), write('!'), nl
    ).

levelUpHencoop :-
    exp_hencoop(CurExpHencoop),
    level_hencoop(CurLevelHencoop),
    boundHencoop(CurBound),
    (
        CurExpHencoop < CurBound,
        write('');

        CurExpHencoop >= CurBound,
        % NewExpHencoop is CurExpHencoop - CurBound,
        % retract(exp_hencoopCurExpHencoop)),
        % assertz(exp_hencoop(NewExpHencoop)),
        % level_up_hencoop,
        NewLevelHencoop is CurLevelHencoop + 1,
        NewBound is CurBound * 2,
        retract(level_hencoop(CurLevelHencoop)),
        assertz(level_hencoop(NewLevelHencoop)),
        retract(boundHencoop(CurBound)),
        assertz(boundHencoop(NewBound)),
        write('Congratulations! Hencoop level has been levelled up from '), write(CurLevelHencoop),
        write(' to '), write(NewLevelHencoop), write('!'), nl
    ).

levelUpShear :-
    exp_shear(CurExpShear),
    level_shear(CurLevelShear),
    boundShear(CurBound),
    (
        CurExpShear < CurBound,
        write('');

        CurExpShear >= CurBound,
        % NewExpShear is CurExpShear - CurBound,
        % retract(exp_shear(CurExpShear)),
        % assertz(exp_shear(NewExpShear)),
        % level_up_shear,
        NewLevelShear is CurLevelShear + 1,
        NewBound is CurBound * 2,
        retract(level_shear(CurLevelShear)),
        assertz(level_shear(NewLevelShear)),
        retract(boundShear(CurBound)),
        assertz(boundShear(NewBound)),
        write('Congratulations! Shear level has been levelled up from '), write(CurLevelShear),
        write(' to '), write(NewLevelShear), write('!'), nl
    ).

levelUpBucket :-
    exp_bucket(CurExpBucket),
    level_bucket(CurLevelBucket),
    boundBucket(CurBound),
    (
        CurExpBucket < CurBound,
        write('');

        CurExpBucket >= CurBound,
        NewExpBucket is CurExpBucket - CurBound,
        % retract(exp_bucket(CurExpBucket)),
        % assertz(exp_bucket(NewExpBucket)),
        % level_up_bucket,
        NewLevelBucket is CurLevelBucket + 1,
        NewBound is CurBound * 2,
        retract(level_bucket(CurLevelBucket)),
        assertz(level_bucket(NewLevelBucket)),
        retract(boundBucket(CurBound)),
        assertz(boundBucket(NewBound)),
        write('Congratulations! Bucket level has been levelled up from '), write(CurLevelBucket),
        write(' to '), write(NewLevelBucket), write('!'), nl
    ).

ranch :-
    map_object(X, Y, 'P'),
    map_object(X, Y, 'R'),
    (
        isInRanch(false) ->
        retract(isInRanch(false)),
        assertz(isInRanch(true));

        % else
        write('')
    ),
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
    isInRanch(true),
    playerInventory(ListInventory),
    countItem('Chicken', ListInventory, I),
    I =:= 0,
    write('You don\'t have any Chicken.'),
    !.

chicken :-
    /* sick or not sick, waitTime = 0 */
    isInRanch(true),
    time(HourT, MinuteT),
    date(DayT, MonthT),
    waitTimeChicken(Time, HourC, MinuteC, DayC, MonthC),
    TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
    TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
    (TimeT-TimeC) >= Time,
    incrementNTime(60), decStamina(10), updateStamina,
    time(HourTNew, MinuteTNew), % updatetime
    date(DayTNew, MonthTNew), % updatetime
    playerInventory(ListInventory),
    countItem('Chicken', ListInventory, I),
    write('Your chicken lays '), write(I), write(' eggs.'), nl,
    write('You got '), write(I), write(' eggs'), nl,
    addItem(I, 'Egg'),
    ranchingDone(I),
    RanchingExp is I*1,

    % level up ranching
    exp_ranching(CurrentExp),
    NewExp is CurrentExp + RanchingExp,
    retract(exp_ranching(_)),
    asserta(exp_ranching(NewExp)),

    % level up total
    exp_total(CurExpTotal),
    NewExpTotal is CurExpTotal + RanchingExp,
    retract(exp_total(CurExpTotal)),
    asserta(exp_total(NewExpTotal)),

    % level up Hencoop
    exp_hencoop(CurExpHencoop),
    specialty(Job),
    (
        Job = 'Rancher' ->
        NewExpHencoop is CurExpHencoop + RanchingExp + 3,
        write('Rancher mendapatkan bonus exp!'), nl;

        % else
        NewExpHencoop is CurExpHencoop + RanchingExp,
        write('Bukan rancher!'), nl
    ),
    retract(exp_hencoop(CurExpHencoop)),
    asserta(exp_hencoop(NewExpHencoop)),

    write('You gained '), write(RanchingExp), write(' ranching exp!'), !, nl,

    levelUpRanching,
    levelUpHencoop,
    level_ranching(CurrentLevel),

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
        asserta(waitTimeChicken(TimeDelay, HourTNew, MinuteTNew, DayTNew, MonthTNew));
        
        % else
        (
            isChickenSick(true) ->
            retract(isChickenSick(true)),
            asserta(isChickenSick(false));

            write('') % prevent invalid
        ),
        delayTime(CurrentLevel, TimeDelay),
        retract(waitTimeChicken(Time, HourC, MinuteC, DayC, MonthC)),
        asserta(waitTimeChicken(TimeDelay, HourTNew, MinuteTNew, DayTNew, MonthTNew))
    ),
    !.

chicken :-
    /* sick, waitTime != 0 */
    isInRanch(true),
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
    isInRanch(true),
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
    isInRanch(false),
    write('You\'re not in ranch.').

sheep :-
    /* no sheep */
    isInRanch(true),
    playerInventory(ListInventory),
    countItem('Sheep', ListInventory, I),
    I =:= 0,
    write('You don\'t have any Sheep.'),
    !.

sheep :-
    /* sick or not sick, waitTime = 0 */
    isInRanch(true),
    time(HourT, MinuteT),
    date(DayT, MonthT),
    waitTimeSheep(Time, HourC, MinuteC, DayC, MonthC),
    TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
    TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
    (TimeT-TimeC) >= Time,
    incrementNTime(60), decStamina(10), updateStamina,
    time(HourTNew, MinuteTNew), % updatetime
    date(DayTNew, MonthTNew), % updatetime
    playerInventory(ListInventory),
    countItem('Sheep', ListInventory, I),
    write('Your sheep produces '), write(I), write(' wool.'), nl,
    write('You got '), write(I), write(' wool'), nl,
    addItem(I, 'Wool'),
    ranchingDone(I),
    RanchingExp is I*1,

    % level up ranching
    exp_ranching(CurrentExp),
    NewExp is CurrentExp + RanchingExp,
    retract(exp_ranching(_)),
    asserta(exp_ranching(NewExp)),

    % level up total
    exp_total(CurExpTotal),
    NewExpTotal is CurExpTotal + RanchingExp,
    retract(exp_total(CurExpTotal)),
    asserta(exp_total(NewExpTotal)),

    % level up Shear
    exp_shear(CurExpShear),
    specialty(Job),
    (
        Job = 'Rancher' ->
        NewExpShear is CurExpShear + RanchingExp + 3,
        write('Rancher mendapatkan bonus exp!'), nl;

        % else
        NewExpShear is CurExpShear + RanchingExp,
        write('Bukan rancher!'), nl
    ),
    retract(exp_shear(CurExpShear)),
    asserta(exp_shear(NewExpShear)),

    write('You gained '), write(RanchingExp), write(' ranching exp!'), !, nl,

    levelUpRanching,
    levelUpShear,
    level_ranching(CurrentLevel),

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
        asserta(waitTimeSheep(TimeDelay, HourTNew, MinuteTNew, DayTNew, MonthTNew));
        
        % else
        (
            isSheepSick(true) ->
            retract(isSheepSick(true)),
            asserta(isSheepSick(false));

            write('') % prevent invalid
        ),
        delayTime(CurrentLevel, TimeDelay),
        retract(waitTimeSheep(Time, HourC, MinuteC, DayC, MonthC)),
        asserta(waitTimeSheep(TimeDelay, HourTNew, MinuteTNew, DayTNew, MonthTNew))
    ),
    !.

sheep :-
    /* sick, waitTime != 0 */
    isInRanch(true),
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
    isInRanch(true),
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
    isInRanch(false),
    write('You\'re not in ranch.').


cow :-
    /* no cow */
    isInRanch(true),
    playerInventory(ListInventory),
    countItem('Cow', ListInventory, I),
    I =:= 0,
    write('You don\'t have any Cow.'),
    !.

cow :-
    /* sick or not sick, waitTime = 0 */
    isInRanch(true),
    time(HourT, MinuteT),
    date(DayT, MonthT),
    waitTimeCow(Time, HourC, MinuteC, DayC, MonthC),
    TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
    TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
    (TimeT-TimeC) >= Time,
    incrementNTime(60), decStamina(10), updateStamina,
    time(HourTNew, MinuteTNew), % updatetime
    date(DayTNew, MonthTNew), % updatetime
    playerInventory(ListInventory),
    countItem('Cow', ListInventory, I),
    write('Your cow produces '), write(I), write(' milk.'), nl,
    write('You got '), write(I), write(' milk'), nl,
    addItem(I, 'Milk'),
    ranchingDone(I),
    RanchingExp is I*1,

    % level up ranching
    exp_ranching(CurrentExp),
    NewExp is CurrentExp + RanchingExp,
    retract(exp_ranching(_)),
    asserta(exp_ranching(NewExp)),

    % level up total
    exp_total(CurExpTotal),
    NewExpTotal is CurExpTotal + RanchingExp,
    retract(exp_total(CurExpTotal)),
    asserta(exp_total(NewExpTotal)),

    % level up Bucket
    exp_bucket(CurExpBucket),
    specialty(Job),
    (
        Job = 'Rancher' ->
        NewExpBucket is CurExpBucket + RanchingExp + 3,
        write('Rancher mendapatkan bonus exp!'), nl;

        % else
        NewExpBucket is CurExpBucket + RanchingExp,
        write('Bukan rancher!'), nl
    ),
    retract(exp_bucket(CurExpBucket)),
    asserta(exp_bucket(NewExpBucket)),

    write('You gained '), write(RanchingExp), write(' ranching exp!'), !, nl,

    levelUpRanching,
    levelUpBucket,
    level_ranching(CurrentLevel),

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
        asserta(waitTimeCow(TimeDelay, HourTNew, MinuteTNew, DayTNew, MonthTNew));
        
        % else
        (
            isCowSick(true) ->
            retract(isCowSick(true)),
            asserta(isCowSick(false));

            write('') % prevent invalid
        ),
        delayTime(CurrentLevel, TimeDelay),
        retract(waitTimeCow(Time, HourC, MinuteC, DayC, MonthC)),
        asserta(waitTimeCow(TimeDelay, HourTNew, MinuteTNew, DayTNew, MonthTNew))
    ),
    !.

cow :-
    /* sick, waitTime != 0 */
    isInRanch(true),
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
    isInRanch(true),
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
    isInRanch(false),
    write('You\'re not in ranch.').

ranchingDone(X) :-
    questStatus(Fishing, Farming, Ranching, Status),
    retract(questStatus(Fishing, Farming, Ranching, Status)),
    (
        X >= Ranching,
        NewRanching is 0;

        X < Ranching,
        NewRanching is Ranching - X
    ),
    asserta(questStatus(Fishing, Farming, NewRanching, Status)).

exitRanch :-
    isInRanch(true),
    retract(isInRanch(true)),
    asserta(isInRanch(false)), !,
    write('Thanks for coming!').

exitRanch :-
    write('You are not in the ranch, use \'ranch.\' to enter the ranch').

addExpRanch(X) :-
    exp_ranching(CurExp),
    NewExp is CurExp + X,
    retract(exp_ranching(CurExp)),
    assertz(exp_ranching(NewExp)),
    levelUpRanching.