#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>
#include "Jela.h"
#include "Agregirani.h"
#include "Radnici.h"

int main ()
{
  Sql sql;

  sql.konekcija = mysql_init(NULL);

  if (mysql_real_connect (sql.konekcija, "localhost", "root", "dylandog", "KineskiRestoran", 0, NULL, 0) == NULL) {
    printf ("Neuspesno konektovanje na bazu\n");
  }

  int brojZahteva;

  while (1) {
    printf ("%s:\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n\n",
            "Unesite","1. za dodavanje novog radnika", "2. za azuriranje plate postojeceg radnika",
            "3. za brisanje radnika iz baze", "4. za dodavanje novog jela u bazu", "5. za brisanje jela iz baze",
            "6. za unos kuvara i jela koje on zna da spremi", "7. za brisanje kuvara i jela koje on zna da spremi",
            "8. za unos sastojka i jela u koje sastojak ide",
            "9. za brisanje sastojka i jela u koje sastojak ide", "10. za unos raznosaca",
            "11. za brisanje kuvara", "12. za brisanje raznosaca", "13. za brisanje prodavca",
            "14. za zavrsetak rada");

    scanf ("%i", &brojZahteva);

    switch (brojZahteva) {
      case 1:
        dodajRadnika(&sql);
        break;
      case 2:
        azurirajPlatuRadniku(&sql);
        break;
      case 3:
        obrisiRadnika(&sql);
        break;
      case 4:
        dodajJelo(&sql);
        break;
      case 5:
        obrisiJelo(&sql);
        break;
      case 6:
        dodajKuvaraIJelo(&sql);
        break;
      case 7:
        obrisiKuvaraIJelo(&sql);
        break;
      case 8:
        dodajSastojakIJelo(&sql);
        break;
      case 9:
        obrisiSastojakIJelo(&sql);
        break;
      case 10:
        dodajRaznosaca(&sql);
        break;
      case 11:
        obrisiKuvara(&sql);
        break;
      case 12:
        obrisiRaznosaca(&sql);
        break;
      case 13:
        obrisiProdavca(&sql);
        break;
      case 14:
        exit (EXIT_SUCCESS);
      default:
        printf ("Pogresan izbor komande!\n");
    }
  }

  return 0;
}
