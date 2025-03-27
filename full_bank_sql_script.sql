-- full bank sql script
-- create tables

create table Currencies (
	Currency_id serial primary key,
	Currency_code varchar,
	Currency_name varchar,
	Exchange_rate decimal,
	Last_updated date
);


create table Clients
(
	Client_id serial primary key,
	Fullname varchar,
	Phone varchar,
	Email varchar,
	Address varchar,
	Registration_date date,
	Status varchar
);


create table Accounts (
	Account_id serial primary key,
	Client_id integer references Clients (Client_id),
	Account_number varchar,
	Account_type varchar,
	Currency_id integer references Currencies (Currency_id),
	Amount integer,
	Interest_rate integer,
	Start_date date,
	End_date date,
	Status varchar
);


create table Loans
(
	Loan_id serial primary key,
	Client_id integer references Clients (Client_id),
	Loan_amount integer,
	Currency_id integer references Currencies (Currency_id),
	Interest_rate integer,
	Start_date date,
	End_date date,
	Status varchar
);

create table Loan_payments
(
	Payment_id serial primary key,
	Loan_id integer references Loans (Loan_id),
	Payment_amount integer,
	Payment_date date,
	Status varchar
);

create table Transactions
(
	Transaction_id serial primary key,
	Account_id integer references Accounts (Account_id),
	Transaction_type varchar,
	Amount integer,
	Currency_id integer references Currencies (Currency_id),
	Transaction_date date,
	Description varchar,
	Status varchar
);

create table Cards
(
	Card_id serial primary key,
	Client_id integer references Clients (Client_id),
	Account_id integer references Accounts (Account_id),
	Card_number varchar,
	Card_type varchar,
	Expiration_date date,
	Status varchar
);


create table branches
(
	Branch_id serial primary key,
	Branch_name varchar,
	Address varchar,
	Phone varchar
);

create table Employees
(
	Employee_id serial primary key,
	Fullname varchar,
	position varchar,
	Phone varchar,
	Email varchar,
	Hire_date date,
	Salary decimal,
	Branch_id integer references Branches (Branch_id)
);

create table Visits 
(
	Visit_id serial primary key,
	Client_id integer references Clients (Client_id),
	Branch_id integer references branches (Branch_id),
	Employee_id integer references Employees (Employee_id),
	Visit_date date,
	Purpose varchar
);

-- insert data

INSERT INTO Currencies (Currency_id, Currency_code, Currency_name, Exchange_rate, Last_updated)
VALUES 
(1, 'USD', 'US Dollar', 1.0, '2023-10-01'),
(2, 'EUR', 'Euro', 0.95, '2023-10-01'),
(3, 'GBP', 'British Pound', 0.82, '2023-10-01'),
(4, 'JPY', 'Japanese Yen', 145.0, '2023-10-01'),
(5, 'CAD', 'Canadian Dollar', 1.35, '2023-10-01');


INSERT INTO Clients (Fullname, Phone, Email, Address, Registration_date, Status)
VALUES 
('Emily White', '111-222-3333', 'emily.white@example.com', '789 Cedar St, City A', '2020-06-10', 'Active'),
('Michael Green', '222-333-4444', 'michael.green@example.com', '456 Walnut St, City B', '2021-08-15', 'Active'),
('Sophia Black', '333-444-5555', 'sophia.black@example.com', '123 Spruce St, City C', '2019-11-20', 'Inactive'),
('William Blue', '444-555-6666', 'william.blue@example.com', '789 Birch St, City D', '2022-03-05', 'Active'),
('Olivia Grey', '555-666-7777', 'olivia.grey@example.com', '321 Maple St, City E', '2023-01-10', 'Active');

