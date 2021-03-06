use KineskiRestoran;

delimiter @

drop trigger if exists azurirajBrojJela@

create trigger azurirajBrojJela after insert on Jelo
for each row
begin
  declare jela integer;
  set jela = (select brojRazlicitihJelaKojaSeSpremaju from Restoran);

  update Restoran set brojRazlicitihJelaKojaSeSpremaju = (jela + 1);
end@


drop trigger if exists smanjiBrojJela@

create trigger smanjiBrojJela after delete on Jelo
for each row
begin
  declare jela integer;
  set jela = (select brojRazlicitihJelaKojaSeSpremaju from Restoran);

  update Restoran set brojRazlicitihJelaKojaSeSpremaju = (jela - 1);
end@


drop trigger if exists azurirajUkupnePlate@

create trigger azurirajUkupnePlate after insert on Radnik
for each row
begin
  declare plate integer;
  set plate = (select ukupanIznosPlataZaposlenih from Restoran);

  update Restoran set ukupanIznosPlataZaposlenih = (plate + new.plata);
end@


drop trigger if exists smanjiUkupnePlate@

create trigger smanjiUkupnePlate after delete on Radnik
for each row
begin
  declare plate integer;
  set plate = (select ukupanIznosPlataZaposlenih from Restoran);

  update Restoran set ukupanIznosPlataZaposlenih = (plate - old.plata);
end@


drop trigger if exists azurirajPlate@

create trigger azurirajPlate after update on Radnik
for each row
begin
  declare plate integer;
  set plate = (select ukupanIznosPlataZaposlenih from Restoran);

  if (new.plata < old.plata) then
    update Restoran set ukupanIznosPlataZaposlenih = (plate - old.plata + new.plata);
  else
    update Restoran set ukupanIznosPlataZaposlenih = (plate + new.plata - old.plata);
  end if;
end@


drop trigger if exists azurirajUkupnuCenuGoriva@

create trigger azurirajUkupnuCenuGoriva after insert on Raznosac
for each row
begin
  declare gorivo integer;
  set gorivo = (select ukupnaCenaGorivaZaSveRaznosace from Restoran);

  update Restoran set ukupnaCenaGorivaZaSveRaznosace = (gorivo + new.cenaGorivaNaMesecnomNivou);
end@


drop trigger if exists smanjiUkupnuCenuGoriva@

create trigger smanjiUkupnuCenuGoriva after delete on Raznosac
for each row
begin
  declare gorivo integer;
  set gorivo = (select ukupnaCenaGorivaZaSveRaznosace from Restoran);

  update Restoran set ukupnaCenaGorivaZaSveRaznosace = (gorivo - old.cenaGorivaNaMesecnomNivou);
end@


drop trigger if exists azurirajBrojZaposlenih@

create trigger azurirajBrojZaposlenih after insert on Radnik
for each row
begin
  declare zaposleni integer;
  set zaposleni = (select brojZaposlenih from Restoran);

  update Restoran set brojZaposlenih = (zaposleni + 1);
end@


drop trigger if exists smanjiBrojZaposlenih@

create trigger smanjiBrojZaposlenih after delete on Radnik
for each row
begin
  declare zaposleni integer;
  set zaposleni = (select brojZaposlenih from Restoran);

  update Restoran set brojZaposlenih = (zaposleni - 1);
end@


drop trigger if exists azurirajBrojKuvara@

create trigger azurirajBrojKuvara after insert on KuvarSpremaJelo
for each row
begin
  declare kuvari integer;
  set kuvari = (select brojKuvaraKojiUmejuDaSpremeJelo from Jelo where sifraJela = new.sifraJela);

  update Jelo set brojKuvaraKojiUmejuDaSpremeJelo = (kuvari + 1) where sifraJela = new.sifraJela;
end@


drop trigger if exists smanjiBrojKuvara@

create trigger smanjiBrojKuvara after delete on KuvarSpremaJelo
for each row
begin
  declare kuvari integer;
  set kuvari = (select brojKuvaraKojiUmejuDaSpremeJelo from Jelo where sifraJela = old.sifraJela);

  update Jelo set brojKuvaraKojiUmejuDaSpremeJelo = (kuvari - 1) where sifraJela = old.sifraJela;
end@


drop trigger if exists azurirajBrojJela@

create trigger azurirajBrojJela after insert on SastojakIdeUJelo
for each row
begin
  declare jela integer;
  set jela = (select brojJelaUkojaIde from Sastojak where sifraSastojka = new.sifraSastojka);

  update Sastojak set brojJelaUkojaIde = (jela + 1) where sifraSastojka = new.sifraSastojka;
end@


drop trigger if exists smanjiBrojJela@

create trigger smanjiBrojJela after delete on SastojakIdeUJelo
for each row
begin
  declare jela integer;
  set jela = (select brojJelaUkojaIde from Sastojak where sifraSastojka = old.sifraSastojka);

  update Sastojak set brojJelaUkojaIde = (jela - 1) where sifraSastojka = old.sifraSastojka;
end@


drop trigger if exists obrisiSpecijalitet@

create trigger obrisiSpecijalitet after delete on Kuvar
for each row
begin
  delete from Specijalitet where sifraRadnika = old.sifraRadnika;
end@

drop trigger if exists obrisiKuvara@

create trigger obrisiKuvara after delete on Kuvar
for each row
begin
  delete from Radnik where sifraRadnika = old.sifraRadnika;
end@

drop trigger if exists obrisiRaznosaca@

create trigger obrisiRaznosaca after delete on Raznosac
for each row
begin
  delete from Radnik where sifraRadnika = old.sifraRadnika;
end@

drop trigger if exists obrisiProdavca@

create trigger obrisiProdavca after delete on Prodavac
for each row
begin
  delete from Radnik where sifraRadnika = old.sifraRadnika;
end@

drop trigger if exists obrisiKineski@

create trigger obrisiKineski after delete on KineskiZacin
for each row
begin
  delete from Zacin where sifraZacina = old.sifraZacina;
end@

drop trigger if exists obrisiObican@

create trigger obrisiObican after delete on ObicanZacin
for each row
begin
  delete from Zacin where sifraZacina = old.sifraZacina;
end@


drop trigger if exists IzracunajCenuGoriva@

create trigger IzracunajCenuGoriva before insert on Raznosac
for each row
begin
  declare reon integer;
  set reon = (select vaznostReona from Reon where idReona = new.idReona);
  set new.cenaGorivaNaMesecnomNivou = new.cenaGorivaZaAutomobil * reon * new.potrosnjaAutomobila;
end;
