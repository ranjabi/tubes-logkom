/* File start.pl */
/* Inisialisasi awal game */

:- dynamic(isStart/1).
:- dynamic(specialty/1).
isStart(false).

startGame :-

    
    write(' .sSs. .sSs.                                                                         '),nl,
    write(' SSSSS SSSSS .sSSSSs.    .sSSSSSSSs. .sSs. .sSs. .sSSSSs.    .sSSSSs.    .sSs.       '),nl,
    write(' S SSS SSSSS S SSSSSSSs. S SSS SSSSS S SSS SSSSS S SSSSSSSs. S SSSSSSSs. S SSS       '),nl,
    write(' S  SS SSSSS S  SS SSSSS S  SS SSSS  S  SS SSSSS S  SS SSSS  S  SS SSSS  S  SS       '),nl,
    write(' S..SS SSSSS S..SS SSSSS S..SSsSSSa. S..SS SSSSS S..SS       S..SS       S..SS       '),nl,
    write(' S:::SSSSSSS S:::SSSSSSS S:::S SSSSS S:::S sSSS  S:::SSSS    S:::SSSSs   S:::SSSS    '),nl,
    write(' S;;;S SSSSS S;;;S SSSSS S;;;S SSSSS S;;;S sSS   S;;;S            .SSSS. S;;;S       '),nl,
    write(' S%%%S SSSSS S%%%S SSSSS S%%%S SSSSS S%%%SSSS    S%%%S SSSSS S%%%S SSSSS S%%%S SSSSS '),nl,
    write(' SSSSS SSSSS SSSSS SSSSS SSSSS SSSSS SSSSS;:     SSSSSsSS;:  SSSSSsSS;:  SSSSSsSS;:  '),nl,nl,

    write(' .sSSSSs.                                                                            '),nl,
    write(' SSSSSSSSs   .sSs.       .sSSSSs.    .sSSSSSSSs.        *         *          *       '),nl,
    write(' S SSS SSSS  S SSS       S SSSSSSSs. S SSS SSSSS                 ***                 '),nl,
    write(' S  SS       S  SS       S  SS SSSSS S  SS SSSS           *  ***********             '),nl,
    write(' S..SS       S..SS       S..SS SSSSS S..SSsSSSa.     *        *********        *     '),nl,
    write(' S:::SSSSs   S:::SSSS    S:::SSSSSSS S:::S SSSSS               *******               '),nl,
    write('      .SSSS. S;;;S       S;;;S SSSSS S;;;S SSSSS               *** ***      *        '),nl,
    write(' S%%%S SSSSs S%%%S SSSSS S%%%S SSSSS S%%%S SSSSS       *      **     **              '),nl,
    write(' SSSSSsSS;:  SSSSSsSS;:  SSSSS SSSSS SSSSS SSSSS                                     '),nl,nl,

    write(' Harvest Star!!!'),nl,nl,

    write(' Let\'s play and pay our debts together!'),nl,nl,

    write(' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,
    write(' %                              ~Harvest Star~                                  %'),nl,
    write(' % 1. start  : untuk memulai petualanganmu                                      %'),nl,
    write(' % 2. map    : menampilkan peta                                                 %'),nl,
    write(' % 3. status : menampilkan kondisimu terkini                                    %'),nl,
    write(' % 4. w      : gerak ke utara 1 langkah                                         %'),nl,
    write(' % 5. s      : gerak ke selatan 1 langkah                                       %'),nl,
    write(' % 6. d      : gerak ke ke timur 1 langkah                                      %'),nl,
    write(' % 7. a      : gerak ke barat 1 langkah                                         %'),nl,
    write(' % 8. help   : menampilkan segala bantuan                                       %'),nl,
    write(' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl.

input_job(X) :-
    repeat,
    write('> '), read(X),
    (X = 1; X = 2; X = 3).

start :-
    retract(isStart(false)), !,
    asserta(isStart(true)),
    write('Welcome to Harvest Star. Choose your job'),nl,
    write('1. Fisherman'),nl,
    write('2. Farmer'),nl,
    write('3. Rancher'),nl,
    input_job(Job),nl,
    
    (   Job=1,
        assertz(specialty('Fisherman'));
        Job=2,
        assertz(specialty('Farmer'));
        Job=3,
        assertz(specialty('Rancher'))
    ),

    specialty(X),
    write('You choose '), write(X), write(', let\'s start farming!'),

    % Inisialisasi Pemain
    assertz(level_fishing(1)),
    assertz(level_farming(1)),
    assertz(level_ranching(1)),
    assertz(level_player(1)),
    assertz(exp_fishing(0)),
    assertz(exp_farming(0)),
    assertz(exp_ranching(0)),
    assertz(exp_total(0)),
    assertz(gold(1000)),
    assertz(playerInventory([])),

    % Inisialisasi Posisi Pemain dan Bangunan
    assertz(map_object(1, 1, 'P')),
    assertz(map_object(12, 10, 'M')),
    assertz(map_object(10, 5, 'R')),
    assertz(map_object(7, 6, 'H')),
    assertz(map_object(7, 3, 'Q')).

start :-
    write('The game has already been started. Use \'help.\' to see available commands!').

quit :- 
    isStart(true),
    write('Progress will not be saved after you quit.'),nl,
    write('Are you sure? (y/n): '),
    read(Param), !,
    ((Param = y -> halt);
    (Param = n -> fail)).
