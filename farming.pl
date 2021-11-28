/* File farming.pl */
/* Menyimpan mekanisme farming */

:- dynamic(expUp/2).
:- dynamic(level_reward/2).
:- dynamic(farm_equip/2).
:- dynamic(farm_equip_expUp/2).
:- dynamic(farm_equip_exp/1).

/* stat untuk shovel level 1*/
farm_equip(1,2).
farm_equip_expUp(1,100).
farm_equip_exp(0).

/* stat untuk level farming 1*/
expUp(1,100).
level_reward(1,3).

vegetable('Carrot',25).
vegetable('Corn',30).
vegetable('Tomato',25).
vegetable('Potato',20).

farmingDone(X) :- 
    questStatus(Fishing,Farming,Ranching,Status),
    retract(questStatus(Fishing,Farming,Ranching,Status)),
    (
        X >= Farming,
        NewFarming is 0;
        
        X < Farming,
        NewFarming is Farming - X
    ),
    asserta(questStatus(Fishing,NewFarming,Ranching,Status)).

/* harvest jika tidak menggunakan shovel dan specialty bukan farmer */
gainStuff(Veg,Symbol,Equip,Seed):-
    Equip = 1,\+specialty('Farmer'),!,
    level_reward(N,M),
    playerInventory(ListInventory),
    countLength(ListInventory,Length),
    random(1,M,Reward),
    (
        Length + Reward =< 100,
        addItem(Reward,Veg),
        farmingDone(Reward),
        retract(map_object(X,Y,Symbol)),
        write('You received '),write(Reward),write(' '),write(Veg),nl,
        vegetable(Veg,R),
        exp_farming(S),
        exp_total(AB),
        S1 is S + R,
        AB1 is AB + R,
        assertz(exp_total(AB1)),
        retract(exp_total(AB)),
        assertz(exp_farming(S1)),
        retract(exp_farming(S)),
        expUp(W,Z),
        (
            S1 < Z,!, write('farming exp : '), write(S1),nl,
            write('total exp : '),write(AB1),nl,
            level_up_player,fail;

            S1 >= Z,!,
            S2 is S1 - Z,
            assertz(exp_farming(S2)),
            retract(exp_farming(S1)),
            level_up_farming,
            W1 is W + 1,
            Z1 is Z * 2,
            assertz(expUp(W1,Z1)),
            retract(expUp(W,Z)),
            N1 is N + 1,
            M1 is M + 1,
            assertz(level_reward(N1,M1)),
            retract(level_reward(N,M)),
            write('your level increased to : Level '), write(W1),nl,
            write('farming exp : '),write(S2),nl,
            write('total exp : '),write(AB1),nl,
            level_up_player
        ),fail;

        Length + Reward > 100,
        Reward2 is 100-Length,
        write('Your inventory is full, some items will be thrown away'),nl,
        addItem(Reward2,Veg),
        farmingDone(Reward2),
        retract(map_object(X,Y,Symbol)),
        write('You received '),write(Reward2),write(' '),write(Veg),nl,
        vegetable(Veg,R),
        exp_farming(S),
        exp_total(AB),
        S1 is S + R,
        AB1 is AB + R,
        assertz(exp_total(AB1)),
        retract(exp_total(AB)),
        assertz(exp_farming(S1)),
        retract(exp_farming(S)),
        expUp(W,Z),
        (
            S1 < Z,!, write('farming exp : '), write(S1),nl,
            write('total exp : '),write(AB1),nl,
            level_up_player,fail;

            S1 >= Z,!,
            S2 is S1 - Z,
            assertz(exp_farming(S2)),
            retract(exp_farming(S1)),
            level_up_farming,
            W1 is W + 1,
            Z1 is Z * 2,
            assertz(expUp(W1,Z1)),
            retract(expUp(W,Z)),
            N1 is N + 1,
            M1 is M + 1,
            assertz(level_reward(N1,M1)),
            retract(level_reward(N,M)),
            write('your level increased to : Level '), write(W1),nl,
            write('farming exp : '),write(S2),nl,
            write('total exp : '),write(AB1),nl,
            level_up_player
        )
    ).

