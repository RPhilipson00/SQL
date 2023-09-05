CREATE DATABASE CS_Store; 
USE CS_Store; 

-- next 7 lines create the tables in the database, delcaring the column names, datatypes, and keys
CREATE TABLE Customers(birth_day date, first_name varchar(20), last_name varchar(20), c_id int, CONSTRAINT PK_Cust PRIMARY KEY (c_id)); 
CREATE TABLE Employees(birth_day date, first_name varchar(20), last_name varchar(20), e_id int, CONSTRAINT PK_Emp PRIMARY KEY (e_id)); 
CREATE TABLE Transactions(e_id int, c_id int, date date, t_id int, CONSTRAINT FK_TransEmp FOREIGN KEY (e_id) REFERENCES Employees(e_id), CONSTRAINT FK_TransCust FOREIGN KEY (c_id) REFERENCES Customers(c_id), CONSTRAINT PK_Trans PRIMARY KEY (t_id));
CREATE TABLE Items(price_for_each int, amount int, name VARCHAR(20), CONSTRAINT PK_Item PRIMARY KEY (name)); 
CREATE TABLE Promotions(discount int, p_id int,CONSTRAINT PK_Prom PRIMARY KEY (p_id));
CREATE TABLE ItemsInPromotions(name varchar(20), p_id int, amount int, CONSTRAINT FK_promotion_name FOREIGN KEY (name) REFERENCES Items(name), CONSTRAINT FK_promotionID FOREIGN KEY (p_id) REFERENCES Promotions(p_id));
CREATE TABLE ItemsInTransactions(name varchar(20), t_id int, amount int, CONSTRAINT FK_transaction_name FOREIGN KEY (name) REFERENCES Items(name), CONSTRAINT FK_transactionID FOREIGN KEY (t_id) REFERENCES Transactions(t_id));
  -- Data for Customers(birth_day, first_name, last_name, c_id) 
INSERT INTO Customers VALUES ('1993-07-11','Victor','Davis',1); 
INSERT INTO Customers VALUES ('2001-03-28','Katarina','Williams',2); 
INSERT INTO Customers VALUES ('1965-12-11','David','Jones',3); 
INSERT INTO Customers VALUES ('1980-10-10','Evelyn','Lee',4); 
-- Data for Employees(birth_day, first_name, last_name, e_id) 
INSERT INTO Employees VALUES ('1983-09-02','David','Smith',1); 
INSERT INTO Employees VALUES ('1990-07-23','Olivia','Brown',2); 
INSERT INTO Employees VALUES ('1973-05-11','David','Johnson',3); 
INSERT INTO Employees VALUES ('1999-11-21','Mia','Taylor',4); 
-- Data for Transactions(e_id*, c_id*, date, t_id) 
INSERT INTO Transactions VALUES (1,1,'2020-8-11',1); 
INSERT INTO Transactions VALUES (3,1,'2020-8-15',2); 
INSERT INTO Transactions VALUES (1,4,'2020-9-01',3); 
INSERT INTO Transactions VALUES (2,2,'2020-9-07',4); 
INSERT INTO Transactions VALUES (4,3,'2020-9-07',5); 
-- Data for Items(price_for_each, amount, name) 
INSERT INTO Items VALUES (110,22,'2l of milk'); 
INSERT INTO Items VALUES (99,30,'6 cans of lemonade'); 
INSERT INTO Items VALUES (150,20,'Pack of butter'); 
INSERT INTO Items VALUES (450,13,'Roast chicken'); 
INSERT INTO Items VALUES (99,30,'Pack of rice'); 
INSERT INTO Items VALUES (20,50,'Banana'); 
INSERT INTO Items VALUES (200,30,'3kg sugar'); 
INSERT INTO Items VALUES (150,15,'Toast bread'); 
INSERT INTO Items VALUES (150,18,'Earl Grey tea'); 
-- Data for Promotions(discount, p_id) 
INSERT INTO Promotions VALUES (99,1); 
INSERT INTO Promotions VALUES (200,2); 
INSERT INTO Promotions VALUES (150,3); 
INSERT INTO Promotions VALUES (150,4); 
-- Data for ItemsInPromotions(name*, p_id*, amount) 
INSERT INTO ItemsInPromotions VALUES ('6 cans of lemonade',1,2); 
INSERT INTO ItemsInPromotions VALUES ('Roast chicken',2,1); 
INSERT INTO ItemsInPromotions VALUES ('Pack of rice',2,1); 
INSERT INTO ItemsInPromotions VALUES ('Pack of butter',3,1); 
INSERT INTO ItemsInPromotions VALUES ('Toast bread',3,2); 
INSERT INTO ItemsInPromotions VALUES ('2l of milk',4,2); 
INSERT INTO ItemsInPromotions VALUES ('Banana',4,3); 
INSERT INTO ItemsInPromotions VALUES ('3kg sugar',4,2); 
-- Data for ItemsInTransactions(name*, t_id*, amount) 
INSERT INTO ItemsInTransactions VALUES ('6 cans of lemonade',1,1); 
INSERT INTO ItemsInTransactions VALUES ('Roast chicken',1,1); 
INSERT INTO ItemsInTransactions VALUES ('Pack of butter',1,1); 
INSERT INTO ItemsInTransactions VALUES ('Toast bread',1,1); 
INSERT INTO ItemsInTransactions VALUES ('2l of milk',1,2); 
INSERT INTO ItemsInTransactions VALUES ('Banana',1,3); 
INSERT INTO ItemsInTransactions VALUES ('3kg sugar',1,1); 
INSERT INTO ItemsInTransactions VALUES ('6 cans of lemonade',2,5); 
INSERT INTO ItemsInTransactions VALUES ('Pack of rice',2,1); 
INSERT INTO ItemsInTransactions VALUES ('6 cans of lemonade',3,3); 
INSERT INTO ItemsInTransactions VALUES ('Roast chicken',3,2); 
INSERT INTO ItemsInTransactions VALUES ('Pack of rice',3,1); 
INSERT INTO ItemsInTransactions VALUES ('Pack of butter',3,1); 
INSERT INTO ItemsInTransactions VALUES ('2l of milk',4,5); 
INSERT INTO ItemsInTransactions VALUES ('Banana',4,20); 
INSERT INTO ItemsInTransactions VALUES ('3kg sugar',4,8); 
INSERT INTO ItemsInTransactions VALUES ('6 cans of lemonade',5,10); 
INSERT INTO ItemsInTransactions VALUES ('Roast chicken',5,10); 
INSERT INTO ItemsInTransactions VALUES ('Pack of rice',5,10); 
INSERT INTO ItemsInTransactions VALUES ('Pack of butter',5,10); 
INSERT INTO ItemsInTransactions VALUES ('Toast bread',5,10); 
INSERT INTO ItemsInTransactions VALUES ('2l of milk',5,10); 
INSERT INTO ItemsInTransactions VALUES ('Banana',5,10); 
INSERT INTO ItemsInTransactions VALUES ('3kg sugar',5,10); 
INSERT INTO ItemsInTransactions VALUES ('Earl Grey tea',5,10); 
-- creates the first view
CREATE VIEW DavidSoldTo AS 
-- selects 3 fields from the customers table, joined with the employees and transactions tables
SELECT Distinct Customers.birth_day, Customers.first_name, Customers.last_name
FROM Customers, Employees, Transactions
-- filters out any employees named david, and then matches the the customer ids and emplyee ids in the seperate tables
WHERE Employees.first_name = "David" AND Customers.c_id = Transactions.c_id AND Employees.e_id = Transactions.e_id
-- sorts by birthday ascending
ORDER BY birth_day ASC;

