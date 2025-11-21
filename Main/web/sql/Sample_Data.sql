INSERT INTO organizations (name) VALUES ('TechCorp');
INSERT INTO organizations (name) VALUES ('HealthPlus');
INSERT INTO organizations (name) VALUES ('EduWorld');
INSERT INTO organizations (name) VALUES ('FinServe');
INSERT INTO organizations (name) VALUES ('RetailWorks');
INSERT INTO organizations (name) VALUES ('GovAssist');

INSERT INTO contacts (name, contact_type, org_id)
VALUES ('John Doe', 'Primary',
        (SELECT org_id FROM organizations WHERE name = 'TechCorp'));

INSERT INTO contacts (name, contact_type, org_id)
VALUES ('Jane Roe', 'Secondary',
        (SELECT org_id FROM organizations WHERE name = 'TechCorp'));

INSERT INTO contacts (name, contact_type, org_id)
VALUES ('Mark Lee', 'Primary',
        (SELECT org_id FROM organizations WHERE name = 'HealthPlus'));

INSERT INTO contacts (name, contact_type, org_id)
VALUES ('Nina Patel', 'Secondary',
        (SELECT org_id FROM organizations WHERE name = 'HealthPlus'));

INSERT INTO contacts (name, contact_type, org_id)
VALUES ('Sara Khan', 'Primary',
        (SELECT org_id FROM organizations WHERE name = 'EduWorld'));

INSERT INTO contacts (name, contact_type, org_id)
VALUES ('Alex Chen', 'Primary',
        (SELECT org_id FROM organizations WHERE name = 'FinServe'));

INSERT INTO contacts (name, contact_type, org_id)
VALUES ('Priya Singh', 'Secondary',
        (SELECT org_id FROM organizations WHERE name = 'FinServe'));

INSERT INTO contacts (name, contact_type, org_id)
VALUES ('Emily Park', 'Primary',
        (SELECT org_id FROM organizations WHERE name = 'RetailWorks'));

INSERT INTO contacts (name, contact_type, org_id)
VALUES ('Liam Jones', 'Secondary',
        (SELECT org_id FROM organizations WHERE name = 'RetailWorks'));

INSERT INTO contacts (name, contact_type, org_id)
VALUES ('Rita Gill', 'Primary',
        (SELECT org_id FROM organizations WHERE name = 'GovAssist'));

INSERT INTO contacts (name, contact_type, org_id)
VALUES ('Owen Hart', 'Secondary',
        (SELECT org_id FROM organizations WHERE name = 'GovAssist'));

INSERT INTO departments (name, org_id) VALUES
('IT Support',
  (SELECT org_id FROM organizations WHERE name = 'TechCorp'));

INSERT INTO departments (name, org_id) VALUES
('HR',
  (SELECT org_id FROM organizations WHERE name = 'TechCorp'));

INSERT INTO departments (name, org_id) VALUES
('Medical Desk',
  (SELECT org_id FROM organizations WHERE name = 'HealthPlus'));

INSERT INTO departments (name, org_id) VALUES
('Teaching Support',
  (SELECT org_id FROM organizations WHERE name = 'EduWorld'));

INSERT INTO departments (name, org_id) VALUES
('Finance Helpdesk',
  (SELECT org_id FROM organizations WHERE name = 'FinServe'));

INSERT INTO departments (name, org_id) VALUES
('Retail Support',
  (SELECT org_id FROM organizations WHERE name = 'RetailWorks'));

INSERT INTO departments (name, org_id) VALUES
('Customer Relations',
  (SELECT org_id FROM organizations WHERE name = 'RetailWorks'));

INSERT INTO departments (name, org_id) VALUES
('Public Services Desk',
  (SELECT org_id FROM organizations WHERE name = 'GovAssist'));

INSERT INTO departments (name, org_id) VALUES
('Policy IT',
  (SELECT org_id FROM organizations WHERE name = 'GovAssist'));

----------------------------------------------------------------
-- USERS
----------------------------------------------------------------
INSERT INTO users (name, email, phone, dept_id, roles) VALUES
('John Doe', 'jdoe@techcorp.com', '555-1111',
 (SELECT dept_id FROM departments
   WHERE name = 'IT Support'
     AND org_id = (SELECT org_id FROM organizations WHERE name = 'TechCorp')),
 'Agent');

