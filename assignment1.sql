CREATE DATABASE CS_Store; 
USE CS_Store; 
CREATE TABLE Customers(birth_day date, first_name varchar(20), last_name varchar(20), c_id int, CONSTRAINT PK_Cust PRIMARY KEY (c_id)); 
CREATE TABLE Employees(birth_day date, first_name varchar(20), last_name varchar(20), e_id int, CONSTRAINT PK_Emp PRIMARY KEY (e_id)); 
CREATE TABLE Transactions(e_id int, c_id int, date date, t_id int, CONSTRAINT FK_TransEmp FOREIGN KEY (e_id) REFERENCES Employees(e_id), CONSTRAINT FK_TransCust FOREIGN KEY (c_id) REFERENCES Customers(c_id), CONSTRAINT PK_Trans PRIMARY KEY (t_id));
CREATE TABLE Items(price_for_each int, amount int, name VARCHAR(20), CONSTRAINT PK_Item PRIMARY KEY (name)); 
CREATE TABLE Promotions(discount int, p_id int,CONSTRAINT PK_Prom PRIMARY KEY (p_id));
CREATE TABLE ItemsInPromotions(name varchar(20), p_id int, amount int, CONSTRAINT FK_promotion_name FOREIGN KEY (name) REFERENCES Items(name), CONSTRAINT FK_promotionID FOREIGN KEY (p_id) REFERENCES Promotions(p_id));
CREATE TABLE ItemsInTransactions(name varchar(20), t_id int, amount int, CONSTRAINT FK_transaction_name FOREIGN KEY (name) REFERENCES Items(name), CONSTRAINT FK_transactionID FOREIGN KEY (t_id) REFERENCES Transactions(t_id));
 

CREATE VIEW DavidSoldTo AS 
SELECT Distinct Customers.birth_day, Customers.first_name, Customers.last_name
FROM Customers, Employees, Transactions
WHERE Employees.first_name = "David" AND Customers.c_id = Transactions.c_id AND Employees.e_id = Transactions.e_id
ORDER BY birth_day ASC;

select * From DavidSoldTo;

CREATE VIEW PeopleInShop AS
SELECT Distinct first_name AS first_name, last_name, birth_day
from Customers, Transactions
WHERE Transactions.date = '2020-9-07' AND Customers.c_id = Transactions.c_id
UNION
SELECT first_name, last_name, birth_day
from Employees, Transactions
WHERE Transactions.date = '2020-9-07' AND Employees.e_id = Transactions.e_id
ORDER BY birth_day ASC;

SELECT * From PeopleInShop;

CREATE VIEW ItemsLeft AS
SELECT DISTINCT Items.name, Items.Amount - SUM(ItemsInTransactions.Amount) AS amount_left
from Items, ItemsInTransactions
WHERE Items.name=ItemsInTransactions.name
GROUP BY name
ORDER BY name ASC;

SELECT * FROM ItemsLeft;

 CREATE VIEW PromotionItemsSatisfiedByTransactions AS
 SELECT Transactions.t_id, Promotions.p_id, Items.name, (ItemsInTransactions.amount DIV ItemsInPromotions.amount) AS number_of_times
 FROM Transactions, Promotions, Items, ItemsInTransactions, ItemsInPromotions
 WHERE ItemsInTransactions.p_id = ItemsInPromotions.p_id
 GROUP BY name;
 
 SELECT * 
 
 