/* File farming.pl */
/* Menyimpan mekanisme farming */

:- dynamic(level_reward/2).
level_reward(1,3).

vegetable('carrot',10,25).
vegetable('corn',15,30).
vegetable('tomato',15,25).
vegetable('potato',10,20).



dig :-
    map_object(X,Y,'P'),
    \+map_object(X,Y,'='),
    \+map_object(X,Y,'M'),
    \+map_object(X,Y,'R'),
    \+map_object(X,Y,'H'),
    \+map_object(X,Y,'Q'),
    \+map_object(X,Y,'T'),
    assertz(map_object(X,Y,'=')),
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
                    assertz(map_object(X,Y,'o')),
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
        \+ ( map_object(X,Y,'c'); map_object(X,Y,'C'); map_object(X,Y,'T'); map_object(X,Y,'o')), !, write('belum ada tanaman disini'), fail;

        map_object(X,Y,'T'),
        (
            \+seed_grow(X,Y,Seed,0), !, write('Tanaman belum selesai tumbuh'), fail;

            seed_grow(X,Y,Seed,0),
            (
                Seed = 'tomato seed',
                level_reward(N,M),
                random(1,M,Reward),
                addItem(Reward,'tomato'),
                retract(map_object(X,Y,'T')),
                write('Anda mendapatkan '),write(Reward),write(' tomato'),nl
            )
        );

        map_object(X,Y,'c'),
        (
            \+seed_grow(X,Y,Seed,0), !, write('Tanaman belum selesai tumbuh'), fail;

            seed_grow(X,Y,Seed,0),
            (
                Seed = 'carrot seed',
                level_reward(N,M),
                random(1,M,Reward),
                addItem(Reward,'carrot'),
                retract(map_object(X,Y,'c')),
                write('Anda mendapatkan '),write(Reward),write(' carrot'),nl
                
            )
        );

        map_object(X,Y,'C'),
        (
            \+seed_grow(X,Y,Seed,0), !, write('Tanaman belum selesai tumbuh'), fail;

            seed_grow(X,Y,Seed,0),
            (
                Seed = 'corn seed',
                level_reward(N,M),
                random(1,M,Reward),
                addItem(Reward,'corn'),
                retract(map_object(X,Y,'C')),
                write('Anda mendapatkan '),write(Reward),write(' corn'),nl
                
            )
        );

        map_object(X,Y,'o'),
        (
            \+seed_grow(X,Y,Seed,0), !, write('Tanaman belum selesai tumbuh'), fail;

            seed_grow(X,Y,Seed,0),
            (
                Seed = 'potato seed',
                level_reward(N,M),
                random(1,M,Reward),
                addItem(Reward,'potato'),
                retract(map_object(X,Y,'o')),
                write('Anda mendapatkan '),write(Reward),write(' potato'),nl
            )
        )
    ).