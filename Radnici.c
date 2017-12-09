#include "Radnici.h"

int dodajRadnika (Sql *sql)
{
  // printf ("Statistika radnika pre upisa novog radnika:\n\n");
  // ispisiRadnike (sql);
  // ispisiRestoran(sql);

  printf ("Unesite redom:\nsifru radnika\nime\nprezime\nplatu\ndatum rodjenja\nemail adresu\
          \nbroj telefona\nbroj restorana u kojima je vec radio\nadresu\nsifru restorana\
          \npodatak o tome da li radnik ima dece (0 ili 1)\n");

  strcpy(sql->query,"");

  sprintf (sql->query, "insert into Radnik (sifraRadnika, ime, prezime, plata, datumRodjenja, email,\
  brojTelefona, brojRestoranaUKojimaJeRadio, adresa, sifraRestorana, daLiRadnikImaDece) values(");

  char *s, pom[50];
  int sifra;
  for (int i=0;i<11;i++) {
    scanf ("%ms", &s);
    if (i == 0)
      sifra = (int)strtol(s,NULL,10);

    if (i == 1 || i == 2 || i == 4 || i == 5 || i == 6 || i == 8) {
          sprintf (pom, "'%s'", s);
          strcpy(s,pom);
    }
    strcat (sql->query, s);

    if (i != 10)
      strcat (sql->query, ", ");

    free (s);
  }

  strcat (sql->query, ");");

  if (mysql_query (sql->konekcija, sql->query) != 0) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }

  // printf ("Statistika radnika nakon upisa novog radnika:\n\n");
  // ispisiRadnike (sql);
  // ispisiRestoran(sql);

  return sifra;
}

int dodajKuvara (Sql *sql)
{
  printf ("Da biste dodali kuvara prvo morate dodati Radnika.\n");
  int sifra = dodajRadnika(sql);

  printf ("Sada mozete dodati kuvara.\nUnesite redom:\nzavrsenu skolu\n\
godine iskustva u spremanju kineske hrane\ngodine iskustva u poslu\n");

  char *skola;
  int godineKin, godine;

  scanf ("%ms", &skola);
  scanf ("%i%i", &godineKin,&godine);

  sprintf (sql->query, "insert into Kuvar (sifraRadnika, zavrsenaSkola, godineIskustvaUSpremanjuKineskeHrane,\
    godineIskustvaUPoslu) values (%i, '%s', %i, %i)", sifra,skola,godineKin,godine);

  if (mysql_query(sql->konekcija,sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }

  free(skola);

  return sifra;
}

void dodajRaznosaca (Sql *sql)
{
  printf ("Da biste dodali raznosaca prvo morate dodati Radnika a zatim i reon koji on pokriva.\n");
  int sifra = dodajRadnika(sql);
  int reon = dodajReon(sql);

  printf ("Sada mozete dodati raznosaca.\nUnesite redom:\nmodel automobila\n\
potrosnju automobila\ncenu goriva koje automobil trosi\nukupnu cenu goriva na mesecnom nivou\n");

  char *model;
  int potrosnja, gorivo, gorivoMesec;

  scanf ("%ms", &model);
  scanf ("%i%i%i", &potrosnja,&gorivo,&gorivoMesec);

  sprintf (sql->query, "insert into Raznosac (sifraRadnika, modelAutomobila, potrosnjaAutomobila, cenaGorivaZaAutomobil,\
    cenaGorivaNaMesecnomNivou, idReona) values (%i, '%s', %i, %i, %i, %i)",
    sifra, model, potrosnja, gorivo, gorivoMesec,reon);

  if (mysql_query(sql->konekcija,sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }

  free(model);
}

int dodajReon (Sql *sql)
{
  printf ("Unesite redom:\nid reona\nime reona\nvaznost reona\n");

  int id,vaznost;
  char *ime;

  scanf("%i%ms%i", &id,&ime,&vaznost);

  sprintf (sql->query, "insert into Reon (idReona, imeReona, vaznostReona) values (%i, '%s', %i);",
           id,ime,vaznost);

  if (mysql_query(sql->konekcija, sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }

  return id;
}

void azurirajPlatuRadniku (Sql *sql)
{
  printf ("Statistika radnika pre azuriranja plata:\n\n");
  ispisiRadnike (sql);

  printf ("Unesite sifru radnika ciju platu zelite da izmenite i novu platu:\n");

  int sifra,plata;
  scanf ("%i%i", &sifra,&plata);

  sprintf (sql->query, "update Radnik set plata=%i where sifraRadnika=%i", plata, sifra);

  if (mysql_query (sql->konekcija, sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }

  // ispisiRadnike(sql);
  // ispisiRestoran(sql);
}

void ispisiRadnike (Sql *sql)
{
  sprintf (sql->query, "select sifraRadnika, ime, prezime, datumRodjenja, brojTelefona, plata from Radnik");

  if (mysql_query(sql->konekcija, sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }

  sql->rezultat = mysql_use_result(sql->konekcija);

  sql->kolona = mysql_fetch_fields(sql->rezultat);

  int n = mysql_field_count(sql->konekcija);

  for (int i=0;i<n;i++) {
    printf ("%s\t\t", sql->kolona[i].name);
  }
  printf ("\n\n");

  while ((sql->red = mysql_fetch_row(sql->rezultat))) {
    for (int i=0;i<n;i++)
      printf ("%s\t\t", sql->red[i]);
    printf ("\n");
  }
  printf ("\n\n");
}

void obrisiRadnika (Sql *sql)
{
  printf ("Statistika radnika brisanja:\n\n");
  ispisiRadnike (sql);

  printf ("Unesite sifru radnika koga zelite da izbrisete iz baze:\n");

  int sifra;
  scanf("%i", &sifra);

  sprintf (sql->query, "delete from Radnik where sifraRadnika=%i", sifra);

  if (mysql_query(sql->konekcija, sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }

  ispisiRadnike(sql);
  ispisiRestoran(sql);
}

void obrisiKuvara (Sql *sql)
{
  ispisiRadnika (sql, "Kuvar");

  printf ("Unesite sifru kuvara koga zelite da izbrisete iz baze:\n");

  int sifra;
  scanf("%i", &sifra);

  sprintf (sql->query, "delete from Kuvar where sifraRadnika=%i", sifra);

  if (mysql_query(sql->konekcija, sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }
}

void obrisiRaznosaca (Sql *sql)
{
  ispisiRadnika (sql, "Raznosac");

  printf ("Unesite sifru raznosaca koga zelite da izbrisete iz baze:\n");

  int sifra;
  scanf("%i", &sifra);

  sprintf (sql->query, "delete from Raznosac where sifraRadnika=%i", sifra);

  if (mysql_query(sql->konekcija, sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }
}

void obrisiProdavca (Sql *sql)
{
  ispisiRadnika (sql, "Prodavac");

  printf ("Unesite sifru prodavca koga zelite da izbrisete iz baze:\n");

  int sifra;
  scanf("%i", &sifra);

  sprintf (sql->query, "delete from Prodavac where sifraRadnika=%i", sifra);

  if (mysql_query(sql->konekcija, sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }
}

void ispisiRadnika (Sql *sql, char *s)
{
  sprintf (sql->query, "select sifraRadnika from %s;", s);

  if (mysql_query(sql->konekcija,sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }

  sql->rezultat = mysql_use_result(sql->konekcija);

  sql->kolona = mysql_fetch_fields(sql->rezultat);

  printf ("%s\n", sql->kolona[0].name);

  while ((sql->red = mysql_fetch_row(sql->rezultat))) {
    printf ("%s\n", sql->red[0]);
  }
}
