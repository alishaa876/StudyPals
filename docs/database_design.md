1. Users table
Stores student profile information.
Field	Type	Purpose
user_id	Integer / ID	Unique student ID
name	Text	Student's name
email	Text	Student's email
course	Text	Degree or course
badge	Text	Student profile badge

2. Groups table
Stores the study groups created by students.
Field	Type	Purpose
group_id	Integer / ID	Unique group ID
group_name	Text	Name of the group
subject	Text	Study subject
description	Text	Group details
created_by	User ID	Student who created it
created_at	Date/Time	Creation date and time

3. Library Tables table
Stores library tables and their availability.
Field	Type	Purpose
table_id	Integer / ID	Unique library table ID
table_name	Text	Table number or name
seat_capacity	Integer	Number of seats
location	Text	Library area
status	Text	Available or occupied

4. Reservations table
Stores student bookings for library tables.
Field	Type	Purpose
reservation_id	Integer / ID	Unique reservation ID
user_id	User ID	Student making the booking
table_id	Table ID	Reserved library table
booking_date	Date	Date of reservation
start_time	Time	Booking start time
end_time	Time	Booking end time
status	Text	Booked or cancelled