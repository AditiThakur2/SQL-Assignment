alter table Customers
alter column Phone bigint

alter table Orders
alter column OrderDate Date 

alter table Products
alter column Price float

alter table Inventory
alter column LastStockUpdate datetime

truncate table OrderDetails
select * from Products

alter table Products
add Category varchar(100)

update Products set Category='Electronic Gadgets' where ProductID between 1 and 11
update Products set ProductName='Router', Description='High Speed Wireless Router' where ProductID=11
INSERT INTO Products VALUES
(12,'Book', 'Classic literature', 199,'Non-electrical'),
(13,'Coffee Maker', 'Automatic drip coffee maker', 1499,'Non-electrical'),
(14,'Backpack', 'Durable hiking backpack',1399,'Non-electrical'),
(15,'Running Shoes', 'High-performance running shoes', 1000,'Non-electrical'),
(16,'Cookware Set', 'Stainless steel cookware set',500,'Non-electrical')

--Query

--insert sample records into customers
insert into Customers values(1,'John','Johnson','johnjohnson123@gmail.com',7652890032,'123 Maple St'),(2,'Sophia','Davis','sophia342@gmail.com',9232456780,'456 Oak Ave'),(3,'Noah','Martinez','noah.martinez@email.com',7768990045,'789 Pine Ln'),(4,'Olivia','Taylor','olivia.taylor@email.com',9763456280,'101 Elm Dr'),(5,'Jackson','Brown','jackson.brown@email.com',6843356789,'222 Cedar Ct'),(6,'Ava','Clark','ava.clark@email.com',9998762345,'333 Birch Rd'),(7,'Lucas','Adams','lucas.adams@email.com',8834562311,'444 Spruce Blvd'),(8,'Mia','Turner','mia.turner@email.com',6344345678,'555 Willow Pl'),(9,'Ethan','Baker','ethan.baker@email.com','7676789005','666 Aspen Ave'),(10,'Isabella','White','isabella.white@email.com',9450036627,'777 Juniper Ln')
insert into Products values(1,'Laptop', 'High-performance laptop', 999),(2,'Smartphone', 'High-end smartphone', 799),(3,'Tablet', 'Slim and lightweight tablet', 299),(4,'Smart TV', '4K UHD Smart TV', 1499),(5,'Headphones', 'Noise-canceling headphones', 129),(6,'Digital Camera', 'Professional digital camera', 899),(7,'Fitness Tracker', 'Water-resistant fitness tracker', 49),(8,'Gaming Console', 'Next-gen gaming console', 499),(9,'Wireless Earbuds', 'Bluetooth wireless earbuds', 79),(10,'External Hard Drive', '1TB External Hard Drive', 79)
insert into Orders values(1,6,'2023-01-01',100),(2,6,'2023-01-02',200),(3,1,'2023-01-03', 150),(4,2, '2023-01-04', 300),(5,2, '2023-01-05', 180),(6,7,'2023-01-06', 250),(7,9, '2023-01-07', 120),(8,3,'2023-01-08', 350),(9,4, '2023-01-09', 270),(10,1, '2023-01-10', 180)
insert into OrderDetails values(1,1,1,2),(2,2,2,1),(3,3,3,1),(4,4,4,1),(5,5,5,2),(6,6,6,2),(7,7,7,1),(8,8,8,1),(9,9,9,3),(10,10,10,2)
insert into Inventory values (1,1,20,'2023-01-15 10:30:00'),(2,2,15,'2023-01-15 11:45:00'),(3,3,30,'2023-01-16 09:15:00'),(4,4,25,'2023-01-16 14:00:00'),(5,5,18,'2023-01-17 12:20:00'),(6,6,22,'2023-01-17 15:45:00'),(7,7,28,'2023-01-18 08:30:00'),(8,8,12,'2023-01-18 10:00:00'),(9,9,35,'2023-01-19 11:30:00'),(10,10,40,'2023-01-19 14:15:00')

--to retrieve the names and emails of all customers
select FirstName, LastName, Email from Customers

--to list all orders with their order dates and corresponding customer names
select O.OrderID,O.OrderDate,Concat(FirstName,' ',LastName) as CustomersName
from Orders as O
join Customers as C on O.CustomerID=C.CustomerID


