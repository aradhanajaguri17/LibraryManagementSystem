-- Run as LIBRARY_APP after creating the tables and package.
-- 1. Catalogue report
SELECT book_id, title, total_copies, available_copies FROM books ORDER BY title;
-- 2. Member report
SELECT member_id, full_name, email FROM members ORDER BY full_name;
-- 3. Active loan report
SELECT l.loan_id, m.full_name, b.title, l.issue_date, l.due_date
FROM loans l JOIN members m ON m.member_id=l.member_id
JOIN books b ON b.book_id=l.book_id WHERE l.status='ISSUED';
-- 4. Exercise successful borrow; replace IDs with IDs visible in your database.
-- BEGIN library_pkg.borrow_book(100,100); COMMIT; END; /
-- 5. Exercise return; replace with the created loan ID.
-- BEGIN library_pkg.return_book(100); COMMIT; END; /
-- 6. Negative tests: invalid member, invalid book, no available copies, repeat return.
-- Each should raise an application error. Roll back test data when appropriate.
