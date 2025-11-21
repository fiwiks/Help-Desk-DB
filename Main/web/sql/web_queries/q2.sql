-- Advanced report: workload of open incidents per staff member.
-- Only counts incidents in states NEW, IN PROGRESS, ON HOLD.

COLUMN assigned_to_name FORMAT A22 HEADING 'STAFF'
COLUMN emp_no           FORMAT 9999 HEADING 'EMP#'
COLUMN open_incidents   FORMAT 9999 HEADING 'OPEN'

SELECT u.name AS assigned_to_name, s.emp_no,
       COUNT(i.incident_id) AS open_incidents
FROM incidents i
JOIN staff s ON s.staff_id = i.assigned_to
JOIN users u ON u.user_id = s.staff_id
WHERE i.state IN ('NEW','IN PROGRESS','ON HOLD')
GROUP BY u.name, s.emp_no
ORDER BY open_incidents DESC, u.name;
