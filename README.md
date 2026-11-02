# Library Management System — MCA Mini Project

## Stack
- Advanced Internet Programming: Java 17, Jakarta Servlet 6, JSP, HTML/CSS, Apache Tomcat 10.1+
- Database / PL/SQL Lab: Oracle Database (FREEPDB1 or your institute's service), SQL, PL/SQL package
- Integration: JDBC with Oracle `ojdbc11`; Maven WAR packaging

## Features
- Dashboard counts for books, members, active loans
- Search books by title/author; add book
- Register members
- Issue books and return books using PL/SQL procedures
- Loan history and availability tracking
- PreparedStatement parameter binding and database constraints

## Setup
1. Install JDK 17, Maven, Oracle Database (or get the college Oracle connection details), and Tomcat 10.1+.
2. In SQL Developer, connect as an administrator and create `LIBRARY_APP` as described at the top of `sql/01_schema_and_seed.sql`. Use your own password in a real environment.
3. Connect as `LIBRARY_APP`; run `sql/01_schema_and_seed.sql`, then `sql/02_library_package.sql`.
4. Configure environment variables:
   - `LIBRARY_DB_URL=jdbc:oracle:thin:@localhost:1521/FREEPDB1`
   - `LIBRARY_DB_USER=LIBRARY_APP`
   - `LIBRARY_DB_PASSWORD=<your password>`
   The Java defaults are for a local practice setup only; change them for your system.
5. From this directory run `mvn clean package`.
6. Copy `target/library-management.war` to Tomcat's `webapps` folder and start Tomcat.
7. Open `http://localhost:8080/library-management/home`.
8. First register or use the seeded members. The Books page shows book IDs; Members shows member IDs. Use those IDs on Issue / Return.

## Important notes
- Tomcat 10.1 uses `jakarta.*`; Tomcat 9 uses `javax.*` and is not compatible without code changes.
- Ensure Oracle service and listener are running. Your service name may be `XEPDB1`, `FREEPDB1`, or a college-provided service; use the actual value.
- The database package raises application errors for invalid IDs, unavailable copies, and repeat returns. The servlet surfaces an error page through Tomcat; a production version should map these errors to a friendly UI.
- This is an educational baseline, not a production system: authentication/authorization, CSRF protection, audit logging, and pooled DataSource configuration are recommended before real deployment.
