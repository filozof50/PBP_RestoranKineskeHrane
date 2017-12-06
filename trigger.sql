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

  update Jelo set brojKuvaraKojiUmejuDaSpremeJelo = (kuvari + 1);
end@


drop trigger if exists smanjiBrojKuvara@

create trigger smanjiBrojKuvara after delete on KuvarSpremaJelo
for each row
begin
  declare kuvari integer;
  set kuvari = (select brojKuvaraKojiUmejuDaSpremeJelo from Jelo where sifraJela = old.sifraJela);

  update Jelo set brojKuvaraKojiUmejuDaSpremeJelo = (kuvari - 1);
end@

drop trigger if exists azurirajBrojJela@

create trigger azurirajBrojJela after insert on SastojakIdeUJelo
for each row
begin
  declare jela integer;
  set jela = (select brojJelaUkojaIde from Sastojak where sifraSastojka = new.sifraSastojka);

  update Sastojak set brojJelaUkojaIde = (jela + 1);
end@


drop trigger if exists smanjiBrojJela@

create trigger smanjiBrojJela after delete on SastojakIdeUJelo
for each row
begin
  declare jela integer;
  set jela = (select brojJelaUkojaIde from Sastojak where sifraSastojka = old.sifraSastojka);

  update Sastojak set brojJelaUkojaIde = (jela - 1);
end@


drop trigger if exists obrisiSpecijalitet@

create trigger obrisiSpecijalitet after delete on Kuvar
for each row
begin
  delete from Specijalitet where sifraRadnika = old.sifraRadnika;
end@
