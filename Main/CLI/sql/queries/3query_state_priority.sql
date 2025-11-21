@sql/sqlFormatter.sql
COLUMN state    FORMAT A12
COLUMN priority FORMAT 99
COLUMN count    FORMAT 9999

SELECT state, priority, COUNT(*) AS count
FROM incidents
GROUP BY state, priority
ORDER BY state, priority;
