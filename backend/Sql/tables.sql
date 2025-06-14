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
