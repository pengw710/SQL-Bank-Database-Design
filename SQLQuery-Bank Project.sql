--------------------------------------------------------------------------
--This project creates a database for a banking application called "Bank".
--------------------------------------------------------------------------

--				PROJECT PHASE ONE				--
        

--				CREATE DATABASE: BANKPROJECT_PENG				--

create database db_BankProject_Peng
use db_BankProject_Peng;

go

--				CREATE TABLES AND INSERT ITEMS				--

/*
TABLES FOR ACCOUNT:
===================
Table #1: AccountType, parent table for Account
Table #2: AccountStatusType, parent table for Account
Table #3: SavingInterestRate, parent table for Account
Table #4: Account, parent table for OverDraftLog
Table #5: OverDraftLog
*/

--				Table #1: AccountType, parent table for Account				--
create table tblAccountType
(AccountTypeID tinyint not null primary key, 
AccountTypeDescription varchar(30));
go

insert into tblAccountType values
(0,'Checking Account'),
(1,'Savings Account');

select * from tblAccountType
go

--				Table #2: AccountStatusType, parent table for Account				--
create table tblAccountStatusType
(AccountStatusTypeID tinyint not null primary key, 
AccountStatusDescription varchar(30));
go

insert into tblAccountStatusType values
(0, 'Inactive Account'),
(1, 'Active Account');

select * from tblAccountStatusType
go

--				Table #3: SavingInterestRate, parent table for Account				--
create table tblSavingsInterestRates
(InterestSavingsRateID tinyint not null primary key, 
InterestRateValue numeric not null (9,9),
InterestRateDescription varchar(20));
go

insert into tblSavingsInterestRates values
(0, 0.0000, 'No Interests'),
(1, 0.0123, 'Savings Rate 1'),
(2, 0.0234, 'Savings Rate 2'),
(3, 0.0345, 'Savings Rate 3'),
(4, 0.0456, 'Savings Rate 4'),
(5, 0.0567, 'Savings Rate 5');

select * from tblSavingsInterestRates
Go

--				Table #4: Account, parent table for OverDraftLog				--
create table tblAccount--child table contains 3 FKs from 3 parent tables
(AccountID int not null primary key,
CurrentBalance money not null,
AccountTypeID tinyint not null foreign key references tblAccountType(AccountTypeID),
AccountStatusTypeID tinyint not null foreign key references tblAccountStatusType(AccountStatusTypeID),
InterestSavingsRateID tinyint not null foreign key references tblSavingsInterestRates(InterestSavingsRateID));
go

insert into tblAccount values
(101, 1000, 1, 0, 1),
(102, 2000, 1, 0, 1),
(103, 3000, 1, 1, 2),
(104, 4000, 1, 1, 2),
(105, 5000, 1, 1, 3),
(106, 6000, 1, 1, 3),
(107, 7000, 1, 1, 4),
(108, 8000, 1, 0, 5),
(109, 900, 0, 0, 0),
(110, 200, 0, 0, 0),
(111, 300, 0, 1, 0),
(112, 400, 0, 1, 0),
(113, 500, 0, 1, 0),
(114, 600, 0, 1, 0),
(115, 700, 0, 1, 0),
(116, 800, 0, 0, 0);
go

select * from tblAccount
Go

--				Table #5: OverDraftLog				--
create table tblOverDraftLog
(AccountID int not null primary key foreign key references tblAccount(AccountID),
OverDraftDate datetime not null,
OverDraftAmount money not null,
OverDraftTransactionXML xml);
go

insert into tblOverDraftLog values
(101, convert(datetime, '2020-12-10', 120), 1500, null),
(102, convert(datetime, '2020-12-15', 120), 2100, null),
(105, convert(datetime, '2020-12-16', 120), 5200, null),
(107, convert(datetime, '2020-12-18', 120), 7100, null),
(108, convert(datetime, '2020-12-15', 120), 8400, null),
(103, convert(datetime, '2020-12-20', 120), 3500, null);

