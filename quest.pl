:- dynamic(questStatus/4).
:- dynamic(peningkatan/1).
:- dynamic(isQuestStart/1).

/* di start.pl harus startQuest dulu, jalanin manual aja ketik di terminal kalo belum dimasukin ke start.pl */
isQuestStart(false).
inProgressQuest :- questStatus(_,_,_,1). /* jika quest blom finish maka param ke 4 bernilai 1 */
isFinishQuest :- questStatus(0,0,0,0).

isQuestPos :- 
    isQuestPos .

finishQuest :- 
    questStatus(0,0,0,1),
    retractall(questStatus(_,_,_,_)),
    asserta(questStatus(0,0,0,0)).

quest :- 
    isStart(true),
    map_object(X, Y, 'P'),
    map_object(X,Y, 'Q'),
    retract(isQuestStart(_)),
    asserta(isQuestStart(true)),
    isFinishQuest, 
    write('You got a new quest!'),nl, 
    write('You need to collect'),
    /* ini dia bakal set batas atas dan bawah sesuai dynamic <peningkatan> */
    Down = 1,
    Up = 2,
    nl,write('Down '),write(Down),nl,write('Up '),write(Up),nl,
    peningkatan(Current),
    NewDown is Down * 2,
    NewUp is Up * 2,
    write(NewDown),nl,write(NewUp),nl,
    /* quest barunya di init */
    random(NewDown,NewUp,InitFishing),
    random(NewDown,NewUp,InitFarming),
    random(NewDown,NewUp,InitRanching),
    retractall(questStatus(_,_,_,_)),
    assertz(questStatus(InitFishing,InitFarming,InitRanching,1)), 
    % assertz(questStatus(InitFishing,InitFarming,InitRanching,1)), 
    questStatus(Fishing,Farming,Ranching,Status),
    write('- '), write(Fishing), write(' fish'), !, nl,
    write('- '), write(Farming), write(' farm item'), !, nl,
    write('- '), write(Ranching), write(' ranch item'), !, nl.

quest :- isStart(false), write('You need to start the game first!'), nl,fail.

quest :- 
    finishQuest,
    write('You have finished a quest. Congratulations!'),!,
    peningkatan(Current),
    retractall(peningkatan(Current)),
    /* setiap berhasil quest, maka peningkatan bertambah 2 */
    NewCurrent is Current+2,
    asserta(peningkatan(NewCurrent)),
    questStatus(Fishing,Farming,Ranching,Status),
    retractall(questStatus(Fishing,Farming,Ranching,Status)),

    retract(exp_total(ExpTotal)),
    NewExpTotal is ExpTotal+5000,
    assertz(exp_total(NewExpTotal)),
    retract(gold(Gold)),
    NewGold is Gold+4000,
    assertz(gold(NewGold)),
    write('You got '),write(NewExpTotal),write(' EXP and '),write(NewGold),write(' Gold'),nl,
    /* quest status direset lagi */
    asserta(questStatus(0,0,0,0)). 

quest :- 
    inProgressQuest,
    write('You have an on-going quest!'),nl,
    write('You need to collect'),nl,
    questStatus(Fishing,Farming,Ranching,Status),
    write('- '), write(Fishing), write(' fish'), !, nl,
    write('- '), write(Farming), write(' farm item'), !, nl,
    write('- '), write(Ranching), write(' ranch item'), !, nl.


quest :- write('You need to be on the tile Q to get the new quest!'),nl.


/* pake ini di farming/ranching kalian, X adalah banyak pengurangan quest (isi 1) setiap quest berhasil dijalankan, ada di line 78 fishing.pl buat contoh */
fishingDone(X) :- 
    questStatus(Fishing,Farming,Ranching,Status),
    retract(questStatus(Fishing,Farming,Ranching,Status)),
    (
        X >= Fishing,
        NewFishing is 0;
        X < Fishing,
        NewFishing is Fishing - X),
    asserta(questStatus(NewFishing,Farming,Ranching,Status)).