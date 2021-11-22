/* File fishing.pl */
/* Menyimpan mekanisme fishing */

% 8. Fishing
% Fakta:
% - Durasi waktu aktivitas fishing.
% Rule:
% - Hanya bisa fishing di dekat danau/tile air
% - Tambah exp fishing dan total setelah memancing (dapat maupun tidak dapat ikan).
% - Ikan yang didapat bergantung pada level equipment dan level fishing.
% - Makin besar level, makin mahal ikan.
% - Stats equipment berpengaruh terhadap waktu memancing (stats bagus maka waktu mancing
% sebentar)

/* Daftar Ikan, Ukuran, EXP, dan Harga Jual */
ikan('Tuna',1,10,100).
ikan('Salmon',2,20,200).
ikan('Piranha',3,30,300).
ikan('Arwana',4,40,400).
ikan('Mujair',5,50,500).
ikan('Green Arwana',6,60,600).
ikan('Dorado',7,70,700).
ikan('Hiu',8,80,800).
ikan('Goldfish',9,90,900).

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
    isAround,
    random(1,101,FishingChance),
    0 is mod(FishingChance,2),
    fishing_equip(EquipLevel),
    level_fishing(FishingLevel),
    (
        EquipLevel > 0,
        EquipLevel < 4,
        FishingLevel > 0,
        FishingLevel < 4 ->
        random(1,4,Rarity),!;

        EquipLevel > 3,
        EquipLevel < 7,
        FishingLevel > 3,
        FishingLevel < 7 ->
        random(4,7,Rarity),!;

        EquipLevel > 7,
        EquipLevel < 10,
        FishingLevel > 7, 
        FishingLevel < 10 ->
        random(7,10,Rarity),!),
    % writeln(Rarity),!,
    ikan(FishName,Rarity,FishingExp,_Gold),
    addItem(1,FishName),
    write('You got '),
    write(FishName),
    writeln('!'),!,
    
    % writeln(FishingExp),!,
    exp_fishing(CurrentExp),
    NewExp is CurrentExp+FishingExp,
    write('You gained '),
    write(FishingExp),
    writeln(' fishing exp!'),
    retract(exp_fishing(_)),
    asserta(exp_fishing(NewExp)),
    write('Your new exp is '),
    writeln(NewExp),!.

fish :- 
    isAround, 
    writeln('You didnt get anything!'),!.

fish :-
    write('Youre not around the lake. Use map. to see where you are right now'),!.