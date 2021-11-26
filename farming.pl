/* File farming.pl */
/* Menyimpan mekanisme farming */

:- dynamic(expUp/2).
:- dynamic(level_reward/2).

expUp(1,100).
level_reward(1,3).

vegetable('carrot',10,25).
vegetable('corn',15,30).
vegetable('tomato',15,25).
vegetable('potato',10,20).

gainStuff(Veg,Symbol):-
    level_reward(N,M),
    random(1,M,Reward),
    addItem(Reward,Veg),
    retract(map_object(X,Y,Symbol)),
    write('Anda mendapatkan '),write(Reward),write(' '),write(Veg),nl,
    vegetable(Veg,Q,R),
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
        S1 < Z,!, write('exp farming anda : '), write(S1),fail;

        S1 >= Z,
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
        write('level anda naik menjadi : '), write(W1),nl,
        write('exp farming anda : '),write(S2)
    ).

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
    addItem(1,'carrot seed'),
    addItem(1,'tomato seed'),
    addItem(1,'potato seed'),
    addItem(1,'corn seed'),
    write('You digged the tile').

plant :- 
    map_object(X,Y,'P'),
    (
        \+map_object(X,Y,'='), !, write('tile is not digged'),fail;

        map_object(X,Y,'='),
        \+ (map_object(X,Y,'M'), map_object(X,Y,'R'), map_object(X,Y,'H'), map_object(X,Y,'Q')),
        playerInventory(ListInventory),
        countItem('carrot seed', ListInventory, I),
        countItem('corn seed', ListInventory, J),
        countItem('tomato seed', ListInventory, K),
        countItem('potato seed', ListInventory, L),
        M is I + J + K + L,
        (
            M =:= 0, !, write('You do not have any seed'), fail;

            M > 0,
            write('You have:'),nl,
            write(I),write(' carrot seed'),nl,
            write(J),write(' corn seed'),nl,
            write(K),write(' tomato seed'),nl,
            write(L),write(' potato seed'),nl,
            write('What do you want to plant?'),nl,
            write('> '),read(Seed),nl,
            searchItem(Seed, ListInventory, Found),
            (
                Found = false, !, write('Seed not available!'), fail;

                Found = true,
                (
                    Seed = 'carrot seed',
                    assertz(map_object(X,Y,'c')),
                    assertz(seed_grow(X,Y,Seed,0)),
                    retract(map_object(X,Y,'=')),
                    deleteItem(Seed, 1, ListInventory, NewList),
                    write(Seed),write(' berhasil ditanam'),nl;

                    Seed = 'corn seed',
                    assertz(map_object(X,Y,'C')),
                    assertz(seed_grow(X,Y,Seed,0)),
                    retract(map_object(X,Y,'=')),
                    deleteItem(Seed, 1, ListInventory, NewList),
                    write(Seed),write(' berhasil ditanam'),nl;

                    Seed = 'tomato seed',
                    assertz(map_object(X,Y,'T')),
                    assertz(seed_grow(X,Y,Seed,0)),
                    retract(map_object(X,Y,'=')),
                    deleteItem(Seed, 1, ListInventory, NewList),
                    write(Seed),write(' berhasil ditanam'),nl;

                    Seed = 'potato seed',
                    assertz(map_object(X,Y,'O')),
                    assertz(seed_grow(X,Y,Seed,0)),
                    retract(map_object(X,Y,'=')),
                    deleteItem(Seed, 1, ListInventory, NewList),
                    write(Seed),write(' berhasil ditanam'),nl
                ),

                retract(playerInventory(ListInventory)),
                assertz(playerInventory(NewList))
                
            )
        )
    ).


harvest:- 
    map_object(X,Y,'P'),
    (
        \+ ( map_object(X,Y,'c'); map_object(X,Y,'C'); map_object(X,Y,'T'); map_object(X,Y,'O')), !, write('belum ada tanaman disini'), fail;

        map_object(X,Y,'T'),
        (
            \+seed_grow(X,Y,Seed,0), !, write('Tanaman belum selesai tumbuh'), fail;

            seed_grow(X,Y,Seed,0),
            (
                Seed = 'tomato seed',
                gainStuff('tomato','T')
            )
        );

        map_object(X,Y,'c'),
        (
            \+seed_grow(X,Y,Seed,0), !, write('Tanaman belum selesai tumbuh'), fail;

            seed_grow(X,Y,Seed,0),
            (
                Seed = 'carrot seed',
                gainStuff('carrot','c')
            )
        );

        map_object(X,Y,'C'),
        (
            \+seed_grow(X,Y,Seed,0), !, write('Tanaman belum selesai tumbuh'), fail;

            seed_grow(X,Y,Seed,0),
            (
                Seed = 'corn seed',
                gainStuff('corn','C')
                
            )
        );

        map_object(X,Y,'O'),
        (
            \+seed_grow(X,Y,Seed,0), !, write('Tanaman belum selesai tumbuh'), fail;

            seed_grow(X,Y,Seed,0),
            (
                Seed = 'potato seed',
                gainStuff('potato','O')
            )
        )
    ).