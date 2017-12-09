#ifndef AGREGIRANI_H
#define AGREGIRANI_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>
#include "Jela.h"
#include "Radnici.h"
#include "Restoran.h"

void dodajKuvaraIJelo(Sql *sql);
void obrisiKuvaraIJelo(Sql *sql);
void ispisiKuvareIJela(Sql *sql);
void dodajSastojakIJelo(Sql *sql);
void obrisiSastojakIJelo(Sql *sql);
void ispisiSastojkeIJela(Sql *sql);

#endif
