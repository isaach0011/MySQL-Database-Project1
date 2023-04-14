#-----------------------DATABASE AND TABLE CREATION -------------------

CREATE DATABASE Feeding_Tracker;
CREATE TABLE employee
( employeeID   INT NOT NULL primary key,
  employeeName VARCHAR(30),
  position     VARCHAR(30),
  hourly_pay   DECIMAL(5,2)
); 

CREATE TABLE dog
( dogID          INT NOT NULL primary key,
  dogName        VARCHAR(30),
  employeeID     INT NOT NULL,
  foreign key (employeeID) references employee(employeeID),
  ownerName      VARCHAR(30),
  ownerPhoneNum  VARCHAR(15),
  dropOffDate    DATE,
  estPickUpDate  DATE
);

CREATE TABLE feedlog
( logID      INT NOT NULL primary key,
  employeeID INT,
  dogID      INT,
  foreign key (employeeID) references employee(employeeID),
  foreign key (dogID) references dog(dogID),
  timeFed    DATETIME,
  foodBrand  VARCHAR(30)
);

#------------------------- DATA ENTRY --------------------------

INSERT INTO employee (employeeID, employeeName, position, hourly_pay) 
VALUES (0001, "Isaac Hill", "Kennel Technician", 15.00),
	   (0002, "Duncan Nguyen", "Kennel Technician", 16.00),
       (0003, "Zach Hymas", "Janitor", 13.00),
       (0004, "Ray Parker", "Kennel Technician", 15.00),
       (0005, "Brandon Briggs", "Kennel Technician", 15.00),
       (0006, "Mary Corbet", "Assistant Manager", 19.00),
       (0007, "Ryan Stone", "Manager", 22.00),
       (0008, "Margaret Valente", "Manager", 22.00),
       (0009, "Marisa Hernandez", "Owner", 999.00),
       (0010, "Shelby Gordon", "Supervisor", 26.00);

INSERT INTO dog (dogID, dogName, employeeID, ownerName, ownerPhoneNum, dropOffDate, estPickUpDate)
VALUES (0001, 'Dexter', 0003, 'Mike Tamms', '801-278-7234', '2023-02-15', '2023-03-05'),
       (0002, 'Eris', 0009, 'Marisa Hernandez', '435-555-2314', '2023-02-23', '2023-03-15'),
       (0003, 'Hunny', 0005, 'David Tannen', '614-282-2681', '2023-02-03', '2023-03-17'),
       (0004, 'Elroy', 0001, 'Blake Jenson', '607-288-7494', '2023-02-01', '2023-03-10'),
       (0005, 'Melly', 0007, 'Logan Bryne', '352-452-6029', '2023-02-02', '2023-03-09'),
       (0006, 'Harley', 0004, 'Ray Parker', '760-396-1056', '2023-02-15', '2023-03-08'),
       (0007, 'Maverick', 0006, 'Aiden Foster', '434-888-2083', '2023-02-20', '2023-03-05'),
       (0008, 'Kayana', 0010, 'Jacob Squire', '910-686-5252', '2023-02-21', '2023-03-04'),
       (0009, 'Soldier', 0008, 'Robin Wayne', '201-555-7584', '2023-02-23', '2023-03-01'),
       (0010, 'Minty', 0002, 'Arthur Smith', '952-536-8488', '2023-02-23', '2023-03-02');

INSERT INTO feedlog (logID, employeeID, dogID, timeFed, foodBrand)
VALUES #(0001, 0003, 0001, '2023-03-01 10:30:23', 'Instinct')
       (0002, 0009, 0002, '2023-03-01 10:25:23', 'Purina'),
       (0003, 0005, 0003, '2023-03-01 10:40:45', 'Blue Buffalo'),
       (0004, 0001, 0004, '2023-03-01 10:45:00', 'Nulo'),
       (0005, 0007, 0005, '2023-03-01 10:33:05', 'Purina'),
       (0006, 0004, 0006, '2023-03-01 10:10:10', 'Purina'),
       (0007, 0006, 0007, '2023-03-01 10:24:27', 'Eagle Pack'),
       (0008, 0010, 0008, '2023-03-01 10:55:37', 'Nulo'),
       (0009, 0008, 0009, '2023-03-01 10:11:11', 'Instinct'),
       (0010, 0002, 0010, '2023-03-01 10:03:55', 'Purina');

#-------------------- QUERIES --------------------
/*
#Joins Employee with the feed log to show what time they fed the dog and is ordered by employee ID
SELECT employee.employeeID, employee.employeeName, feedlog.logID, feedlog.timeFed
FROM employee
LEFT JOIN feedlog ON employee.employeeID = feedlog.employeeID
ORDER BY employee.employeeID;

#Joins Dog with the feed log to show what time they were fed and what type of food they ate and is ordered by dog name
SELECT dog.dogName, dog.dogID, feedlog.logID, feedlog.timeFed, feedlog.foodBrand
FROM dog
LEFT JOIN feedlog ON dog.dogID = feedlog.dogID
ORDER BY dog.dogName;

#Joins Employee with the dog they are responsible for and shows the time the dog got dropped off and is ordered by employee ID
SELECT employee.employeeID, employee.employeeName, dog.dogName, dog.dropOffDate
FROM employee
LEFT JOIN dog ON employee.employeeID = dog.employeeID
ORDER BY employee.employeeID;

#Joins employee with the dog they are responsible for and shows the owner and owner phone number and is ordered by employee name
SELECT employee.employeeID, employee.employeeName, dog.dogName, dog.ownerName, dog.ownerPhoneNum
FROM employee
LEFT JOIN dog ON employee.employeeID = dog.employeeID
ORDER BY employee.employeeID;

#Joins dog with feedlog to show the dog dropoff time, pickup time, and the time they were last fed and is ordered by dog ID
SELECT dog.dogID, dog.dogName, dog.dropOffDate, dog.estPickUpDate, feedlog.timeFed
FROM dog
LEFT JOIN feedlog ON dog.dogID = feedlog.dogID
ORDER BY dog.dogID;
*/
