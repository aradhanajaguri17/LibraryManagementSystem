<%@ page contentType="text/html; charset=UTF-8" %><%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html><head><title>Loans</title><link rel="stylesheet" href="style.css"></head><body>
<header><h1>Library Management System</h1><nav><a href="home">Dashboard</a><a href="books">Books</a><a href="members">Members</a><a href="loans">Issue / Return</a></nav></header>
<main><h2>Issue and return books</h2><p>Use the numeric member ID and book ID shown on the Members and Books pages.</p>
<div class="panel"><h3>Issue a book</h3><form method="post" action="loans"><input type="hidden" name="action" value="borrow">
<input name="memberId" type="number" min="1" required placeholder="Member ID"><input name="bookId" type="number" min="1" required placeholder="Book ID"><button>Issue book</button></form></div>
<div class="panel"><h3>Return a book</h3><form method="post" action="loans"><input type="hidden" name="action" value="return">
<input name="loanId" type="number" min="1" required placeholder="Loan ID"><button>Return book</button></form></div>
<div class="panel"><h3>Loan history</h3><table><tr><th>Loan ID</th><th>Member</th><th>Book</th><th>Issued</th><th>Due</th><th>Returned</th><th>Status</th></tr>
<c:forEach var="l" items="${loans}"><tr><td>${l.id}</td><td><c:out value="${l.member}"/></td><td><c:out value="${l.book}"/></td><td>${l.issue}</td><td>${l.due}</td><td>${l.returned}</td><td>${l.status}</td></tr></c:forEach></table></div></main></body></html>