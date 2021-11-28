/* File ranching.pl */
/* Menyimpan mekanisme tambahan (just for fun :D) */

/* Gambling */
:- dynamic(isAroundMarket/1).
isAroundMarket(false).

isAroundGamble :- 
    map_object(X,Y,'P'), 
    PrevX is X-1,
    NextX is X+1,
    PrevY is Y-1,
    NextY is Y+1,
    (
        map_object(PrevX,PrevY,'M') ->
        retract(isAroundMarket(_)),
        asserta(isAroundMarket(true));        
        
        map_object(X,PrevY,'M') ->
        retract(isAroundMarket(_)),
        asserta(isAroundMarket(true));

        map_object(NextX,PrevY,'M') ->
        retract(isAroundMarket(_)),
        asserta(isAroundMarket(true));

        map_object(PrevX,Y,'M') ->
        retract(isAroundMarket(_)),
        asserta(isAroundMarket(true));

        map_object(NextX,Y,'M') ->
        retract(isAroundMarket(_)),
        asserta(isAroundMarket(true));

        map_object(PrevX,NextY,'M') ->
        retract(isAroundMarket(_)),
        asserta(isAroundMarket(true));

        map_object(X,NextY,'M') ->
        retract(isAroundMarket(_)),
        asserta(isAroundMarket(true));

        map_object(NextX,NextY,'M') ->
        retract(isAroundMarket(_)),
        asserta(isAroundMarket(true));

        % else
        retract(isAroundMarket(_)),
        asserta(isAroundMarket(false))
    ).

gambling :-
    isAroundGamble,
    isAroundMarket(true),
    write('Welcome to Side Hustle Gambling!'), nl, nl,
    write('1. guess.'), nl,
    write('   Rules:'), nl,
    write('   - Guess a number between 1-100.'), nl,
    write('   - You have 3 chances and 2 hint.'), nl,
    write('   Cost: 10 Gold'), nl,
    write('   Grand Prize: 1000 Gold.'), nl, nl,
    write('2. slot.'), nl,
    write('   Rules:'), nl,
    write('   - "Spin" the wheel.'), nl,
    write('   - Win if it lands on 2-1-2-1.'), nl,
    write('   Cost: 10 Gold'), nl,
    write('   Grand Prize: 2000 Gold.'), nl, nl,
    write('Which game do you want to play?'), !.

gambling :-
    write('You are not in the secret gambling area.').

checkNumber(X, LuckyNumber) :-
    (
        X > LuckyNumber ->
        write('Your guess is too big.'), nl, nl;
        
        % else
        write('Your guess is too small.'), nl, nl
    ).

guess :-
    isAroundGamble,
    isAroundMarket(true),
    write('Welcome to guess Game!'), nl,
    decGold(10),
    write('You are charged 10 Gold.'), nl,
    write('Good luck!'), nl, nl,
    write('We have picked a number between 1-100. Guess it!'), nl, nl,
    random(1, 51, LuckyNumber),
    write('Your guess: '),
    read(X),
    (
        X =:= LuckyNumber ->
        nl, write('Congratulations! You have guessed the correct number.'), nl,
        addGold(1000),
        write('You are given 1000 Gold.'), nl, 
        write('Thank you for playing!'), nl, nl,
        write('Do you want to play again?'), nl, !;

        % else
        nl, write('You have not guessed the correct number.'), nl,
        checkNumber(X, LuckyNumber),
        write('Your guess: '),
        read(Y),
        (
            Y =:= LuckyNumber ->
            nl, write('Congratulations! You have guessed the correct number.'), nl,
            addGold(1000),
            write('You are given 1000 Gold.'), nl,
            write('Thank you for playing!'), nl, nl,
            write('Do you want to play again?'), nl, !;

            % else
            nl, write('You have not guessed the correct number.'), nl,
            checkNumber(Y, LuckyNumber),
            write('Your guess: '),
            read(Z),
            (
                Z =:= LuckyNumber ->
                nl, write('Congratulations! You have guessed the correct number.'), nl,
                addGold(1000),
                write('You are given 1000 Gold.'), nl, nl;

                % else
                nl, write('You have not guessed the correct number.'), nl, 
                write('The correct number is '), write(LuckyNumber), write('!'), nl, nl
            ),
            write('Thank you for playing!'), nl, nl,
            write('Do you want to play again?'), nl
        )
    ).

guess :-
    write('You are not in the secret gambling area.').

printNSlot(_V, _W, _X, _Y, _Z, 0).
printNSlot(V, W, X, Y, Z, A) :-
    A > 0,
    printSlot(V, W, X, Y, Z), sleep(0.4), cls,
    A1 is A - 1,
    printNSlot(V, W, X, Y, Z, A1).

