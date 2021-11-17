/* File save.pl */
/* Perintah save file */

save :-
    write('Saving to savefile.dat...\n'),
    nl,
    open('savefile.dat',write,S),
    set_output(S),
    listing,
    close(S),
    write('Savefile successful!'),
    nl.