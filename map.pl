/* File map.pl */
/* Menyimpan ukuran peta, objek pada peta, dan perintah cetak peta */

:- dynamic(map_object/3).

/* map_size(X,Y) = X adalah lebar dan Y adalah tinggi */
map_size(14,14).

/* map_object(X, Y, Obj) = Object Obj di posisi (X,Y), X dihitung dari kiri, Y dihitung dari atas */
map_object(5, 8, 'o').
map_object(6, 8, 'o').
map_object(7, 8, 'o').
map_object(4, 9, 'o').
map_object(5, 9, 'o').
map_object(6, 9, 'o').
map_object(7, 9, 'o').
map_object(8, 9, 'o').
map_object(5, 10, 'o').
map_object(6, 10, 'o').
map_object(7, 10, 'o').

/* Perintah map untuk mencetak peta */
map :-
	isStart(true), !,
	draw_map.

map :- !,
	write('Game has not started, use \"start.\" to play the game"').

/* Mencetak tepi peta */
/* Tepi kanan */
draw_point(X, Y) :- map_size(W, H),
					X =:= W + 1,
					Y =< H + 1,
					write('#'), nl,
					NewY is Y+1,
					draw_point(0, NewY).
		
/* Tepi kiri */		
draw_point(X, Y) :- map_size(_, H),
					X =:= 0,
					Y =< H+1,
					write('#'),
					NewX is X+1,
					draw_point(NewX, Y).
				
/* Tepi atas */				
draw_point(X, Y) :- map_size(W, _),
					X < W + 1,
					X > 0,
					Y =:= 0,
					write('#'),
					NewX is X+1,
					draw_point(NewX, Y).
					
/* Tepi bawah */			
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y =:= H + 1,
					write('#'),
					NewX is X+1,
					draw_point(NewX, Y).					
				
/* Mencetak bagian dalam peta */
/* Jika pemain berada di lokasi spesial, maka simbol lokasi spesial akan tertimpa oleh simbol pemain */
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					map_object(X, Y, 'P'),
					map_object(X, Y, 'M'), !,
					write('P'),
					NewX is X+1,
					draw_point(NewX, Y).

draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					map_object(X, Y, 'P'),
					map_object(X, Y, 'R'), !,
					write('P'),
					NewX is X+1,
					draw_point(NewX, Y).

draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					map_object(X, Y, 'P'),
					map_object(X, Y, 'H'), !,
					write('P'),
					NewX is X+1,
					draw_point(NewX, Y).

draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					map_object(X, Y, 'P'),
					map_object(X, Y, 'Q'), !,
					write('P'),
					NewX is X+1,
					draw_point(NewX, Y).

draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					map_object(X, Y, 'P'),
					map_object(X, Y, '='), !,
					write('P'),
					NewX is X+1,
					draw_point(NewX, Y).

draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					map_object(X, Y, 'P'),
					map_object(X, Y, 'T'), !,
					write('P'),
					NewX is X+1,
					draw_point(NewX, Y).

draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					map_object(X, Y, 'P'),
					map_object(X, Y, 'c'), !,
					write('P'),
					NewX is X+1,
					draw_point(NewX, Y).

draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					map_object(X, Y, 'P'),
					map_object(X, Y, 'C'), !,
					write('P'),
					NewX is X+1,
					draw_point(NewX, Y).

draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					map_object(X, Y, 'P'),
					map_object(X, Y, 'O'), !,
					write('P'),
					NewX is X+1,
					draw_point(NewX, Y).

/* Mencetak objek yang tidak tertimpa simbol pemain */
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					map_object(X, Y, Obj), !,
					write(Obj),
					NewX is X+1,
					draw_point(NewX, Y).

/* Mencetak lokasi kosong */
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					(\+ map_object(X, Y, _)),
					write('-'),
					NewX is X+1,
					draw_point(NewX, Y).

/* Mencetak map secara rekursif mulai dari point (0,0) */
draw_map :- draw_point(0, 0).