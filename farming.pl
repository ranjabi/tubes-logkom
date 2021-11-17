/* File farming.pl */
/* Menyimpan mekanisme farming */

dig :-
    map_object(X,Y,'P'),
    \+ (map_object(X,Y,'M'), map_object(X,Y,'R'), map_object(X,Y,'H'), map_object(X,Y,'Q')),
    assertz(map_object(X,Y,'=')),
    write('You digged the tile').

plant.

harvest.