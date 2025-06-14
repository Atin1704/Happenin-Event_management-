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
    UserID INT,                                                 -- User registering for the event
    EventID INT,                                                -- Event being registered for
    TransactionID VARCHAR(255) UNIQUE,                          -- Unique transaction reference
    CONSTRAINT fk_Users FOREIGN KEY (UserID) REFERENCES Users(userID) ON DELETE SET NULL,  -- Link to Users table
    CONSTRAINT fk_Events FOREIGN KEY (EventID) REFERENCES Events(eventID) ON DELETE SET NULL  -- Link to Events table
);





-- THIS FILE CONSISTS OF THE DATA ENTRIES FOR THE DATA TABLES FOR "HappenIn"!

-- ENTRIES FOR TABLE: USERS
WITH first_names AS ( 					-- ATTRIBUTE: FIRST NAME
    SELECT unnest(ARRAY['Janitra', 'Damayanti', 'Rupinder', 'Chander', 'Rikita', 'Mihir', 'Ajit', 'Yanisha', 'Shalena', 'Hemali', 
                     'Manu', 'Varun', 'Prasad', 'Akshay', 'Shantai', 'Drisana', 'Hansika', 
                     'Pravin', 'Tanika', 'Rashanda']) AS first_name
),
last_names AS ( 					-- ATTRIBUTE: LAST NAME
    SELECT unnest(ARRAY['Acharya', 'Kumar', 'Aggarwal', 'Agrawal', 'Ahluwalia', 'Chatterjee', NULL]) AS last_name
),
emails AS ( 						-- ATTRIBUTE: EMAIL
    SELECT unnest(ARRAY['@gmail.com', '@yahoo.mail.co.in', '@ymail.com', '@iiitd.ac.in', '@hotmail.com']) AS email
)
INSERT INTO Users (username, "password", firstName, lastName, emailID, contactNo, dob, walletCash)
SELECT 
    LOWER(first_name || '_' || COALESCE(last_name, '') || floor(random() * 1000)) AS username,
    'Pass' || floor(random() * 1000000) AS "password",
    first_name,
    last_name,
    LOWER(first_name || COALESCE(last_name, '') || (SELECT email FROM emails ORDER BY random() LIMIT 1)) AS emailID,
    '98' || LPAD(CAST(floor(random() * 100000000) AS TEXT), 8, '0') AS contactNo,
    '1990-01-01'::DATE + (random() * 10000)::INT * INTERVAL '1 day',
    round((random() * 500)::numeric, 2)
FROM first_names, last_names
LIMIT 100;
-- USERS CONSISTS OF MAXIMUM 100 ENTRIES







-- ENTRIES FOR TABLE: ADMINS
WITH emails AS (					-- ATTRIBUTE: EMAIL
    SELECT unnest(ARRAY['@gmail.com', '@yahoo.mail.co.in', '@ymail.com', '@iiitd.ac.in', '@hotmail.com']) AS email_domain
)
INSERT INTO Admins (firstName, lastName, emailID, "password", "role")
-- Generate 20 Admin entries using a generate_series
SELECT 
    'Admin' || gs AS firstName,
    'User' || gs AS lastName,
    LOWER('admin' || gs || (SELECT email_domain FROM emails ORDER BY random() LIMIT 1)) AS emailID,
    CASE 
        WHEN gs % 2 = 0 THEN 'SecurePass' || gs 
        ELSE 'StrongPass' || gs 
    END AS "password",
    CASE 
        WHEN gs % 2 = 0 THEN 'Manager' 
        ELSE 'Coordinator' 
    END AS "role"
FROM generate_series(1,20) gs;
-- ADMINS CONSISTS OF 20 ENTRIES


