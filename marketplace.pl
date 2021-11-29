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

            Item = 'Carrot',
            Total is 25 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX),isGoal;

            Item = 'Tomato',
            Total is 30 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX),isGoal;

            Item = 'Corn',
            Total is 25 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX),isGoal;

            Item = 'Potato',
            Total is 20 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX),isGoal;

            Item = 'Egg',
            Total is 50 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX),isGoal;

            Item = 'Wool',
            Total is 100 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX),isGoal;

            Item = 'Milk',
            Total is 150 * Amount,
            NewX is X + Total,
            retract(gold(X)),
            assertz(gold(NewX)),
            deleteItem(Item,Amount,ListInventory,NewList),
            retract(playerInventory(ListInventory)),
            assertz(playerInventory(NewList)),
            write('You sell '),write(Amount),write(' '),write(Item),nl,
            write('gold received : '),write(Total),nl,
            write('Your gold : '),write(NewX),isGoal;

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
            write('Your gold : '),write(NewX),isGoal;

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
            write('Your gold : '),write(NewX),isGoal;

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
            write('Your gold : '),write(NewX),isGoal;

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
            write('Your gold : '),write(NewX),isGoal;

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
            write('Your gold : '),write(NewX),isGoal;

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
            write('Your gold : '),write(NewX),isGoal;

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
            write('Your gold : '),write(NewX),isGoal;

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
            write('Your gold : '),write(NewX),isGoal;

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
            write('Your gold : '),write(NewX),isGoal
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
    playerInventory(ListInventory),
    countLength(ListInventory, Jumlah),
    level_shovel(LvShovel), NewLvShovel is LvShovel+1, CostShovel is 600*NewLvShovel,
    level_fishing_rod(LvFishingRod), NewLvFishingRod is LvFishingRod+1, CostFishingRod is 800*NewLvFishingRod,
    level_hencoop(LvHencoop), NewLvHencoop is LvHencoop+1, CostHencoop is 1000*NewLvHencoop,
    level_shear(LvShear), NewLvShear is LvShear+1, CostShear is 1200*NewLvShear,
    level_bucket(LvBucket), NewLvBucket is LvBucket+1, CostBucket is 1400*NewLvBucket,
    write('What do you want to buy?'),nl,
    write('1. Carrot seed (25 golds)'),nl,
    write('2. Corn seed (30 golds)'),nl,
    write('3. Tomato seed (25 golds)'),nl,
    write('4. Potato seed (20 golds)'),nl,
    write('5. Chicken (500 golds)'),nl,
    write('6. Sheep (1000 golds)'),nl,
    write('7. Cow (1500 golds)'),nl,
    write('8. Level '), write(NewLvShovel), write(' Shovel ('), write(CostShovel), write(' golds)'), nl,
    write('9. Level '), write(NewLvFishingRod), write(' Fishing rod ('), write(CostFishingRod), write(' golds)'), nl,
    write('10. Level '), write(NewLvHencoop), write(' Hencoop ('), write(CostHencoop), write(' golds)'), nl,
    write('11. Level '), write(NewLvShear), write(' Shear ('), write(CostShear), write(' golds)'), nl,
    write('12. Level '), write(NewLvBucket), write(' Bucket ('), write(CostBucket), write(' golds)'), nl,
    write('> '), read(Item), nl,
    (
        Item = 1,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        (
            NewJumlah is Jumlah+Amount, NewJumlah>100, !, write('Inventory full!'), fail;

            Cost is Amount*25,
            pay(Cost),
            addItem(Amount, 'Carrot seed'),
            write('You have bought '), write(Amount), write(' Carrot seed(s)')
        );

        Item = 2,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        (
            NewJumlah is Jumlah+Amount, NewJumlah>100, !, write('Inventory full!'), fail;

            Cost is Amount*30,
            pay(Cost),
            addItem(Amount, 'Corn seed'),
            write('You have bought '), write(Amount), write(' Corn seed(s)')
        );

        Item = 3,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        (
            NewJumlah is Jumlah+Amount, NewJumlah>100, !, write('Inventory full!'), fail;

            Cost is Amount*25,
            pay(Cost),
            addItem(Amount, 'Tomato seed'),
            write('You have bought '), write(Amount), write(' Tomato seed(s)')
        );

        Item = 4,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        (
            NewJumlah is Jumlah+Amount, NewJumlah>100, !, write('Inventory full!'), fail;

            Cost is Amount*20,
            pay(Cost),
            addItem(Amount, 'Potato seed'),
            write('You have bought '), write(Amount), write(' Potato seed(s)')
        );

        Item = 5,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        (
            NewJumlah is Jumlah+Amount, NewJumlah>100, !, write('Inventory full!'), fail;

            Cost is Amount*500,
            pay(Cost),
            addItem(Amount, 'Chicken'),
            write('You have bought '), write(Amount), write(' Chicken(s)')
        );

        Item = 6,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        (
            NewJumlah is Jumlah+Amount, NewJumlah>100, !, write('Inventory full!'), fail;

            Cost is Amount*1000,
            pay(Cost),
            addItem(Amount, 'Sheep'),
            write('You have bought '), write(Amount), write(' Sheep(s)')
        );

        Item = 7,
        write('How many do you want to buy?'),nl,
        write('> '), read(Amount), nl,
        (
            NewJumlah is Jumlah+Amount, NewJumlah>100, !, write('Inventory full!'), fail;

            Cost is Amount*1500,
            pay(Cost),
            addItem(Amount, 'Cow'),
            write('You have bought '), write(Amount), write(' Cow(s)')
        );

        Item = 8,
        searchItem('Shovel', ListInventory, Found),
        (
            Found = false,
            (
                NewJumlah is Jumlah+1, NewJumlah>100, !, write('Inventory full!'), fail;

                pay(CostShovel),
                retract(level_shovel(LvShovel)),
                assertz(level_shovel(NewLvShovel)),
                assertz(farm_equip(1,2)),
                assertz(farm_equip_expUp(1,100)),
                assertz(farm_equip_exp(0))
            ),
            addItem(1,'Shovel');
            
            Found = true,
            pay(CostShovel),
            retract(level_shovel(LvShovel)),
            assertz(level_shovel(NewLvShovel)),
            farm_equip(LevelFarm,BonusLevel),
            farm_equip_expUp(LevelUp,ExpRequired),
            farm_equip_exp(Exp3),
            LevelFarm2 is LevelFarm + 1,
            BonusLevel2 is BonusLevel + 1,
            LevelUp2 is LevelUp + 1,
            ExpRequired2 is ExpRequired + 40,
            assertz(farm_equip(LevelFarm2,BonusLevel2)),
            assertz(farm_equip_expUp(LevelUp2,ExpRequired2)),
            assertz(farm_equip_exp(0)),
            retract(farm_equip(LevelFarm,BonusLevel)),
            retract(farm_equip_expUp(LevelUp,ExpRequired)),
            retract(farm_equip_exp(Exp3))
        ),
        
        write('You have bought a Level '), write(NewLvShovel), write(' Shovel');

        Item = 9,
        searchItem('Fishing rod', ListInventory, Found),
        (
            Found = false,
            (
                NewJumlah is Jumlah+1, NewJumlah>100, !, write('Inventory full!'), fail;

                pay(CostFishingRod),
                retract(level_fishing_rod(LvFishingRod)),
                assertz(level_fishing_rod(NewLvFishingRod)),
                expUpFishingRod(L,X),
                NewLvl is L + 1,
                NewExp is X + 100, /* Exp bounds */
                assertz(expUpFishingRod(NewLvl,NewExp)),
                retract(expUpFishingRod(L,X))
            ),
            addItem(1,'Fishing rod');
            
            Found = true,
            pay(CostFishingRod),
            retract(level_fishing_rod(LvFishingRod)),
            assertz(level_fishing_rod(NewLvFishingRod)),
            expUpFishingRod(L,X),
            NewLvl is L + 1,
            NewExp is X + 100, /* Exp bounds */
            assertz(expUpFishingRod(NewLvl,NewExp)),
            retract(expUpFishingRod(L,X))
        ),
        write('You have bought a Level '), write(NewLvFishingRod), write(' Fishing rod');

        Item = 10,
        searchItem('Hencoop', ListInventory, Found),
        (
            Found = false,
            (
                NewJumlah is Jumlah+1, NewJumlah>100, !, write('Inventory full!'), fail;

                pay(CostHencoop),
                retract(level_hencoop(LvHencoop)),
                assertz(level_hencoop(NewLvHencoop))
            ),
            addItem(1,'Hencoop');
            
            Found = true,
            pay(CostHencoop),
            retract(level_hencoop(LvHencoop)),
            assertz(level_hencoop(NewLvHencoop))
        ),
        write('You have bought a Level '), write(NewLvHencoop), write(' Hencoop');

        Item = 11,
        searchItem('Shear', ListInventory, Found),
        (
            Found = false,
            (
                NewJumlah is Jumlah+1, NewJumlah>100, !, write('Inventory full!'), fail;

                pay(CostShear),
                retract(level_shear(LvShear)),
                assertz(level_shear(NewLvShear))
            ),
            addItem(1,'Shear');
            
            Found = true,
            pay(CostShear),
            retract(level_shear(LvShear)),
            assertz(level_shear(NewLvShear))
        ),
        write('You have bought a Level '), write(NewLvShear), write(' Shear');

        Item = 12,
        searchItem('Bucket', ListInventory, Found),
        (
            Found = false,
            (
                NewJumlah is Jumlah+1, NewJumlah>100, !, write('Inventory full!'), fail;

                pay(CostBucket),
                retract(level_bucket(LvBucket)),
                assertz(level_bucket(NewLvBucket))
            ),
            addItem(1,'Bucket');
            
            Found = true,
            pay(CostBucket),
            retract(level_bucket(LvBucket)),
            assertz(level_bucket(NewLvBucket))
        ),
        write('You have bought a Level '), write(NewLvBucket), write(' Bucket')
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