--for test purpose of Q5/Phase 2
update tblOverDraftLog
set OverDraftAmount = 0
where AccountID = 103
go

select * from tblOverDraftLog
go


/*
TABLES FOR USER LOGIN:
======================
Table #6: UserLogin, parent table for UserSecurityAnswers, Login-Account, and LoginErrorLog
Table #7: UserSecurityQuestions, parent table for UserSecurityAnswers
Table #8: UserSecurityAnswers
Table #9: Login_Account
Table #10: LoginErrorLog
*/

--				Table #6: UserLogin, parent table for UserSecurityAnswers, Login-Account, and LoginErrorLog				--
create table tblUserLogin
(UserLoginID smallint not null primary key,
UserName char(15) not null,
UserPassword varchar(20) not null);
go
alter table tblUserlogin
alter column username char(20)--to satisfy Q6/Phase 2
go

insert into tblUserLogin values
(401, 'UserName123', 'UPS401123'),
(402, 'UserName234', 'UPS402234'),
(403, 'UserName345', 'UPS403345'),
(404, 'UserName456', 'UPS404456'),
(405, 'UserName567', 'UPS405567'),
(406, 'UserName678', 'UPS406678'),
(407, 'UserName789', 'UPS407789'),
(408, 'UserName890', 'UPS408890'),
(409, 'UserName012', 'UPS409012'),
(410, 'UserName246', 'UPS410246'),
(411, 'UserName135', 'UPS411135')

select * from tblUserLogin
go

--				Table #7: UserSecurityQuestions, parent table for UserSecurityAnswers				--
create table tblUserSecurityQuestions
(UserSecurityQuestionID tinyint not null primary key,
UserSecurityQuestion varchar(50));
go

insert into tblUserSecurityQuestions values
(1, 'What is USQ 1?'),
(2, 'What is USQ 2?'),
(3, 'What is USQ 3?'),
(4, 'What is USQ 4?'),
(5, 'What is USQ 5?'),
(6, 'What is USQ 6?');

select * from tblUserSecurityQuestions
go

--				Table #8: UserSecurityAnswers				--
create table tblUserSecurityAnswers
(UserLoginID smallint not null primary key foreign key references tblUserLogin(UserLoginID),
UserSecurityAnswer varchar(25),
UserSecurityQuestionID tinyint not null foreign key references tblUserSecurityQuestions(UserSecurityQuestionID));
go

insert into tblUserSecurityAnswers values
(401, 'The answer is 401.', 1),
(402, 'The answer is 402.', 2),
(403, 'The answer is 403.', 3),
(404, 'The answer is 404.', 4),
(405, 'The answer is 405.', 5),
(406, 'The answer is 406.', 6),
(407, 'The answer is one.', 1),
(408, 'The answer is two.', 2),
(409, 'The answer is three.', 3),
(410, 'The answer is four.', 4),
(411, 'The answer is five.', 5)

select * from tblUserSecurityAnswers
go

--				Table #9: Login_Account				--
create table tblLogin_Account
(UserLoginID smallint not null foreign key references tblUserLogin(UserLoginID),
AccountID int not null foreign key references tblAccount(AccountID));
go

insert into tblLogin_Account values
(401, 102),
(402, 102),
(403, 101),
(404, 101),
(405, 101),
(406, 103),
(407, 104),
(408, 105),
(409, 106),
(410, 107),
(411, 108)

select * from tblLogin_Account
go

--				Table #10: LoginErrorLog				--
create table tblLoginErrorLog
(ErrorLogID int not null primary key,
UserLoginID smallint not null foreign key references tblUserLogin(UserLoginID),
ErrorTime datetime,
FailedTransactionXML xml);
go

