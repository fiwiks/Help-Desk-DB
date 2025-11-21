CREATE TABLE organizations (
    org_id             NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name               VARCHAR2(200) NOT NULL
);

CREATE TABLE contacts (
	contact_id	NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name		VARCHAR2(200) NOT NULL,
	contact_type	VARCHAR2(50),
	org_id		NUMBER NOT NULL,
	CONSTRAINT primary_secondary
		CHECK (contact_type IN ('Primary', 'Secondary')),
	FOREIGN KEY (org_id) REFERENCES organizations(org_id)
);

CREATE TABLE departments (
    dept_id   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name      VARCHAR2(200) NOT NULL,
    org_id    NUMBER NOT NULL,
    CONSTRAINT fk_dept_org
      FOREIGN KEY (org_id) REFERENCES organizations(org_id)
);

CREATE TABLE users (
    user_id  NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name     VARCHAR2(200) NOT NULL,
    email    VARCHAR2(200),
    phone    VARCHAR2(50),
    dept_id  NUMBER,
    roles    VARCHAR2(100),
    CONSTRAINT fk_user_dept
      FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE staff (
    staff_id NUMBER PRIMARY KEY,
    emp_no   NUMBER GENERATED ALWAYS AS IDENTITY,
    title    VARCHAR2(100),
    CONSTRAINT fk_staff_user
      FOREIGN KEY (staff_id) REFERENCES users(user_id)
);

CREATE TABLE incidents (
    incident_id       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    created_on        DATE DEFAULT SYSDATE NOT NULL,
    created_by        NUMBER NOT NULL,
    assigned_to       NUMBER,
    state             VARCHAR2(20) DEFAULT 'NEW' NOT NULL,
    priority          NUMBER(1) DEFAULT 3 NOT NULL,
    short_description VARCHAR2(200),
    description       CLOB,
    impact            NUMBER,
    caller            VARCHAR2(200),
    channel           VARCHAR2(50),
    category          VARCHAR2(100),
    business_service  VARCHAR2(100),
    assignment_group  VARCHAR2(100),
    CONSTRAINT fk_inc_created_by
      FOREIGN KEY (created_by) REFERENCES users(user_id),
    CONSTRAINT fk_inc_assigned_to
      FOREIGN KEY (assigned_to) REFERENCES staff(staff_id),
    CONSTRAINT ck_inc_state
      CHECK (state IN (
        'NEW','IN PROGRESS','ON HOLD','RESOLVED','CLOSED','CANCELLED'
      )),
    CONSTRAINT ck_inc_priority
      CHECK (priority BETWEEN 1 AND 5)
);


CREATE TABLE reports (
    report_id   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    created_on  DATE DEFAULT SYSDATE NOT NULL,
    created_by  NUMBER NOT NULL,
    title       VARCHAR2(200) NOT NULL,
    table_name  VARCHAR2(50),
    query_txt   CLOB,
    CONSTRAINT fk_report_staff
      FOREIGN KEY (created_by) REFERENCES staff(staff_id)
);

CREATE TABLE incident_reports (
    report_id   NUMBER NOT NULL,
    incident_id NUMBER NOT NULL,
    CONSTRAINT pk_incident_reports
      PRIMARY KEY (report_id, incident_id),
    CONSTRAINT fk_ir_report
      FOREIGN KEY (report_id) REFERENCES reports(report_id),
    CONSTRAINT fk_ir_incident
      FOREIGN KEY (incident_id) REFERENCES incidents(incident_id)
);