/* harvest jika tidak menggunakan shovel dan specialty farmer */
gainStuff(Veg,Symbol,Equip,Seed):-
    Equip = 1,specialty('Farmer'),!,
    level_reward(N,M),
    playerInventory(ListInventory),
    countLength(ListInventory,Length),
    random(1,M,Reward),
    (
        Length + Reward =< 100,
        addItem(Reward,Veg),
        farmingDone(Reward),
        retract(map_object(X,Y,Symbol)),
        write('You received '),write(Reward),write(' '),write(Veg),nl,
        vegetable(Veg,R),
        exp_farming(S),
        exp_total(AB),
        R2 is R * 1.5,
        S1 is S + R2,
        AB1 is AB + R2,
        assertz(exp_total(AB1)),
        retract(exp_total(AB)),
        assertz(exp_farming(S1)),
        retract(exp_farming(S)),
        expUp(W,Z),
        (
            S1 < Z,!, write('farming exp : '), write(S1),nl,
            write('total exp : '),write(AB1),nl,
            level_up_player,fail;

            S1 >= Z,!,
            S2 is S1 - Z,
            assertz(exp_farming(S2)),
            retract(exp_farming(S1)),
            level_up_farming,
            W1 is W + 1,
            Z1 is Z * 2,
            assertz(expUp(W1,Z1)),
            retract(expUp(W,Z)),
            N1 is N + 1,
            M1 is M + 1,
            assertz(level_reward(N1,M1)),
            retract(level_reward(N,M)),
            write('your level increased to : Level '), write(W1),nl,
            write('farming exp : '),write(S2),nl,
            write('total exp : '),write(AB1),nl,
            level_up_player
        ),fail;

        Length + Reward > 100,
        Reward2 is 100-Length,
        write('Your inventory is full, some items will be thrown away'),nl,
        addItem(Reward2,Veg),
        farmingDone(Reward2),
        retract(map_object(X,Y,Symbol)),
        write('You received '),write(Reward2),write(' '),write(Veg),nl,
        vegetable(Veg,R),
        exp_farming(S),
        exp_total(AB),
        R2 is R * 1.5,
        S1 is S + R2,
        AB1 is AB + R2,
        assertz(exp_total(AB1)),
        retract(exp_total(AB)),
        assertz(exp_farming(S1)),
        retract(exp_farming(S)),
        expUp(W,Z),
        (
            S1 < Z,!, write('farming exp : '), write(S1),nl,
            write('total exp : '),write(AB1),nl,
            level_up_player,fail;

            S1 >= Z,!,
            S2 is S1 - Z,
            assertz(exp_farming(S2)),
            retract(exp_farming(S1)),
            level_up_farming,
            W1 is W + 1,
            Z1 is Z * 2,
            assertz(expUp(W1,Z1)),
            retract(expUp(W,Z)),
            N1 is N + 1,
            M1 is M + 1,
            assertz(level_reward(N1,M1)),
            retract(level_reward(N,M)),
            write('your level increased to : Level '), write(W1),nl,
            write('farming exp : '),write(S2),nl,
            write('total exp : '),write(AB1),nl,
            level_up_player
        )
    ).
    

