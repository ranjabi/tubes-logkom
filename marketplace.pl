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
    playerInventory(ListInventory),
    gold(X),
    write('Here are the items in your inventory'),nl,
    writeInventory(ListInventory),
    write('What do you want to sell?'),nl,
    write('> '),read(Item),nl,
    searchItem(Item, ListInventory, Found),
    (
        Found = false, !, write('Item not found'),fail;

        Found = true,
        write('How many item do you want to sell ?'),nl,
        write('> '),read(Amount),nl,
        countItem(Item, ListInventory, Count),
        (
            Count < Amount,!,write('Cannot find enough item'),fail;

            Item = 'carrot',
            Total is 15 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX);

            Item = 'tomato',
            Total is 20 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX);

            Item = 'corn',
            Total is 20 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX);

            Item = 'potato',
            Total is 15 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX);

            Item = 'egg',
            Total is 50 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX);

            Item = 'wool',
            Total is 100 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX);

            Item = 'milk',
            Total is 150 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX);

            Item = 'Tuna',
            Total is 100 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX);

            Item = 'Salmon',
            Total is 200 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX);

            Item = 'Piranha',
            Total is 300 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX);

            Item = 'Arwana',
            Total is 400 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX);

            Item = 'Mujair',
            Total is 500 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX);

            Item = 'Green Arwana',
            Total is 600 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX);

            Item = 'Dorado',
            Total is 700 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX);

            Item = 'Hiu',
            Total is 800 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX);

            Item = 'Goldfish',
            Total is 900 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX)
        )
    ).


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
    write('10. Level 2 hencoop (400 golds)'),nl,    
    write('11. Level 2 shear (300 golds)'),nl,
    write('12. Level 2 bucket (200 golds)'),nl,
    write('> '), read(Item), nl,
    (
        Item = 1,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        Cost is Amount*50,
        pay(Cost),
        addItem(Amount, 'carrot seed'),
        write('You have bought '), write(Amount), write(' carrot seed(s)');

        Item = 2,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        Cost is Amount*50,
        pay(Cost),
        addItem(Amount, 'corn seed'),
        write('You have bought '), write(Amount), write(' corn seed(s)');

        Item = 3,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        Cost is Amount*50,
        pay(Cost),
        addItem(Amount, 'tomato seed'),
        write('You have bought '), write(Amount), write(' tomato seed(s)');

        Item = 4,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        Cost is Amount*50,
        pay(Cost),
        addItem(Amount, 'potato seed'),
        write('You have bought '), write(Amount), write(' potato seed(s)');

        Item = 5,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        Cost is Amount*500,
        pay(Cost),
        addItem(Amount, 'chicken'),
        write('You have bought '), write(Amount), write(' chicken(s)');

        Item = 6,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        Cost is Amount*1000,
        pay(Cost),
        addItem(Amount, 'sheep'),
        write('You have bought '), write(Amount), write(' sheep(s)');

        Item = 7,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        Cost is Amount*1500,
        pay(Cost),
        addItem(Amount, 'cow'),
        write('You have bought '), write(Amount), write(' cow(s)');

        Item = 8,
        pay(300),
        retract(level_shovel(_)),
        assertz(level_shovel(2)),
        write('You have bought a Level 2 shovel');

        Item = 9,
        pay(500),
        retract(level_fishing_rod(_)),
        assertz(level_fishing_rod(2)),
        write('You have bought a Level 2 fishing rod');

        Item = 10,
        pay(400),
        retract(level_hencoop(_)),
        assertz(level_hencoop(2)),
        write('You have bought a Level 2 hencoop');

        Item = 11,
        pay(300),
        retract(level_shear(_)),
        assertz(level_shear(2)),
        write('You have bought a Level 2 shear');

        Item = 12,
        pay(200),
        retract(level_bucket(_)),
        assertz(level_bucket(2)),
        write('You have bought a Level 2 bucket')
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