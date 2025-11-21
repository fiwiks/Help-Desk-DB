#!/bin/bash
source ./../db.env

run_sql () {
  local file="$1"
  sqlplus -s -L "$DB_USER/$DB_PASS@$DB_CONN" @"$file" < /dev/null | cat
  
  exec < /dev/tty
  echo
}

case "$1" in

	create) run_sql sql/Tables_Main.sql ;;
	delete) run_sql sql/Drop_Tables.sql ;;
	insert) run_sql sql/Sample_Data.sql ;;

esac

exit 0