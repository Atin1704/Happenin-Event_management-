-- INSERT Users (20)
INSERT INTO Users ( username, "password", firstName, lastName, emailID, contactNo, dob, walletCash)
VALUES
( 'user1', 'passwrd01', 'Alice', 'Green', 'alice1@example.com','1000000001','1990-01-01', 15.00),
( 'user2', 'passwrd02', 'Bob', 'Smith', 'bob2@example.com','1000000002','1992-02-02', 0.00),
( 'user3', 'passwrd03', 'Carol', 'Jones', 'carol3@example.com','1000000003','1988-03-03', 50.50),
( 'user4', 'passwrd04', 'David', 'Brown', 'david4@example.com','1000000004','1995-04-04', 10.00),
( 'user5', 'passwrd05', 'Eva', 'Davis', 'eva5@example.com','1000000005','1991-05-05', 25.00),
( 'user6', 'passwrd06', 'Frank', 'Miller', 'frank6@example.com','1000000006','1989-06-06', 0.00),
( 'user7', 'passwrd07', 'Grace', 'Wilson', 'grace7@example.com','1000000007','1993-07-07', 5.00),
( 'user8', 'passwrd08', 'Henry', 'Taylor', 'henry8@example.com','1000000008','1994-08-08', 0.00),
( 'user9', 'passwrd09', 'Ivy', 'Adams', 'ivy9@example.com','1000000009','1987-09-09', 60.00),
('user10','passwrd10','Jack', 'Thomas','jack10@example.com','1000000010','1996-10-10', 0.00),
('user11','passwrd11','Kelly','White','kelly11@example.com','1000000011','1990-08-01', 70.00),
('user12','passwrd12','Leo','Harris','leo12@example.com','1000000012','1985-12-12', 10.00),
('user13','passwrd13','Mia','Martin','mia13@example.com','1000000013','1991-04-14', 0.00),
('user14','passwrd14','Noah','Garcia','noah14@example.com','1000000014','1982-11-11',15.00),
('user15','passwrd15','Olivia','Roberts','olivia15@example.com','1000000015','1993-03-15',42.00),
('user16','passwrd16','Paul','Clark','paul16@example.com','1000000016','1994-05-06', 0.00),
('user17','passwrd17','Quinn','Hall','quinn17@example.com','1000000017','1992-09-21', 50.00),
('user18','passwrd18','Rose','Allen','rose18@example.com','1000000018','1996-01-31', 0.00),
('user19','passwrd19','Sam','Young','sam19@example.com','1000000019','1991-12-25', 5.00),
('user20','passwrd20','Tina','Baker','tina20@example.com','1000000020','1993-07-04', 8.00);

-- INSERT Admins (2) - optional, helps link staffID in complaints
INSERT INTO Admins ( firstName, lastName, emailID, "password", "role")
VALUES
('Admin', 'One', 'admin1@example.com', 'adminpwd1', 'Support'),
( 'Admin', 'Two', 'admin2@example.com', 'adminpwd2', 'Support');

-- INSERT Organizers (8)
INSERT INTO Organizer (staffID, username, firstName, lastName, emailID, contactNo, "password", organization)
VALUES
(1, 'orguser1', 'OrgA', 'UserA', 'org1@example.com','2000000001','orgpass01','OrganizerFoo'),
( 1, 'orguser2', 'OrgB', 'UserB', 'org2@example.com','2000000002','orgpass02','OrganizerFoo'),
( 2, 'orguser3', 'OrgC', 'UserC', 'org3@example.com','2000000003','orgpass03','OrganizerBar'),
( 2, 'orguser4', 'OrgD', 'UserD', 'org4@example.com','2000000004','orgpass04','OrganizerBar'),
( NULL, 'orguser5','OrgE','UserE','org5@example.com','2000000005','orgpass05','OrgQ'),
( NULL, 'orguser6','OrgF','UserF','org6@example.com','2000000006','orgpass06','OrgQ'),
( NULL, 'orguser7','OrgG','UserG','org7@example.com','2000000007','orgpass07','OrgX'),
( NULL, 'orguser8','OrgH','UserH','org8@example.com','2000000008','orgpass08','OrgX');

-- INSERT Venues (2)
INSERT INTO Venue ( "name", street, city, "state", pincode)
VALUES
('Big Hall', '123 Main St', 'Metropolis', 'StateX', '12345'),
( 'Open Field', '456 Park Ave', 'Riverside', 'StateY', '67890');

-- INSERT Events (20)
-- 12 completed events set to 22 March 2025 (10:30 PM -> 10:31 PM), 8 upcoming with a future date
-- Mix ticketPrice=0 (free) and >0 (paid); some high attendance, some low

INSERT INTO Events
( eventName, ticketPrice, category, maxAttendees, created_at, startDate, startTime, endDate, endTime, venueID, organizerID, ticketsSold, status)
VALUES
-- Completed events (12) on 22 Mar 2025
( 'Music Fest A', 10.00, 'Concert', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 1, 1, 10, 'Completed'),
( 'Book Expo A', 0.00, 'Expo', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 2, 2, 8, 'Completed'),
( 'Food Carnival A', 15.00, 'Food', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 1, 3, 7, 'Completed'),
( 'Tech Summit A', 0.00, 'Tech', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 2, 4, 5, 'Completed'),
( 'Startup Pitch A', 20.00, 'Business', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 1, 5, 10, 'Completed'),
( 'Charity Gala A', 0.00, 'Charity', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 2, 6, 10, 'Completed'),
( 'Art Fair A', 8.00, 'Art', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 1, 7, 7, 'Completed'),
( 'Game Con A', 0.00, 'Gaming', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 2, 8, 6, 'Completed'),
( 'Marathon A', 5.00, 'Sports', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 1, 1, 5, 'Completed'),
( 'Cooking Show A', 12.50, 'Food', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 2, 2, 6, 'Completed'),
( 'Dance Workshop A', 0.00, 'Dance', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 1, 3, 10, 'Completed'),
( 'Startup Demo Day A', 25.00, 'Business', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 2, 4, 8, 'Completed'),

