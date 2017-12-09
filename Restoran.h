#ifndef RESTORAN_H
#define RESTORAN_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>

#define QUERY_DUZINA 512

typedef struct {
  MYSQL *konekcija;
  MYSQL_RES *rezultat;
  MYSQL_ROW red;
  MYSQL_FIELD *kolona;
  char query[QUERY_DUZINA];
} Sql;

void ispisiRestoran(Sql *sql);
#endif
