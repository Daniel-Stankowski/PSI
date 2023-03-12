:-dynamic komputer/5.
wykPrg:-
 write('1 - biezacy stan bazy danych'), nl,
 write('2 - dopisanie nowego komputera'), nl,
 write('3 - usuniecie komputera'), nl,
 write('4 - obliczenie sredniej ceny'), nl,
 write('5 - uzupelnienie bazy o dane zapisane w pliku'), nl,
 write('6 - zapisanie bazy w pliku'), nl,
 write('7 - wyszukaj komputera po nazwie procesora'), nl,
 write('8 - wyszukaj komputerow tanszych niz podana kwota'), nl,
 write('0 - koniec programu'), nl, nl,
 read(I),
 I > 0,
 opcja(I),
 wykPrg.
wykPrg.
opcja(1) :- wyswietl.
opcja(2) :- write('Podaj nazwe procesora:'), read(Proc_name),
 write('Podaj typ procesora:'), read(Proc_type), nl,
 write('Podaj czestotliwosc procesora:'), read(Proc_freq), nl,
 write('Podaj rozmiar dysku:'), read(Disk_size), nl,
 write('Podaj cene:'), read(Price), nl,
 assert(komputer(Proc_name, Proc_type, Proc_freq, Disk_size, Price)).
opcja(3) :- write('Podaj nazwe procesora usuwanego komputera:'), read(Proc_name),
 write('Podaj typ procesora usuwanego komputera:'), read(Proc_type),
 retract(komputer(Proc_name, Proc_type, _, _, _)),! ;
 write('Brak takiego komputera').
opcja(4) :- sredniaCena.
opcja(5) :- write('Podaj nazwe pliku:'), read(Nazwa),
 exists_file(Nazwa), !, consult(Nazwa);
 write('Brak pliku o podanej nazwie'), nl.
opcja(6) :- write('Podaj nazwe pliku:'), read(Nazwa),
 open(Nazwa, write, X), zapis(X), close(X).
opcja(7) :- write('Podaj nazwe procesora:'), read(Proc_name),
 findall([Proc_name, Proc_type, Proc_freq, Disk_size, Price], komputer(Proc_name, Proc_type, Proc_freq, Disk_size, Price), Lista),
 ileElementow(Lista, N),
 wypiszListe(Lista), write(N), write(" elementow"), nl.
opcja(8) :- write('Podaj cene maksymalna:'), read(Warunek),
 findall([Proc_name, Proc_type, Proc_freq, Disk_size, Price], komputer(Proc_name, Proc_type, Proc_freq, Disk_size, Price), Lista),
 wypiszListeJezeli(Lista, Warunek, N), write(N), write(" elementow"), nl.
opcja(_) :- write('Zly numer opcji'), nl.
wyswietl :- write('elementy bazy:'), nl,
 komputer(Proc_name, Proc_type, Proc_freq, Disk_size, Price),
 write(Proc_name), write(' '),
 write(Proc_type), write(' '),
 write(Proc_freq), write(' '),
 write(Disk_size), write(' '),
 write(Price), nl, fail.
wyswietl :- nl.
sredniaCena :- findall(Cena, komputer(_, _, _, _, Cena), Lista),
 suma(Lista, Suma, LiczbaKomputerow),
 SredniaCena is Suma / LiczbaKomputerow,
 write('Srednia cena:'), write(SredniaCena), nl, nl.
zapis(X) :- komputer(Proc_name, Proc_type, Proc_freq, Disk_size, Price),
 write(X, 'komputer('),
 write(X, Proc_name), write(X, ','),
 write(X, Proc_type), write(X, ','),
 write(X, Proc_freq), write(X, ','),
 write(X, Disk_size), write(X, ','),
 write(X, Price), write(X, ','),
 write(X, ').'), nl(X), fail.
zapis(_) :- nl.
suma([],0,0).
suma([G|Og], Suma, N) :- suma(Og, S1, N1),
 Suma is G + S1,
 N is N1+1.

ileElementow([],0).
ileElementow([G|Og], N) :- ileElementow(Og, N1),
 N is N1+1.

wypiszListe([]) :- nl.
wypiszListe([G|Og]) :- nth0(0, G, Proc_name),
 nth0(1, G, Proc_type),
 nth0(2, G, Proc_freq),
 nth0(3, G, Disk_size),
 nth0(4, G, Price),
 wypiszJeden(Proc_name, Proc_type, Proc_freq, Disk_size, Price),
 wypiszListe(Og).

wypiszListeJezeli([], _, 0).
wypiszListeJezeli([G|Og], Warunek, N) :-
 wypiszListeJezeli(Og, Warunek, N1),
 nth0(4, G, Price),
 (Price < Warunek ->
 nth0(0, G, Proc_name),
 nth0(1, G, Proc_type),
 nth0(2, G, Proc_freq),
 nth0(3, G, Disk_size),
 N is N1 + 1,
 wypiszJeden(Proc_name, Proc_type, Proc_freq, Disk_size, Price); N is N1, repeat).

wypiszJeden(Proc_name, Proc_type, Proc_freq, Disk_size, Price):-
 write(Proc_name), write(' '),
 write(Proc_type), write(' '),
 write(Proc_freq), write(' '),
 write(Disk_size), write(' '),
 write(Price), nl.

 komputer(es,sa,1,2,15).
 komputer(es,sa,1,2,13).
 komputer(es,sa,1,2,14).
 komputer(es,sa,1,2,12).
 komputer(es,sa,1,2,9).
 komputer(es,sa,1,2,10).
 komputer(es,sa,1,2,11).
 komputer(es,sa,1,2,18).
