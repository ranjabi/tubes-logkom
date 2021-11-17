/* File fishing.pl */
/* Menyimpan mekanisme fishing */

isAround :- 
    map_object(X,Y,'P'), 
    PrevX is X-1,
    NextX is X+1,
    PrevY is Y-1,
    NextY is Y+1,
    (
        map_object(PrevX,PrevY,'o'); map_object(X,PrevY,'o'); map_object(NextX,PrevY,'o');
        map_object(PrevX,Y,'o'); map_object(NextX,Y,'o');
        map_object(PrevX,NextY,'o'); map_object(X,NextY,'o'); map_object(NextX,NextY,'o')
    ).

fish :-
    isAround, !,
    write('You got Tuna!'),nl,
    write('You gained 10 fishing exp!').

fish :-
    write('You\'re not around the lake. Use \'map.\' to see where you are right now').