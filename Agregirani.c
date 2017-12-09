#include "Agregirani.h"

void dodajKuvaraIJelo(Sql *sql)
{
  printf ("Unos kuvara:\n");

  int kuvar = dodajKuvara(sql);

  printf ("Unos jela:\n");

  int jelo = dodajJelo(sql);

  sprintf(sql->query, "insert into KuvarSpremaJelo (sifraRadnika,sifraJela) values (%i, %i);", kuvar, jelo);

  printf ("%s\n", sql->query);

  if (mysql_query(sql->konekcija, sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }
}

void obrisiKuvaraIJelo (Sql *sql)
{
  ispisiKuvareIJela(sql);

  printf ("Unesite sifru kuvara i jela koje zelite da izbacite\n");

  int kuvar,jelo;

  scanf("%i%i", &kuvar,&jelo);

  sprintf(sql->query, "delete from KuvarSpremaJelo where sifraRadnika = %i and sifraJela = %i", kuvar, jelo);

  if (mysql_query(sql->konekcija, sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }
}

void ispisiKuvareIJela(Sql *sql)
{
  sprintf (sql->query, "select * from KuvarSpremaJelo");

  if (mysql_query(sql->konekcija, sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }

  sql->rezultat = mysql_use_result(sql->konekcija);

  sql->kolona = mysql_fetch_fields(sql->rezultat);

  printf ("%s\t%s\n", sql->kolona[0].name, sql->kolona[1].name);

  while ((sql->red = mysql_fetch_row(sql->rezultat))) {
    printf ("%s\t\t%s\n", sql->red[0], sql->red[1]);
  }
}

void dodajSastojakIJelo (Sql *sql)
{
  printf ("Unos sastojka:\nUnesite redom:\nsifru sastojka\nime sastojka\ncenu na trzistu\n");

  int sifra, cena;
  char *ime;

  scanf ("%i%ms%i", &sifra,&ime,&cena);

  sprintf (sql->query, "insert into Sastojak (sifraSastojka, imeSastojka, brojJelaUkojaIde, cenaNaTrzistu)\
           values (%i, '%s', default, %i);", sifra,ime,cena);

  free (ime);

  if (mysql_query(sql->konekcija, sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }

  printf ("Unos jela:\n");

  int jelo = dodajJelo(sql);

  sprintf (sql->query, "insert into SastojakIdeUJelo(sifraSastojka, sifraJela) values (%i,%i);", sifra, jelo);

  if (mysql_query(sql->konekcija,sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }
}

void ispisiSastojkeIJela(Sql *sql)
{
  sprintf (sql->query, "select * from SastojakIdeUJelo");

  if (mysql_query(sql->konekcija, sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }

  sql->rezultat = mysql_use_result(sql->konekcija);

  sql->kolona = mysql_fetch_fields(sql->rezultat);

  printf ("%s\t%s\n", sql->kolona[0].name, sql->kolona[1].name);

  while ((sql->red = mysql_fetch_row(sql->rezultat))) {
    printf ("%s\t\t%s\n", sql->red[0], sql->red[1]);
  }
}

void obrisiSastojakIJelo (Sql *sql)
{
  ispisiSastojkeIJela(sql);

  printf ("Unesite sifru sastojka i jela koje zelite da izbacite\n");

  int sastojak,jelo;

  scanf("%i%i", &sastojak,&jelo);

  sprintf(sql->query, "delete from SastojakIdeUJelo where sifraSastojka = %i and sifraJela = %i", sastojak, jelo);

  if (mysql_query(sql->konekcija, sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }
}