printSlot(V, W, X, Y, _Z) :-
    (
        % slot 1
        V =:= 1 ->
        write('Slot '), write(V), write(': '), random(1, 4, SlotAnim), write(SlotAnim), nl,
        write('Slot 2: '), nl,
        write('Slot 3: '), nl,
        write('Slot 4: '), nl;

        % slot 2
        V =:= 2 ->
        write('Slot 1: '), write(W), nl,
        write('Slot '), write(V), write(': '), random(1, 4, SlotAnim), write(SlotAnim), nl,
        write('Slot 3: '), nl,
        write('Slot 4: '), nl;

        % slot 3
        V =:= 3 ->
        write('Slot 1: '), write(W), nl,
        write('Slot 2: '), write(X), nl,
        write('Slot '), write(V), write(': '), random(1, 4, SlotAnim), write(SlotAnim), nl,
        write('Slot 4: '), nl;

        % slot 4
        V =:= 4 ->
        write('Slot 1: '), write(W), nl,
        write('Slot 2: '), write(X), nl,
        write('Slot 3: '), write(Y), nl,
        write('Slot '), write(V), write(': '), random(1, 4, SlotAnim), write(SlotAnim), nl
    ).

printFinalSlot(V, W, X, Y, Z) :-
    (
        % slot 1
        V =:= 1 ->
        write('Slot 1: '), write(W), nl,
        write('Slot 2: '), nl,
        write('Slot 3: '), nl,
        write('Slot 4: '), nl;

        % slot 2
        V =:= 2 ->
        write('Slot 1: '), write(W), nl,
        write('Slot 2: '), write(X), nl,
        write('Slot 3: '), nl,
        write('Slot 4: '), nl;

        % slot 3
        V =:= 3 ->
        write('Slot 1: '), write(W), nl,
        write('Slot 2: '), write(X), nl,
        write('Slot 3: '), write(Y), nl,
        write('Slot 4: '), nl;

        % slot 4
        V =:= 4 ->
        write('Slot 1: '), write(W), nl,
        write('Slot 2: '), write(X), nl,
        write('Slot 3: '), write(Y), nl,
        write('Slot 4: '), write(Z), nl
    ).


slot :-
    isAroundGamble,
    isAroundMarket(true),
    write('Welcome to slot Game!'), nl, 
    decGold(10),
    write('You are charged 10 Gold.'), nl,
    write('Good luck!'), nl, nl,
    write('Your strength (1-5): '), read(Strength), nl,
    write('We are going to spin the wheel.'), nl, nl, cls,
    random(1, 4, Slot1), printNSlot(1, Slot1, 0, 0, 0, Strength), sleep(0.4), cls, printFinalSlot(1, Slot1, 0, 0, 0), sleep(0.4), cls,
    random(1, 4, Slot2), printNSlot(2, Slot1, Slot2, 0, 0, Strength), sleep(0.4), cls, printFinalSlot(2, Slot1, Slot2, 0, 0), sleep(0.4), cls,
    random(1, 4, Slot3), printNSlot(3, Slot1, Slot2, Slot3, 0, Strength), sleep(0.4), cls, printFinalSlot(3, Slot1, Slot2, Slot3, 0), sleep(0.4), cls,
    random(1, 4, Slot4), printNSlot(4, Slot1, Slot2, Slot3, Slot4, Strength), sleep(0.4), cls, printFinalSlot(4, Slot1, Slot2, Slot3, Slot4), sleep(0.4), cls,
    write('Welcome to slot Game!'), nl, 
    write('You are charged 10 Gold.'), nl,
    write('Good luck!'), nl, nl,
    write('We are going to spin the wheel.'),
    printFinalSlot(4, Slot1, Slot2, Slot3, Slot4),
    write('Final slot: '), write(Slot1), write('-'), write(Slot2), write('-'), write(Slot3), write('-'), write(Slot4), nl,
    (
        Slot1 =:= 2, Slot2 =:= 1, Slot3 =:= 2, Slot4 =:= 1 ->
        nl, write('Congratulations! You landed at Lucky 2-1-2-1.'), nl,
        addGold(2000), write('You are given 2000 Gold.'), !, nl;

        % else
        nl, write('You did not land at Lucky 2121.'), !, nl
    ),
    write('Thank you for playing!'), nl,
    write('Do you want to play again?'), nl.

slot :-
    write('You are not in the secret gambling area.').

/* Clear Screen */
cls :- 
    write('\33\[2J').