/* harvest jika menggunakan shovel dan specialty bukan farmer */
gainStuff(Veg,Symbol,Equip,Seed):-
    Equip = 2,\+specialty('Farmer'),!,
    playerInventory(ListInventory),
    countLength(ListInventory,Length),
    farm_equip(Level,Bonus),
    level_reward(N,M),
    M2 is M + Bonus,
    random(1,M2,Reward),
    (
        Length + Reward =< 100,
        addItem(Reward,Veg),
        farmingDone(Reward),
        retract(map_object(X,Y,Symbol)),
        write('You received '),write(Reward),write(' '),write(Veg),nl,
        vegetable(Veg,R),
        exp_farming(S),
        exp_total(AB),
        farm_equip_exp(E2),
        E21 is E2 + R,
        S1 is S + R,
        AB1 is AB + R,
        assertz(exp_total(AB1)),
        retract(exp_total(AB)),
        assertz(exp_farming(S1)),
        retract(exp_farming(S)),
        assertz(farm_equip_exp(E21)),
        retract(farm_equip_exp(E2)),
        farm_equip_expUp(EquipLevel,EquipExp),
        expUp(W,Z),
        (
            S1 < Z,!, write('farming exp : '), write(S1),nl,
            (

                E21 < EquipExp, !, write('Equipment exp : '), write(E21),nl,
                write('total exp : '),write(AB1),nl,
                level_up_player,fail;

                E21 >= EquipExp,!,
                level_shovel(LvL),
                LvL2 is LvL + 1,
                assertz(level_shovel(LvL2)),
                retract(level_shovel(LvL)),
                Level1 is Level + 1,
                Bonus1 is Bonus + 1,
                assertz(farm_equip(Level1,Bonus1)),
                retract(farm_equip(Level,Bonus)),
                E22 is E21 - EquipExp,
                assertz(farm_equip_exp(E22)),
                retract(farm_equip_exp(E21)),
                EquipExp1 is EquipExp + 40,
                EquipLevel1 is EquipLevel + 1,
                assertz(farm_equip_expUp(EquipLevel1,EquipExp1)),
                retract(farm_equip_expUp(EquipLevel,EquipExp)),
                write('Equipment level increased : Level '),write(Level1),nl,
                write('Equipment exp : '),write(E22),nl,
                write('total exp : '),write(AB1),nl,
                level_up_player
            );
        
            S1 >= Z,!,
            S2 is S1 - Z,
            assertz(exp_farming(S2)),
            retract(exp_farming(S1)),
            level_up_farming,
            W1 is W + 1,
            Z1 is Z * 2,
            assertz(expUp(W1,Z1)),
            retract(expUp(W,Z)),
            N1 is N + 1,
            M1 is M + 1,
            assertz(level_reward(N1,M1)),
            retract(level_reward(N,M)),
            write('your level increased to : Level '), write(W1),nl,
            write('farming exp : '),write(S2),nl,
            (
                E21 < EquipExp, !, write('Equipment exp : '), write(E21),nl,
                write('total exp : '),write(AB1),nl,
                level_up_player,fail;

                E21 >= EquipExp,!,
                level_shovel(LvL),
                LvL2 is LvL + 1,
                assertz(level_shovel(LvL2)),
                retract(level_shovel(LvL)),
                Level1 is Level + 1,
                Bonus1 is Bonus + 1,
                assertz(farm_equip(Level1,Bonus1)),
                retract(farm_equip(Level,Bonus)),
                E22 is E21 - EquipExp,
                assertz(farm_equip_exp(E22)),
                retract(farm_equip_exp(E21)),
                EquipExp1 is EquipExp + 40,
                EquipLevel1 is EquipLevel + 1,
                assertz(farm_equip_expUp(EquipLevel1,EquipExp1)),
                retract(farm_equip_expUp(EquipLevel,EquipExp)),
                write('Equipment level increased : Level '),write(Level1),nl,
                write('Equipment exp : '),write(E22),nl,
                write('total exp : '),write(AB1),nl,
                level_up_player
            )
        ),fail;

        Length + Reward > 100,
        Reward2 is 100-Length,
        write('Your inventory is full, some items will be thrown away'),nl,
        addItem(Reward2,Veg),
        farmingDone(Reward2),
        retract(map_object(X,Y,Symbol)),
        write('You received '),write(Reward2),write(' '),write(Veg),nl,
        vegetable(Veg,R),
        exp_farming(S),
        exp_total(AB),
        farm_equip_exp(E2),
        E21 is E2 + R,
        S1 is S + R,
        AB1 is AB + R,
        assertz(exp_total(AB1)),
        retract(exp_total(AB)),
        assertz(exp_farming(S1)),
        retract(exp_farming(S)),
        assertz(farm_equip_exp(E21)),
        retract(farm_equip_exp(E2)),
        farm_equip_expUp(EquipLevel,EquipExp),
        expUp(W,Z),
        (
            S1 < Z,!, write('farming exp : '), write(S1),nl,
            (

                E21 < EquipExp, !, write('Equipment exp : '), write(E21),nl,
                write('total exp : '),write(AB1),nl,
                level_up_player,fail;

                E21 >= EquipExp,!,
                level_shovel(LvL),
                LvL2 is LvL + 1,
                assertz(level_shovel(LvL2)),
                retract(level_shovel(LvL)),
                Level1 is Level + 1,
                Bonus1 is Bonus + 1,
                assertz(farm_equip(Level1,Bonus1)),
                retract(farm_equip(Level,Bonus)),
                E22 is E21 - EquipExp,
                assertz(farm_equip_exp(E22)),
                retract(farm_equip_exp(E21)),
                EquipExp1 is EquipExp + 40,
                EquipLevel1 is EquipLevel + 1,
                assertz(farm_equip_expUp(EquipLevel1,EquipExp1)),
                retract(farm_equip_expUp(EquipLevel,EquipExp)),
                write('Equipment level increased : Level '),write(Level1),nl,
                write('Equipment exp : '),write(E22),nl,
                write('total exp : '),write(AB1),nl,
                level_up_player
            );
        
            S1 >= Z,!,
            S2 is S1 - Z,
            assertz(exp_farming(S2)),
            retract(exp_farming(S1)),
            level_up_farming,
            W1 is W + 1,
            Z1 is Z * 2,
            assertz(expUp(W1,Z1)),
            retract(expUp(W,Z)),
            N1 is N + 1,
            M1 is M + 1,
            assertz(level_reward(N1,M1)),
            retract(level_reward(N,M)),
            write('your level increased to : Level '), write(W1),nl,
            write('farming exp : '),write(S2),nl,
            (
                E21 < EquipExp, !, write('Equipment exp : '), write(E21),nl,
                write('total exp : '),write(AB1),nl,
                level_up_player,fail;

                E21 >= EquipExp,!,
                level_shovel(LvL),
                LvL2 is LvL + 1,
                assertz(level_shovel(LvL2)),
                retract(level_shovel(LvL)),
                Level1 is Level + 1,
                Bonus1 is Bonus + 1,
                assertz(farm_equip(Level1,Bonus1)),
                retract(farm_equip(Level,Bonus)),
                E22 is E21 - EquipExp,
                assertz(farm_equip_exp(E22)),
                retract(farm_equip_exp(E21)),
                EquipExp1 is EquipExp + 40,
                EquipLevel1 is EquipLevel + 1,
                assertz(farm_equip_expUp(EquipLevel1,EquipExp1)),
                retract(farm_equip_expUp(EquipLevel,EquipExp)),
                write('Equipment level increased : Level '),write(Level1),nl,
                write('Equipment exp : '),write(E22),nl,
                write('total exp : '),write(AB1),nl,
                level_up_player
            )
        )
    ).

