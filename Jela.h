#ifndef JELA_H
#define JELA_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>
#include "Restoran.h"

int dodajJelo(Sql *sql);
void ispisiJela(Sql *sql);
void obrisiJelo (Sql *sql);

#endif
