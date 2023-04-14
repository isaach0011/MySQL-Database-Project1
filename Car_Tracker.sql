#-----------------------DATABASE AND TABLE CREATION -------------------

CREATE DATABASE towing_company;
CREATE TABLE employee
( employeeID       INT NOT NULL primary key,
  employeeName     VARCHAR(30) NOT NULL,
  position         VARCHAR(30),
  commissionRate   DECIMAL(2,2)
); 

CREATE TABLE car
( carID         INT NOT NULL primary key,
  make          VARCHAR(30) NOT NULL,
  model         VARCHAR(30) NOT NULL,
  modelYear     INT,
  color         VARCHAR(30),
  licensePlate  VARCHAR(7) NOT NULL
);

CREATE TABLE towlog
( logID        INT NOT NULL primary key,
  employeeID   INT NOT NULL,
  carID        INT NOT NULL,
  foreign key (employeeID) references employee(employeeID),
  foreign key (carID) references car(carID),
  timeTowed    DATETIME,
  location     VARCHAR(30),
  timeKept     VARCHAR(30),
  releasePrice DECIMAL(6,2),
  towPrice     DECIMAL(5,2)
);

#------------------------- DATA ENTRY --------------------------
INSERT INTO employee (employeeID, employeeName, position, commissionRate)
VALUES (0001, 'Isaac Hill', 'Towtruck Operator', .30),
       (0002, 'Ervin Lamb', 'Towtruck Operator', .28),
       (0003, 'Sylvester Myers', 'Towtruck Operator', .27),
       (0004, 'Alexis Lewis', 'Towtruck Operator', .29),
       (0005, 'Luther Lindsey', 'Garage Worker', .00),
       (0006, 'Dorothy Day', 'Garage Worker', .00),
       (0007, 'Leona Rice', 'Supervisor', .00),
       (0008, 'Mabel Hawkins', 'Manager', .00),
       (0009, 'Taylor Wood', 'Assistant Manager', .00),
       (0010, 'Jeff Gray', 'Owner', .00);

INSERT INTO car (carID, make, model, modelYear, color, licensePlate)
VALUES (0001, 'Ford', 'F150', 2020, 'White', 'V26 5KG'),
	   (0002, 'Dodge', 'Ram 2500', 2009, 'Black', 'W26 1BP'),
       (0003, 'Toyota', 'Prius', 2012, 'Red', 'U73 4RT'),
       (0004, 'Mercedes-Benz', 'GL500', 2014, 'Gray', 'A20 6AL'),
       (0005, 'Subaru', 'XV', 2017, 'White', 'T30 1YX'),
       (0006, 'Toyota', 'Matrix', 2012, 'Gray', 'T79 1HJ'),
       (0007, 'Volvo', 'V40', 2004, 'White', 'Z82 9WJ'),
       (0008, 'BMW', 'X5', 2023, 'Black', 'Y94 7SX'),
       (0009, 'Maserati', 'Coupe', 2020, 'Blue', '2FAST4U'),
       (0010, 'Ford', 'F250', 2022, 'Gray', 'T57 6MN');

INSERT INTO towlog (logID, employeeID, carID, timeTowed, location, timeKept, releasePrice, towPrice)
VALUES (0001, 0004, 0007, '2023-01-03 03:25:05', 'Orem, Utah', '6 Days', 556.75, 100.49),
       (0002, 0001, 0009, '2023-01-08 08:55:46', 'Draper, Utah', '2 Days', 345.08, 126.28),
       (0003, 0003, 0002, '2023-01-15 18:02:38', 'Salt Lake City, Utah', '1 Day', 209.01, 150.23),
       (0004, 0003, 0003, '2023-01-25 23:39:57', 'Provo, Utah', '2 Days', 298.97, 105.89),
       (0005, 0001, 0008, '2023-02-05 08:00:00', 'Sandy, Utah', '3 Days', 314.38, 135.14),
       (0006, 0002, 0010, '2023-02-12 07:59:22', 'Lehi, Utah', '4 Days', 457.24, 115.99),
       (0007, 0004, 0006, '2023-02-18 12:45:31', 'Saratoga Springs, Utah', '1 Day', 212.88, 121.18),
       (0008, 0002, 0005, '2023-02-26 13:12:45', 'Orem, Utah', '6 Days', 599.49, 102.42),
       (0009, 0001, 0009, '2023-02-28 15:26:02', 'Draper, Utah', '1 Day', 300.98, 129.73),
       (0010, 0004, 0001, '2023-03-01 02:37:51', 'West Jordan, Utah', '2 Days', 281.73, 142.03),
       (0011, 0002, 0004, '2023-03-03 05:48:29', 'Bluffdale, Utah', '1 Days', 223.21, 120.48);

#-------------------- QUERIES --------------------
/*
#Pairs towlog and car to show how much it took to get the car out of the lot (releasePrice + towPrice) and this is ordered by logID
SELECT towlog.logID, car.make, car.model, car.modelYear, car.color, car.licensePlate, (towlog.releasePrice + towlog.towPrice) AS totalPrice
FROM towlog
INNER JOIN car ON towlog.carID = car.carID
ORDER BY towlog.logID

#Pairs employee and towlog to show how much the towtruck operator will make for their commission on the specific tow they did. This is ordered by the commission
SELECT employee.employeeID, employee.employeeName, employee.commissionRate, towlog.towPrice, ROUND(towlog.towPrice * employee.commissionRate, 2) AS commission
FROM employee
INNER JOIN towlog ON employee.employeeID = towlog.employeeID
ORDER BY commission DESC

#Joins car and towlog to show the information of the car and the time, location and how long it was kept for. This is ordered by carID
SELECT car.carID, car.make, car.model, car.modelYear, car.color, car.licensePlate, towlog.timeTowed, towlog.location, towlog.timeKept
FROM car
INNER JOIN towlog ON towlog.carID = car.carID
ORDER BY car.carID

#Joins employee and towlog to show where they have towed from, the time they towed, and the price from the location. This is ordered by employeeID
SELECT employee.employeeID, employee.employeeName, towlog.location, towlog.timeTowed, towlog.towPrice
FROM employee
INNER JOIN towlog ON employee.employeeID = towlog.employeeID
ORDER BY employeeID 

#Counts how many cars have passed through their lot
SELECT COUNT(*)
FROM car
*/