-- Upcoming events (8) with a later date/time
( 'Music Fest B', 10.00, 'Concert', 10, DEFAULT, '2025-04-10', '17:00:00', '2025-04-10', '20:00:00', 1, 1, 0, 'Upcoming'),
( 'Book Expo B', 0.00, 'Expo', 10, DEFAULT, '2025-05-01', '09:00:00', '2025-05-01', '15:00:00', 2, 2, 0, 'Upcoming'),
( 'Food Carnival B', 15.00, 'Food', 10, DEFAULT, '2025-05-02', '10:00:00', '2025-05-02', '18:00:00', 1, 3, 0, 'Upcoming'),
( 'Tech Summit B', 0.00, 'Tech', 10, DEFAULT, '2025-06-15', '08:00:00', '2025-06-15', '17:00:00', 2, 4, 0, 'Upcoming'),
( 'Startup Pitch B', 20.00, 'Business', 10, DEFAULT, '2025-06-20', '09:00:00', '2025-06-20', '12:00:00', 1, 5, 0, 'Upcoming'),
( 'Charity Gala B', 0.00, 'Charity', 10, DEFAULT, '2025-07-01', '19:00:00', '2025-07-01', '22:00:00', 2, 6, 0, 'Upcoming'),
( 'Marathon B', 5.00, 'Sports', 10, DEFAULT, '2025-08-15', '06:00:00', '2025-08-15', '11:00:00', 1, 7, 0, 'Upcoming'),
( 'Art Fair B', 0.00, 'Art', 10, DEFAULT, '2025-09-05', '10:00:00', '2025-09-05', '17:00:00', 2, 8, 0, 'Upcoming');

-- INSERT Registrations & Transactions
-- For completed paid events, we create both Registration and Transaction for each attendee.
-- For completed free events, we only create Registration.
-- The example below shows a subset. Add more up to the listed ticketsSold totals.

-- Event 1 (paid, 10 ticketsSold)
INSERT INTO Registration ( UserID, EventID, TransactionID)
VALUES
( 1, 1, 1),
( 2, 1, 2),
( 3, 1, 3),
( 4, 1, 4),
( 5, 1, 5),
( 6, 1, 6),
( 7, 1, 7),
( 8, 1, 8),
( 9, 1, 9),
(10,1,10);

INSERT INTO Transactions ( eventID, userID, method_of_payment, amount, status)
VALUES
( 1, 1, 'Credit Card', 10.00, 'Processed'),
( 1, 2, 'Debit Card', 10.00, 'Processed'),
( 1, 3, 'UPI', 10.00, 'Processed'),
( 1, 4, 'Wallet', 10.00, 'Processed'),
( 1, 5, 'Credit Card', 10.00, 'Processed'),
( 1, 6, 'Credit Card', 10.00, 'Processed'),
( 1, 7, 'Debit Card', 10.00, 'Processed'),
( 1, 8, 'Credit Card', 10.00, 'Processed'),
( 1, 9, 'UPI', 10.00, 'Processed'),
(1,10,'Credit Card',10.00,'Processed');

-- Event 2 (free, 8 ticketsSold) - sample
INSERT INTO Registration ( UserID, EventID, TransactionID)
VALUES
(1,2,NULL),
(2,2,NULL),
(4,2,NULL),
(5,2,NULL),
(11,2,NULL),
(16,2,NULL),
(17,2,NULL),
(20,2,NULL);

-- Repeat for other completed events, respecting the “ticketsSold” count and whether event is free or paid
-- (Omitted for brevity - be sure to assign unique RegistrationID and optional TransactionID)

-- INSERT Feedback for completed events (≥20% of attendees). Example for Event 1:
INSERT INTO Feedback ( eventID, userID, Rating, "Comments")
VALUES
( 1, 1, 5, 'Amazing show!'),
( 1, 2, 4, 'Great experience'),
( 1, 3, 3, 'It was okay');

-- INSERT Complaints for completed events (≥20% of attendees). Example for Event 1:
INSERT INTO Complaint ( eventID, userID, staffID, Description, Status, Category)
VALUES
( 1, 2, 1, 'Ticketing confusion at entry', 'Resolved', 'Ticketing Problems'),
( 1, 3, 2, 'Audio quality was poor at times', 'Resolved', 'Event Issues');

-- Repeat similar INSERTs for Events 2..12, ensuring enough Feedback/Complaint coverage.
-- Make sure the categories and user IDs used do not violate the “unique_user_event_category” or “unique_user_feedback” constraints.
-- Continue similarly for all completed events, adjusting staffID, userID, rating, and complaint category



-- For Event 3: Food Carnival A (Paid, 7 tickets sold)
INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (3, 3, 11),
    (4, 3, 12),
    (5, 3, 13),
    (6, 3, 14),
    (7, 3, 15),
    (8, 3, 16),
    (10,3, 17);

INSERT INTO Transactions (eventID, userID, method_of_payment, amount, status)
VALUES
    (3, 3, 'Credit Card', 15.00, 'Processed'),
    (3, 4, 'Debit Card', 15.00, 'Processed'),
    (3, 5, 'UPI', 15.00, 'Processed'),
    (3, 6, 'Wallet', 15.00, 'Processed'),
    (3, 7, 'Credit Card', 15.00, 'Processed'),
    (3, 8, 'Debit Card', 15.00, 'Processed'),
    (3, 10, 'Credit Card', 15.00, 'Processed');