select * From DavidSoldTo;

CREATE VIEW PeopleInShop AS
-- selects from the join of customers and transactions to find customers 
SELECT Distinct first_name AS first_name, last_name, birth_day
from Customers, Transactions
-- checks which customers made a transaction on the given date
WHERE Transactions.date = '2020-9-07' AND Customers.c_id = Transactions.c_id
UNION
-- unions with a 2nd select, joining the employees to the transactions
SELECT first_name, last_name, birth_day
from Employees, Transactions
-- finds which employees were working thart day
WHERE Transactions.date = '2020-9-07' AND Employees.e_id = Transactions.e_id
ORDER BY birth_day ASC;

SELECT * From PeopleInShop;

CREATE VIEW ItemsLeft AS
-- selects information about items, and assigns a maths function to the new field amount_left
-- the maths subtracts the sum amount bought of a given item from the original amount left of that item
SELECT DISTINCT Items.name, Items.Amount - SUM(ItemsInTransactions.Amount) AS amount_left
from Items, ItemsInTransactions
-- matches the name of the item in the 2 tables
WHERE Items.name=ItemsInTransactions.name
GROUP BY name
ORDER BY name ASC;

SELECT * FROM ItemsLeft;

-- creates an intermediate view to select all the transactions items, whether they satisfy an offer or not
CREATE VIEW alltranspromo AS
-- selects the ids, name and the number of times satisfied for each item
-- to get the number_of_times, I divide the amount of the item in the transactions table by the amount needed for the promotion.
SELECT Distinct ItemsInTransactions.t_id, ItemsInPromotions.p_id, ItemsInTransactions.name, (ItemsInTransactions.amount DIV ItemsInPromotions.amount) AS number_of_times
 FROM ItemsInTransactions, ItemsInPromotions
 -- matches the names of the items in the 2 tables
 WHERE ItemsInTransactions.name = ItemsInPromotions.name 
 UNION 
 -- unions with another select for the item that do not satisfy any offers, setting the number of times to 0 by default
 Select t_id, p_id, ItemsInPromotions.name, 0 AS number_of_times
 FROM ItemsInTransactions, ItemsInPromotions
 -- checks whether the name is in the promotions table
 WHERE ItemsInTransactions.name NOT IN (ItemsInPromotions.name) 
 GROUP BY t_id, name, p_id;
 
 -- create the main view
 CREATE VIEW PromotionItemsSatisfiedByTransactions AS
 -- selects distinct ids, and takes the names from the intermediate view
 SELECT DISTINCT t_id, p_id, alltranspromo.name AS name, number_of_times
 FROM Items, alltranspromo
 -- where the names from items are not in the intermediate, to remove duplicates
 WHERE items.name NOT IN (alltranspromo.name) 
 GROUP BY t_id, p_id, name
 ORDER BY t_id, p_id, name ASC;
 
 SELECT * FROM PromotionItemsSatisfiedByTransactions;

 
 
 
 