INSERT INTO users (name, email, phone, dept_id, roles) VALUES
('Jane Roe', 'jroe@techcorp.com', '555-2222',
 (SELECT dept_id FROM departments
   WHERE name = 'IT Support'
     AND org_id = (SELECT org_id FROM organizations WHERE name = 'TechCorp')),
 'Manager');

INSERT INTO users (name, email, phone, dept_id, roles) VALUES
('Mark Lee', 'mlee@healthplus.com', '555-3333',
 (SELECT dept_id FROM departments
   WHERE name = 'Medical Desk'
     AND org_id = (SELECT org_id FROM organizations WHERE name = 'HealthPlus')),
 'Agent');

INSERT INTO users (name, email, phone, dept_id, roles) VALUES
('Sara Khan', 'skhan@eduworld.com', '555-4444',
 (SELECT dept_id FROM departments
   WHERE name = 'Teaching Support'
     AND org_id = (SELECT org_id FROM organizations WHERE name = 'EduWorld')),
 'Agent');

INSERT INTO users (name, email, phone, dept_id, roles) VALUES
('Tom Wu', 'twu@techcorp.com', '555-5555',
 (SELECT dept_id FROM departments
   WHERE name = 'HR'
     AND org_id = (SELECT org_id FROM organizations WHERE name = 'TechCorp')),
 'Agent');

INSERT INTO users (name, email, phone, dept_id, roles) VALUES
('Emily Park', 'epark@retailworks.com', '555-6666',
 (SELECT dept_id FROM departments
   WHERE name = 'Retail Support'
     AND org_id = (SELECT org_id FROM organizations WHERE name = 'RetailWorks')),
 'Agent');

INSERT INTO users (name, email, phone, dept_id, roles) VALUES
('Liam Jones', 'ljones@retailworks.com', '555-7777',
 (SELECT dept_id FROM departments
   WHERE name = 'Customer Relations'
     AND org_id = (SELECT org_id FROM organizations WHERE name = 'RetailWorks')),
 'Manager');

INSERT INTO users (name, email, phone, dept_id, roles) VALUES
('Alex Chen', 'achen@finserve.com', '555-8888',
 (SELECT dept_id FROM departments
   WHERE name = 'Finance Helpdesk'
     AND org_id = (SELECT org_id FROM organizations WHERE name = 'FinServe')),
 'Agent');

INSERT INTO users (name, email, phone, dept_id, roles) VALUES
('Rita Gill', 'rgill@govassist.gov', '555-9999',
 (SELECT dept_id FROM departments
   WHERE name = 'Public Services Desk'
     AND org_id = (SELECT org_id FROM organizations WHERE name = 'GovAssist')),
 'Agent');

INSERT INTO users (name, email, phone, dept_id, roles) VALUES
('Owen Hart', 'ohart@govassist.gov', '555-0000',
 (SELECT dept_id FROM departments
   WHERE name = 'Policy IT'
     AND org_id = (SELECT org_id FROM organizations WHERE name = 'GovAssist')),
 'Manager');

INSERT INTO staff (staff_id, title)
SELECT user_id, 'Support Agent'
FROM users
WHERE email = 'jdoe@techcorp.com';

INSERT INTO staff (staff_id, title)
SELECT user_id, 'Support Manager'
FROM users
WHERE email = 'jroe@techcorp.com';

INSERT INTO staff (staff_id, title)
SELECT user_id, 'Nurse Agent'
FROM users
WHERE email = 'mlee@healthplus.com';

INSERT INTO staff (staff_id, title)
SELECT user_id, 'Teacher Support'
FROM users
WHERE email = 'skhan@eduworld.com';

INSERT INTO staff (staff_id, title)
SELECT user_id, 'Retail Agent'
FROM users
WHERE email = 'epark@retailworks.com';

INSERT INTO staff (staff_id, title)
SELECT user_id, 'Retail Manager'
FROM users
WHERE email = 'ljones@retailworks.com';

INSERT INTO staff (staff_id, title)
SELECT user_id, 'Financial Agent'
FROM users
WHERE email = 'achen@finserve.com';

INSERT INTO staff (staff_id, title)
SELECT user_id, 'Public Services Agent'
FROM users
WHERE email = 'rgill@govassist.gov';

