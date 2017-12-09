#ifndef RADNICI_H
#define RADNICI_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>
#include "Restoran.h"

int dodajRadnika(Sql *sql);
void azurirajPlatuRadniku(Sql *sql);
void ispisiRadnike(Sql *sql);
void obrisiRadnika(Sql *sql);
int dodajKuvara(Sql *sql);
int dodajReon(Sql *sql);
void dodajRaznosaca(Sql *sql);
void ispisiRadnika(Sql *sql, char *s);
void obrisiKuvara(Sql *sql);
void obrisiProdavca(Sql *sql);
void obrisiRaznosaca(Sql *sql);

#endif
