# SQL-Bank-Database-Design
SQL project including tasks of creating database and tables, identifying constraints, Client log in control, and Customer Accounts Details inquiries.
•
Introduction:
There are only two types of accounts
at this time : Checking and Savings
accounts. The provided column list should be separated into appropriate
entities (tables) with relationships between these entities defined. The most
efficient choices as far as your primary key constraints and foreign key
constraints, and picked the appropriate data types for each of the columns.
•
Project Goals:
The goal of the project is to understand database entities in more depth
and have practical experience of working with different objects of SQL.

Criterias:
•
When an employee opens an account, performs a transaction on or
reactivates an account there must be a record of which employee
performed the action.
•
Every person who opens a savings account does not get the same rate.
•
Because the bank charges an overdraft fee, a record must be maintained
on any transaction that causes an account to go into overdraft.
•
Extra error information is required to be stored when a transaction fails.
The bank uses this information for fraud detection and to diagnose
periodic problems within their networks and applications.
•
Customers have a user logins to allow them to access all of their
accounts. If a user fails a login attempt, for instance because they have
forgotten their password, a record of that failed attempt needs to be kept.
•
The information for checking and saving accounts is very similar to each
other as are the transactions that update those accounts.
•
More than one customer is allowed on each account, and any transaction
record should reflect which customer made the transaction.