--to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address.
insert into Customers values(11,'Tim','Hortan','tim.hortan123@gmail.com',7652890056,'123 St. Thomas')

--to update the prices of all electronic gadgets in the "Products" table by increasing them by 10%.
update Products set Price = Price * 1.10 where description='High-end smartphone'
select * from Products

--to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.
declare @OrderIDToDelete INT = 1
delete from OrderDetails where OrderID = @OrderIDToDelete
delete from Orders where OrderID = @OrderIDToDelete

--to insert a new order into the "Orders" table. Include the customer ID, order date, and any other necessary information.
insert into Orders values (11,2, '2023-02-01', 1499)
select * from Orders

--to update the contact information (e.g., email and address) of a specific customer in the "Customers" table. Allow users to input the customer ID and new contact information.
declare @CustomerIDToUpdate int 
update Customers set Email = 'new.email@email.com', Address = '789 Elm St' where CustomerID = @CustomerIDToUpdate
select * from Customers

--to recalculate and update the total cost of each order in the "Orders" table based on the prices and quantities in the "OrderDetails" table.
insert into OrderDetails values(11,11,11,3)

update Orders
set TotalAmount=(select sum(OD.Quantity*P.Price)
from OrderDetails as OD 
join Products as P on OD.ProductID=P.ProductID
where OD.OrderID=Orders.OrderID)

select * from Orders

--to delete all orders and their associated order details for a specific customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter.
declare @CustomerIDToDelete int=2
delete from OrderDetails where OrderID in (select OrderID from Orders where CustomerID = @CustomerIDToDelete)
delete from Orders where CustomerID = @CustomerIDToDelete

--to insert a new electronic gadget product into the "Products" table, including product name, category, price, and any other relevant details.
insert into Products values(11,'Smartphone', 'High-end smartphone', 799)
select * from Products

--to update the status of a specific order in the "Orders" table (e.g., from "Pending" to "Shipped"). Allow users to input the order ID and the new status.
alter table Orders 
add Status varchar(50)

update Orders set Status='Pending'

declare @OrderIDToUpdate int=2
update Orders set Status = 'Shipped' WHERE OrderID = @OrderIDToUpdate

select * from Orders

--to calculate and update the number of orders placed by each customer in the "Customers" table based on the data in the "Orders" table.
alter table Customers
add NoOfOrders int

update Customers
set NoOfOrders = (select count(*) from Orders where Orders.CustomerID = Customers.CustomerID)
select * from Customers



--Aggregate Functions

--find out which customers have not placed any orders.
select C.CustomerID, C.FirstName, C.LastName
from Customers as C
left join Orders as O ON C.CustomerID = O.CustomerID
where O.CustomerID IS NULL
select * from Orders


--find the total number of products available for sale. 
select count(*) as TotalProducts FROM Products


--calculate the total revenue generated by TechShop. 
select sum(TotalAmount) AS TotalRevenue from Orders


--calculate the average quantity ordered for products in a specific category. Allow users to input the category name as a parameter.
declare @CategoryName varchar(255) = 'Electronic Gadgets';
select AVG(Quantity) as AQ
FROM OrderDetails OD
JOIN Products as P ON OD.ProductID = P.ProductID
where P.Category = @CategoryName


--calculate the total revenue generated by a specific customer. Allow users to input the customer ID as a parameter.
declare @CustomerID INT
select sum(TotalAmount) AS TotalRevenue from Orders where CustomerID = @CustomerID


--find the customers who have placed the most orders. List their names and the number of orders they've placed.
SELECT top 1 Customers.CustomerID, FirstName, LastName, COUNT(Orders.OrderID) AS OrderCount
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, FirstName, LastName
ORDER BY OrderCount DESC


--find the most popular product category, which is the one with the highest total quantity ordered across all orders.
SELECT top 1 Products.Category, SUM(OrderDetails.Quantity) AS TotalQuantityOrdered
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.Category
ORDER BY TotalQuantityOrdered DESC


