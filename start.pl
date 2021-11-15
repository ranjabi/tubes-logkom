/* File: start.pl */
/* Untuk inisialisasi keadaan awal player dan memulai new game */

:- dynamic(isStart/1).
:- dynamic(player_role/1).

isStart(false).

% Implementasi rule-rule kendali dasar

/* tipe job */
job_type(fisherman).
job_type(farmer).
job_type(rancher).

/* command startgame */
command_startgame :- 
    write_ln(' _   _                           _   '),
    write_ln('| | | | __ _ _ ____   _____  ___| |_ '),
    write_ln('| |_| |/ _` | '__\ \ / / _ \/ __| __|'),
    write_ln('|  _  | (_| | |   \ V /  __/\__ \ |_ '),
    write_ln('|_| |_|\__,_|_|    \_/ \___||___/\__|'),
    write_ln('Harvest Star!!!),
    write_ln('Let's play and pay our debts together!'),
    write_ln('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),
    write_ln('%                              ~Harvest Star~         %'),
    write_ln('% 1. start  : untuk memulai petualanganmu             %'),
    write_ln('% 2. map    : menampilkan peta                        %'),
    write_ln('% 3. status : menampilkan kondisimu terkini           %'),
    write_ln('% 4. w      : gerak ke utara 1 langkah                %'),
    write_ln('% 5. s      : gerak ke selatan 1 langkah              %'),
    write_ln('% 6. d      : gerak ke ke timur 1 langkah             %'),
    write_ln('% 7. a      : gerak ke barat 1 langkah                %'),
    write_ln('% 8. help   : menampilkan segala bantuan              %'),
    write_ln('% (status seharusnya hanya ada 1)                     %'),
    write_ln('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%').

command_start :- 
    write_ln('Welcome to Harvest Star. Choose your job'),
    write_ln('1. Fisherman'),
    write_ln('2. Farmer'),
    write_ln('3. Rancher'), read(player_job), write('Hello'), tab(1), write(player_job).

choose_job(X) :- job_type, job(X,fisherman,farmer,rancher).


command_help:- write_ln('
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %                              ~Harvest Star~                                  %
   % 1. start  : untuk memulai petualanganmu                                      %
   % 2. map    : menampilkan peta                                                 %
   % 3. status : menampilkan kondisimu terkini                                    %
   % 4. w      : gerak ke utara 1 langkah                                         %
   % 5. s      : gerak ke selatan 1 langkah                                       %
   % 6. d      : gerak ke ke timur 1 langkah                                      %
   % 7. a      : gerak ke barat 1 langkah                                         %
   % 8. help   : menampilkan segala bantuan                                       %
   % (status seharusnya hanya ada 1)                                              %
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ').