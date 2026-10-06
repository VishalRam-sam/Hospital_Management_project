USE HospitalManagementSystem;

--  Q1 )LIST OF PATIENTS WITH THEIR APPOINMENT DOCTOR WITH REASON.

SELECT p.FName as Patients_Name,
       d.FName as Doctor_Name,
       a.Reason 
From appointment a
JOIN patients p on a.patient_Id = p.patient_Id
JOIN doctor d on d.doct_Id = a.doct_Id;

-- Q.2) SHOW NURSES WHO HAVE ASSISTED IN BAD ADMISSION WITH PATIENT NAME 
SELECT * FROM NURSE;
SELECT * FROM patients;
SELECT * FROM bedrecords;

SELECT  n.FName as Nurse_name,
        p.FName as patient_name,
        b.bed_No, 
        b.admission_Date
FROM bedrecords b
JOIN NURSE n  ON n.nurse_Id = b.nurse_Id
join patients p on p.patient_Id = b.patient_Id;
        
/* Q.3) List Rooms Use for Surgeries, the surgeon, 
and the surgery types*/

SELECT * FROM ROOM;
SELECT * FROM DOCTOR;
SELECT * FROM surgeryrecord;

select r.room_No as Room_No,
	   d.FName as Surgeon_Name,
       s.surgery_Type 
From room r
join doctor d on r.dept_Id = d.dept_Id
join surgeryrecord s on s.room_no = r.room_no;

/* Q.4) Each Department with the no. of doctor assingned to it.*/
        
Select * from department;
select * from doctor;

select d.dept_Name as Department,
	   count(doc.FName) as Doctor_Name
From doctor doc
join department d ON d.dept_Id = doc.dept_Id
group by department 
order by Doctor_Name desc;

/* Q.5) Show patients who had an appoinment and were admitted to a bed. */

select * from appointment;
select * from bedrecords;
select * from patients;

select 
      a.appoIntment_Id,
      b.bed_No,
      p.FName as Patient_Name
from appointment a 
join bedrecords b On a.patient_Id = b.patient_Id
join patients p on p.patient_Id = a.patient_Id
order by bed_No desc;

/*Q.6) We have new patient for the cardiology ward and he want's 
bed on specific day.I wanna find out which bed are empty in that
 ward on that particular day*/
        use hospitalmanagementsystem;
 select * from ward;
 select * from bed;
 select * from department;
 select * from bedrecords;
select 
       b.bed_No , b.ward_No
from bed b 
join ward w on b.ward_No = w.ward_No
join department d on d.dept_Id = w.dept_Id
where  d.dept_Name = "Cardiology"
and b.bed_No not in (
           select  br.bed_No
		   from bedrecords br 
           where "2025-03-30" between br.admission_Date and br.discharge_Date
              );

/* Q.7) There is a new virus in the city and the hospital is expecting more patients 
than a regular day.Management wants to see if they can manage those with the current staff 
or not.They want to check upcoming appointments for each department on 4 June 2025.*/

Select * from appointment;
select * from doctor;
select * from department;

select 
      d.dept_Name as Department_Name,
      count(a.appoIntment_Id )
 from appointment a 
 join doctor dr on a.doct_Id = dr.doct_Id
 join department d on d.dept_Id = dr.dept_Id
 where a.appointment_Date = "25-06-04"
 group by  d.dept_Name;

/* Q.8) Doctor is asking for a salary raise due to over time in previous month.
Check if he/she deserves raise by retrieving their total appointment , total visits ,total surgeries 
and total shift.  */

select d.FName as Docter_Name ,

              (select count(*)
               from appointment a
               where d.doct_Id = a.doct_Id and a.appointment_Date
               between "2025-05-01" and "2025-05-30") as Total_Appointment,
               
               (select count(*)
               from medicalrecord mr 
               where mr.doct_Id = d.doct_Id and mr.visit_Date 
               between "2025-05-01" and "2025-05-30") as Total_Visits,
               
               (select count(*) 
               from SurgeryRecord sr
               where sr.surgeon_Id = d.doct_Id and sr.surgery_Date
			   between "2025-05-01" and "2025-05-30") as Total_surgery,
                
			   (select count(*)
               from StaffShift ss
               where ss.doct_Id = d.doct_Id and ss.shift_Date
			   between  "2025-05-01" and "2025-05-30") as Total_Shift
               
from doctor d 
where d.doct_Id =1009;
               
/*Q.9) The hospital is analyzing it's daily revenue and they want to calculate 
revenue generateed on 10 May 2025 (including appointment revenue, room revenue, bed revenue)*/ 
			
select * from roomrecords;        
select * from appointment;
select * from bedrecords;

select sum(a.payment_amount) as appointment_revenue,
	   sum(rr.amount) as room_revenue,
       sum(br.amount) as bed_revenue,
       sum((a.payment_amount) +(rr.amount) + (br.amount)) as Totol_Revenue
from appointment a 
left join roomrecords rr on rr.admission_Date = "2025-05-10"
left join bedrecords br on br.admission_Date = "2025-05-10"
where
          a.appointment_Date = "2025-05-10";
	

/* Q10) The hospital decided to give some discounts to its old customers on some services.
Identify patients who have visited the hospital more than 4 times in the past year.*/

select * from patients;
select * from medicalrecord;

select  p.patient_Id , 
        p.FName , 
        count(mr.record_Id) as No_of_Visits
from medicalrecord mr
join patients p 
on mr.patient_Id= p.patient_Id
where mr.visit_Date >= "2025-01-01"
group by p.patient_Id ,
          p.FName 
having count(mr.record_Id)>4
order by No_of_Visits desc;				
        
/* Q.11) Management received a report that a patient was given the wrong amount of anesthesia
during surgery. Track which staff (surgeon, nurse, and helper) was present during the
surgery of patient 967 on 16 May 2024 between 11 to 12 at night.*/

Select 
     p.patient_Id,
     p.FName as patient_name,
     d.FName as Doctor_name,
     n.FName as Nurse_name,
     h.FName as Helper_name,
     sr.room_no,
     sr.surgery_Type,
     sr.surgery_Date,
     sr.start_Time,
     sr.end_Time,
     sr.notes
from SurgeryRecord sr
join patients p on p.patient_Id = sr.patient_Id
join doctor d on d.doct_Id = sr.surgeon_Id
join nurse n on n.nurse_Id = sr.nurse_id
join helpers h on h.helper_Id = sr.helper_id
where sr.surgery_Date = "2024-05-16" 
	 and sr.patient_Id = 967
     and sr.start_Time ="23:15:52"
	 and sr.end_Time = "23:45:52";    
        
/* Q.12) The management wants to pay salaries for this month and wants a record of working
hours. Each staff member should have 200 hours this month. For the month of May 2025,
calculate the total working hours of each staff member (doctors, nurses, helpers) to
check total hours according to the 200 hours baseline.*/
select * from doctor;
select * from nurse;
select * from helpers;

SELECT
    'doctor' AS role,
    d.doct_Id AS staff_id,
    d.FName AS staff_name,
    SUM(
        CASE
            WHEN ss.shift_End < ss.shift_Start
                THEN TIMESTAMPDIFF(HOUR, ss.shift_Start, ss.shift_End) + 24
            ELSE TIMESTAMPDIFF(HOUR, ss.shift_Start, ss.shift_End)
        END
    ) AS total_hours
FROM StaffShift ss
JOIN Doctor d ON ss.doct_Id = d.doct_Id
WHERE ss.shift_Date BETWEEN '2025-05-01' AND '2025-05-31'
GROUP BY d.doct_Id, d.FName

UNION ALL

SELECT
    'nurse',
    n.nurse_Id,
    n.FName,
    SUM(
        CASE
            WHEN ss.shift_End < ss.shift_Start
                THEN TIMESTAMPDIFF(HOUR, ss.shift_Start, ss.shift_End) + 24
            ELSE TIMESTAMPDIFF(HOUR, ss.shift_Start, ss.shift_End)
        END
    )
FROM StaffShift ss
JOIN nurse n ON ss.nurse_Id = n.nurse_Id
WHERE ss.shift_Date BETWEEN '2025-05-01' AND '2025-05-31'
GROUP BY n.nurse_Id, n.FName

UNION ALL

SELECT
    'helper',
    h.helper_Id,
    h.FName,
    SUM(
        CASE
            WHEN ss.shift_End < ss.shift_Start
                THEN TIMESTAMPDIFF(HOUR, ss.shift_Start, ss.shift_End) + 24
            ELSE TIMESTAMPDIFF(HOUR, ss.shift_Start, ss.shift_End)
        END
    )
FROM StaffShift ss
JOIN helpers h ON ss.helper_Id = h.helper_Id
WHERE ss.shift_Date BETWEEN '2025-05-01' AND '2025-05-31'
GROUP BY h.helper_Id, h.FName;

/*Question 13)  List all patients who have a follow-up appointment due this week, based on their last
next_Visit from MedicalRecord.*/

 SELECT
     p.patient_Id,
     p. FName AS patient_name,
	 mr.next_Visit
FROM MedicalRecord mr
JOIN Patients p ON mr.patient_Id = p.patient_Id
WHERE mr.next_Visit IS NOT NULL
AND mr.next_Visit BETWEEN "2025-05-03" AND '2025-05-26'
/* Question 14)
Find the most preferred payment method chosen by upper-class people (defined by
users of super deluxe room types).*/

        SELECT
    rr.mode_of_payment,
    COUNT(*) AS usage_count
FROM RoomRecords rr
JOIN Room r ON r.room_No = rr.room_No
WHERE r.room_Type = 'Super Deluxe Room'
  AND EXISTS (
      SELECT 1
      FROM Appointment a
      WHERE a.patient_Id = rr.patient_Id
  )
GROUP BY rr.mode_of_payment
ORDER BY usage_count DESC;

/*Question 14)
The hospital wants to analyze the performance of its surgeons' surgeries. Give the
percentage of stable patients as per declared in the notes after surgery.*/

SELECT
    d.doct_Id,
    d.FName,
    COUNT(*) AS total_surgeries,
    SUM(CASE WHEN sr.notes = 'Stable' THEN 1 ELSE 0 END) AS stable_patients,
    ROUND(
        SUM(CASE WHEN sr.notes = 'Stable' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS stable_pct
FROM SurgeryRecord sr
JOIN Doctor d ON d.doct_Id = sr.surgeon_Id
GROUP BY d.doct_Id, d.FName
ORDER BY stable_pct DESC;