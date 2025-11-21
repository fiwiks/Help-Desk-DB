@sql/sqlFormatter.sql
COLUMN org_name   FORMAT A18
COLUMN dept_name  FORMAT A18
COLUMN short_description FORMAT A36

SELECT i.incident_id,
       i.short_description,
       o.name AS org_name,
       d.name AS dept_name
FROM incidents i
JOIN users u       ON u.user_id = i.created_by
JOIN departments d ON d.dept_id = u.dept_id
JOIN organizations o ON o.org_id = d.org_id
ORDER BY o.name, d.name, i.incident_id;