INSERT INTO Accounts (Client_id, Account_number, Account_type, Currency_id, Amount, Interest_rate, Start_date, End_date, Status)
VALUES 
(11, 'ACC123456789', 'Savings', 1, 10000, 2.5, '2020-06-10', NULL, 'Active'),
(12, 'ACC987654321', 'Checking', 2, 5000, 1.0, '2021-08-15', NULL, 'Active'),
(13, 'ACC111222333', 'Savings', 1, 2000, 3.0, '2019-11-20', '2023-11-20', 'Inactive'),
(14, 'ACC444555666', 'Checking', 3, 15000, 1.5, '2022-03-05', NULL, 'Active'),
(15, 'ACC777888999', 'Savings', 2, 7500, 2.0, '2023-01-10', NULL, 'Active');


INSERT INTO Loans (Client_id, Loan_amount, Currency_id, Interest_rate, Start_date, End_date, Status)
VALUES 
(11, 50000, 1, 5.0, '2020-06-10', '2025-06-10', 'Active'),
(12, 30000, 2, 4.5, '2021-08-15', '2026-08-15', 'Active'),
(13, 10000, 1, 6.0, '2019-11-20', '2024-11-20', 'Inactive'),
(14, 75000, 3, 4.0, '2022-03-05', '2027-03-05', 'Active'),
(15, 20000, 2, 5.5, '2023-01-10', '2028-01-10', 'Active');

INSERT INTO Loan_payments (Loan_id, Payment_amount, Status)
VALUES 
(11, 10000, 'Completed'),
(12, 5000, 'Pending'),
(13, 2000, 'Completed'),
(14, 15000, 'Pending'),
(15, 4000, 'Completed');


INSERT INTO Transactions (Account_id, Transaction_type, Amount, Currency_id, Transaction_date, Status)
VALUES 
(16, 'Deposit', 1000, 1, '2023-09-01', 'Completed'),
(17, 'Withdrawal', 500, 2, '2023-09-05', 'Completed'),
(18, 'Transfer', 200, 1, '2023-09-10', 'Pending'),
(19, 'Deposit', 1500, 3, '2023-09-15', 'Completed'),
(20, 'Withdrawal', 300, 2, '2023-09-20', 'Completed');


INSERT INTO Cards (Client_id, Account_id, Card_type, Expiration_date, Status)
VALUES 
(11, 16, 'Debit', '2025-12-31', 'Active'),
(12, 17, 'Credit', '2026-06-30', 'Active'),
(13, 18, 'Debit', '2024-09-30', 'Inactive'),
(14, 19, 'Credit', '2027-03-31', 'Active'),
(15, 20, 'Debit', '2025-08-31', 'Active');


INSERT INTO Branches (Branch_name, Address, Phone)
VALUES 
('Main Branch', '123 Elm St, City A', '123-456-7890'),
('Downtown Branch', '456 Oak St, City B', '234-567-8901'),
('Eastside Branch', '789 Pine St, City C', '345-678-9012'),
('Westside Branch', '321 Maple St, City D', '456-789-0123'),
('North Branch', '654 Birch St, City E', '567-890-1234');


INSERT INTO Employees (Fullname, Position, Phone, Email, Hire_date, Salary, Branch_id)
VALUES 
('John Doe', 'Manager', '123-456-7890', 'john.doe@example.com', '2020-01-15', 50000, 1),
('Jane Smith', 'Manager', '234-567-8901', 'jane.smith@example.com', '2019-05-20', 52000, 2),
('Alice Johnson', 'Manager', '345-678-9012', 'alice.johnson@example.com', '2021-03-10', 51000, 3),
('Bob Brown', 'Manager', '456-789-0123', 'bob.brown@example.com', '2018-07-25', 53000, 4),
('Charlie Davis', 'Manager', '567-890-1234', 'charlie.davis@example.com', '2022-02-01', 54000, 5);

INSERT INTO Visits (Client_id, Branch_id, Employee_id, Visit_date, Purpose)
VALUES 
(11, 1, 1, '2023-01-01', 'Account Opening'),
(12, 2, 2, '2023-01-15', 'Loan Application'),
(13, 3, 3, '2023-02-11', 'Card Replacement'),
(14, 4, 4, '2023-03-01', 'Balance Inquiry'),
(15, 5, 5, '2023-04-01', 'Currency Exchange');


















