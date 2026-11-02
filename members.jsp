<%@ page contentType="text/html; charset=UTF-8" %><%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html><head><title>Members</title><link rel="stylesheet" href="style.css"></head><body>
<header><h1>Library Management System</h1><nav><a href="home">Dashboard</a><a href="books">Books</a><a href="members">Members</a><a href="loans">Issue / Return</a></nav></header>
<main><h2>Members</h2><div class="panel"><h3>Register member</h3><form method="post" action="members">
<input name="name" required maxlength="120" placeholder="Full name"><input name="email" type="email" required maxlength="180" placeholder="Email">
<input name="phone" maxlength="30" placeholder="Phone"><button type="submit">Register</button></form></div>
<div class="panel"><table><tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th></tr><c:forEach var="m" items="${members}"><tr><td>${m.id}</td><td><c:out value="${m.name}"/></td><td><c:out value="${m.email}"/></td><td><c:out value="${m.phone}"/></td></tr></c:forEach></table></div></main></body></html>