-- ENTRIES FOR TABLE: ORGANIZERS
WITH first_names AS (					-- ATTRIBUTE: FIRST NAME
    SELECT unnest(ARRAY['Nisha', 'Kiran', 'Varun', 'Pooja', 'Suresh', 'Deepa', 'Anil', 'Sneha', 'Manoj', 'Divya']) AS first_name
),
last_names AS ( 					-- ATTRIBUTE: LAST NAME
    SELECT unnest(ARRAY['Sharma', 'Iyer', 'Verma', 'Kapoor', 'Patel', 'Chopra', 'Gupta', 'Ahuja', NULL]) AS last_name
),
emails AS (						-- ATTRIBUTE: EMAIL
    SELECT unnest(ARRAY['@gmail.com', '@yahoo.mail.co.in', '@ymail.com', '@iiitd.ac.in', '@hotmail.com']) AS email_domain
),
organizations AS ( 					-- ATTRIBUTE: ORGANIZATION
    SELECT unnest(ARRAY['Cineyug Entertainment Private Limited', 'Infosys', 'Comic Con India', 'DNA Entertainment Networks', 'Google']) AS org_name
),
random_data AS (
    SELECT 
        first_name,
        CASE WHEN random() < 0.3 THEN NULL ELSE last_name END AS last_name, 	-- CONDITION FOR GETTING SOME LAST NAME VALUES AS NULL
        (SELECT email_domain FROM emails ORDER BY random() LIMIT 1) AS email_domain,
        (SELECT org_name FROM organizations OFFSET floor(random() * 3) LIMIT 1) AS org_name,
        (floor(random() * 3) + 1)::INT AS staffID,  				-- ID OF THE ADMIN SUPERVISING THE ORGANIZER
        row_number() OVER () AS row_id
    FROM first_names, last_names, emails
    LIMIT 20
)
INSERT INTO Organizer (staffID, username, firstName, lastName, emailID, contactNo, "password", organization, verificationStatus, dateOfVerification)
SELECT 
    staffID,
    LOWER(first_name || '_' || COALESCE(last_name, '') || row_id) AS username,  	-- ENSURES A UNIQUE USERNAME
    first_name,
    last_name,
    LOWER(first_name || COALESCE(last_name, '') || row_id || email_domain) AS emailID,  -- ENSURES A UNIQUE EMAIL
    '89' || LPAD(row_id::TEXT, 8, '0') AS contactNo,  					-- ENSURES A UNIQUE CONTACT NO.
    'Pass' || LPAD(CAST(floor(random() * 1000000) AS TEXT), 6, '0') AS "password",  	-- RANDOM 6-DIGIT PASSWORD WITH 'Pass'
    org_name,
    TRUE,  										-- VERIFIED AS EVERY ORGANISER HAS A STAFF ID
    CURRENT_DATE  									-- DATE OF VERIFICATION
FROM random_data;
-- ORGANIZERS CONSISTS OF 20 ENTRIES


-- ENTRIES FOR TABLE: VENUE
WITH venue_names AS (
    SELECT unnest(ARRAY[ 				-- ATTRIBUTE: NAME
        'Lotus Convention Center', 'Grand Sapphire Hall', 'Royal Orchid Banquet', 
        'Emerald Arena', 'The Regal Hall', 'Heritage Grand', 'Golden Jubilee Auditorium',
        'Pearl Banquet', 'Sunrise Event Palace', 'Celestial Plaza',
        'Diamond Convention Hall', 'The Grand Emporium', 'Crystal Galaxy Banquet',
        'Skyline Festivity Hall', 'The Imperial Lounge'
    ]) AS venue_name
),
streets AS ( 						-- ATTRIBUTE: STREET
    SELECT unnest(ARRAY[
        'MG Road', 'Brigade Road', 'Connaught Place', 'Marine Drive', 'Park Street', 
        'Anna Salai', 'Sector 18 Market', 'Jubilee Hills', 'Linking Road', 
        'College Street', 'Lajpat Nagar', 'Baner Road', 'DLF Phase 3', 'Law Garden', 'Residency Road'
    ]) AS street_name
),
cities_states AS ( 					-- ATTRIBUTE: CITY and STATE
    SELECT unnest(ARRAY[
        'Bengaluru', 'Mumbai', 'Delhi', 'Kolkata', 'Hyderabad', 
        'Chennai', 'Pune', 'Ahmedabad', 'Jaipur', 'Chandigarh', 
        'Lucknow', 'Bhopal', 'Indore', 'Nagpur', 'Visakhapatnam'
    ]) AS city,
    unnest(ARRAY[
        'Karnataka', 'Maharashtra', 'Delhi', 'West Bengal', 'Telangana', 
        'Tamil Nadu', 'Maharashtra', 'Gujarat', 'Rajasthan', 'Punjab',
        'Uttar Pradesh', 'Madhya Pradesh', 'Madhya Pradesh', 'Maharashtra', 'Andhra Pradesh'
    ]) AS state
),
random_venues AS (
    SELECT 
        venue_name,
        street_name,
        city,
        state,
        LPAD(CAST(floor(100000 + random() * 900000) AS TEXT), 6, '0') AS pincode, 	-- ENSURING A 6-DIGIT PINCODE
        ROW_NUMBER() OVER () AS row_id
    FROM venue_names, streets, cities_states
    ORDER BY random()
    LIMIT 20
)
INSERT INTO Venue ("name", street, city, "state", pincode)
SELECT 
    venue_name,
    street_name,
    city,
    state,
    pincode
