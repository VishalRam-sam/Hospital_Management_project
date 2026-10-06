# Hospital Management System – SQL Project

This is a SQL project I built in MySQL to practice answering real business questions from a hospital database. The database has 14 tables (patients, doctors, nurses, appointments, beds, rooms, surgeries, staff shifts and so on), and I wrote 15 queries to solve problems a hospital management team might actually face.

## Files

- `Hospital_Management_System_file.sql` – creates the database, tables and sample data
- `SQL_project.sql` – all 15 queries with the question written above each one

## Tables

Department, Ward, Room, Bed, Doctor, Nurse, Helpers, StaffShift, Patients, Appointment, MedicalRecord, SurgeryRecord, BedRecords, RoomRecords

## Questions I solved

1. Patients with their appointment doctor and the reason for the visit
2. Nurses who assisted in bed admissions, along with the patient name
3. Rooms used for surgeries, with the surgeon and the type of surgery
4. Number of doctors in each department
5. Patients who had an appointment and were also admitted to a bed
6. Empty beds in the Cardiology ward on a given date (for a new patient who wants a bed on a specific day)
7. Upcoming appointments per department on one day, to check if the hospital can handle extra patients during a virus outbreak
8. Whether a doctor deserves a raise, based on their appointments, visits, surgeries and shifts in a month
9. Total revenue for one day from appointments, rooms and beds
10. Patients who visited more than 4 times in a year, so they can get a discount
11. Surgeon, nurse and helper present during a particular surgery, to investigate an anesthesia complaint
12. Total working hours of every doctor, nurse and helper in May 2025, compared with the 200-hour target
13. Patients who have a follow-up appointment due this week
14. Most used payment method among Super Deluxe room patients
15. Percentage of stable patients after surgery for each surgeon

## What I used in the queries

- JOINs across multiple tables (up to 5 in one query)
- GROUP BY and HAVING
- Subqueries, including correlated subqueries, IN, NOT IN and EXISTS
- CASE WHEN for conditional counts and percentages
- Date and time functions like BETWEEN and TIMESTAMPDIFF
- UNION ALL to combine doctors, nurses and helpers in one result

## How to run it

1. Open MySQL Workbench.
2. Run `Hospital_Management_System_file.sql` to create the database and load the data.
3. Run `SQL_project.sql` to see the results of the queries.

## What I learned

The hardest part was Q12, because some shifts end after midnight, so I had to handle the case where the end time is smaller than the start time. Q6 and Q8 also taught me a lot about using subqueries properly.

## About me

I'm [Your Name], a B.Pharm graduate from Thane looking for a data analyst role in the pharma industry. I work with Advanced Excel, Power BI, SQL and Python.

- LinkedIn: [your link]
- Email: [your email]
