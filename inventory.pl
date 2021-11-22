/* File inventory.pl */
/* Menyimpan fakta dan aturan terkait inventory */


/* Menghitung jumlah item keseluruhan di dalam inventory */
countLength([], 0) :- !.

countLength([_|Tail], Ans) :-
    countLength(Tail, Ans1), Ans is Ans1 + 1, !.

/* Menambah item ke dalam inventory */
addItem(_,_) :-
    playerInventory(ListItem), countLength(ListItem, Length), Length =:= 100, 
    write('Inventory is full.'), !.

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
deleteItem(X, 1, [X|T], T) :- !.

deleteItem(X, 1, List, List) :- !.

deleteItem(X, N, [X|T1], T2) :- deleteItem(X, N1, T1, T2), N is N1-1.

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
        Found = false, !, write("Item not available!"), fail;
        
        Found = true,
        countItem(Item, ListInventory, Count),
        write('You have '), write(Count), write('. How many do you want to throw?'),nl,
        write('> '), read(Amount), nl,
        
        (
            Count < Amount, write('You don\'t have enough '), write(Item), write('. Cancelling...'), fail;

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
searchItem(X, [X|Tail], true) :- !.

searchItem(_, [], false) :- !.

searchItem(X, [Head|Tail], Found) :-
    searchItem(X, Tail, Found), !.

/* Menuliskan isi inventory */
writeInventory([]) :- !.

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