FROM random_venues
ON CONFLICT ("name", street, city, "state", pincode) DO NOTHING;
-- VENUE CONSISTS OF 20 ENTRIES


-- ENTRIES FOR TABLE: EVENTS
INSERT INTO Events (
    eventName, ticketPrice, category, maxAttendees, startDate, startTime, 
    endDate, endTime, venueID, organizerID, ticketsSold, status
)
SELECT 
    event_data.eventName,
    ROUND((random() * 500 + 100)::NUMERIC, 2) AS ticketPrice,
    event_data.category,
    floor(random() * 990 + 10) AS maxAttendees,
    CURRENT_DATE + (floor(random() * 30) + 2)::integer AS startDate, -- Random start date within next 30 days
    make_time(floor(random() * 14 + 8)::int, floor(random() * 60)::int, 0) AS startTime,
    (CURRENT_DATE + (floor(random() * 30) + 2)::integer) + (floor(random() * 3 + 1))::integer AS endDate,
    make_time(floor(random() * 10 + 14)::int, floor(random() * 60)::int, 0) AS endTime,
    (SELECT venueID FROM Venue ORDER BY random() LIMIT 1) AS venueID,
    (SELECT organizerID FROM Organizer ORDER BY random() LIMIT 1) AS organizerID,
    floor(random() * 50) AS ticketsSold,
    'Upcoming'
FROM (
    VALUES 
        ('Tech Conference 2025', 'Technology'),
        ('Music Fest', 'Music'),
        ('Startup Pitch Night', 'Business'),
        ('AI & Robotics Workshop', 'Education'),
        ('Fashion Show 2025', 'Entertainment'),
        ('Food Carnival', 'Food & Beverages'),
        ('Comedy Night Special', 'Comedy'),
        ('Photography Exhibition', 'Art'),
        ('E-Sports Tournament', 'Gaming'),
        ('Blockchain Summit', 'Technology'),
        ('Auto Expo 2025', 'Automobile'),
        ('Yoga & Wellness Retreat', 'Health & Wellness'),
        ('Stand-Up Open Mic', 'Comedy'),
        ('Dance Battle Championship', 'Dance'),
        ('Rock & Roll Night', 'Music'),
        ('National Science Fair', 'Education'),
        ('Book Launch & Signing', 'Literature'),
        ('Sports Marathon', 'Sports'),
        ('Christmas Carnival', 'Festival'),
        ('Coding Hackathon', 'Technology')
) AS event_data(eventName, category)
ORDER BY random()
LIMIT 20;


