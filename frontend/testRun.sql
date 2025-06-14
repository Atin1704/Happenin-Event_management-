--This File contains the external to run on the SQL files and check for the domains and the constrains.

drop table events;
drop table users;
drop table organizer;
drop table venue;
drop table complaint;
drop table admins;
drop table registration;
drop table transactions;
drop table feedback;

select * from events;
select * from organizer;
select * from users;
select * from feedback;
select * from complaint;
select * from admins;
select * from registration;
select * from transactions;
select * from venue;

delete from events;
delete from organizer;
delete from users;
delete from feedback;
delete from complaint;
delete from admins;
delete from registration;
delete from transactions;
delete from venue;

--Commands Checking the functionalities of the Data Sets
SELECT eventName, ticketsSold, maxAttendees FROM Events 
WHERE ticketsSold < (maxAttendees * 0.10);

DELETE FROM Events WHERE endDate < '2025-02-21';

SELECT eventName, ticketsSold FROM Events ORDER BY ticketsSold DESC LIMIT 1;

SELECT category, AVG(ticketPrice) AS avg_price FROM Events GROUP BY category;

SELECT e.eventName, v.venueName 
FROM Events e 
JOIN Venue v ON e.venueID = v.venueID;

SELECT * FROM Events WHERE startDate BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 days';