INSERT INTO incidents (
  created_by, assigned_to, state, priority,
  short_description, description,
  impact, caller, channel, category,
  business_service, assignment_group
)
VALUES (
  (SELECT user_id FROM users WHERE email = 'jdoe@techcorp.com'),
  (SELECT staff_id FROM staff s
     JOIN users u ON u.user_id = s.staff_id
    WHERE u.email = 'jdoe@techcorp.com'),
  'NEW', 3,
  'Email not working',
  'User reports corporate email is down for their account.',
  2, 'John Doe', 'Email', 'Email', 'Messaging', 'IT Support L1'
);

INSERT INTO incidents (
  created_by, assigned_to, state, priority,
  short_description, description,
  impact, caller, channel, category,
  business_service, assignment_group
)
VALUES (
  (SELECT user_id FROM users WHERE email = 'mlee@healthplus.com'),
  (SELECT staff_id FROM staff s
     JOIN users u ON u.user_id = s.staff_id
    WHERE u.email = 'mlee@healthplus.com'),
  'IN PROGRESS', 2,
  'Patient record access issue',
  'Nurse cannot access patient records in EMR system.',
  3, 'Mark Lee', 'Phone', 'Access', 'EMR', 'Health Desk'
);

INSERT INTO incidents (
  created_by, assigned_to, state, priority,
  short_description, description,
  impact, caller, channel, category,
  business_service, assignment_group
)
VALUES (
  (SELECT user_id FROM users WHERE email = 'skhan@eduworld.com'),
  (SELECT staff_id FROM staff s
     JOIN users u ON u.user_id = s.staff_id
    WHERE u.email = 'skhan@eduworld.com'),
  'ON HOLD', 3,
  'LMS slow performance',
  'Learning Management System is very slow in evenings.',
  2, 'Sara Khan', 'Portal', 'Performance', 'LMS', 'Teaching Support'
);

INSERT INTO incidents (
  created_by, assigned_to, state, priority,
  short_description, description,
  impact, caller, channel, category,
  business_service, assignment_group
)
VALUES (
  (SELECT user_id FROM users WHERE email = 'jroe@techcorp.com'),
  (SELECT staff_id FROM staff s
     JOIN users u ON u.user_id = s.staff_id
    WHERE u.email = 'jdoe@techcorp.com'),
  'RESOLVED', 4,
  'Password reset',
  'User forgot password and needed reset.',
  1, 'Jane Roe', 'Phone', 'Account', 'SSO', 'IT Support L1'
);

INSERT INTO incidents (
  created_by, assigned_to, state, priority,
  short_description, description,
  impact, caller, channel, category,
  business_service, assignment_group
)
VALUES (
  (SELECT user_id FROM users WHERE email = 'epark@retailworks.com'),
  (SELECT staff_id FROM staff s
     JOIN users u ON u.user_id = s.staff_id
    WHERE u.email = 'epark@retailworks.com'),
  'NEW', 1,
  'POS outage at store 12',
  'Point-of-sale system offline at store 12.',
  5, 'Store Manager', 'Phone', 'Outage', 'POS', 'Retail Ops'
);

INSERT INTO incidents (
  created_by, assigned_to, state, priority,
  short_description, description,
  impact, caller, channel, category,
  business_service, assignment_group
)
VALUES (
  (SELECT user_id FROM users WHERE email = 'ljones@retailworks.com'),
  (SELECT staff_id FROM staff s
     JOIN users u ON u.user_id = s.staff_id
    WHERE u.email = 'ljones@retailworks.com'),
  'IN PROGRESS', 2,
  'Refund processing delays',
  'Refunds taking more than 48 hours to process.',
  3, 'Customer', 'Email', 'Finance', 'Payments', 'Retail Finance'
);

INSERT INTO incidents (
  created_by, assigned_to, state, priority,
  short_description, description,
  impact, caller, channel, category,
  business_service, assignment_group
)
VALUES (
  (SELECT user_id FROM users WHERE email = 'achen@finserve.com'),
  (SELECT staff_id FROM staff s
     JOIN users u ON u.user_id = s.staff_id
    WHERE u.email = 'achen@finserve.com'),
  'NEW', 3,
  'Wire transfer failure',
  'Wire transfer failing for high-value client.',
  4, 'Alex Chen', 'Phone', 'Transaction', 'Core Banking', 'FinServe L2'
);

