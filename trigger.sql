use KineskiRestoran;

delimiter @

drop trigger if exists azurirajBrojJela@

create trigger azurirajBrojJela after insert on Jelo
for each row
begin
  update Restoran set brojRazlicitihJelaKojaSeSpremaju = ((select brojRazlicitihJelaKojaSeSpremaju
    from Restoran) + 1);
end@


drop trigger if exists smanjiBrojJela@

create trigger smanjiBrojJela after delete on Jelo
for each row
begin
  update Restoran set brojRazlicitihJelaKojaSeSpremaju = ((select brojRazlicitihJelaKojaSeSpremaju
    from Restoran) - 1);
end@


drop trigger if exists azurirajUkupnePlate@

create trigger azurirajUkupnePlate after insert on Radnik
for each row
begin
  update Restoran set ukupanIznosPlataZaposlenih = ((select ukupanIznosPlataZaposlenih
    from Restoran) + new.plata);
end@


drop trigger if exists smanjiUkupnePlate@

create trigger smanjiUkupnePlate after delete on Radnik
for each row
begin
  update Restoran set ukupanIznosPlataZaposlenih = ((select ukupanIznosPlataZaposlenih
    from Restoran) - old.plata);
end@


drop trigger if exists azurirajUkupnuCenuGoriva@

create trigger azurirajUkupnuCenuGoriva after insert on Raznosac
for each row
begin
  update Restoran set ukupanIznosPlataZaposlenih = ((select ukupnaCenaGorivaZaSveRaznosace
    from Restoran) + new.cenaGorivaNaMesecnomNivou);
end@


drop trigger if exists smanjiUkupnuCenuGoriva@

create trigger smanjiUkupnuCenuGoriva after delete on Raznosac
for each row
begin
  update Restoran set ukupanIznosPlataZaposlenih = ((select ukupnaCenaGorivaZaSveRaznosace
    from Restoran) + old.cenaGorivaNaMesecnomNivou);
end@


drop trigger if exists azurirajBrojZaposlenih@

create trigger azurirajBrojZaposlenih after insert on Radnik
for each row
begin
  update Restoran set brojZaposlenih = ((select brojZaposlenih
    from Restoran) + 1);
end@


drop trigger if exists smanjiBrojZaposlenih@

create trigger smanjiBrojZaposlenih after delete on Radnik
for each row
begin
  update Restoran set brojZaposlenih = ((select brojZaposlenih
    from Restoran) - 1);
end@


drop trigger if exists azurirajBrojKuvara@

create trigger azurirajBrojKuvara after insert on Kuvar
for each row
begin
  update Jelo set brojKuvaraKojiUmejuDaSpremeJelo = ((select brojKuvaraKojiUmejuDaSpremeJelo
    from Jelo) + 1);
end@


drop trigger if exists smanjiBrojKuvara@

create trigger smanjiBrojKuvara after delete on Kuvar
for each row
begin
  update Jelo set brojKuvaraKojiUmejuDaSpremeJelo = ((select brojKuvaraKojiUmejuDaSpremeJelo
    from Jelo) - 1);
end@


drop trigger if exists obrisiSpecijalitet@

create trigger obrisiSpecijalitet after delete on Kuvar
for each row
begin
  delete from Specijalitet where sifraRadnika = old.sifraRadnika;
end@