insert into tblLoginErrorLog values
(1, 402, convert(datetime, '2020-12-19 8:30', 120), null),
(2, 402, convert(datetime, '2020-12-19 8:35', 120), null),
(3, 402, convert(datetime, '2020-12-19 8:40', 120), null),
(4, 405, convert(datetime, '2020-12-20 8:15', 120), null),
(5, 405, convert(datetime, '2020-12-20 8:22', 120), null),
(6, 406, convert(datetime, '2020-12-20 9:30', 120), null)

select * from tblloginerrorlog
go


/*
TABLES FOR CUSTOMER:
====================
Table #11: Customer, parent table for Customer_Account
Table #12: Customer_Account
*/

--				Table #11: Customer, parent table for Customer_Account				--
create table tblCustomer
(CustomerID int not null primary key,

CustomerAddress1 varchar(30) not null,
CustomerAddress2 varchar(30),

CustomerFirstName varchar(30) not null,
CustomerMiddleInitial char(1),
CustomerLastName varchar(30) not null,

City varchar(20) not null,
State char(2) not null,
ZipCode char(10) not null,

EmailAddress varchar(40),
HomePhone char(10),
CellPhone char(10) not null,
WorkPhone char(10),

SSN char(9) not null,
UserLoginID smallint not null foreign key references tblUserLogin(UserLoginID));
go

insert into tblCustomer values
(201, '123 King St.', null, 'John', 'J', 'Smith', 'Toronto', 'ON', 'A1B 2C3', 'JS@email.com', null, '6471111111', null, '123456789', 401),
(202, '123 King St.', null, 'Mary', null, 'Smith', 'Toronto', 'ON', 'A1B 2C3', 'MS@email.com', null, '647222222', null, '234567890', 402),
(203, '456 Queen St.', null, 'Emily', 'E', 'Reese', 'Vancouver', 'BC', 'A2B 3C4', 'ER@email.com', null, '6473333333', null, '345678901', 403),
(204, '456 Queen St.', null, 'Michelle', null, 'Long', 'Vancouver', 'BC', 'A2B 3C4', 'ML@email.com', null, '6474444444', null, '456789012', 404),
(205, '456 Queen St.', null, 'Sam', 'S', 'Lee', 'Vancouver', 'BC', 'A2B 3C4', 'SL@email.com', null, '6475555555', null, '567890123', 405),
(206, '111 Yonge St.', null, 'Tom', null, 'Walsh', 'Toronto', 'ON', 'A3B 2C3', 'TW@email.com', null, '6476666666', null, '678901234', 406),
(207, '111 Yonge St.', null, 'Jerry', 'J', 'Nicholls', 'Toronto', 'ON', 'A3B 2C3', 'JN@email.com', null, '6477777777', null, '789012345', 407),
(208, '789 Bloor St.', null, 'Iris', null, 'Ryan', 'Toronto', 'ON', 'A4B 5C6', 'IR@email.com', null, '6478888888', null, '890123456', 408),
(209, '321 Keel St.', null, 'Nicole', 'N', 'Gill', 'Vaughan', 'ON', 'A5B 6C7', 'NG@email.com', null, '6479999999', null, '901234567', 409),
(210, '678 Hwy 7', null, 'Justine', null, 'Bieber', 'Vaughan', 'ON', 'A6B 7C8', 'JB@email.com', null, '6471234567', null, '012345678', 410),
(211, '678 Hwy 7', null, 'Hailey', null, 'Baldwin', 'Vaughan', 'ON', 'A6B 7C8', 'HB@email.com', null, '6472345678', null, '135790246', 411)

select * from tblCustomer
go

--				Table #12: Customer_Account				--
create table tblCustomer_Account
(AccountID int not null foreign key references tblAccount(AccountID),
CustomerID int not null foreign key references tblCustomer(CustomerID));
go

