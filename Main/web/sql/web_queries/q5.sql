COLUMN report_id  FORMAT 9999
COLUMN title      FORMAT A28
COLUMN table_name FORMAT A12
COLUMN preview    FORMAT A60

SELECT report_id, title, table_name, SUBSTR(query_txt,1,120) AS preview
FROM reports
WHERE UPPER(table_name) = 'INCIDENTS'
ORDER BY created_on DESC
FETCH FIRST 20 ROWS ONLY;
