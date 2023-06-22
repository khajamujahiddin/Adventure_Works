CREATE DATABASE SalesData;



USE SalesData;

CREATE TABLE Salespeople
(
snum INT,
sname VARCHAR (30), 
city VARCHAR (50),
comm float
);

CREATE TABLE Cust
(
cnum INT,
cname VARCHAR (30), 
city VARCHAR (50),
rating INT,
snum INT
);

CREATE TABLE orders
(
onum INT,
amt float,
odate date,
cnum INT,
snum INT
);

INSERT INTO Salespeople
VALUES ('1001','Peel','London','0.12'),
('1002','Serres','London','0.13'),
('1003','Axelrod','San Jose','0.10'),
('1004','Motika','New York','0.11'),
('1007','Rafkin','Barcelona','0.15');


INSERT INTO Cust
VALUES 
('2001','Hoffman','London','100','1001'),
('2002','Giovanne','Rome','200','1003'),
('2003','Liu','San Jose','300','1002'),
('2004','Grass','Berlin','100','1002'),
('2006','Clemens','London','300','1007'),
('2007','Pereira','Rome','100','1004'),
('2008','James','London','200','1007');

INSERT INTO orders
VALUES 
('3001','18.69','1994-10-03','2008','1007'),
('3002','1900.10','1994-10-03','2007','1004'),
('3003','767.19','1994-10-03','2001','1001'),
('3005','5160.45','1994-10-03','2003','1002'),
('3006','1098.16','1994-10-04','2008','1007'),
('3007','75.75','1994-10-05','2004','1002'),
('3008','4723.00','1994-10-05','2006','1001'),
('3009','1713.23','1994-10-04','2002','1003'),
('3010','1309.95','1994-10-06','2004','1002'),
('3011','9891.88','1994-10-06','2006','1001');

SELECT  Cust.cname as cust_name, 
Salespeople.sname as Sales_person, 
Salespeople.city
FROM Cust, Salespeople
WHERE Salespeople.city != Cust.city;


SELECT  Cust.cname as cust_name, 
Salespeople.sname as Sales_person
FROM Cust
LEFT JOIN Salespeople
ON  Salespeople.snum = Cust.snum;

SELECT Cust.cname  as customer ,
Cust.city as c_city, 
Salespeople.city as s_city, orders.*
FROM Salespeople, Cust, orders
WHERE Cust.city <> Salespeople.city
AND orders.cnum = Cust.cnum 
AND orders.snum= Salespeople.snum;





SELECT orders.onum, 
Cust.cname as cust_name
FROM Cust
JOIN orders
ON  orders.cnum = Cust.cnum;

SELECT DISTINCT C.cname, U.cname,
Salespeople.sname
FROM Cust C, Cust U 
JOIN Salespeople
ON Salespeople.snum = C.snum 
WHERE C.snum = U.snum
AND C.cname != U.cname;

SELECT C.cname, U.cname,
C.rating
FROM Cust C, Cust U
WHERE C.rating = U.rating 
AND C.cname != U.cname;

SELECT a.cname,b.cname,c.sname 
FROM Cust a, Cust b,
Salespeople c 
WHERE a.snum=b.snum 
AND a.snum=c.snum;




SELECT a.sname, a.city AS Salesperson1_city,
b.sname, b.city AS Salesperson2_city
FROM salespeople a, salespeople b 
WHERE a.snum != b.snum 
AND a.city = b.city;

SELECT orders.*, 
Cust.cname as cust_name, 
Salespeople.sname
FROM Cust
JOIN orders
ON  orders.cnum = Cust.cnum
JOIN Salespeople
ON orders.snum = Salespeople.snum
WHERE Salespeople.snum = (SELECT snum 
FROM Cust 
WHERE cnum = '2008');



SELECT *
FROM orders
HAVING amt > (SELECT AVG(amt) 
FROM orders
WHERE odate = '1994-10-04');



SELECT orders.onum,Salespeople.snum, 
Salespeople.sname, Salespeople.city 
FROM orders
JOIN Salespeople
ON orders.snum = Salespeople.snum
WHERE Salespeople.city = 'London';



SELECT * FROM Cust
WHERE cnum > '1000' + (SELECT snum 
FROM Salespeople 
WHERE sname = 'Serres');

 SELECT * 
 FROM Cust 
 HAVING rating>= (SELECT AVG(rating) 
 FROM Cust 
 WHERE city='san jose');


SELECT a.sname
FROM Salespeople a, Cust b 
HAVING COUNT(a.snum = b.snum)>1;