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
VALUES 
    ('Rajesh', 'Sharma', 
     LOWER('rajesh.sharma' || (SELECT email_domain FROM emails ORDER BY random() LIMIT 1)), 
     'SecurePass1', 'Manager'),

    ('Neha', 'Iyer', 
     LOWER('neha.iyer' || (SELECT email_domain FROM emails ORDER BY random() LIMIT 1)), 
     'SafePass12', 'Coordinator'),

    ('Amit', 'Verma', 
     LOWER('amit.verma' || (SELECT email_domain FROM emails ORDER BY random() LIMIT 1)), 
     'StrongPass34', 'Coordinator'
);
-- ADMINS CONSISTS OF 3 ENTRIES WITH NAMES: RAJESH SHARMA, NEHA IYER AND AMIT VERMA!


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
-- ORGANIZERS CONSISTS OF MAXIMUM 20 ENTRIES


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
cities_states AS ( 					-- ATTRIBUTE: CITY
    SELECT unnest(ARRAY[
        'Bengaluru', 'Mumbai', 'Delhi', 'Kolkata', 'Hyderabad', 
        'Chennai', 'Pune', 'Ahmedabad', 'Jaipur', 'Chandigarh', 
        'Lucknow', 'Bhopal', 'Indore', 'Nagpur', 'Visakhapatnam'
    ]) AS city,
    unnest(ARRAY[ 					-- ATTRIBUTE: STATE
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
    LIMIT 15
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
-- VENUE CONSISTS OF MAXIMUM 15 ENTRIES

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
    CURRENT_DATE + (floor(random() * 8) + 2)::integer AS startDate,
    make_time(floor(random() * 14 + 8)::int, floor(random() * 60)::int, 0) AS startTime,
    (CURRENT_DATE + (floor(random() * 8) + 2)::integer) + (floor(random() * 3 + 1))::integer AS endDate,
    make_time(floor(random() * 10 + 14)::int, floor(random() * 60)::int, 0) AS endTime,
    COALESCE((SELECT venueID FROM Venue ORDER BY random() LIMIT 1), 1) AS venueID,
    COALESCE((SELECT organizerID FROM Organizer ORDER BY random() LIMIT 1), 1) AS organizerID,
    floor(random() * 50) AS ticketsSold,
    'Upcoming'
FROM (
    VALUES ('Tech Conference 2025', 'Technology'),
           ('Music Fest', 'Music'),
           ('Startup Pitch Night', 'Business'),
           ('AI & Robotics Workshop', 'Education'),
           ('Fashion Show 2025', 'Entertainment')
) AS event_data(eventName, category)
ORDER BY random()
LIMIT 5;

-- ENTRIES FOR TABLE: TRANSACTIONS
INSERT INTO Transactions (eventID, userID, method_of_payment, amount, date_of_payment)
SELECT 
    (SELECT eventID FROM Events ORDER BY random() LIMIT 1) AS eventID,
    (SELECT userID FROM Users ORDER BY random() LIMIT 1) AS userID,
    (ARRAY['Credit Card', 'Debit Card', 'UPI', 'Net Banking', 'Wallet'])[floor(random() * 5 + 1)] AS method_of_payment,
    ROUND((random() * 900 + 100)::NUMERIC, 2) AS amount,
    CURRENT_TIMESTAMP - (floor(random() * 30) || ' days')::INTERVAL AS date_of_payment
FROM generate_series(1, 25); 


-- ENTRIES FOR TABLE: REGISTRATIONS
INSERT INTO Registration (UserID, EventID, TransactionID)
SELECT 
    t.userID,   
    t.eventID,      
	t.transactionID  
FROM Transactions t
LIMIT 25;
-- REGISTRATIONS CONSISTS OF MAXIMUM 25 ENTRIES

-- ENTRIES FOR TABLE: COMPLAINTS
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
LIMIT 10;
-- COMPLAINTS CONSISTS OF MAXIMUM 10 ENTRIES

-- ENTRIES FOR TABLE: FEEDBACK
WITH random_feedback AS (
    SELECT 
        e.eventID,
        (SELECT userID FROM Users ORDER BY RANDOM() LIMIT 1) AS userID,
        (SELECT unnest(ARRAY[1, 4, 5]) ORDER BY RANDOM() LIMIT 1) AS rating,
        (SELECT unnest(ARRAY[
            'Would attend again!', 'Not worth the price.', 'Highly recommended!',
            'Super fun!', 'Not as expected.', 'Sound quality was bad.', 
            'Loved the performers!', 'Disappointing experience.'
        ]) ORDER BY RANDOM() LIMIT 1) AS "comment",
        e.endDate + (floor(random() * 30) || ' days')::INTERVAL +
        (floor(random() * 24) || ' hours')::INTERVAL +
        (floor(random() * 60) || ' minutes')::INTERVAL AS created_at
    FROM Events e
    ORDER BY RANDOM()
    LIMIT 12
)
INSERT INTO Feedback (eventID, userID, Rating, "Comments", Created_At)
SELECT eventID, userID, rating, "comment", created_at
FROM random_feedback;
-- FEEDBACK CONSISTS OF MAXIMUM 12 ENTRIES
