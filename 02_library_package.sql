CREATE OR REPLACE PACKAGE library_pkg AS
  PROCEDURE borrow_book(p_member_id IN NUMBER, p_book_id IN NUMBER);
  PROCEDURE return_book(p_loan_id IN NUMBER);
END library_pkg;
/

CREATE OR REPLACE PACKAGE BODY library_pkg AS
  PROCEDURE borrow_book(p_member_id IN NUMBER, p_book_id IN NUMBER) IS
    v_available NUMBER;
    v_member_count NUMBER;
  BEGIN
    SELECT COUNT(*) INTO v_member_count FROM members WHERE member_id = p_member_id;
    IF v_member_count = 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Member ID does not exist.');
    END IF;

    -- Lock the selected book row so simultaneous issues cannot oversubscribe copies.
    SELECT available_copies INTO v_available FROM books
      WHERE book_id = p_book_id FOR UPDATE;
    IF v_available <= 0 THEN
      RAISE_APPLICATION_ERROR(-20002, 'No copies are currently available.');
    END IF;

    UPDATE books SET available_copies = available_copies - 1 WHERE book_id = p_book_id;
    INSERT INTO loans(loan_id, member_id, book_id, issue_date, due_date, status)
      VALUES(loans_seq.NEXTVAL, p_member_id, p_book_id, TRUNC(SYSDATE), TRUNC(SYSDATE)+14, 'ISSUED');
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20003, 'Book ID does not exist.');
  END borrow_book;

  PROCEDURE return_book(p_loan_id IN NUMBER) IS
    v_book_id NUMBER;
    v_status VARCHAR2(10);
  BEGIN
    SELECT book_id, status INTO v_book_id, v_status
      FROM loans WHERE loan_id = p_loan_id FOR UPDATE;
    IF v_status = 'RETURNED' THEN
      RAISE_APPLICATION_ERROR(-20004, 'This loan has already been returned.');
    END IF;
    UPDATE loans SET status='RETURNED', return_date=TRUNC(SYSDATE) WHERE loan_id=p_loan_id;
    UPDATE books SET available_copies = available_copies + 1 WHERE book_id=v_book_id;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20005, 'Loan ID does not exist.');
  END return_book;
END library_pkg;
/