INSERT INTO Feedback (eventID, userID, Rating, "Comments")
VALUES
    (3, 3, 5, 'Delicious experience'),
    (3, 4, 4, 'Great food presentation');

INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
VALUES
    (3, 5, 1, 'Delay in service', 'Resolved', 'Service & Hospitality'),
    (3, 6, 2, 'Less variety than expected', 'Resolved', 'Event Issues');

-- For Event 4: Tech Summit A (Free, 5 tickets sold)
INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (2, 4, NULL),
    (11,4, NULL),
    (12,4, NULL),
    (13,4, NULL),
    (14,4, NULL);

INSERT INTO Feedback (eventID, userID, Rating, "Comments")
VALUES
    (4, 2, 4, 'Informative sessions');

INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
VALUES
    (4, 11, 1, 'Weak audio at one session', 'Resolved', 'App & Tech Issues');

-- For Event 5: Startup Pitch A (Paid, 10 tickets sold)
INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (1, 5, 18),
    (2, 5, 19),
    (15,5, 20),
    (16,5, 21),
    (17,5, 22),
    (18,5, 23),
    (19,5, 24),
    (20,5, 25),
    (3, 5, 26),
    (4, 5, 27);

INSERT INTO Transactions (eventID, userID, method_of_payment, amount, status)
VALUES
    (5, 1, 'Credit Card', 20.00, 'Processed'),
    (5, 2, 'Debit Card', 20.00, 'Processed'),
    (5, 15, 'UPI', 20.00, 'Processed'),
    (5, 16, 'Wallet', 20.00, 'Processed'),
    (5, 17, 'Credit Card', 20.00, 'Processed'),
    (5, 18, 'Debit Card', 20.00, 'Processed'),
    (5, 19, 'Credit Card', 20.00, 'Processed'),
    (5, 20, 'UPI', 20.00, 'Processed'),
    (5, 3, 'Wallet', 20.00, 'Processed'),
    (5, 4, 'Credit Card', 20.00, 'Processed');

INSERT INTO Feedback (eventID, userID, Rating, "Comments")
VALUES
    (5, 1, 5, 'Innovative ideas!'),
    (5, 2, 4, 'Well organized');

INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
VALUES
    (5, 15, 1, 'Presentation delays', 'Resolved', 'Event Issues'),
    (5, 16, 2, 'Technical glitches during pitch', 'Resolved', 'App & Tech Issues');

-- For Event 6: Charity Gala A (Free, 10 tickets sold)
INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (5, 6, NULL),
    (6, 6, NULL),
    (7, 6, NULL),
    (8, 6, NULL),
    (9, 6, NULL),
    (10,6, NULL),
    (11,6, NULL),
    (12,6, NULL),
    (13,6, NULL),
    (14,6, NULL);

INSERT INTO Feedback (eventID, userID, Rating, "Comments")
VALUES
    (6, 5, 5, 'Heartwarming event'),
    (6, 6, 5, 'Great cause and execution');

INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
VALUES
    (6, 7, 1, 'Venue seating issues', 'Resolved', 'Service & Hospitality'),
    (6, 8, 2, 'Delay in starting the program', 'Resolved', 'Event Issues');

-- For Event 7: Art Fair A (Paid, 7 tickets sold)
INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (1, 7, 28),
    (3, 7, 29),
    (5, 7, 30),
    (7, 7, 31),
    (9, 7, 32),
    (11,7, 33),
    (13,7, 34);

INSERT INTO Transactions (eventID, userID, method_of_payment, amount, status)
VALUES
    (7, 1, 'Credit Card', 8.00, 'Processed'),
    (7, 3, 'Debit Card', 8.00, 'Processed'),
    (7, 5, 'UPI', 8.00, 'Processed'),
    (7, 7, 'Wallet', 8.00, 'Processed'),
    (7, 9, 'Credit Card', 8.00, 'Processed'),
    (7, 11, 'Debit Card', 8.00, 'Processed'),
    (7, 13, 'Credit Card', 8.00, 'Processed');

INSERT INTO Feedback (eventID, userID, Rating, "Comments")
VALUES
    (7, 1, 4, 'Good exhibit'),
    (7, 3, 5, 'Loved the artwork');

INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
VALUES
    (7, 5, 1, 'Crowded space', 'Resolved', 'Safety & Security'),
    (7, 7, 2, 'Insufficient parking', 'Resolved', 'Service & Hospitality');

-- For Event 8: Game Con A (Free, 6 tickets sold)
INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (2, 8, NULL),
    (4, 8, NULL),
    (6, 8, NULL),
    (8, 8, NULL),
    (10,8, NULL),
    (12,8, NULL);

INSERT INTO Feedback (eventID, userID, Rating, "Comments")
VALUES
    (8, 2, 3, 'Fun but chaotic'),
    (8, 4, 4, 'Enjoyable games and activities');

INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
VALUES
    (8, 6, 1, 'Long waiting times', 'Resolved', 'Ticketing Problems'),
    (8, 8, 2, 'Unclear instructions', 'Resolved', 'Service & Hospitality');

-- For Event 9: Marathon A (Paid, 5 tickets sold)
INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (3, 9, 35),
    (5, 9, 36),
    (7, 9, 37),
    (9, 9, 38),
    (11,9, 39);

INSERT INTO Transactions (eventID, userID, method_of_payment, amount, status)
VALUES
    (9, 3, 'Credit Card', 5.00, 'Processed'),
    (9, 5, 'Debit Card', 5.00, 'Processed'),
    (9, 7, 'UPI', 5.00, 'Processed'),
    (9, 9, 'Wallet', 5.00, 'Processed'),
    (9, 11, 'Credit Card', 5.00, 'Processed');

