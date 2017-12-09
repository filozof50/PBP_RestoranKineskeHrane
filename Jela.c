#include "Jela.h"

int dodajJelo (Sql *sql)
{
  printf ("Unesite redom:\nsifru jela\nime jela\ncenu jela\nsifru restorana\n");

  sprintf (sql->query, "insert into Jelo (sifraJela, imeJela, brojKuvaraKojiUmejuDaSpremeJelo, cenaJela,\n\
           sifraRestorana) values(");

  char *s, pom[50];

  int sifra;

  for (int i=0;i<5;i++) {
    if (i != 2)
      scanf ("%ms", &s);

    if (i == 0)
      sifra = (int) strtol(s,NULL,10);

    if (i == 1) {
      sprintf (pom, "'%s'", s);
      strcpy(s,pom);
    }
    else if (i == 2)
      strcpy(s,"default");

    strcat (sql->query, s);

    if (i != 4)
      strcat (sql->query, ", ");

    if (i != 2)
      free (s);
  }

  strcat (sql->query,");");

  if (mysql_query(sql->konekcija, sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }

  return sifra;
}


void obrisiJelo (Sql *sql)
{
  ispisiJela(sql);

  printf ("Unesite sifru jela koje zelite da obrisete\n");

  int sifra;

  scanf ("%i", &sifra);

  sprintf (sql->query, "delete from Jelo where sifraJela = %i", sifra);

  if (mysql_query(sql->konekcija,sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }
}

void ispisiJela (Sql *sql)
{
  sprintf (sql->query, "select * from Jelo");

  if (mysql_query(sql->konekcija, sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }

  sql->rezultat = mysql_use_result(sql->konekcija);

  sql->kolona = mysql_fetch_fields (sql->rezultat);

  int n = mysql_field_count (sql->konekcija);

  for (int i=0;i<n;i++) {
    if (i == 2)
      printf ("%s\t\t", "broj kuvara");
    else
      printf ("%s\t\t", sql->kolona[i].name);
  }
  printf ("\n\n");

  while (sql->red = mysql_fetch_row(sql->rezultat)) {
    for (int i=0;i<n;i++)
      printf ("%s\t\t", sql->red[i]);
    printf ("\n");
  }
  printf ("\n\n");
}
