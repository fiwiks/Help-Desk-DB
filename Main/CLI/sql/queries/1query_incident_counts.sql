-- Shows total incident counts per organization.
-- Special case: includes orgs even if they currently have zero incidents (via LEFT JOIN).

@sql/sqlFormatter.sql
COLUMN org_id         FORMAT 999        HEADING 'ORG_ID'
COLUMN org_name       FORMAT A22        HEADING 'ORG_NAME'
COLUMN incident_count FORMAT 9999       HEADING 'INCIDENTS'

PROMPT === Organizations by total incidents ===
SELECT o.org_id,
       o.name AS org_name,
       COUNT(i.incident_id) AS incident_count
FROM incidents i
LEFT JOIN users u       ON u.user_id = i.created_by
LEFT JOIN departments d ON d.dept_id = u.dept_id
LEFT JOIN organizations o ON o.org_id = d.org_id
GROUP BY o.org_id, o.name
ORDER BY incident_count DESC, o.name;
