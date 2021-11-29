/* File inventory.pl */
/* Menyimpan fakta dan aturan terkait inventory */

:- dynamic(playerInventory/1).

/* Menghitung jumlah item keseluruhan di dalam inventory */
countLength([], 0) :- !.

countLength([_|Tail], Ans) :-
    countLength(Tail, Ans1), Ans is Ans1 + 1, !.

/* Mengecek apakah inventory full */
isInventoryFull :-
    playerInventory(ListItem), countLength(ListItem, Length), Length =:= 100.

/* Menambah item ke dalam inventory */
addItem(_,_) :- 
    isInventoryFull, write('Inventory full!'), nl, !.

addItem(1,X) :-
    playerInventory(ListItem),
    countLength(ListItem, Length),
    Length < 100,
    retract(playerInventory(ListItem)),
    asserta(playerInventory([X|ListItem])), !.

addItem(N,X) :-
    playerInventory(ListItem),
    countLength(ListItem, Length),
    Length < 100,
    retract(playerInventory(ListItem)),
    asserta(playerInventory([X|ListItem])),
    N1 is N-1,
    addItem(N1,X), !.

/* Menghapus item tertentu dari list */
deleteAllX(_, [], []) :- !.

deleteAllX(X, [X|T1], T2) :- 
    deleteAllX(X, T1, T2), !.

deleteAllX(X, [H|T1], [H|T2]) :-
    H \= X, deleteAllX(X, T1, T2), !.

/* Menghapus beberapa item tertentu dari list */

deleteItem(X, 1, [X], []) :- !.

deleteItem(X, 1, [X|T], T) :- !.

deleteItem(X, 1, [Y|List], [Y|List2]) :- Y \= X, deleteItem(X, 1, List,List2).

deleteItem(X, N, [X|T1], T2) :- N1 is N-1, deleteItem(X, N1, T1, T2).

deleteItem(X, N, [H|T1], [H|T2]) :- H \= X, deleteItem(X, N, T1, T2).

/* Membuang item dari inventory */
throwItem :-
    write('Your inventory'), nl,
    playerInventory(ListInventory),
    writeInventory(ListInventory), nl,
    write('What do you want to throw?'), nl,
    write('> '), read(Item), nl,
    searchItem(Item, ListInventory, Found),
    (
        Found = false, !, write('Item not available!'), fail;
        
        Found = true,
        countItem(Item, ListInventory, Count),
        write('You have '), write(Count), write('. How many do you want to throw?'),nl,
        write('> '), read(Amount), nl,
        
        (
            Count < Amount, !, write('You don\'t have enough '), write(Item), write('. Cancelling...'), fail;

            (
                Item = 'Shovel', !,
                retract(level_shovel(_)),
                retract(farm_equip(_,_)),
                retract(farm_equip_expUp(_,_)),
                retract(farm_equip_exp(_)),
                assertz(level_shovel(0));

                Item = 'Fishing rod', !,
                retract(level_fishing_rod(_)),
                assertz(level_fishing_rod(0));

                Item = 'Hencoop', !,
                retract(level_hencoop(_)),
                assertz(level_hencoop(0));

                Item = 'Shear', !,
                retract(level_shear(_)),
                assertz(level_shear(0));

                Item = 'Bucket', !,
                retract(level_bucket(_)),
                assertz(level_bucket(0));

                !
            ),
            
            deleteItem(Item, Amount, ListInventory, NewList)
        ),
        
        write('You threw away '), write(Amount), write(' '), write(Item),
        retract(playerInventory(ListInventory)),
        asserta(playerInventory(NewList))
    ).

/* Menghitung jumlah item tertentu di dalam list */
countItem(_, [], 0) :- !.

countItem(X, [Head|Tail], Count) :-
    Head = X, countItem(X, Tail, Count1), Count is Count1+1, !.

countItem(X, [Head|Tail], Count) :-
    Head \= X, countItem(X, Tail, Count), !.

/* Mengecek keberadaan item di dalam inventory */
searchItem(X, [X|_Tail], true) :- !.

searchItem(_, [], false) :- !.

searchItem(X, [_Head|Tail], Found) :-
    searchItem(X, Tail, Found), !.

/* Menuliskan isi inventory */
writeInventory([]) :- !.

writeInventory([Head|Tail]) :-
    Head = 'Shovel',
    level_shovel(X),
    write('1 Level '), write(X), write(' Shovel'), nl,
    deleteAllX(Head, [Head|Tail], NewList),
    writeInventory(NewList), !.

writeInventory([Head|Tail]) :-
    Head = 'Fishing rod',
    level_fishing_rod(X),
    write('1 Level '), write(X), write(' Fishing rod'), nl,
    deleteAllX(Head, [Head|Tail], NewList),
    writeInventory(NewList), !.

writeInventory([Head|Tail]) :-
    Head = 'Hencoop',
    level_hencoop(X),
    write('1 Level '), write(X), write(' Hencoop'), nl,
    deleteAllX(Head, [Head|Tail], NewList),
    writeInventory(NewList), !.

writeInventory([Head|Tail]) :-
    Head = 'Shear',
    level_shear(X),
    write('1 Level '), write(X), write(' Shear'), nl,
    deleteAllX(Head, [Head|Tail], NewList),
    writeInventory(NewList), !.

writeInventory([Head|Tail]) :-
    Head = 'Bucket',
    level_bucket(X),
    write('1 Level '), write(X), write(' Bucket'), nl,
    deleteAllX(Head, [Head|Tail], NewList),
    writeInventory(NewList), !.

writeInventory([Head|Tail]) :-
    countItem(Head, [Head|Tail], Count),
    write(Count), write(' '), write(Head), nl,
    deleteAllX(Head, [Head|Tail], NewList),
    writeInventory(NewList), !.

/* Perintah inventory */
inventory :-
    isStart(true),
    playerInventory(ListInventory), countLength(ListInventory, X),
    write('Your inventory ('), write(X), write(' / 100)'), nl,
    writeInventory(ListInventory), !.

inventory :-
    write('Game has not started, use \"start.\" to play the game').