INSERT INTO Feedback (eventID, userID, Rating, "Comments")
VALUES
    (9, 3, 4, 'Energetic race'),
    (9, 5, 3, 'Could be better organized');

INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
VALUES
    (9, 7, 1, 'Route was not well marked', 'Resolved', 'Safety & Security');

-- For Event 10: Cooking Show A (Paid, 6 tickets sold)
INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (2, 10, 40),
    (4, 10, 41),
    (6, 10, 42),
    (8, 10, 43),
    (10,10, 44),
    (12,10, 45);

INSERT INTO Transactions (eventID, userID, method_of_payment, amount, status)
VALUES
    (10, 2, 'Credit Card', 12.50, 'Processed'),
    (10, 4, 'Debit Card', 12.50, 'Processed'),
    (10, 6, 'UPI', 12.50, 'Processed'),
    (10, 8, 'Wallet', 12.50, 'Processed'),
    (10, 10, 'Credit Card', 12.50, 'Processed'),
    (10, 12, 'Debit Card', 12.50, 'Processed');

INSERT INTO Feedback (eventID, userID, Rating, "Comments")
VALUES
    (10, 2, 5, 'Amazing culinary presentation'),
    (10, 4, 4, 'Enjoyable cooking tips');

INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
VALUES
    (10, 6, 1, 'Sound issues during demo', 'Resolved', 'App & Tech Issues'),
    (10, 8, 2, 'Lights were too dim', 'Resolved', 'Event Issues');





--new

-- Users table: Stores user account and contact information.
CREATE TABLE Users (
    userID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, -- Auto-incrementing user ID
    username VARCHAR(50) UNIQUE NOT NULL,                  -- Unique username for login
    "password" VARCHAR(15) NOT NULL CHECK (LENGTH("password") >= 8), -- Password with minimum 8 characters
    firstName VARCHAR(50) NOT NULL,                        -- User's first name
    lastName VARCHAR(50),                                  -- Optional last name
    emailID VARCHAR(100) UNIQUE,                           -- Unique email address
    contactNo VARCHAR(15) UNIQUE,                          -- Unique contact number
    dob DATE,                                              -- Date of birth
    walletCash DECIMAL(10,2) DEFAULT 0.00 CHECK(walletCash >= 0.00), -- Non-negative wallet balance
    CONSTRAINT chk_at_least_one_contact CHECK (contactNo IS NOT NULL OR emailID IS NOT NULL) -- Require at least one contact method
);


-- Admins table: Stores admin/staff account details.
CREATE TABLE Admins (
    staffID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, -- Auto-incrementing staff ID
    firstName VARCHAR(50) NOT NULL,                        -- First name
    lastName VARCHAR(50),                                  -- Last name (optional)
    emailID VARCHAR(100) UNIQUE NOT NULL,                  -- Unique email address
    "password" VARCHAR(15) NOT NULL CHECK (LENGTH("password") >= 8), -- Minimum 8-character password
    "role" VARCHAR(50)                                     -- Role designation
);

-- Organizer table: Stores event organizer details.
CREATE TABLE Organizer (
    organizerID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, -- Auto-incrementing organizer ID
    staffID INT,                                              -- Optional link to an admin
    username VARCHAR(50) UNIQUE NOT NULL,                     -- Unique username for login
    firstName VARCHAR(50) NOT NULL,                           -- First name
    lastName VARCHAR(50),                                     -- Last name (optional)
    emailID VARCHAR(100) UNIQUE NOT NULL,                     -- Unique email address
    contactNo VARCHAR(15) UNIQUE NOT NULL,                    -- Unique contact number
    "password" VARCHAR(15) NOT NULL CHECK (LENGTH("password") >= 8), -- Minimum 8-character password
    organization VARCHAR(100),                                -- Organization name
    verificationStatus BOOLEAN DEFAULT FALSE,                 -- Verification flag
    dateOfVerification DATE,                                  -- Date of verification (if any)
    FOREIGN KEY (staffID) REFERENCES Admins(staffID) ON DELETE SET NULL -- Link to Admins table
);

-- Venue table: Stores venue details with a unique constraint to prevent duplicates.
CREATE TABLE Venue (
    venueID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,  -- Auto-incrementing venue ID
    "name" VARCHAR(255) NOT NULL,                             -- Venue name
    street VARCHAR(255) NOT NULL,                             -- Street address
    city VARCHAR(100) NOT NULL,                               -- City
    "state" VARCHAR(100) NOT NULL,                            -- State
    pincode VARCHAR(10) NOT NULL CHECK (pincode ~ '^[0-9]{5,10}$'), -- Pincode format check
    CONSTRAINT unique_venue UNIQUE ("name", street, city, "state", pincode) -- Prevent duplicate venue entries
);

-- Events table: Stores event details, scheduling, and associations with venue and organizer.
CREATE TABLE Events (
    eventID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,  -- Auto-incrementing event ID
    eventName VARCHAR(100) NOT NULL,                          -- Event name
    ticketPrice DECIMAL(10,2) DEFAULT 0.00 CHECK (ticketPrice >= 0.00), -- Non-negative ticket price
    category VARCHAR(50) NOT NULL,                            -- Event category
    maxAttendees INT CHECK (maxAttendees > 0),                -- Must allow at least one attendee
    created_at TIMESTAMP DEFAULT NOW(),                       -- Creation timestamp
    startDate DATE NOT NULL CHECK (startDate >= created_at::DATE), -- Start date cannot precede creation date
    startTime TIME NOT NULL CHECK (
        startDate > created_at::DATE 
        OR (startDate = created_at::DATE AND startTime > created_at::TIME)
    ),                                                       -- For same-day events, start time must be after creation time
    endDate DATE NOT NULL CHECK (endDate >= startDate),       -- End date must not be before start date
    endTime TIME NOT NULL CHECK (
        endDate > startDate 
        OR (endDate = startDate AND endTime > startTime)
    ),                                                       -- For same-day events, end time must be after start time
    venueID INT,                                             -- Foreign key to Venue
    organizerID INT,                                         -- Foreign key to Organizer
    ticketsSold INT DEFAULT 0,                               -- Tickets sold defaults to 0
    status VARCHAR(50) DEFAULT 'Upcoming',                   -- Event status with default value
    CONSTRAINT fk_venue FOREIGN KEY (venueID) REFERENCES Venue(venueID) ON DELETE SET NULL, -- Link to Venue table
    CONSTRAINT fk_organizer FOREIGN KEY (organizerID) REFERENCES Organizer(organizerID) ON DELETE SET NULL -- Link to Organizer table
);


