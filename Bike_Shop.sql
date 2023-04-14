#-----------------------DATABASE AND TABLE CREATION -------------------

CREATE DATABASE Bike_Shop;
CREATE TABLE employee
( employeeID       INT NOT NULL primary key,
  employeeName     VARCHAR(30) NOT NULL,
  position         VARCHAR(30),
  commissionRate   DECIMAL(2,2)
); 

CREATE TABLE customer
( customerID   INT NOT NULL primary key,
  customerName VARCHAR(30) NOT NULL,
  phoneNum     VARCHAR(15)
); 

CREATE TABLE bike
( bikeID   INT NOT NULL primary key,
  brand    VARCHAR(30) NOT NULL,
  model    VARCHAR(30) NOT NULL
  modelYear     INT
); 

CREATE TABLE shoporder
( orderID      INT NOT NULL primary key,
  employeeID   INT NOT NULL,
  customerID   INT NOT NULL,
  bikeID       INT NOT NULL,
  foreign key (employeeID) references employee(employeeID),
  foreign key (customerID) references customer(customerID),
  foreign key (bikeID) references bike(bikeID),
  quantity     INT,
  purchaseTime DATETIME,
  totalPrice   DECIMAL(7,2)
); 

#------------------------- DATA ENTRY --------------------------

INSERT INTO employee (employeeID, employeeName, position, commissionRate)
VALUES (0001, 'Isaac Hill', 'Sales Representative', .24),
       (0002, 'Gregory Barnett', 'Sales Representative', .28),
       (0003, 'Leticia Alvarado', 'Sales Representative', .25),
       (0004, 'Bessie Gonzales', 'Sales Representative', .20),
       (0005, 'Clinton Taylor', 'Sales Representative', .22),
       (0006, 'Jamie Clarke', 'Sales Representative', .21),
       (0007, 'Rita Jennings', 'Supervisor', .00),
       (0008, 'Mindy Myers', 'Manager', .00),
       (0009, 'Bridget Figueroa', 'Assistant Manager', .00),
       (0010, 'Willie Gray', 'General Manager', .00);

INSERT INTO customer (customerID, customerName, phoneNum)
VALUES (0001, 'Marshall Klein', '308-489-7223'),
       (0002, 'Deanna George', '850-448-2147'),
       (0003, 'Allison Lawrence', '765-872-7506'),
       (0004, 'Lamar Powers', '575-226-3447'),
       (0005, 'Carolyn Griffith', '479-348-2750'),
       (0006, 'Jared Powell', '202-565-6939'),
       (0007, 'Wilfred Quinn', '718-685-7902'),
       (0008, 'Jenna Walton', '727-257-7777'),
       (0009, 'Terri Barnett', '704-562-4400'),
       (0010, 'Leonard Edwards', '850-338-5819')

INSERT INTO bike (bikeID, brand, model, modelYear)
VALUES (0001, 'Specialized', 'Fuse Comp 29', 2022),
       (0002, 'Specialized', 'Crossroads 1.0', 2022),
       (0003, 'Specialized', 'Jett 24', 2023),
       (0004, 'Trek', 'Checkpoint ALR 5', 2022),
       (0005, 'Trek', 'Checkpoint SL 5', 2023),
       (0006, 'Trek', '820 WSD', 2022),
       (0007, 'Trek', 'Marlin 5 Gen 2', 2023),
       (0008, 'Cannondale', 'Adventure 1', 2022),
       (0009, 'Cannondale', 'CAAD Optimo', 2021),
       (0010, 'Specialized Turbo', 'Como 3.0', 2023);

INSERT INTO shoporder (orderID, employeeID, customerID, bikeID, quantity, purchaseTime, totalPrice)
VALUES (0001, 0003, 0004, 0007, 1, '2023-01-28 12:30:13', 632.77),
       (0002, 0005, 0008, 0006, 1, '2023-02-24 08:35:55', 512.80),
       (0003, 0001, 0007, 0001, 1, '2023-01-18 10:12:00', 2932.03),
       (0004, 0002, 0003, 0002, 1, '2023-01-01 13:45:41', 694.59),
       (0005, 0003, 0010, 0003, 1, '2023-03-03 16:39:30', 502.14),
       (0006, 0004, 0009, 00010, 2, '2023-02-11 15:55:29', 6632.41),
       (0007, 0005, 0005, 0005, 1, '2023-02-17 12:00:27', 3332.27),
       (0008, 0005, 0006, 0008, 1, '2023-03-01 14:29:39', 1002.05),
       (0009, 0003, 0002, 0004, 2, '2023-03-01 18:30:11', 2699.99),
       (0010, 0006, 0001, 0009, 2, '2023-03-02 19:00:02', 1132.55),
       (0011, 0001, 0002, 0002, 1, '2023-01-13 08:59:31', 694.59);

#-------------------- QUERIES --------------------
/*
#Count the amount of orders that have sold product worth more than $1000
SELECT COUNT(*)
FROM shoporder
WHERE totalPrice > 1000;

#Joins Employees with order to calculate how much money the employee will make on their commission and is ordered by commission amount
SELECT employee.employeeID, employee.employeeName, shoporder.orderId, shoporder.totalPrice, ROUND(employee.commissionRate*shopOrder.totalPrice, 2) AS commission
FROM employee
LEFT JOIN shoporder ON employee.employeeID = shoporder.employeeID
ORDER BY commission DESC

#Joins bike with their order to see how much the bike will be after taxes ordered by bikeID
SELECT bike.bikeID, bike.brand, bike.model, bike.modelYear, shoporder.totalPrice
FROM bike
LEFT JOIN shoporder ON bike.bikeID = shoporder.bikeID
ORDER BY bike.bikeID

#Joins shoporder with employee, customer, and bike to show which employee sold what type of bike to what customer and how many. This is ordered by employeeID
SELECT employee.employeeID, employee.employeeName, customer.customerName, bike.brand, bike.model, bike.modelYear, shoporder.quantity
FROM shoporder
LEFT JOIN employee ON shoporder.employeeID = employee.employeeID
LEFT JOIN customer ON shoporder.customerID = customer.customerID
LEFT JOIN bike ON shoporder.bikeID = bike.bikeID
ORDER BY employee.employeeID


#Joins shoporder with customer, and bike to show how much a customer spent on buying different bikes and is ordered by customerID
SELECT customer.customerID, customer.customerName, bike.brand, bike.model, bike.modelYear, shopOrder.totalPrice
FROM shoporder
LEFT JOIN customer ON shoporder.customerID = customer.customerID
LEFT JOIN bike ON shoporder.bikeID = bike.bikeID
ORDER BY customer.customerID
*/