/* harvest jika menggunakan shovel dan specialty farmer */
gainStuff(Veg,Symbol,Equip,Seed):-
    Equip = 2,specialty('Farmer'),!,
    playerInventory(ListInventory),
    countLength(ListInventory,Length),
    farm_equip(Level,Bonus),
    level_reward(N,M),
    M2 is M + Bonus,
    random(1,M2,Reward),
    (
        Length + Reward =< 100,
        addItem(Reward,Veg),
        farmingDone(Reward),
        retract(map_object(X,Y,Symbol)),
        write('You received '),write(Reward),write(' '),write(Veg),nl,
        vegetable(Veg,R),
        exp_farming(S),
        exp_total(AB),
        farm_equip_exp(E2),
        R2 is R * 1.5,
        E21 is E2 + R2,
        S1 is S + R2,
        AB1 is AB + R2,
        assertz(exp_total(AB1)),
        retract(exp_total(AB)),
        assertz(exp_farming(S1)),
        retract(exp_farming(S)),
        assertz(farm_equip_exp(E21)),
        retract(farm_equip_exp(E2)),
        farm_equip_expUp(EquipLevel,EquipExp),
        expUp(W,Z),
        (
            S1 < Z,!, write('farming exp : '), write(S1),nl,
            (

                E21 < EquipExp, !, write('Equipment exp : '), write(E21),nl,
                write('total exp : '),write(AB1),nl,
                level_up_player,fail;

                E21 >= EquipExp,!,
                level_shovel(LvL),
                LvL2 is LvL + 1,
                assertz(level_shovel(LvL2)),
                retract(level_shovel(LvL)),
                Level1 is Level + 1,
                Bonus1 is Bonus + 1,
                assertz(farm_equip(Level1,Bonus1)),
                retract(farm_equip(Level,Bonus)),
                E22 is E21 - EquipExp,
                assertz(farm_equip_exp(E22)),
                retract(farm_equip_exp(E21)),
                EquipExp1 is EquipExp + 40,
                EquipLevel1 is EquipLevel + 1,
                assertz(farm_equip_expUp(EquipLevel1,EquipExp1)),
                retract(farm_equip_expUp(EquipLevel,EquipExp)),
                write('Equipment level increased : Level '),write(Level1),nl,
                write('Equipment exp : '),write(E22),nl,
                write('total exp : '),write(AB1),nl,
                level_up_player
            );
        
            S1 >= Z,!,
            S2 is S1 - Z,
            assertz(exp_farming(S2)),
            retract(exp_farming(S1)),
            level_up_farming,
            W1 is W + 1,
            Z1 is Z * 2,
            assertz(expUp(W1,Z1)),
            retract(expUp(W,Z)),
            N1 is N + 1,
            M1 is M + 1,
            assertz(level_reward(N1,M1)),
            retract(level_reward(N,M)),
            write('your level increased to : Level '), write(W1),nl,
            write('farming exp : '),write(S2),nl,
            (
                E21 < EquipExp, !, write('Equipment exp : '), write(E21),nl,
                write('total exp : '),write(AB1),nl,
                level_up_player,fail;

                E21 >= EquipExp,!,
                level_shovel(LvL),
                LvL2 is LvL + 1,
                assertz(level_shovel(LvL2)),
                retract(level_shovel(LvL)),
                Level1 is Level + 1,
                Bonus1 is Bonus + 1,
                assertz(farm_equip(Level1,Bonus1)),
                retract(farm_equip(Level,Bonus)),
                E22 is E21 - EquipExp,
                assertz(farm_equip_exp(E22)),
                retract(farm_equip_exp(E21)),
                EquipExp1 is EquipExp + 40,
                EquipLevel1 is EquipLevel + 1,
                assertz(farm_equip_expUp(EquipLevel1,EquipExp1)),
                retract(farm_equip_expUp(EquipLevel,EquipExp)),
                write('Equipment level increased : Level '),write(Level1),nl,
                write('Equipment exp : '),write(E22),nl,
                write('total exp : '),write(AB1),nl,
                level_up_player
            )
        ),fail;

        Length + Reward > 100,
        Reward2 is 100-Length,
        write('Your inventory is full, some items will be thrown away'),nl,
        addItem(Reward2,Veg),
        farmingDone(Reward2),
        retract(map_object(X,Y,Symbol)),
        write('You received '),write(Reward2),write(' '),write(Veg),nl,
        vegetable(Veg,R),
        exp_farming(S),
        exp_total(AB),
        farm_equip_exp(E2),
        R2 is R * 1.5,
        E21 is E2 + R2,
        S1 is S + R2,
        AB1 is AB + R2,
        assertz(exp_total(AB1)),
        retract(exp_total(AB)),
        assertz(exp_farming(S1)),
        retract(exp_farming(S)),
        assertz(farm_equip_exp(E21)),
        retract(farm_equip_exp(E2)),
        farm_equip_expUp(EquipLevel,EquipExp),
        expUp(W,Z),
        (
            S1 < Z,!, write('farming exp : '), write(S1),nl,
            (

                E21 < EquipExp, !, write('Equipment exp : '), write(E21),nl,
                write('total exp : '),write(AB1),nl,
                level_up_player,fail;

                E21 >= EquipExp,!,
                level_shovel(LvL),
                LvL2 is LvL + 1,
                assertz(level_shovel(LvL2)),
                retract(level_shovel(LvL)),
                Level1 is Level + 1,
                Bonus1 is Bonus + 1,
                assertz(farm_equip(Level1,Bonus1)),
                retract(farm_equip(Level,Bonus)),
                E22 is E21 - EquipExp,
                assertz(farm_equip_exp(E22)),
                retract(farm_equip_exp(E21)),
                EquipExp1 is EquipExp + 40,
                EquipLevel1 is EquipLevel + 1,
                assertz(farm_equip_expUp(EquipLevel1,EquipExp1)),
                retract(farm_equip_expUp(EquipLevel,EquipExp)),
                write('Equipment level increased : Level '),write(Level1),nl,
                write('Equipment exp : '),write(E22),nl,
                write('total exp : '),write(AB1),nl,
                level_up_player
            );
        
            S1 >= Z,!,
            S2 is S1 - Z,
            assertz(exp_farming(S2)),
            retract(exp_farming(S1)),
            level_up_farming,
            W1 is W + 1,
            Z1 is Z * 2,
            assertz(expUp(W1,Z1)),
            retract(expUp(W,Z)),
            N1 is N + 1,
            M1 is M + 1,
            assertz(level_reward(N1,M1)),
            retract(level_reward(N,M)),
            write('your level increased to : Level '), write(W1),nl,
            write('farming exp : '),write(S2),nl,
            (
                E21 < EquipExp, !, write('Equipment exp : '), write(E21),nl,
                write('total exp : '),write(AB1),nl,
                level_up_player,fail;

                E21 >= EquipExp,!,
                level_shovel(LvL),
                LvL2 is LvL + 1,
                assertz(level_shovel(LvL2)),
                retract(level_shovel(LvL)),
                Level1 is Level + 1,
                Bonus1 is Bonus + 1,
                assertz(farm_equip(Level1,Bonus1)),
                retract(farm_equip(Level,Bonus)),
                E22 is E21 - EquipExp,
                assertz(farm_equip_exp(E22)),
                retract(farm_equip_exp(E21)),
                EquipExp1 is EquipExp + 40,
                EquipLevel1 is EquipLevel + 1,
                assertz(farm_equip_expUp(EquipLevel1,EquipExp1)),
                retract(farm_equip_expUp(EquipLevel,EquipExp)),
                write('Equipment level increased : Level '),write(Level1),nl,
                write('Equipment exp : '),write(E22),nl,
                write('total exp : '),write(AB1),nl,
                level_up_player
            )
        )
    ).
    
    