--find the customer who has spent the most money (highest total revenue) on electronic gadgets. List their name and total spending.
select TOP 1 C.CustomerID, FirstName, LastName, SUM(O.TotalAmount) AS TotalSpending
from Customers as C
join Orders as O ON C.CustomerID = O.CustomerID
join OrderDetails as OD ON O.OrderID = OD.OrderID
join Products as P ON OD.ProductID = P.ProductID
where P.Category = 'Electronic Gadgets'
Group by C.CustomerID, FirstName, LastName
ORDER BY TotalSpending desc


select * from Customers
select * from Products
select * from Orders 
select * from OrderDetails


--calculate the average order value (total revenue divided by the number of orders) for all customers.
select avg(TotalAmount) AS AvgOrderValue from Orders


--find the total number of orders placed by each customer and list their names along with the order count
SELECT Customers.CustomerID, FirstName, LastName, COUNT(Orders.OrderID) AS OrderCount
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, FirstName, LastName






--JOINS

--1. Write an SQL query to retrieve a list of all orders along with customer information (e.g., customer name) for each order.
select O.OrderID,C.CustomerId,Concat(FirstName,' ',LastName) as CName,C.Email,C.Phone,C.Address
from Orders as O 
join Customers as C
on O.CustomerID=C.CustomerID


--2. Write an SQL query to find the total revenue generated by each electronic gadget product. Include the product name and the total revenue.
select P.ProductID, P.ProductName,(OD.Quantity*P.Price) as TotalRevenue
from Products as P 
join OrderDetails as OD 
on P.ProductID=OD.OderDetailID
where P.Category='Electronic Gadgets'


--3. Write an SQL query to list all customers who have made at least one purchase. Include their names and contact information.
select Distinct(C.CustomerID),Concat(FirstName,' ',LastName) as CName,C.Phone
from Customers as C
join Orders as O 
on C.CustomerID=O.CustomerID
order by CustomerID


--4. Write an SQL query to find the most popular electronic gadget, which is the one with the highest total quantity ordered. Include the product name and the total quantity ordered.
select Top 1 P.ProductName,OD.Quantity
from Products as P
join OrderDetails as OD
on P.ProductID=OD.ProductID
order by Quantity desc


--5.Write an SQL query to retrieve a list of electronic gadgets along with their corresponding categories.
select ProductName, Category
from Products
where Category = 'Electronic Gadgets'


--6. Write an SQL query to calculate the average order value for each customer. Include the customer's name and their average order value.
select Concat(FirstName,' ',LastName) as CName, AVG(OD.Quantity * P.Price) AS AverageOrderValue
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY C.FirstName, C.LastName


--7. Write an SQL query to find the order with the highest total revenue. Include the order ID, customer information, and the total revenue.
select TOP 1 O.OrderID,P.ProductID, P.ProductName,Concat(FirstName,' ',LastName) as CName,C.Phone,(OD.Quantity*P.Price) as TotalRevenue
from Products as P 
join OrderDetails as OD on P.ProductID=OD.OderDetailID
join Orders as O on OD.OrderID=O.OrderID
join Customers as C on O.CustomerID=C.CustomerID
order by TotalRevenue desc  


--8. Write an SQL query to list electronic gadgets and the number of times each product has been ordered.
select P.ProductID,P.ProductName,P.Category,OD.Quantity
from Products as  P
join OrderDetails as OD
on P.ProductID=OD.ProductID
where P.Category='Electronic Gadgets'


--9. Write an SQL query to find customers who have purchased a specific electronic gadget product. Allow users to input the product name as a parameter.
declare @productname varchar(50)='Laptop'
select C.CustomerId,Concat(FirstName,' ',LastName) as CName,@productname as ProductNAme
from Customers as C
join Orders as O on C.CustomerID=O.CustomerID
join OrderDetails as OD on O.OrderID=OD.OrderID
join Products as P on OD.ProductID=P.ProductID
where P.ProductName=@productname



--10. Write an SQL query to calculate the total revenue generated by all orders placed within a specific time period. Allow users to input the start and end dates as parameters.
declare @startdate date = '2023-01-03'
declare @enddate date='2023-01-07'
select O.OrderID,P.ProductID,P.ProductName,(OD.Quantity*P.Price) as TotalRevenue
from Orders as O
join OrderDetails as OD on O.OrderID=OD.OrderID
join Products as P on OD.ProductID=P.ProductID
where OrderDate Between @startdate and @enddate