-- ENTRIES FOR TABLE: TRANSACTIONS
INSERT INTO Transactions (eventID, userID, method_of_payment, amount, date_of_payment)
SELECT 
    (SELECT eventID FROM Events ORDER BY random() LIMIT 1) AS eventID,
    (SELECT userID FROM Users ORDER BY random() LIMIT 1) AS userID,
    (ARRAY['Credit Card', 'Debit Card', 'UPI', 'Net Banking', 'Wallet'])[floor(random() * 5 + 1)] AS method_of_payment,
    ROUND((random() * 900 + 100)::NUMERIC, 2) AS amount,
    CURRENT_TIMESTAMP - (floor(random() * 30) || ' days')::INTERVAL AS date_of_payment
FROM generate_series(1, 25);
-- TRANSACTIONS CONSISTS OF 25 ENTRIES


-- ENTRIES FOR TABLE: REGISTRATIONS
INSERT INTO Registration (UserID, EventID, TransactionID)
SELECT 
    t.userID,   
    t.eventID,      
    t.transactionID  
FROM Transactions t
LIMIT 25;
-- REGISTRATIONS CONSISTS OF 25 ENTRIES


-- ENTRIES FOR TABLE: COMPLAINT
WITH random_users AS (
    SELECT userID FROM Users ORDER BY RANDOM() LIMIT 10
),
random_events AS (
    SELECT eventID FROM Events ORDER BY RANDOM() LIMIT 10
),
random_staff AS (
    SELECT staffID FROM Admins ORDER BY RANDOM() LIMIT 5
),
statuses AS (
    SELECT unnest(ARRAY['Pending', 'In Progress', 'Resolved', 'Dismissed']) AS status
),
categories AS (
    SELECT unnest(ARRAY[
        'Event Issues', 'Ticketing Problems', 'App & Tech Issues', 
        'Safety & Security', 'Service & Hospitality', 'Other'
    ]) AS category
)
INSERT INTO Complaint (eventID, userID, staffID, Description, Status, Category)
SELECT DISTINCT ON (u.userID, e.eventID, c.category)
    e.eventID,
    u.userID,
    CASE WHEN random() < 0.5 THEN (SELECT staffID FROM random_staff ORDER BY RANDOM() LIMIT 1) ELSE NULL END,
    'Random complaint description generated for testing purposes.',
    s.status,
    c.category
FROM random_users u, random_events e, statuses s, categories c
ORDER BY u.userID, e.eventID, c.category
LIMIT 20;
-- COMPLAINTS CONSISTS OF 20 ENTRIES


-- ENTRIES FOR TABLE: FEEDBACK
WITH random_feedback AS (
    SELECT 
        e.eventID,
        (SELECT userID FROM Users ORDER BY RANDOM() LIMIT 1) AS userID,
        (SELECT unnest(ARRAY[1, 2, 3, 4, 5]) ORDER BY RANDOM() LIMIT 1) AS rating,
        (SELECT unnest(ARRAY[
            'Would attend again!', 'Not worth the price.', 'Highly recommended!',
            'Super fun!', 'Not as expected.', 'Sound quality was bad.', 
            'Loved the performers!', 'Disappointing experience.', 
            'Great networking opportunity!', 'Food was delicious!', 
            'Poorly organized.', 'Fantastic atmosphere!', 
            'Enjoyed every moment!', 'Needed better crowd management.', 
            'Top-notch event management!', 'Too crowded for comfort.'
        ]) ORDER BY RANDOM() LIMIT 1) AS "comment",
        e.endDate + (floor(random() * 30) || ' days')::INTERVAL +
        (floor(random() * 24) || ' hours')::INTERVAL +
        (floor(random() * 60) || ' minutes')::INTERVAL AS created_at
    FROM Events e
    ORDER BY RANDOM()
    LIMIT 20
)
INSERT INTO Feedback (eventID, userID, Rating, "Comments", Created_At)
SELECT eventID, userID, rating, "comment", created_at
FROM random_feedback;



select * from events;
select * from organizer;
select * from users;
select * from feedback;
select * from complaint;
select * from admins;
select * from registration;
select * from transactions;
select * from venue;