/* menggali tile */
dig :-
    map_object(X,Y,'P'),
    \+map_object(X,Y,'='),
    \+map_object(X,Y,'M'),
    \+map_object(X,Y,'R'),
    \+map_object(X,Y,'H'),
    \+map_object(X,Y,'Q'),
    \+map_object(X,Y,'T'),
    \+map_object(X,Y,'c'),
    \+map_object(X,Y,'C'),
    \+map_object(X,Y,'O'),
    assertz(map_object(X,Y,'=')),
    addItem(25,'Carrot seed'),
    addItem(25,'Tomato seed'),
    addItem(25,'Potato seed'),
    addItem(25,'Corn seed'),
    write('You digged the tile').

/* melakukan plant */
plant :- 
    map_object(X,Y,'P'),
    (
        /* Jika belum digali */
        \+map_object(X,Y,'='), !, write('tile is not digged'),fail;

        /* Jika sudah digali */
        map_object(X,Y,'='),!,
        \+ (map_object(X,Y,'M'), map_object(X,Y,'R'), map_object(X,Y,'H'), map_object(X,Y,'Q')),
        playerInventory(ListInventory),
        countItem('Carrot seed', ListInventory, I),
        countItem('Corn seed', ListInventory, J),
        countItem('Tomato seed', ListInventory, K),
        countItem('Potato seed', ListInventory, L),
        M is I + J + K + L,!,
        (
            M =:= 0, !, write('You do not have any seed'), fail;

            M > 0,
            write('You have:'),nl,
            write('1. '),write(I),write(' Carrot seed'),nl,
            write('2. '),write(J),write(' Corn seed'),nl,
            write('3. '),write(K),write(' Tomato seed'),nl,
            write('4. '),write(L),write(' Potato seed'),nl,
            write('What do you want to plant?'),nl,
            write('> '),read(Seed),nl,
            searchItem(Seed, ListInventory, Found),
            (
                Found = false, !, write('Seed not available!'), fail;

                Found = true,!,
                (
                    Seed = 'Carrot seed',!,
                    assertz(map_object(X,Y,'c')),
                    time(HourC, MinuteC),
                    date(DayC, MonthC),
                    assertz(seed_grow(X,Y,Seed, 40, HourC, MinuteC, DayC, MonthC)),
                    retract(map_object(X,Y,'=')),
                    deleteItem(Seed, 1, ListInventory, NewList),
                    write(Seed),write(' successfully planted'),nl,
                    retract(playerInventory(ListInventory)),
                    assertz(playerInventory(NewList)),!;

                    Seed = 'Corn seed',!,
                    assertz(map_object(X,Y,'C')),
                    time(HourC, MinuteC),
                    date(DayC, MonthC),
                    assertz(seed_grow(X,Y,Seed, 60, HourC, MinuteC, DayC, MonthC)),
                    retract(map_object(X,Y,'=')),
                    deleteItem(Seed, 1, ListInventory, NewList),
                    write(Seed),write(' successfully planted'),nl,
                    retract(playerInventory(ListInventory)),
                    assertz(playerInventory(NewList)),!;

                    Seed = 'Tomato seed',!,
                    assertz(map_object(X,Y,'T')),
                    time(HourC, MinuteC),
                    date(DayC, MonthC),
                    assertz(seed_grow(X,Y,Seed, 50, HourC, MinuteC, DayC, MonthC)),
                    retract(map_object(X,Y,'=')),
                    deleteItem(Seed, 1, ListInventory, NewList),
                    write(Seed),write(' successfully planted'),nl,
                    retract(playerInventory(ListInventory)),
                    assertz(playerInventory(NewList)),!;

                    Seed = 'Potato seed',!,
                    assertz(map_object(X,Y,'O')),
                    time(HourC, MinuteC),
                    date(DayC, MonthC),
                    assertz(seed_grow(X,Y,Seed, 40, HourC, MinuteC, DayC, MonthC)),
                    retract(map_object(X,Y,'=')),
                    deleteItem(Seed, 1, ListInventory, NewList),
                    write(Seed),write(' successfully planted'),nl,
                    retract(playerInventory(ListInventory)),
                    assertz(playerInventory(NewList)),!
                )
            )
        )
    ),!.

