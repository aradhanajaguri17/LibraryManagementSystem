<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html><html><head><title>Library Dashboard</title><link rel="stylesheet" href="style.css"></head>
<body><header><h1>Library Management System</h1><nav><a href="home">Dashboard</a><a href="books">Books</a><a href="members">Members</a><a href="loans">Issue / Return</a></nav></header>
<main><h2>Dashboard</h2><p>Manage the book catalogue, registered members, and borrowing transactions.</p>
<div class="cards"><div class="card"><h3>Books</h3><strong>${bookCount}</strong></div><div class="card"><h3>Members</h3><strong>${memberCount}</strong></div><div class="card"><h3>Active loans</h3><strong>${activeLoans}</strong></div></div>
<div class="panel"><h3>Project scope</h3><p>Java Servlets/JSP handle the web interface; JDBC connects Java to Oracle; PL/SQL package procedures enforce issue and return rules inside the database.</p></div></main></body></html>