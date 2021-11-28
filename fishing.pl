/* File fishing.pl */
/* Menyimpan mekanisme fishing */
% :- include('quest.pl').
% :- include('inventory.pl'). 
% :- include('status.pl'). 
% :- include('player.pl').

:- dynamic(expUpFishing/2).
:- dynamic(expUpFishingRod/2).
expUpFishing(1,100).
expUpFishingRod(1,100).

% initFishing :-
%     write('init sukses'),
%     asserta(exp_fishing(1)),
%     asserta(level_fishing(1)),
%     asserta(level_fishing_rod(1)),
%     addItem(1,'Level 1 Fishing Rod').

levelUpFishing :- 
    exp_fishing(CurFishExp),
    expUpFishing(L,X),
    (
        CurFishExp < X, !, fail;

        CurFishExp >= X,
        NewCurFishExp is CurFishExp - X,
        assertz(exp_fishing(NewCurFishExp)),
        retract(exp_fishing(CurFishExp)),
        level_up_fishing,
        NewLvl is L + 1,
        NewExp is X * 2, /* Exp bounds */
        assertz(expUpFishing(NewLvl,NewExp)),
        retract(expUpFishing(L,X)),
        write('Selamat! Level fishing naik dari '),
        write(L),
        write(' menjadi '),
        write(NewLvl),nl
        
    ).

levelUpFishingRod :- 
    exp_fishing_rod(CurFishExp),
    expUpFishingRod(L,X),
    (
        CurFishExp < X, !, fail;

        CurFishExp >= X,
        NewCurFishExp is CurFishExp - X,
        assertz(exp_fishing_rod(NewCurFishExp)),
        retract(exp_fishing_rod(CurFishExp)),
        level_up_fishing_rod,
        NewLvl is L + 1,
        NewExp is X + 100, /* Exp bounds */
        assertz(expUpFishingRod(NewLvl,NewExp)),
        retract(expUpFishingRod(L,X)),
        write('Selamat! Level fishing rod naik dari '),
        write(L),
        write(' menjadi '),
        write(NewLvl),nl
        
    ).

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
    isQuestStart(true),
    random(1,101,FishingChance),
    0 =:= mod(FishingChance,2),
    level_fishing_rod(EquipLevel),
    level_fishing(FishingLevel),
    (
        EquipLevel > 0,
        EquipLevel < 4 ->
        random(1,4,Rarity),!;
        
        EquipLevel > 3,
        EquipLevel < 7 ->
        random(4,7,Rarity),!;
        
        EquipLevel > 7,
        EquipLevel < 10 ->
        random(7,10,Rarity),!
    ),
        nl,write(Rarity),nl,!,
        ikan(FishName,Rarity,FishingExp,FishGold),
        write('You got '),
        write(FishName),
        write('!'),nl,!,
        addItem(1,FishName),
        fishingDone(1),
        
        retract(gold(CurGold)),
        NewGold is CurGold+FishGold+(50*FishingLevel),
        assertz(gold(NewGold)),

        exp_total(TotalExp),
        retract(exp_total(TotalExp)),
        NewExpTotal is TotalExp+FishingExp,

        assertz(exp_total(NewExpTotal)),
        exp_fishing(CurrentExp),
        NewExp is CurrentExp+FishingExp,

        write('You gained '),
        write(FishingExp),
        write(' fishing exp!'),nl,
        retract(exp_fishing(_)),
        asserta(exp_fishing(NewExp)),
        write('Your new exp is '),
        write(NewExp),nl,!,nl,

        exp_fishing_rod(ExpRod),
        specialty(Job),
        ( Job = 'Fisherman' -> NewExpRod is ExpRod+FishingExp+50, write('Fisherman mendapat tambahan exp!'); NewExpRod is ExpRod+FishingExp, write('Bukan fisherman!')),
        retract(exp_fishing_rod(_)),
        asserta(exp_fishing_rod(NewExpRod)),

        exp_fishing(ExpFish),
        level_fishing(LvlFishing),
        level_fishing_rod(LvlFishingRod),nl,
        write('exp_fishing_rod: '),write(ExpRod),nl,!,
        write('exp_fishing: '),write(ExpFish),nl,!,
        write('exp total: '),write(NewExpTotal),nl,!,
        write('level_fishing: '),write(LvlFishing),nl,!,
        write('level_fishing_rod: '),write(LvlFishingRod),nl,!,
        levelUpFishing,
        levelUpFishingRod,
        level_up_player,
        incrementNTime(10), decStamina(3), updateStamina,showTime,
        ifGoal.
    
fish :- 
    isAround, 
    isQuestStart(true),
    retract(exp_total(ExpTotal)),
    NewExpTotal is ExpTotal+5,
    assertz(exp_total(NewExpTotal)),
    retract(exp_fishing(CurrentExp)),
    NewExp is CurrentExp+5,
    assertz(exp_fishing(NewExp)),
    write('You didnt get anything!'),nl,!,
    exp_fishing(ExpFish),
    level_fishing(LvlFishing),
    level_fishing_rod(LvlFishingRod),
    write('exp_fishing: '),write(ExpFish),nl,!,
    write('exp total: '),write(NewExpTotal),nl,!,
    write('level_fishing: '),write(LvlFishing),nl,!,
    write('level_fishing_rod: '),write(LvlFishingRod),nl,!,
    levelUpFishing,
    levelUpFishingRod,
    level_up_player,
    incrementNTime(10), decStamina(3), updateStamina,showTime,
    ifGoal.

fish :- 
    isAround,
    isQuestStart(false), 
    write('You must start the quest first!'),nl,!.

fish :-
    write('Youre not around the lake. Use map. to see where you are right now'),!.