-- Transactions table: Records payment details for event registrations.
CREATE TABLE Transactions (
    transactionID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, -- Auto-incrementing transaction ID
    eventID INT,                                               -- Associated event ID
    userID INT,                                                -- User who made the transaction
    method_of_payment VARCHAR(50) NOT NULL CHECK (method_of_payment IN ('Credit Card', 'Debit Card', 'UPI', 'Net Banking', 'Wallet')), -- Payment method
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),           -- Transaction amount (must be positive)
    date_of_payment TIMESTAMP DEFAULT CURRENT_TIMESTAMP,       -- Timestamp of payment
    status VARCHAR(10) NOT NULL DEFAULT 'Processed' CHECK (status IN ('Processed', 'Error', 'Refunded')),
    CONSTRAINT fk_Events FOREIGN KEY (eventID) REFERENCES Events(eventID) ON DELETE SET NULL, -- Link to Events table
    CONSTRAINT fk_Users FOREIGN KEY (userID) REFERENCES Users(userID) ON DELETE SET NULL          -- Link to Users table
);

-- Complaint table: Stores user complaints for events.
-- Each user may file one complaint per category for a given event.
CREATE TABLE Complaint (
    ComplaintID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, -- Auto-incrementing complaint ID
    eventID INT NOT NULL,                                      -- Event associated with the complaint
    userID INT NOT NULL,                                       -- User filing the complaint
    staffID INT,                                               -- Admin handling the complaint (optional)
    Created_At TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,   -- When the complaint was submitted
    Description TEXT NOT NULL,                                 -- Details of the complaint
    Status VARCHAR(50) CHECK (Status IN ('Pending', 'In Progress', 'Resolved', 'Dismissed')), -- Complaint status
    Category VARCHAR(100) CHECK (Category IN ('Event Issues', 'Ticketing Problems', 'App & Tech Issues', 'Safety & Security', 'Service & Hospitality', 'Other')), -- Complaint category
    CONSTRAINT fk_Events FOREIGN KEY (eventID) REFERENCES Events(eventID) ON DELETE CASCADE, -- Link to Events table
    CONSTRAINT fk_Users FOREIGN KEY (userID) REFERENCES Users(userID) ON DELETE CASCADE,       -- Link to Users table
    CONSTRAINT fk_Admins FOREIGN KEY (staffID) REFERENCES Admins(staffID) ON DELETE SET NULL,    -- Link to Admins table
    CONSTRAINT unique_user_event_category UNIQUE (userID, eventID, Category) -- One complaint per category per event per user
);

-- Feedback table: Captures user feedback for events.
-- Each user can provide one feedback per event.
CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, -- Auto-incrementing feedback ID
    eventID INT NOT NULL,                                      -- Event associated with the feedback
    userID INT NOT NULL,                                       -- User providing feedback
    Rating INT CHECK (Rating BETWEEN 1 AND 5),                 -- Rating (1 to 5)
    "Comments" TEXT,                                             -- Optional feedback comments
    Created_At TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,   -- When feedback was submitted
    CONSTRAINT fk_Events FOREIGN KEY (eventID) REFERENCES Events(eventID) ON DELETE CASCADE, -- Link to Events table
    CONSTRAINT fk_Users FOREIGN KEY (userID) REFERENCES Users(userID) ON DELETE CASCADE,       -- Link to Users table
    CONSTRAINT unique_user_feedback UNIQUE (userID, eventID) -- One feedback per user per event
);

-- Registration table: Tracks event registrations and associated transaction.
CREATE TABLE Registration (
    RegistrationID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, -- Auto-incrementing registration ID
    UserID INT NOT NULL,                                        -- User registering for the event
    EventID INT NOT NULL,                                       -- Event being registered for
    TransactionID INT,                                          -- Foreign key to Transactions table
    CONSTRAINT fk_Users FOREIGN KEY (UserID) REFERENCES Users(userID) ON DELETE SET NULL,  
    CONSTRAINT fk_Events FOREIGN KEY (EventID) REFERENCES Events(eventID) ON DELETE SET NULL,
    CONSTRAINT fk_Transactions FOREIGN KEY (TransactionID) REFERENCES Transactions(transactionID) ON DELETE SET NULL
);