insert into tblCustomer_Account values
(102,201),
(102,202),
(101,203),
(101,204),
(101,205),
(103,206),
(104,207),
(105,208),
(106,209),
(107,210),
(108,211),
(109, 201),
(109, 202),
(110, 203),
(111, 204),
(111, 205),
(112, 206),
(113, 207),
(113, 208),
(113, 209),
(114, 210),
(115, 211),
(116, 201),
(116, 202)

select * from tblCustomer_Account
go


/*
TABLES FOR EMPLOYEE AND TRANSACTIONS:
=====================================
Table #13: Employee, parent table for TransactionLog
Table #14: TransactionType, parent table for TransactionLog
Table #15: TransactionLog
Table #16: FailedTransactionErrorType, parent table for FailedTransactionLog
Table #17: FailedTransactionLog
*/

--				Table #13: Employee, parent table for TransactionLog				--
create table tblEmployee
(EmployeeID int not null primary key,
EmployeeFirstName varchar(25) not null,
EmployeeMiddleInitial char(1),
EmployeeLastName varchar(23) not null,
EmployeeIsManager bit not null);
go

insert into tblEmployee values
(301, 'Peng', null, 'Wang', 1),
(302, 'Sirena', 'S', 'Fairbank', 1),
(303, 'Sacha', null, 'Dean', 0),
(304, 'Juliet', 'M', 'Mullins', 1),
(305, 'Ashley', null, 'Poe', 0),
(306, 'Elmer', null, 'Boyd', 1)

select * from tblEmployee
go

--				Table #14: TransactionType, parent table for TransactionLog				--
create table tblTransactionType
(TransactionTypeID tinyint not null primary key,
TransactionTypeName char(10) not null,
TransactionTypeDescription varchar(50),
TransactionFeeAmount smallmoney not null);
go

insert into tblTransactionType values
(1, 'Deposit', 'Deposit Cash', 1.00),
(2, 'Withdraw', 'Withdraw Cash', 3.00),
(3, 'Check-in', 'Deposit by check', 5.00),
(4, 'Check-out', 'Withdraw by check', 5.00),
(5, 'E-Transfer', 'Email Transfer', 1.50),
(6, 'Online', 'Online Transfer', 1.00),
(7, 'Wire', 'Wire Transfer', 2.00)

select * from tblTransactionType
go

--				Table #15: TransactionLog				--
create table tblTransactionLog
(TransactionID int identity (500, 1) primary key,
TransactionDate datetime not null,
TransactionTypeID tinyint not null foreign key references tblTransactionType(TransactionTypeID),
TransactionAmount money not null,
NewBalance money not null,

AccountID int not null foreign key references tblAccount(AccountID),
CustomerID int not null foreign key references tblCustomer(CustomerID),
EmployeeID int not null foreign key references tblEmployee(EmployeeID),
UserLoginID smallint not null foreign key references tblUserLogin(UserloginID));
go

insert into tblTransactionLog values
(convert(datetime, '2020-12-11', 120), 7, 10000.00, 5000.00, 108, 211, 301, 411),
(convert(datetime, '2020-12-12', 120), 6, 5000.00, 3000.00, 107, 210, 302, 410),
(convert(datetime, '2020-12-13', 120), 7, 15000.00, 5500.00, 106, 209, 303, 409),
(convert(datetime, '2020-12-13', 120), 5, 1000.00, 1000.00, 105, 208, 304, 408),
(convert(datetime, '2020-12-13', 120), 4, 1000.00, 3000.00, 104, 207, 305, 407),
(convert(datetime, '2020-12-14', 120), 7, 1400.00, 7000.00, 103, 206, 306, 406),
(convert(datetime, '2020-12-14', 120), 3, 10600.00, 5600.00, 101, 205, 305, 405),
(convert(datetime, '2020-12-15', 120), 2, 7000.00, 3300.00, 101, 204, 304, 404),
(convert(datetime, '2020-12-16', 120), 7, 1000.00, 900.00, 101, 203, 303, 403),
(convert(datetime, '2020-12-16', 120), 1, 500.00, 1000.00, 102, 202, 302, 402),
(convert(datetime, '2020-12-17', 120), 7, 2000.00, 5000.00, 102, 201, 301, 401),
(convert(datetime, '2020-12-27', 120), 2, 99, 5000.00, 108, 211, 301, 411)
go

