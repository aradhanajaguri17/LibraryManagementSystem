<%@ page contentType="text/html; charset=UTF-8" %><%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html><head><title>Books</title><link rel="stylesheet" href="style.css"></head><body>
<header><h1>Library Management System</h1><nav><a href="home">Dashboard</a><a href="books">Books</a><a href="members">Members</a><a href="loans">Issue / Return</a></nav></header>
<main><h2>Book catalogue</h2><div class="panel"><form method="get" action="books"><input name="q" value="${q}" placeholder="Search title or author"><button>Search</button></form></div>
<div class="panel"><h3>Add a book</h3><form method="post" action="books">
<input name="title" required maxlength="200" placeholder="Book title"><input name="author" required maxlength="120" placeholder="Author">
<input name="category" maxlength="80" placeholder="Category"><input name="copies" required type="number" min="1" max="10000" placeholder="Copies"><button type="submit">Add book</button></form></div>
<div class="panel"><table><tr><th>ID</th><th>Title</th><th>Author</th><th>Category</th><th>Total</th><th>Available</th></tr>
<c:forEach var="b" items="${books}"><tr><td><c:out value="${b.id}"/></td><td><c:out value="${b.title}"/></td><td><c:out value="${b.author}"/></td><td><c:out value="${b.category}"/></td><td>${b.total}</td><td>${b.available}</td></tr></c:forEach>
</table></div></main></body></html>