-- INSERT Users (20)
INSERT INTO Users (username, "password", firstName, lastName, emailID, contactNo, dob, walletCash)
VALUES
    ('user1', 'passwrd01', 'Alice', 'Green', 'alice1@example.com','1000000001','1990-01-01', 15.00),
    ('user2', 'passwrd02', 'Bob', 'Smith', 'bob2@example.com','1000000002','1992-02-02', 0.00),
    ('user3', 'passwrd03', 'Carol', 'Jones', 'carol3@example.com','1000000003','1988-03-03', 50.50),
    ('user4', 'passwrd04', 'David', 'Brown', 'david4@example.com','1000000004','1995-04-04', 10.00),
    ('user5', 'passwrd05', 'Eva', 'Davis', 'eva5@example.com','1000000005','1991-05-05', 25.00),
    ('user6', 'passwrd06', 'Frank', 'Miller', 'frank6@example.com','1000000006','1989-06-06', 0.00),
    ('user7', 'passwrd07', 'Grace', 'Wilson', 'grace7@example.com','1000000007','1993-07-07', 5.00),
    ('user8', 'passwrd08', 'Henry', 'Taylor', 'henry8@example.com','1000000008','1994-08-08', 0.00),
    ('user9', 'passwrd09', 'Ivy', 'Adams', 'ivy9@example.com','1000000009','1987-09-09', 60.00),
    ('user10','passwrd10','Jack', 'Thomas','jack10@example.com','1000000010','1996-10-10', 0.00),
    ('user11','passwrd11','Kelly','White','kelly11@example.com','1000000011','1990-08-01', 70.00),
    ('user12','passwrd12','Leo','Harris','leo12@example.com','1000000012','1985-12-12', 10.00),
    ('user13','passwrd13','Mia','Martin','mia13@example.com','1000000013','1991-04-14', 0.00),
    ('user14','passwrd14','Noah','Garcia','noah14@example.com','1000000014','1982-11-11',15.00),
    ('user15','passwrd15','Olivia','Roberts','olivia15@example.com','1000000015','1993-03-15',42.00),
    ('user16','passwrd16','Paul','Clark','paul16@example.com','1000000016','1994-05-06', 0.00),
    ('user17','passwrd17','Quinn','Hall','quinn17@example.com','1000000017','1992-09-21', 50.00),
    ('user18','passwrd18','Rose','Allen','rose18@example.com','1000000018','1996-01-31', 0.00),
    ('user19','passwrd19','Sam','Young','sam19@example.com','1000000019','1991-12-25', 5.00),
    ('user20','passwrd20','Tina','Baker','tina20@example.com','1000000020','1993-07-04', 8.00);

-- INSERT Admins (2)
INSERT INTO Admins (firstName, lastName, emailID, "password", "role")
VALUES
    ('Admin', 'One', 'admin1@example.com', 'adminpwd1', 'Support'),
    ('Admin', 'Two', 'admin2@example.com', 'adminpwd2', 'Support');


-- INSERT Organizers (8)
INSERT INTO Organizer (staffID, username, firstName, lastName, emailID, contactNo, "password", organization)
VALUES
    (1, 'orguser1', 'OrgA', 'UserA', 'org1@example.com','2000000001','orgpass01','OrganizerFoo'),
    (1, 'orguser2', 'OrgB', 'UserB', 'org2@example.com','2000000002','orgpass02','OrganizerFoo'),
    (2, 'orguser3', 'OrgC', 'UserC', 'org3@example.com','2000000003','orgpass03','OrganizerBar'),
    (2, 'orguser4', 'OrgD', 'UserD', 'org4@example.com','2000000004','orgpass04','OrganizerBar'),
    (NULL, 'orguser5','OrgE','UserE','org5@example.com','2000000005','orgpass05','OrgQ'),
    (NULL, 'orguser6','OrgF','UserF','org6@example.com','2000000006','orgpass06','OrgQ'),
    (NULL, 'orguser7','OrgG','UserG','org7@example.com','2000000007','orgpass07','OrgX'),
    (NULL, 'orguser8','OrgH','UserH','org8@example.com','2000000008','orgpass08','OrgX');

-- INSERT Venues (2)
INSERT INTO Venue ("name", street, city, "state", pincode)
VALUES
    ('Big Hall', '123 Main St', 'Metropolis', 'StateX', '12345'),
    ('Open Field', '456 Park Ave', 'Riverside', 'StateY', '67890');

-- INSERT Events (20)
INSERT INTO Events (eventName, ticketPrice, category, maxAttendees, created_at, startDate, startTime, endDate, endTime, venueID, organizerID, ticketsSold, status)
VALUES
    -- Completed events (12) on 22 Mar 2025
    ('Music Fest A', 10.00, 'Concert', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 1, 1, 10, 'Completed'),
    ('Book Expo A', 0.00, 'Expo', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 2, 2, 8, 'Completed'),
    ('Food Carnival A', 15.00, 'Food', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 1, 3, 7, 'Completed'),
    ('Tech Summit A', 0.00, 'Tech', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 2, 4, 5, 'Completed'),
    ('Startup Pitch A', 20.00, 'Business', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 1, 5, 10, 'Completed'),
    ('Charity Gala A', 0.00, 'Charity', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 2, 6, 10, 'Completed'),
    ('Art Fair A', 8.00, 'Art', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 1, 7, 7, 'Completed'),
    ('Game Con A', 0.00, 'Gaming', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 2, 8, 6, 'Completed'),
    ('Marathon A', 5.00, 'Sports', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 1, 1, 5, 'Completed'),
    ('Cooking Show A', 12.50, 'Food', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 2, 2, 6, 'Completed'),
    ('Dance Workshop A', 0.00, 'Dance', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 1, 3, 10, 'Completed'),
    ('Startup Demo Day A', 25.00, 'Business', 10, '2025-03-21 10:00:00', '2025-03-22', '22:30:00', '2025-03-22', '22:31:00', 2, 4, 8, 'Completed'),
    -- Upcoming events (8) with a later date/time
    ('Music Fest B', 10.00, 'Concert', 10, DEFAULT, '2025-04-10', '17:00:00', '2025-04-10', '20:00:00', 1, 1, 0, 'Upcoming'),
    ('Book Expo B', 0.00, 'Expo', 10, DEFAULT, '2025-05-01', '09:00:00', '2025-05-01', '15:00:00', 2, 2, 0, 'Upcoming'),
    ('Food Carnival B', 15.00, 'Food', 10, DEFAULT, '2025-05-02', '10:00:00', '2025-05-02', '18:00:00', 1, 3, 0, 'Upcoming'),
    ('Tech Summit B', 0.00, 'Tech', 10, DEFAULT, '2025-06-15', '08:00:00', '2025-06-15', '17:00:00', 2, 4, 0, 'Upcoming'),
    ('Startup Pitch B', 20.00, 'Business', 10, DEFAULT, '2025-06-20', '09:00:00', '2025-06-20', '12:00:00', 1, 5, 0, 'Upcoming'),
    ('Charity Gala B', 0.00, 'Charity', 10, DEFAULT, '2025-07-01', '19:00:00', '2025-07-01', '22:00:00', 2, 6, 0, 'Upcoming'),
    ('Marathon B', 5.00, 'Sports', 10, DEFAULT, '2025-08-15', '06:00:00', '2025-08-15', '11:00:00', 1, 7, 0, 'Upcoming'),
    ('Art Fair B', 0.00, 'Art', 10, DEFAULT, '2025-09-05', '10:00:00', '2025-09-05', '17:00:00', 2, 8, 0, 'Upcoming');