select * from tblTransactionLog
go

--				Table #16: FailedTransactionErrorType, parent table for FailedTransactionLog				--
create table tblFailedTransactionErrorType
(FailedTransactionErrorTypeID tinyint not null primary key,
FailedTransactionDescription varchar(50) not null);
go

insert into tblFailedTransactionErrorType values
(1, 'Account ID Does Not Exist'),
(2, 'Insufficient Account Balance'),
(3, 'Inactive Account'),
(4, 'Expired Check'),
(5, 'Other')

select * from tblFailedTransactionErrorType
go

--				Table #17: FailedTransactionLog				--
create table tblFailedTransactionLog
(FailedTransactionID int not null primary key,
FailedTransactionErrorTypeID tinyint not null foreign key references tblFailedTransactionErrorType(FailedTransactionErrorTypeID),
FailedTransactionErrorTime datetime not null,
FailedTransactionXML xml);
go

insert into tblFailedTransactionLog values
(601, 5, convert(datetime, '2020-12-01 12:05', 120), null),
(602, 4, convert(datetime, '2020-12-03 15:05', 120), null),
(603, 3, convert(datetime, '2020-12-05 17:05', 120), null),
(604, 2, convert(datetime, '2020-12-06 11:05', 120), null),
(605, 1, convert(datetime, '2020-12-20 1:05', 120), null)

select * from tblFailedTransactionLog
go



--				PROJECT PHASE TWO				--


--Q1: Create a view to get all customers with checking account from ON province.
--==============================================================================

drop view vwCheckingON--drop to testify different conditions
go

create view vwCheckingON as
select 
	c.CustomerID, 
	c.CustomerFirstName + ' ' + c.CustomerLastName [Customer Name], 
	c.City, 
	c.State, 
	atype.AccountTypeDescription,
	a.AccountID
from 
	tblCustomer c
	join tblCustomer_Account ca
	on c.CustomerID = ca.CustomerID
	join tblAccount a
	on ca.AccountID = a.AccountID
	join tblAccountType atype
	on a.AccountTypeID = atype.AccountTypeID
where 
	c.State = 'ON' and atype.AccountTypeDescription = 'Checking Account'
go

select * from vwCheckingON order by CustomerID
go


--Q2: Create a view to get all customers with total account balance (including interest rate) greater than 5000.
--==============================================================================================================

drop view vw5000--drop to testify different conditions
go

create view vw5000 as
select 
	c.CustomerID, 
	c.CustomerFirstName + ' ' + c.CustomerLastName [Customer Name], 
	sum(a.CurrentBalance * convert(money, (1 + r.InterestRateValue/12))) [Total Balance incl. Interest]
from 
	tblCustomer c 
	join tblCustomer_Account ca
	on c.CustomerID = ca.CustomerID
	join tblAccount a
	on ca.AccountID = a.AccountID
	join tblSavingsInterestRates r
	on a.InterestSavingsRateID = r.InterestSavingsRateID
group by 
	c.CustomerID, 
	c.CustomerFirstName,
	c.CustomerLastName
having
	sum(a.CurrentBalance * (1 + r.InterestRateValue/12)) > 5000
go

select * from vw5000
go

--As a reference, below table shows the current balance on customer's each account.
select
	c.CustomerID,
	c.CustomerFirstName + ' ' + c.CustomerLastName [Customer Name],
	a.AccountID,
	a.AccountTypeID,
	a.CurrentBalance,
	a.InterestSavingsRateID
from
	tblCustomer c 
	join tblCustomer_Account ca
	on c.CustomerID = ca.CustomerID
	join tblAccount a
	on ca.AccountID = a.AccountID