/* harvest */

harvest:-
    playerInventory(ListInventory),
    countLength(ListInventory,N),
    N >= 100, !, 
    write('Your inventory is full').

harvest:- 
    map_object(X,Y,'P'),
    time(HourT, MinuteT),
    date(DayT, MonthT),
    playerInventory(ListInventory),

    (
        \+ ( map_object(X,Y,'c'); map_object(X,Y,'C'); map_object(X,Y,'T'); map_object(X,Y,'O')), !, write('Cannot find any plant'), fail;

        map_object(X,Y,'T'),
        (
            seed_grow(X,Y,'Tomato seed', Time, HourC, MinuteC, DayC, MonthC),
            TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
            TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
            (TimeT-TimeC) < Time, !, write('Plant is still growing'), fail;
            
            seed_grow(X,Y,'Tomato seed', Time, HourC, MinuteC, DayC, MonthC),
            TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
            TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
            (TimeT-TimeC) >= Time,

            (
                retract(seed_grow(X,Y,'Tomato seed',Time,HourC,MinuteC,DayC,MonthC)),
                write('Do you want to use a shovel?'),nl,
                write('1. No'),nl,
                write('2. Yes'),nl,
                write('> '),read(Equip),nl,
                !,gainStuff('Tomato','T',Equip,'Tomato seed')

            )
        );

        map_object(X,Y,'c'),
        (
            seed_grow(X,Y, 'Carrot seed', Time, HourC, MinuteC, DayC, MonthC),
            TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
            TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
            (TimeT-TimeC) < Time, !, write('Plant is still growing'), fail;
            
            seed_grow(X,Y,'Carrot seed', Time, HourC, MinuteC, DayC, MonthC),
            TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
            TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
            (TimeT-TimeC) >= Time,

            (
                retract(seed_grow(X,Y,'Carrot seed',Time,HourC,MinuteC,DayC,MonthC)),
                write('Do you want to use a shovel?'),nl,
                write('1. No'),nl,
                write('2. Yes'),nl,
                write('> '),read(Equip),nl,
                !,gainStuff('Carrot','c',Equip,'Carrot seed')

            )
        );

        map_object(X,Y,'C'),
        (
            seed_grow(X,Y, 'Corn seed', Time, HourC, MinuteC, DayC, MonthC),
            TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
            TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
            (TimeT-TimeC) < Time, !, write('Plant is still growing'), fail;
            
            seed_grow(X,Y,'Corn seed', Time, HourC, MinuteC, DayC, MonthC),
            TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
            TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
            (TimeT-TimeC) >= Time,

            (   
    
                retract(seed_grow(X,Y,'Corn seed',Time,HourC,MinuteC,DayC,MonthC)),
                write('Do you want to use a shovel?'),nl,
                write('1. No'),nl,
                write('2. Yes'),nl,
                write('> '),read(Equip),nl,
                !,gainStuff('Corn','C',Equip,'Corn seed')
                
            )
        );

        map_object(X,Y,'O'),
        (
            seed_grow(X,Y, 'Potato seed', Time, HourC, MinuteC, DayC, MonthC),
            TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
            TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
            (TimeT-TimeC) < Time, !, write('Plant is still growing'), fail;
            
            seed_grow(X,Y,'Potato seed', Time, HourC, MinuteC, DayC, MonthC),
            TimeC is MonthC * 30 * 24 * 60 + (DayC-1) * 24 * 60 + HourC * 60 + MinuteC,
            TimeT is MonthT * 30 * 24 * 60 + (DayT-1) * 24 * 60 + HourT * 60 + MinuteT,
            (TimeT-TimeC) >= Time,

            (
                retract(seed_grow(X,Y,'Potato seed',Time,HourC,MinuteC,DayC,MonthC)),
                write('Do you want to use a shovel?'),nl,
                write('1. No'),nl,
                write('2. Yes'),nl,
                write('> '),read(Equip),nl,
                !,gainStuff('Potato','O',Equip,'Potato seed')
                
            )
        )
    ).