------------------------------------------------------
-- INSERT Transactions & Registrations (Paid events)
------------------------------------------------------

-- Event 1: Music Fest A (Paid, 10 ticketsSold)
INSERT INTO Transactions (eventID, userID, method_of_payment, amount, status)
VALUES
    (1, 1, 'Credit Card', 10.00, 'Processed'),
    (1, 2, 'Debit Card', 10.00, 'Processed'),
    (1, 3, 'UPI', 10.00, 'Processed'),
    (1, 4, 'Wallet', 10.00, 'Processed'),
    (1, 5, 'Credit Card', 10.00, 'Processed'),
    (1, 6, 'Credit Card', 10.00, 'Processed'),
    (1, 7, 'Debit Card', 10.00, 'Processed'),
    (1, 8, 'Credit Card', 10.00, 'Processed'),
    (1, 9, 'UPI', 10.00, 'Processed'),
    (1,10,'Credit Card',10.00,'Processed');

INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (1, 1, 1),
    (2, 1, 2),
    (3, 1, 3),
    (4, 1, 4),
    (5, 1, 5),
    (6, 1, 6),
    (7, 1, 7),
    (8, 1, 8),
    (9, 1, 9),
    (10,1,10);

-- Event 2: Book Expo A (Free, 8 ticketsSold)
INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (1,2,NULL),
    (2,2,NULL),
    (4,2,NULL),
    (5,2,NULL),
    (11,2,NULL),
    (16,2,NULL),
    (17,2,NULL),
    (20,2,NULL);

-- Event 3: Food Carnival A (Paid, 7 ticketsSold)
INSERT INTO Transactions (eventID, userID, method_of_payment, amount, status)
VALUES
    (3, 3, 'Credit Card', 15.00, 'Processed'),
    (3, 4, 'Debit Card', 15.00, 'Processed'),
    (3, 5, 'UPI', 15.00, 'Processed'),
    (3, 6, 'Wallet', 15.00, 'Processed'),
    (3, 7, 'Credit Card', 15.00, 'Processed'),
    (3, 8, 'Debit Card', 15.00, 'Processed'),
    (3, 10, 'Credit Card', 15.00, 'Processed');

INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (3, 3, 11),
    (4, 3, 12),
    (5, 3, 13),
    (6, 3, 14),
    (7, 3, 15),
    (8, 3, 16),
    (10,3, 17);

-- Event 4: Tech Summit A (Free, 5 ticketsSold)
INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (2, 4, NULL),
    (11,4, NULL),
    (12,4, NULL),
    (13,4, NULL),
    (14,4, NULL);

-- Event 5: Startup Pitch A (Paid, 10 ticketsSold)
INSERT INTO Transactions (eventID, userID, method_of_payment, amount, status)
VALUES
    (5, 1, 'Credit Card', 20.00, 'Processed'),
    (5, 2, 'Debit Card', 20.00, 'Processed'),
    (5, 15, 'UPI', 20.00, 'Processed'),
    (5, 16, 'Wallet', 20.00, 'Processed'),
    (5, 17, 'Credit Card', 20.00, 'Processed'),
    (5, 18, 'Debit Card', 20.00, 'Processed'),
    (5, 19, 'Credit Card', 20.00, 'Processed'),
    (5, 20, 'UPI', 20.00, 'Processed'),
    (5, 3, 'Wallet', 20.00, 'Processed'),
    (5, 4, 'Credit Card', 20.00, 'Processed');

INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (1, 5, 18),
    (2, 5, 19),
    (15,5, 20),
    (16,5, 21),
    (17,5, 22),
    (18,5, 23),
    (19,5, 24),
    (20,5, 25),
    (3, 5, 26),
    (4, 5, 27);

-- Event 6: Charity Gala A (Free, 10 ticketsSold)
INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (5, 6, NULL),
    (6, 6, NULL),
    (7, 6, NULL),
    (8, 6, NULL),
    (9, 6, NULL),
    (10,6, NULL),
    (11,6, NULL),
    (12,6, NULL),
    (13,6, NULL),
    (14,6, NULL);

-- Event 7: Art Fair A (Paid, 7 ticketsSold)
INSERT INTO Transactions (eventID, userID, method_of_payment, amount, status)
VALUES
    (7, 1, 'Credit Card', 8.00, 'Processed'),
    (7, 3, 'Debit Card', 8.00, 'Processed'),
    (7, 5, 'UPI', 8.00, 'Processed'),
    (7, 7, 'Wallet', 8.00, 'Processed'),
    (7, 9, 'Credit Card', 8.00, 'Processed'),
    (7, 11, 'Debit Card', 8.00, 'Processed'),
    (7, 13, 'Credit Card', 8.00, 'Processed');

INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (1, 7, 28),
    (3, 7, 29),
    (5, 7, 30),
    (7, 7, 31),
    (9, 7, 32),
    (11,7, 33),
    (13,7, 34);

-- Event 8: Game Con A (Free, 6 ticketsSold)
INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (2, 8, NULL),
    (4, 8, NULL),
    (6, 8, NULL),
    (8, 8, NULL),
    (10,8, NULL),
    (12,8, NULL);

-- Event 9: Marathon A (Paid, 5 ticketsSold)
INSERT INTO Transactions (eventID, userID, method_of_payment, amount, status)
VALUES
    (9, 3, 'Credit Card', 5.00, 'Processed'),
    (9, 5, 'Debit Card', 5.00, 'Processed'),
    (9, 7, 'UPI', 5.00, 'Processed'),
    (9, 9, 'Wallet', 5.00, 'Processed'),
    (9, 11, 'Credit Card', 5.00, 'Processed');

INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (3, 9, 35),
    (5, 9, 36),
    (7, 9, 37),
    (9, 9, 38),
    (11,9, 39);

-- Event 10: Cooking Show A (Paid, 6 ticketsSold)
INSERT INTO Transactions (eventID, userID, method_of_payment, amount, status)
VALUES
    (10, 2, 'Credit Card', 12.50, 'Processed'),
    (10, 4, 'Debit Card', 12.50, 'Processed'),
    (10, 6, 'UPI', 12.50, 'Processed'),
    (10, 8, 'Wallet', 12.50, 'Processed'),
    (10, 10, 'Credit Card', 12.50, 'Processed'),
    (10, 12, 'Debit Card', 12.50, 'Processed');

INSERT INTO Registration (UserID, EventID, TransactionID)
VALUES
    (2, 10, 40),
    (4, 10, 41),
    (6, 10, 42),
    (8, 10, 43),
    (10,10, 44),
    (12,10, 45);

------------------------------------------------------
-- INSERT Feedback for completed events
------------------------------------------------------
INSERT INTO Feedback (eventID, userID, Rating, "Comments")
VALUES
    (1, 1, 5, 'Amazing show!'),
    (1, 2, 4, 'Great experience'),
    (1, 3, 3, 'It was okay');

INSERT INTO Feedback (eventID, userID, Rating, "Comments")
VALUES
    (3, 3, 5, 'Delicious experience'),
    (3, 4, 4, 'Great food presentation');

INSERT INTO Feedback (eventID, userID, Rating, "Comments")
VALUES
    (4, 2, 4, 'Informative sessions');

INSERT INTO Feedback (eventID, userID, Rating, "Comments")
VALUES
    (5, 1, 5, 'Innovative ideas!'),
    (5, 2, 4, 'Well organized');

INSERT INTO Feedback (eventID, userID, Rating, "Comments")
VALUES
    (6, 5, 5, 'Heartwarming event'),
    (6, 6, 5, 'Great cause and execution');

INSERT INTO Feedback (eventID, userID, Rating, "Comments")
VALUES
    (7, 1, 4, 'Good exhibit'),
    (7, 3, 5, 'Loved the artwork');

INSERT INTO Feedback (eventID, userID, Rating, "Comments")
VALUES
    (8, 2, 3, 'Fun but chaotic'),
    (8, 4, 4, 'Enjoyable games and activities');

INSERT INTO Feedback (eventID, userID, Rating, "Comments")
VALUES
    (9, 3, 4, 'Energetic race'),
    (9, 5, 3, 'Could be better organized');

INSERT INTO Feedback (eventID, userID, Rating, "Comments")
VALUES
    (10, 2, 5, 'Amazing culinary presentation'),
    (10, 4, 4, 'Enjoyable cooking tips');

------------------------------------------------------
-- INSERT Complaints for completed events
------------------------------------------------------
INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
VALUES
    (1, 2, 1, 'Ticketing confusion at entry', 'Resolved', 'Ticketing Problems'),
    (1, 3, 2, 'Audio quality was poor at times', 'Resolved', 'Event Issues');

INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
VALUES
    (3, 5, 1, 'Delay in service', 'Resolved', 'Service & Hospitality'),
    (3, 6, 2, 'Less variety than expected', 'Resolved', 'Event Issues');

INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
VALUES
    (4, 11, 1, 'Weak audio at one session', 'Resolved', 'App & Tech Issues');

INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
VALUES
    (5, 15, 1, 'Presentation delays', 'Resolved', 'Event Issues'),
    (5, 16, 2, 'Technical glitches during pitch', 'Resolved', 'App & Tech Issues');

INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
VALUES
    (6, 7, 1, 'Venue seating issues', 'Resolved', 'Service & Hospitality'),
    (6, 8, 2, 'Delay in starting the program', 'Resolved', 'Event Issues');

INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
VALUES
    (7, 5, 1, 'Crowded space', 'Resolved', 'Safety & Security'),
    (7, 7, 2, 'Insufficient parking', 'Resolved', 'Service & Hospitality');

INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
VALUES
    (8, 6, 1, 'Long waiting times', 'Resolved', 'Ticketing Problems'),
    (8, 8, 2, 'Unclear instructions', 'Resolved', 'Service & Hospitality');

INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
VALUES
    (9, 7, 1, 'Route was not well marked', 'Resolved', 'Safety & Security');

INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
VALUES
    (10, 6, 1, 'Sound issues during demo', 'Resolved', 'App & Tech Issues'),
    (10, 8, 2, 'Lights were too dim', 'Resolved', 'Event Issues');