order by 
	c.CustomerID
go


--Q3: Create a view to get counts of checking and savings accounts by customer.
--=============================================================================

drop view vwACTypeCount--drop to testify different conditions
go

create view vwACTypeCount as
select 
	c.CustomerFirstName + ' ' + c.CustomerLastName [Customer Name],
	atype.AccountTypeDescription [Account Type],
	count(c.CustomerID) [Count of Account]
from 
	tblCustomer c 
	join tblCustomer_Account ca
	on c.CustomerID = ca.CustomerID
	join tblAccount a
	on ca.AccountID = a.AccountID
	join tblAccountType atype
	on a.AccountTypeID = atype.AccountTypeID
group by 
	c.CustomerFirstName, 
	c.CustomerLastName, 
	atype.AccountTypeDescription
go

select * from vwACTypeCount
go


--Q4: Create a view to get any user's login and password using Account ID.
--========================================================================

drop view vwLoginPass
go

create view vwLoginPass as
select
	a.AccountID,
	ul.UserName,
	ul.UserPassword
from
	tblUserLogin ul
	join tblLogin_Account la
	on ul.UserLoginID = la.UserLoginID
	join tblAccount a
	on la.AccountID = a.AccountID
go

select * from vwLoginPass
go


--Q5: Create a view to get all customer's overdraft amount.
--=========================================================

drop view vwOverDraft
go

create view vwOverDraft as
select
	c.CustomerFirstName + ' ' + c.CustomerLastName [Customer Name],
	a.AccountID,
	od.OverDraftAmount
from
	tblOverDraftLog od
	join tblAccount a
	on od.AccountID = a.AccountID
	join tblCustomer_Account ca
	on a.AccountID = ca.AccountID
	join tblCustomer c
	on ca.CustomerID = c.CustomerID
where od.OverDraftAmount > 0
go

select * from tblOverDraftLog--reference, account id 103 has zero amount
select * from vwOverDraft--account id 103 should not be selected
go


--Q6: Create a stored procedure to add "User_" as a prefix to everyone's login.
--=============================================================================

IF EXISTS (SELECT * FROM sys.procedures WHERE NAME='spLoginPrefix')
DROP PROC spLoginPrefix
GO  

create proc spLoginPrefix as
Begin
	update tblUserLogin
	set UserName = concat('User_', UserName)
	where left(UserName, 5) != 'User_'--avoid adding duplication.
End
go

exec spLoginPrefix

--test by removing 'User_' from a login name and see if proc will add it back or not?
update tblUserLogin
set UserName = 'UserName123'
where UserLoginID = 401

select * from tblUserLogin
go


--07: Create a stored procedure that accepts AccountID as a parameter and returns customer's full name.
--=====================================================================================================

IF EXISTS (SELECT * FROM sys.procedures WHERE NAME='spFullNameByAID')
DROP PROC spFullNameByAID
GO  

create proc spFullNameByAID
	@AID int, 
	@FullName nvarchar(50) output
as
begin
	if (@AID in (select AccountID from tblAccount))
		begin
				Select 
					@FullName = c.CustomerFirstName+' '+ISNULL(c.CustomerMiddleInitial, '')+' '+c.CustomerLastName
					--Use ISNULL to add nothing if middle name is NULL, otherwise will return NULL to full name.					
				from 
					tblCustomer c
					join tblCustomer_Account ca
					on c.CustomerID = ca.CustomerID
				where ca.AccountID = @AID;
				set @Fullname = replace (@FullName, '   ', ' ')
					/*in case middle name is null, there will be 2 spaces btw 1st name and 2nd name,
					use REPLACE to change double space to single space.*/					
		end
	else
		begin
			print 'Oops! This Account Id does not exist!'
		end
end
go

--valid account id
Declare @FN nvarchar(50)
exec spFullNameByAID 108, @FN out
Print 'The Full Name is: ' + @FN

