drop database if exists KineskiRestoran;

create database KineskiRestoran;

use KineskiRestoran;

create table if not exists Vlasnik (
  jmbg varchar(13) not null primary key,
  ime varchar(45) not null,
  prezime varchar(45) not null,
  datumRodjenja date not null,
  webStrana varchar(45),
  email varchar(45) not null,
  brojTelefona varchar(10) not null,
  brojRestorana int not null
);

create table if not exists Restoran (
  sifraRestorana int not null primary key,
  imeRestorana varchar(45) not null,
  mesto varchar(45) not null,
  ulica varchar(45) not null,
  brojUlice int not null,
  radnoVremeRadnimDanima varchar(10) not null,
  radnoVremeVikendom varchar(10) not null,
  brojRazlicitihJelaKojaSeSpremaju int not null default 0,
  procenatPopustaZaSpecijalnePrilike int not null,
  brojZaposlenih int not null default 0,
  ukupanIznosPlataZaposlenih int not null default 0,
  ukupnaCenaGorivaZaSveRaznosace int not null default 0,
  jmbgVlasnika varchar(13) not null,
  foreign key (jmbgVlasnika) references Vlasnik (jmbg) on delete cascade on update cascade
);

create table if not exists Radnik (
  sifraRadnika int not null primary key,
  ime varchar(45) not null,
  prezime varchar(45) not null,
  plata int not null,
  datumRodjenja DATE not null,
  email varchar(45) not null,
  brojTelefona varchar(10) not null,
  brojRestoranaUKojimaJeRadio int not null,
  adresa varchar(45) not null,
  sifraRestorana int not null,
  daLiRadnikImaDece tinyint(1) not null,
  foreign key (sifraRestorana) references Restoran (sifraRestorana) on delete cascade on update cascade
);

create table if not exists Prodavac (
  sifraRadnika int not null primary key,
  foreign key (sifraRadnika) references Radnik (sifraRadnika) on delete cascade on update cascade
);

create table if not exists Reon(
  idReona int primary key not null,
  imeReona varchar(45) not null,
  vaznostReona int not null
);

create table if not exists Raznosac (
  sifraRadnika int not null primary key,
  idReona int not null,
  modelAutomobila varchar(45) not null,
  potrosnjaAutomobila int not null,
  cenaGorivaZaAutomobil int not null,
  cenaGorivaNaMesecnomNivou int not null,
  foreign key (sifraRadnika) references Radnik (sifraRadnika) on delete cascade on update cascade,
  foreign key (idReona) references Reon (idReona) on delete cascade on update cascade
);

-- alter table Raznosac set cenaGorivaNaMesecnomNivou = cenaGorivaZaAutomobil * potrosnjaAutomobila * reon;

create table if not exists Kuvar (
  sifraRadnika int not null primary key,
  zavrsenaSkola varchar(45) not null,
  godineIskustvaUSpremanjuKineskeHrane int not null,
  godineIskustvaUPoslu int not null,
  foreign key (sifraRadnika) references Radnik (sifraRadnika) on delete cascade on update cascade
);

create table if not exists Jelo (
  sifraJela int not null primary key,
  imeJela varchar(45) not null,
  brojKuvaraKojiUmejuDaSpremeJelo int not null default 0,
  cenaJela int not null,
  sifraRestorana int not null,
  foreign key (sifraRestorana) references Restoran (sifraRestorana) on delete cascade on update cascade
);

create table if not exists KuvarSpremaJelo(
  sifraRadnika int not null,
  sifraJela int not null,
  primary key (sifraRadnika,sifraJela),
  foreign key (sifraRadnika) references Kuvar (sifraRadnika) on delete cascade on update cascade,
  foreign key (sifraJela) references Jelo (sifraJela) on delete cascade on update cascade
);

create table if not exists Specijalitet (
  sifraSpecijaliteta int not null,
  sifraRadnika int not null,
  imeSpecijaliteta varchar(45) not null,
  cenaSpecijaliteta int not null,
  primary key (sifraSpecijaliteta, sifraRadnika),
  foreign key (sifraRadnika) references Kuvar (sifraRadnika) on delete cascade on update cascade
);

create table if not exists Sastojak (
  sifraSastojka int not null primary key,
  imeSastojka varchar(45) not null,
  brojJelaUkojaIde int not null default 0,
  cenaNaTrzistu int not null
);

create table if not exists SastojakIdeUJelo (
  sifraSastojka int not null,
  sifraJela int not null,
  primary key (sifraSastojka, sifraJela),
  foreign key (sifraSastojka) references Sastojak (sifraSastojka) on delete cascade on update cascade,
  foreign key (sifraJela) references Jelo (sifraJela) on delete cascade on update cascade
);

create table if not exists ZamenaSastojkaDrugimSastojkom (
  sifraSastojka1 int not null,
  sifraSastojka2 int not null,
  kolicinaSastojka1 int not null,
  kolicinaSastojka2 int not null,
  primary key (sifraSastojka1, sifraSastojka2),
  foreign key (sifraSastojka1) references Sastojak (sifraSastojka) on delete cascade on update cascade,
  foreign key (sifraSastojka2) references Sastojak (sifraSastojka) on delete cascade on update cascade
);

create table if not exists Zacin (
  sifraZacina int not null primary key,
  imeZacina varchar (45) not null,
  cenaZacina int not null
);

create table if not exists ZacinIdeUJelo (
  sifraZacina int not null,
  sifraJela int not null,
  primary key (sifraZacina, sifraJela),
  foreign key (sifraZacina) references Zacin (sifraZacina) on delete cascade on update cascade,
  foreign key (sifraJela) references Jelo (sifraJela) on delete cascade on update cascade
);

create table if not exists KineskiZacin (
  sifraZacina int not null primary key,
  foreign key (sifraZacina)  references Zacin (sifraZacina) on delete cascade on update cascade
);

create table if not exists ObicanZacin (
  sifraZacina int not null primary key,
  foreign key (sifraZacina)  references Zacin (sifraZacina) on delete cascade on update cascade
);
