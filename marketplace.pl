/* File marketplace.pl */
/* Menyimpan aktivitas di market */

:- dynamic(isInMarket/1).

isInMarket(false).

market :-
    map_object(X,Y,'M'),
    map_object(X,Y,'P'),
    retract(isInMarket(false)),
    asserta(isInMarket(true)), !,
    write('What do you want to do?'),nl,
    write('1. Sell'),nl,
    write('2. Buy'),nl.

market :-
    write('You are not at the marketplace, use \'map.\' to see where you are right now').

sell :-
    isInMarket(true), !,
    write('Here are the items in your inventory'),nl,
    write('What do you want to sell?').

sell :-
    write('You are not in the marketplace, use \'market.\' to enter the marketplace').

pay(Cost) :-
    gold(X),
    X-Cost < 0, !,
    write('You don\'t have enough money'),nl,nl,fail.

pay(Cost) :- 
    gold(X),
    NewX is X-Cost,
    retract(gold(X)),
    assertz(gold(NewX)).

buy :-
    isInMarket(true), !,
    write('What do you want to buy?'),nl,
    write('1. Carrot seed (50 golds)'),nl,
    write('2. Corn seed (50 golds)'),nl,
    write('3. Tomato seed (50 golds)'),nl,
    write('4. Potato seed (50 golds)'),nl,
    write('5. Chicken (500 golds)'),nl,
    write('6. Sheep (1000 golds)'),nl,
    write('7. Cow (1500 golds)'),nl,
    write('8. Level 2 shovel (300 golds)'),nl,
    write('9. Level 2 fishing rod (500 golds)'),nl,
    write('> '), read(Item), nl,
    (
        Item = 1,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        Cost is Amount*50,
        pay(Cost),
        addItem(Amount, 'carrot seed'),
        write('You have bought '), write(Amount), write(' carrot seed/s');

        Item = 2,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        Cost is Amount*50,
        pay(Cost),
        addItem(Amount, 'corn seed'),
        write('You have bought '), write(Amount), write(' corn seed/s');

        Item = 3,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        Cost is Amount*50,
        pay(Cost),
        addItem(Amount, 'tomato seed'),
        write('You have bought '), write(Amount), write(' tomato seed/s');

        Item = 4,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        Cost is Amount*50,
        pay(Cost),
        addItem(Amount, 'potato seed'),
        write('You have bought '), write(Amount), write(' potato seed/s');

        Item = 5,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        Cost is Amount*500,
        pay(Cost),
        addItem(Amount, 'chicken'),
        write('You have bought '), write(Amount), write(' chicken/s');

        Item = 6,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        Cost is Amount*1000,
        pay(Cost),
        addItem(Amount, 'sheep'),
        write('You have bought '), write(Amount), write(' sheep/s');

        Item = 7,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        Cost is Amount*1500,
        pay(Cost),
        addItem(Amount, 'cow'),
        write('You have bought '), write(Amount), write(' cow/s');

        Item = 8,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        Cost is Amount*300,
        pay(Cost),
        addItem(Amount, 'shovel'),
        write('You have bought '), write(Amount), write(' shovel/s');

        Item = 9,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        Cost is Amount*500,
        pay(Cost),
        addItem(Amount, 'fishing rod'),
        write('You have bought '), write(Amount), write(' fishing rod/s')
    ).

buy :-
    write('You are not in the marketplace, use \'market.\' to enter the marketplace').

exitShop :-
    isInMarket(true),
    retract(isInMarket(true)),
    asserta(isInMarket(false)), !,
    write('Thanks for coming'),nl.

exitShop :-
    write('You are not in the marketplace, use \'market.\' to enter the marketplace').