--invalid account id
Declare @FN nvarchar(50)
exec spFullNameByAID 999, @FN out
Print 'Full name is ' + @FN
go


--Q8: Create a stored procedure that returns error logs inserted in the last 24 hours.
--====================================================================================

--insert 3 test items
insert into tblLoginErrorLog values
(8, 401, convert(datetime, '2020-12-26 13:00', 120), null), 
--within 24 hrs from now (2020-12-27 10:29 am)
--expect to be selected

(9, 405, convert(datetime, '2020-12-26 08:00', 120), null), 
--26.5 hrs from now (2020-12-27 10:30 am), though date looks as yesterday
--expect NOT to be selected

(10, 409, convert(datetime, '2020-12-26 10:30', 120), null); 
--exceeds 24 hrs from now (2020-12-27 10:35 am) by 5 minutes, hours are same
--expect NOT to be selected

insert into tblLoginErrorLog values
(11, 402, convert(datetime, '2020-12-26 17:00', 120), null)
--within 24 hrs from now (2020-12-27 16:05)
--expect to be selected

select * from tblLoginErrorLog
go

IF EXISTS (SELECT * FROM sys.procedures WHERE NAME='spErrorLog24')
DROP PROC spErrorLog24
GO

Create proc spErrorLog24 as
Begin
	select * 
	from tblLoginErrorLog e
	where e.ErrorTime > DATEADD(day, -1, getdate())
	--DATEADD(interval, increment int, expression smalldatetime) RETURNS smalldatetime.
End
Go

Exec spErrorLog24
go

--Q9: Create a stored procedure that takes a deposit as a parameter and updates CurrentBalance value for that particular account.
--===============================================================================================================================

IF EXISTS (SELECT * FROM sys.procedures WHERE NAME='spDeposit')
DROP PROC spDeposit
GO

Create proc spDeposit 
	@AcID int, 
	@Deposit money
as
Begin
	update tblAccount
	set CurrentBalance = CurrentBalance + @Deposit
	where AccountID = @AcID
End
go

select * from tblAccount--before
exec spDeposit 103, 99
select * from tblAccount--after
go


--Q10: Create a stored procedure that takes a withdraw as a parameter and updates.
--===============================================================================================================================

IF EXISTS (SELECT * FROM sys.procedures WHERE NAME='spWithdraw')
DROP PROC spWithdraw
GO

Create proc spWithdraw
	@AcID int, 
	@CustID int,
	@WithDraw money
as
Begin--update table Account
	update tblAccount
	set CurrentBalance = CurrentBalance - @WithDraw
	where AccountID = @AcID
End

Begin--update table transaction log

	--assign the original balance to a variable(OldBalance) - logic: Old$ - withdraw$ = new$
	declare @OldBalance money
	set @OldBalance = (
		--when there are multiple AcctID in the transaction log, use the latest balance from that accountID.
		select NewBalance from tblTransactionLog where TransactionDate = (
			select max(transactiondate) from tblTransactionLog where AccountID = @AcID and CustomerID = @CustID))
			

	--for each transaction, insert a new record to the transaction log.
	insert into tblTransactionLog 
	(
		TransactionDate, 
		TransactionTypeID, 
		TransactionAmount, 
		NewBalance, 
		AccountID, 
		CustomerID, 
		EmployeeID, 
		UserLoginID
	)
	values
	(
		getdate(), 
		2, 
		-@WithDraw, 
		@OldBalance-@WithDraw, 
		@AcID, 
		@CustID, 
		301, 
		(select UserLoginID from tblCustomer where CustomerID = @CustID)
	)
End
go

--before: ref AccountID 101, CustID 204
select * from tblAccount
select * from tblTransactionLog

exec spWithdraw 101, 204, 100.05

--after: ref AccountID 101, CustID 204
select * from tblAccount
select * from tblTransactionLog
go

