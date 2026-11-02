-- Run as a DBA/admin account, or create the user separately with your institution's approved credentials.
-- Example (run as SYS/ADMIN, adapt tablespace/quota as needed):
-- CREATE USER LIBRARY_APP IDENTIFIED BY ChangeMe123;
-- GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE PROCEDURE, CREATE TRIGGER TO LIBRARY_APP;
-- ALTER USER LIBRARY_APP QUOTA UNLIMITED ON USERS;
-- Then connect as LIBRARY_APP and run the rest of this file.

CREATE TABLE books (
  book_id NUMBER PRIMARY KEY,
  title VARCHAR2(200) NOT NULL,
  author VARCHAR2(120) NOT NULL,
  category VARCHAR2(80) DEFAULT 'General',
  total_copies NUMBER(5) NOT NULL CHECK (total_copies >= 1),
  available_copies NUMBER(5) NOT NULL CHECK (available_copies >= 0),
  CONSTRAINT chk_book_copies CHECK (available_copies <= total_copies)
);
CREATE TABLE members (
  member_id NUMBER PRIMARY KEY,
  full_name VARCHAR2(120) NOT NULL,
  email VARCHAR2(180) NOT NULL UNIQUE,
  phone VARCHAR2(30)
);
CREATE TABLE loans (
  loan_id NUMBER PRIMARY KEY,
  member_id NUMBER NOT NULL REFERENCES members(member_id),
  book_id NUMBER NOT NULL REFERENCES books(book_id),
  issue_date DATE DEFAULT TRUNC(SYSDATE) NOT NULL,
  due_date DATE NOT NULL,
  return_date DATE,
  status VARCHAR2(10) DEFAULT 'ISSUED' NOT NULL CHECK (status IN ('ISSUED','RETURNED')),
  CONSTRAINT chk_loan_dates CHECK (due_date >= issue_date),
  CONSTRAINT chk_return_status CHECK ((status='ISSUED' AND return_date IS NULL) OR (status='RETURNED' AND return_date IS NOT NULL))
);
CREATE SEQUENCE books_seq START WITH 100 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE members_seq START WITH 100 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE loans_seq START WITH 100 INCREMENT BY 1 NOCACHE;

INSERT INTO books VALUES (books_seq.NEXTVAL,'Database System Concepts','Silberschatz','Database',5,5);
INSERT INTO books VALUES (books_seq.NEXTVAL,'Effective Java','Joshua Bloch','Java',3,3);
INSERT INTO books VALUES (books_seq.NEXTVAL,'Computer Networks','Andrew Tanenbaum','Networking',4,4);
INSERT INTO members VALUES (members_seq.NEXTVAL,'Aarav Sharma','aarav@example.com','9876500001');
INSERT INTO members VALUES (members_seq.NEXTVAL,'Priya Verma','priya@example.com','9876500002');
COMMIT;