INSERT INTO incidents (
  created_by, assigned_to, state, priority,
  short_description, description,
  impact, caller, channel, category,
  business_service, assignment_group
)
VALUES (
  (SELECT user_id FROM users WHERE email = 'rgill@govassist.gov'),
  (SELECT staff_id FROM staff s
     JOIN users u ON u.user_id = s.staff_id
    WHERE u.email = 'rgill@govassist.gov'),
  'NEW', 2,
  'Portal down',
  'Citizen services portal not responding.',
  5, 'Citizen', 'Web', 'Outage', 'Citizen Portal', 'GovAssist L1'
);

INSERT INTO incidents (
  created_by, assigned_to, state, priority,
  short_description, description,
  impact, caller, channel, category,
  business_service, assignment_group
)
VALUES (
  (SELECT user_id FROM users WHERE email = 'jdoe@techcorp.com'),
  (SELECT staff_id FROM staff s
     JOIN users u ON u.user_id = s.staff_id
    WHERE u.email = 'jdoe@techcorp.com'),
  'CLOSED', 3,
  'Laptop replacement',
  'Old laptop replaced with new device.',
  2, 'John Doe', 'Portal', 'Hardware', 'Devices', 'IT Support L2'
);

INSERT INTO incidents (
  created_by, assigned_to, state, priority,
  short_description, description,
  impact, caller, channel, category,
  business_service, assignment_group
)
VALUES (
  (SELECT user_id FROM users WHERE email = 'epark@retailworks.com'),
  (SELECT staff_id FROM staff s
     JOIN users u ON u.user_id = s.staff_id
    WHERE u.email = 'epark@retailworks.com'),
  'CANCELLED', 4,
  'Duplicate ticket',
  'Duplicate of existing POS outage ticket.',
  1, 'Store Manager', 'Phone', 'Outage', 'POS', 'Retail Ops'
);

INSERT INTO reports (created_by, title, table_name, query_txt)
VALUES (
  (SELECT staff_id FROM staff s
     JOIN users u ON u.user_id = s.staff_id
    WHERE u.email = 'jroe@techcorp.com'),
  'Open Incidents by Org',
  'INCIDENTS',
  'SELECT o.name, COUNT(*) AS open_count
     FROM incidents i
     JOIN users u ON u.user_id = i.created_by
     JOIN departments d ON d.dept_id = u.dept_id
     JOIN organizations o ON o.org_id = d.org_id
    WHERE i.state IN (''NEW'',''IN PROGRESS'',''ON HOLD'')
    GROUP BY o.name'
);

INSERT INTO reports (created_by, title, table_name, query_txt)
VALUES (
  (SELECT staff_id FROM staff s
     JOIN users u ON u.user_id = s.staff_id
    WHERE u.email = 'ljones@retailworks.com'),
  'High Priority Incidents',
  'INCIDENTS',
  'SELECT * FROM incidents WHERE priority IN (1,2)'
);

INSERT INTO reports (created_by, title, table_name, query_txt)
VALUES (
  (SELECT staff_id FROM staff s
     JOIN users u ON u.user_id = s.staff_id
    WHERE u.email = 'jroe@techcorp.com'),
  'Workload by Staff',
  'INCIDENTS',
  'SELECT s.staff_id, u.name, COUNT(*) AS open_count
     FROM incidents i
     JOIN staff s ON s.staff_id = i.assigned_to
     JOIN users u ON u.user_id = s.staff_id
    WHERE i.state IN (''NEW'',''IN PROGRESS'',''ON HOLD'')
    GROUP BY s.staff_id, u.name'
);

INSERT INTO incident_reports (report_id, incident_id)
SELECT r.report_id, i.incident_id
FROM reports r, incidents i
WHERE r.title = 'Open Incidents by Org'
  AND i.priority >= 2;

INSERT INTO incident_reports (report_id, incident_id)
SELECT r.report_id, i.incident_id
FROM reports r, incidents i
WHERE r.title = 'High Priority Incidents'
  AND i.priority IN (1,2);

INSERT INTO incident_reports (report_id, incident_id)
SELECT r.report_id, i.incident_id
FROM reports r, incidents i
WHERE r.title = 'Workload by Staff';
