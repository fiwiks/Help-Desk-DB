#!/bin/bash
set -euo pipefail
source ./../db.env

run_query () {
  local file="$1"

  sqlplus -s "$DB_USER/$DB_PASS@$DB_CONN" @"$file" < /dev/null | cat

  exec < /dev/tty
  echo
  read -p "Press Enter to return to menu..." _
}

run_sql () {
  local file="$1"

  sqlplus -s "$DB_USER/$DB_PASS@$DB_CONN" @"$file" < /dev/null | cat

  exec < /dev/tty
  echo
  sleep 2
}

while true; do
  clear
  echo "=== Help Desk DB Menu ==="
  echo "1) Organizations by incident count"
  echo "2) Open incidents per staff"
  echo "3) Incident distribution (state × priority)"
  echo "4) Departments per organization"
  echo "5) Reports targeting INCIDENTS"
  echo "6) Incidents by organization"
  echo "7) Create Tables"
  echo "8) Drop Tables"
  echo "9) Populate Tables"
  echo "10) exit"
  read -p "Enter: " c

  case "$c" in
    1) run_query sql/queries/1query_incident_counts.sql ;;
    2) run_query sql/queries/2query_open_by_staff.sql ;;
    3) run_query sql/queries/3query_state_priority.sql ;;
    4) run_query sql/queries/4query_depts_per_org.sql ;;
    5) run_query sql/queries/5query_reports_for_incident.sql ;;
    6) run_query sql/queries/6query_incident_by_org.sql ;;
    7) run_sql sql/Tables_Main.sql;;
    8) run_sql sql/Drop_Tables.sql;;
    9) run_sql sql/Sample_Data.sql;;
    10) exit 0 ;;
    *) echo "Invalid option"; sleep 1 ;;
  esac
done
