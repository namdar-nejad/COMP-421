-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the parent tables!

-- This is only an example of how you add INSERT statements to this file.
--   You may remove it.

INSERT INTO Facilities(Hid, Name, Addr, Email, Phone,  Web) VALUES
    (1, 'Lac-Saint-Louis', '43 Rue Saint Batist', 'LacSaint_Louis@gmail.com', '5145215706','LacSaintLouis.com'),
    (2, 'Doula Kimberly', '344 Rue Laval', 'DoulaKimberly@gmail.com', '5145817406','DoulaKimberly.com'),
    (3, 'Jeanne Mance', '21 Rue Saint George', 'Fac.3@gmail.com', '514544306','fac3.com'),
    (4, 'Maison de naissance', '4500 Rue de Contrecoeur', 'MaisonNaissance@gmail.com', '5143564044','MaisonNaissance.com'),
    (5, 'Two Doulas', '3792 Decarie Blvd Suite 1', '2Doulas@gmail.com', '5145526565','TwoDoulas.com'),
    (6, 'McGill Hospital', '455 Rue University', 'Health@McGill.ca', '5815003221','McGillHealth.com'),
    (7, 'Concordia Medical Center', '123 Rue Concordia', 'MedCenter@Concordia.ca', '5145509032', 'ConcordiaMed.com'),
    (8, 'Leval Clinic', '12 Rue Munchkins', 'LevalClinic@gmail.com', '513567234', 'LevalClinic.ca'),
    (9, 'My CLinic', '123 Some Street', 'MMYClinic1@gmail.com', '513678421', 'MyClinic.ca'),
    (10, 'The Final CLinic', '123 Final Street', 'FinalClinic1@gmail.com', '516648421', 'FinalClinic.ca')
;

INSERT INTO BirthCenter(Hid, Capacity) VALUES
    (1, 250),
    (2, 50),
    (3,26),
    (5,20),
    (6,100)
;

INSERT INTO CommClinic(Hid) VALUES
    (4), (7), (8), (9), (10)
;

INSERT INTO Mother(HcId, Name, Phone, DoB, Addr, Email, Profession, DueD, BloodT) VALUES
    (1, 'Victoria Gutierrez', '5745566311', DATE'1985-02-05', '121 Street 1', 'vic.Gu@gmail.com', 'Dentist',  DATE'2022-07-04', 'A+'),
    (2, 'Liz Darner', '5145786312', DATE'1995-03-01', '122 Street 2', 'LizG@gmail.com', 'Doctor',  DATE'2022-09-05', 'A-'),
    (3, 'Nancy Domingo', '5155567313', DATE'1965-05-11', '123 Street 3', 'NancyDomi@gmail.com', 'Chef',  DATE'2021-12-04', 'O+'),
    (4, 'Anabel Gonzales', '5145766314', DATE'1982-03-13', '124 Street 4', 'AnabelGonz@gmail.com', 'Engineer',  DATE'2020-10-04', 'AB+'),
    (5, 'Jenifer Thomson', '5175566315', DATE'1979-04-21', '125 Street 5', 'JeniTom@gmail.com', 'Designer',  DATE'2020-07-04', 'B+')
;

INSERT INTO Father(Fid, Name, Phone, DoB, Addr, Email, Profession, BloodT) VALUES
    (1, 'John Guy', '5815822221', DATE'1970-09-16', NULL, NULL, 'Teacher', 'A-'),
    (2, 'Tommy Boy', '5815847222', DATE'1985-10-16', NULL, NULL, 'Marketing Guy', 'A+'),
    (3, 'Ali Jeffry', '5815824423', DATE'1975-09-29', NULL, NULL, 'Artist', 'AB-'),
    (4, 'Jack Walker', '5815285224', DATE'1980-11-18', NULL, NULL, 'Driver', 'O-'),
    (5, 'Jonny Daniels', '5129941225', DATE'1973-12-06', NULL, NULL, 'Pilot', 'A+')
;

INSERT INTO Couple(Cid, HcId, Fid, Appr) VALUES
    (1, 1, 1, TRUE),
    (2, 2, 2, TRUE),
    (3, 3, 3, TRUE),
    (4, 4, 4, TRUE),
    (5, 5, NULL, TRUE)
;

INSERT INTO Midwife(MidId, Hid, Name, Phone, Email) VALUES
    (1, 1, 'Marion Girard', '5717782131', 'Marion.Girard@gmail.com'),
    (2, 2, 'Marry Gurter', '5517782132', 'Marry.Gurter@gmail.com'),
    (3, 2, 'John Adamson', '5717687133', 'Jhon.Ada@gmail.com'),
    (4, 3, 'Jerry Hudson', '5711489134', 'JerryHud@gmail.com'),
    (5, 1, 'Marry Adams', '5432787135', 'Marry.Adams@gmail.com')
;

INSERT INTO Pregnancy(Cid, Num, PrimID, BackupID, Status, Hid, Interested, HomeBirth, Done) VALUES
    (1, 1,  1, 2, 'Done', 1, TRUE, FALSE, TRUE),
    (1, 2,  1, 4, 'First Tri-master', 1, TRUE, TRUE, FALSE),
    (2, 1,  2, 1, 'Second Tri-master', 1, TRUE, FALSE, FALSE),
    (4, 2,  1, 4, 'First Tri-master', 1, TRUE, FALSE, FALSE),
    (3, 1,  1, 5, 'In Hospital', 3, TRUE, FALSE, FALSE)
