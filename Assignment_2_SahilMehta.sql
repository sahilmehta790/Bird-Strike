-- @uthor : Sahil Mehta 1226240927 : smehta70


--Question 3) 20 Questions - Let's go!

--1) List information on all the employees in the database

SELECT * FROM EMPLOYEE

--2) What carriers are there in the database? List the name of carriers without duplicates.

SELECT DISTINCT(Carrier) FROM ORDERS

--3) List information on the orders before ‘2012-11-01’.

SELECT * FROM ORDERS
	WHERE OrderDate < '2012-11-01'

--4) List OrderID, OrderDate, RequiredDate, and ShippedDate information on orders placed from January 2013 to April 2013, and order by the two following criteria: 
----(i) order date – the latest one comes first

SELECT OrderID, OrderDate, RequiredDate, ShippedDate FROM ORDERS
	WHERE OrderDate between '2013-01-01' AND '2013-04-03' ORDER BY OrderDate DESC

----(ii) ship date – the oldest one comes first (ordering by ship date should be applied after ordering the result by order date).

SELECT OrderID, OrderDate, RequiredDate, ShippedDate FROM ORDERS
	WHERE OrderDate between '2013-01-01' AND '2013-04-03' ORDER BY ShippedDate ASC

--5) List IDs of the customers whose company names start with “F” or “S”.

SELECT CustomerID from CUSTOMER 
	WHERE CompanyName LIKE 'F%' AND 'S%'

--6) List information on all the orders which did not ship by “UPS”.

SELECT * FROM ORDERS 
	WHERE Carrier NOT LIKE 'UPS'

--7) List information on the order details whose sales amount (i.e., unit price ✕ quantity) is less than 70. When you print out the information, make sure you include the sales amount for each row, name it as “Sales Amount”, and order the returned table by it in ascending order.

SELECT *, (UnitPrice*Quantity) as SalesAmount FROM ORDERDETAIL
	WHERE SalesAmount < 70 ORDER BY SalesAmount ASC

--8) List information on the employees whose address is identified (i.e., address value is not null).

SELECT * from Employee WHERE Address is NOT Null

--9) List information on the customers who live in one of the following states: IL, TX, or NV.

SELECT * FROM CUSTOMER 
	WHERE State like 'IL' OR 
		  State like 'TX' OR 
		  State like 'NV'

--10) Count the number of distinct products.

SELECT COUNT(DISTINCT ProductID) FROM ORDERDETAIL

--11) Count the number of distinct customers who placed at least one order.

SELECT COUNT(DISTINCT CustomerID) FROM ORDERS

----ASSUMPTION : If the customer has placed order then it will be definitely there in orders table

--12) Count the number of distinct customers who did not placed any order.

--13) Print out information on the employee who joined the team most recently. Since there might be multiple employees with the same joining date, write a command that prints out all the rows that satisfy the condition.

SELECT * FROM EMPLOYEE 
WHERE HireDate is(SELECT MAX(HireDate) AS RecentHireDate FROM EMPLOYEE)

--14) Print out the total sale. Make sure you name the printed-out column as “Total Sales”.

SELECT SUM(UnitPrice*Quantity) as TotalSales FORM ORDERDETAIL

--15) Calculate and print out the total payment for each carrier. The columns to be print out are Carrier and “Total Payment”\


SELECT Carrier, SUM(FreightCharge) as FinalCharge
FROM ORDERS
GROUP BY CARRIER

--16) From the result for (15), select only the carrier with the minimum payment.

SELECT Carrier, Min(FinalCharge) FROM (SELECT Carrier, SUM(FreightCharge) as FinalCharge FROM ORDERS GROUP BY Carrier)


--17) Create tables that comply with the following logical model and requirements:
---- MANUFACTURER(ManufactuerID, CompanyName, Address)
---- PRODUCT(ProductID, Category, Description, ManufacturerID)
---- FK (ManufaturerID) REFERENCES MANUFACTURER
---- CompanyName in MANUFACTURER should not be null.
---- Address in MANUFACTURER has a default value of “Tucson”.
---- Category in PRODUCT should be among one of the following values: “Electronics”,
---- “Household”, or “Grocery”

DROP TABLE MANUFACTURER
DROP TABLE PRODUCT

CREATE TABLE MANUFACTURER(
	ManufactureID INTEGER PRIMARY KEY NOT NULL,
	CompanyNAme VARCHAR(100) NOT NULL,
	ADDress VARCHAR(100) NOT NULL DEFAULT 'TUCSON');


CREATE TABLE PRODUCT(
	ProductID INTEGER PRIMARY KEY NOT NULL,
	Category VARCHAR(100) DEFAULT 'Electronics', 'Household', 'Grocery',
	Description VARCHAR(100),
	ManufactureID INTEGER NOT NULL,
	FOREIGN KEY ManufactureID REFERENCES MANUFACTURER (ManufactureID)
	);

--18)


INSERT INTO MANUFACTURER('431', 'Zell', 'Tempe');
INSERT INTO MANUFACTURER('790', 'Bapple');
INSERT INTO MANUFACTURER('222', 'La Apparel');

INSERT INTO PRODUCT('431', 'Electronics' ,'Zell', '1');
INSERT INTO PRODUCT('790', 'Household', 'Bell', '2');
INSERT INTO PRODUCT('222', 'Grocery', 'La Apparel', '3');

--19) Set all the null values for Address in EMPLOYEE to “Unknown”. You should be able to make the change with a single command.

UPDATE EMPLOYEE SET Address = 'Unknown' WHERE Address = Null;

--20) Set the FrieghtCharge of UPS to be a flat rate of 5.5.

UPDATE ORDERS SET FreightCharge = '5.5' WHERE Carrier = 'UPS'


