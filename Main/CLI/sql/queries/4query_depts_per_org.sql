@sql/sqlFormatter.sql
COLUMN org_name   FORMAT A22
COLUMN dept_count FORMAT 9999

SELECT o.org_id, o.name AS org_name, COUNT(d.dept_id) AS dept_count
FROM organizations o
LEFT JOIN departments d ON d.org_id = o.org_id
GROUP BY o.org_id, o.name
ORDER BY o.name;