;

INSERT INTO Baby(Bid, Cid, Num, Name, Gender, DoB, BTime, BloodT) VALUES
    (1, 1, 1, 'The First One', 'Female', DATE'2020-04-02', TIME'12:30', 'A+'),
    (2, 1, 1, 'The Second One', 'Male', DATE'2020-04-02', TIME'12:32', 'A-'),
    (3, 1, 2, 'The Final One', 'Female', DATE'2022-07-02', TIME'16:30', 'A+'),
    (4, 2, 1, 'Jonny', 'Male', DATE'2021-10-12', TIME'01:30', 'O+'),
    (5, 4, 2, 'Adam', 'Male', DATE'2022-04-05', TIME'14:32', 'AB-'),
    (6, 3, 1, 'Junior', 'Male', DATE'2022-02-05', TIME'14:30', 'AB-')
;

INSERT INTO Technician(TechId, Name, Phone) VALUES
    (1, 'Jonny Techn', '5213456768'),
    (2, 'Sam Froid', '5543676792'),
    (3, 'James Sood', '578925674'),
    (4, 'Margret Yoker', '5256458734'),
    (5, 'Sammy Lab', '5223434745')
;

INSERT INTO Appointment(Aid, Date, Time, Cid, Num, MidId) VALUES
    (1, DATE'2022-03-24', Time'13:30:00', 1, 2, 1),
    (2, DATE'2022-03-21', Time'14:30:00', 1, 2, 1),
    (3, DATE'2022-03-20', Time'15:30:00', 2, 1, 2),
    (4, DATE'2021-03-21', Time'11:00:00', 4, 2, 1),
    (5, DATE'2022-03-24', Time'10:00:00', 2, 1, 2)
;

INSERT INTO Tests(Tid, MidId, Num, Cid, Ttype, PresDate, SampDate, LabDate, TechId, Bid, Results) VALUES
    (1, 1, 2, 1, 'Blood Iron', DATE'2022-03-24', DATE'2022-03-26', DATE'2022-03-27', 1, NULL, 'Blood Iron OK'),
    (2, 1, 1, 1, 'Blood Iron', DATE'2020-04-14', DATE'2020-04-16', DATE'2020-04-17', 2, NULL, 'Blood Iron Not OK'),
    (3, 2, 1, 2, 'Ultrasound', DATE'2021-05-04', DATE'2021-05-06', NULL, 1, 1, 'Ultra Sound OK'),
    (4, 1, 2, 4, 'Blood Iron', DATE'2020-03-12', DATE'2020-03-14', DATE'2022-03-17', 1, NULL, 'Blood Iron OK'),
    (5, 1, 1, 3, 'Cholesterol', DATE'2022-03-24', DATE'2022-03-26', DATE'2022-03-27', 1, NULL, 'Cholesterol OK'),
    (6, 1, 2, 1, 'Blood Iron', DATE'2022-02-12', DATE'2022-02-13', DATE'2022-02-17', 1, NULL, 'Blood Iron Not OK'),
    (7, 1, 1, 1, 'Blood Iron', DATE'2020-04-28', DATE'2020-05-02', DATE'2020-05-04', 1, NULL, 'Blood Iron Not OK')
;

INSERT INTO Notes(Aid, Date, Time, Text) VALUES
    (1, DATE'2022-03-24', Time'13:35:00', 'I have written a Iron Test'),
    (1, DATE'2022-03-24', Time'13:40:00', 'The meeting was good'),
    (2, DATE'2022-03-21', Time'14:50:00', 'They have twins'),
    (2, DATE'2022-03-21', Time'15:00:00', 'The meeting was productive'),
    (3, DATE'2022-03-20', Time'15:30:00', 'The father didnt show up')
;

INSERT INTO DueDates(Cid, Num, ApproxD, Info ) VALUES
    (1, 1, DATE'2020-03-15', 'initial approximation'),
    (1, 1, DATE'2020-04-01', 'final approximation'),
    (1, 2, DATE'2021-07-15', 'initial approximation'),
    (1, 2, DATE'2021-07-05', 'final approximation'),
    (4, 2, DATE'2022-03-15', 'initial approximation')
;

INSERT INTO InfoSess(Iid, MidId,  Date, Time, Lang, Capacity) VALUES
    (1, 1, DATE'2019-02-11', Time'11:00', 'English', 100),
    (2, 5, DATE'2019-05-10', Time'12:00', 'French', 100),
    (3, 3, DATE'2019-07-09', Time'11:30', 'English', 100),
    (4, 2, DATE'2020-02-01', Time'12:00', 'French', 100),
    (5, 1, DATE'2021-01-05', Time'12:00', 'English', 100)
;

INSERT INTO InfoRegisteration(Iid, Cid, Attended) VALUES
    (1, 1, TRUE),
    (2, 1, FALSE),
    (3, 3, TRUE),
    (4, 2, TRUE),
    (5, 2, False),
    (5, 1, TRUE)
;


