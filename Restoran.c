#include "Restoran.h"

void ispisiRestoran(Sql *sql)
{
  sprintf (sql->query, "select sifraRestorana, imeRestorana, brojRazlicitihJelaKojaSeSpremaju, brojZaposlenih,\
           ukupanIznosPlataZaposlenih, ukupnaCenaGorivaZaSveRaznosace from Restoran");

  if (mysql_query(sql->konekcija, sql->query)) {
    printf ("Neuspesno izvrsavanje upita\n");
    exit (EXIT_FAILURE);
  }

  sql->rezultat = mysql_use_result(sql->konekcija);

  sql->kolona = mysql_fetch_fields(sql->rezultat);

  int n = mysql_field_count(sql->konekcija);

  for (int i=0;i<n;i++) {
    if (i == 2)
      printf ("%s\t", "brojJela");
    else if (i == 4)
      printf ("%s\t   ", "plateRadnika");
    else if (i == 5)
      printf ("%s\t", "cenaGoriva");
    else
      printf ("%s\t", sql->kolona[i].name);
  }
  printf ("\n\n");

  while (sql->red = mysql_fetch_row(sql->rezultat)) {
    for (int i=0;i<n;i++) {
      printf ("%s\t\t", sql->red[i]);
    }
    printf ("\n");
  }
  printf("\n\n");
}
