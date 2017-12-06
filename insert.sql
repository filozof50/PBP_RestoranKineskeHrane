use KineskiRestoran;

insert into Vlasnik (jmbg, ime, prezime, datumRodjenja, webStrana, email, brojTelefona, brojRestorana)
values ('1810986294883', 'Bratislav', 'Stojevic', '1986-10-18', NULL, 'braca@gmail.com', '0641712707', 1);

insert into Restoran (sifraRestorana, imeRestorana, mesto, ulica, brojUlice, radnoVremeRadnimDanima,
                      radnoVremeVikendom, brojRazlicitihJelaKojaSeSpremaju, procenatPopustaZaSpecijalnePrilike,
                      brojZaposlenih, ukupanIznosPlataZaposlenih, ukupnaCenaGorivaZaSveRaznosace, jmbgVlasnika)
values (12345, 'Mr. Chaos', 'Beograd', 'Bulevar Oslobodjenja', '43', '08-20', '10-18', default, 30, default,
        default, default, '1810986294883');

insert into Radnik (sifraRadnika, ime, prezime, plata, datumRodjenja, email, brojTelefona,
                    brojRestoranaUKojimaJeRadio, adresa, sifraRestorana, daLiRadnikImaDece)
values (1, 'Chu Won', 'Chin', 1000, '1989-07-12', 'chuWon@gmail.com', '0649283374', 3,
        'Milutina Milankovica 34', 12345, 1),
       (2, 'Ho Lee', 'Fuk', 1300, '1983-04-12', 'Lee@gmail.com', '0655883374', 1,
        'Gospodara Vucica 34', 12345, 0),
       (3, 'Bang Ding', 'Ow', 2700, '1973-10-12', 'Ding@gmail.com', '0615876374', 9,
        'Resavska 14', 12345, 1),
       (4, 'Jovana', 'Ivanovic', 4700, '1988-10-12', 'Joka@gmail.com', '0613824974', 4,
        'Ustanicka 14', 12345, 0),
       (5, 'Dusan', 'Garabinovic', 500, '1995-7-12', 'Ducman@gmail.com', '0657784591', 0,
        'Bulevar Revolucije 10', 12345, 0);

insert into Kuvar (sifraRadnika, zavrsenaSkola, godineIskustvaUSpremanjuKineskeHrane, godineIskustvaUPoslu)
values (1, 'Visa kuvarska', 5, 5), (2, 'Visa kuvarska', 8, 8), (3, 'Visa kuvarska', 18, 18);

insert into Prodavac (sifraRadnika)
values (4);

insert into Reon (idReona, imeReona, vaznostReona)
values (4, 'Banovo Brdo', 3);

insert into Raznosac (sifraRadnika, idReona, modelAutomobila, potrosnjaAutomobila,
                      cenaGorivaZaAutomobil, cenaGorivaNaMesecnomNivou)
values (5, 4, 'Golf 4', 7, 143, 3087);

insert into Jelo (sifraJela, imeJela, brojKuvaraKojiUmejuDaSpremeJelo, cenaJela, sifraRestorana)
values (1234, 'Teletina u kari sosu', 2, 430, 12345), (1324, 'Piletina u kari sosu', 2, 530, 12345),
       (1243, 'Svinjetina u kari sosu', 3, 480, 12345);

insert into KuvarSpremaJelo (sifraRadnika, sifraJela)
values (1,1234), (2,1234), (1,1324), (2,1324), (1,1243), (2,1243), (3,1243);

insert into Specijalitet (sifraSpecijaliteta, sifraRadnika, imeSpecijaliteta, cenaSpecijaliteta)
values (4321, 1, 'Secuan piletina', 700), (3421, 3, 'Bongo teletina', 800), (4231, 2, 'Kombo svinjetina', 750);

insert into Sastojak (sifraSastojka, imeSastojka, brojJelaUkojaIde, cenaNaTrzistu)
values (1111, 'teletina', default, 300), (2222, 'piletina', default, 400), (3333, 'svinjetina', default, 500);

insert into SastojakIdeUJelo (sifraSastojka, sifraJela)
values (1111, 1234), (2222, 1324), (3333, 1243);

insert into ZamenaSastojkaDrugimSastojkom (sifraSastojka1, sifraSastojka2, kolicinaSastojka1, kolicinaSastojka2)
values (1111, 3333, 100, 100);

insert into Zacin (sifraZacina, imeZacina, cenaZacina)
values (9999, 'kari', 100), (8888, 'so', 50);

insert into ZacinIdeUJelo (sifraZacina, sifraJela)
values (9999, 1234), (9999, 1243), (9999, 1324), (8888, 1234), (8888, 1243), (8888, 1324);

insert into KineskiZacin (sifraZacina)
values (9999);

insert into ObicanZacin (sifraZacina)
values (8888);
