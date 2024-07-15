--Number of companies in cities
SELECT COUNT(Company_id) AS 'Number of company' ,City
FROM COMPANY 
GROUP BY City

--Number of consumers living in Ýzmir, Çanakkale or Sivas
SELECT COUNT(Consumer_id), City
FROM CONSUMER
WHERE City = 'Ýzmir' OR City = 'Çanakkale' OR City = 'Sivas'
GROUP BY City

--Consumers whose names start with 'A'
SELECT Fname, Lname
FROM CONSUMER
WHERE Fname LIKE 'A%'
ORDER BY Lname

--Cities with more than 1 consumer
SELECT COUNT(Consumer_id), City
FROM CONSUMER
GROUP BY City
HAVING COUNT(Consumer_id) > 1
ORDER BY City DESC

--First and last name of people have Matlab skill
SELECT Fname,Lname
FROM CONSUMER AS C 
	 INNER JOIN CONSUMER_SKILL AS CS ON C.Consumer_id = CS.Consumer_id
WHERE CS.Skill_name = 'C'


--Number of employees in companies
SELECT COUNT(Consumer_id), C.Company_name
FROM WORKS_FOR AS W
	INNER JOIN COMPANY C ON W.Company_id = C.Company_id
GROUP BY C.Company_name

--Names, surnames and positions of Arçelik employees by year of employment
SELECT CM.Fname, CM.Lname, W.Position,w.Work_start_date
FROM WORKS_FOR AS W
	 INNER JOIN COMPANY AS CP ON W.Company_id = CP.Company_id
	 INNER JOIN CONSUMER AS CM ON W.Consumer_id = CM.Consumer_id
WHERE CP.Company_name = 'Arçelik'
ORDER BY W.Work_start_date

--Number of posts and e-mails made by Ubisoft employees
SELECT  COUNT(CN.Consumer_id), CN.Email
FROM WORKS_FOR AS W
	 INNER JOIN COMPANY AS CM ON W.Company_id = CM.Company_id
	 INNER JOIN CONSUMER AS CN ON W.Consumer_id = CN.Consumer_id
	 INNER JOIN POST AS P ON CN.Consumer_id = P.Sender_cons_id
WHERE CM.Company_name = 'Ubisoft'
GROUP BY CN.Email

--Number of students in universities in the education system
SELECT COUNT(S.Consumer_id) , U.Uni_name
FROM STUDENT AS S 
	 RIGHT JOIN DEPARTMENT AS D ON S.Dept_id = D.Dept_id
	 INNER JOIN UNIVERSITY AS U ON D.Uni_id = U.Uni_id
GROUP BY U.Uni_name

--Students' first name and last name whose are not registered in the education system
SELECT DISTINCT C.Fname, C.Lname
FROM GETS_EDUCATION AS GE
	 INNER JOIN CONSUMER AS C ON GE.Consumer_id = C.Consumer_id
	 LEFT JOIN  STUDENT AS S ON GE.Consumer_id = S.Consumer_id
WHERE S.Dept_id IS NULL AND GE.Edu_end_date IS NULL

--Names of universities not registered in the education system
SELECT C.Company_name
FROM COMPANY AS C
	 LEFT JOIN UNIVERSITY AS U ON C.Company_id = U.Company_id
WHERE U.Uni_name IS NULL AND C.Company_industry = 'Eðitim'

--Emails of students registered in the education system
SELECT C.Email
FROM STUDENT AS S 
	 INNER JOIN CONSUMER AS C ON S.Consumer_id = C.Consumer_id
WHERE C.Email LIKE '%e%'


--Universities whose have computer engineering in the education system
SELECT U.Uni_name
FROM UNIVERSITY AS U 
	 INNER JOIN DEPARTMENT AS D ON U.Uni_id = D.Uni_id
WHERE D.Dept_name = 'Bilgisayar Mühendisliði'


/* First names, last names and grades of students whose have higher 
grades than average grade of 'Olasýlýk ve Ýstatistik'
course that given by Ýstanbul Teknik Üniversitesi computer engineering */
DECLARE
@Ortalama INT
SET @Ortalama = (SELECT AVG(Grade) 
				 FROM STUDENT_COURSE AS SC 
					  INNER JOIN UNI_INFO AS UI ON SC.Course_id = UI.Course_id
				 WHERE Uni_name = 'Ýstanbul Teknik Üniversitesi' AND
					   Dept_name = 'Bilgisayar Mühendisliði'
				       AND Course_name = 'Olasýlýk ve Ýstatistik')	    
SELECT Fname, Lname, Grade
FROM STUDENT_COURSE AS SC 
	INNER JOIN CONSUMER AS C ON SC.Student_id = C.Consumer_id
	INNER JOIN UNI_INFO AS UI ON SC.Course_id = UI.Course_id
WHERE Uni_name = 'Ýstanbul Teknik Üniversitesi' AND Dept_name = 'Bilgisayar Mühendisliði'
					AND Course_name = 'Olasýlýk ve Ýstatistik' AND Grade  > @Ortalama 

--Students who take lessons from Mustafa Kalýr
select C.Fname, C.Lname, CO.Course_name
FROM CONSUMER AS C
	 INNER JOIN STUDENT AS S ON C.Consumer_id = S.Consumer_id
	 INNER JOIN STUDENT_COURSE AS SC ON S.Consumer_id = SC.Student_id
	 INNER JOIN COURSE AS CO ON SC.Course_id = CO.Course_id
WHERE CO.Given_by = ( SELECT C.Consumer_id from INSTRUCTOR AS I, CONSUMER AS C WHERE C.Consumer_id = I.Consumer_id AND C.Fname = 'Mustafa')


--Students' first names, last names, course names and post dates who posted their submission which are male
SELECT CO.Fname, CO.Lname, C.Course_name, P.Post_time
FROM SUBMISSION_POST AS SP
	 INNER JOIN SUBMISSION AS S ON SP.Submission_id = S.Submission_id
	 INNER JOIN ASSIGNMENT AS A ON S.Assignment_name = A.Assignment_name AND S.Course_id = A.Course_id
	 INNER JOIN COURSE AS C ON A.Course_id = C.Course_id
	 INNER JOIN POST AS P ON SP.Post_id = P.Post_id
	 INNER JOIN CONSUMER AS CO ON P.Sender_cons_id = CO.Consumer_id
WHERE Gender = 'M'
ORDER BY P.Post_time

/* Students' names, surnames and skills that endorsed by Mustafa Kalýr 
because of completed their courses  */
SELECT ENDORSED.Fname, ENDORSED.Lname, CSE.Skill_name
FROM CONSUMER_SKILL_ENDORSE AS CSE
	INNER JOIN CONSUMER_SKILL AS CS ON CSE.Endorsed_consumer = CS.Consumer_id AND CSE.Skill_name = CS.Skill_name
	INNER JOIN CONSUMER AS ENDORSED ON CS.Consumer_id = ENDORSED.Consumer_id
	INNER JOIN CONSUMER AS ENDORSE_BY ON ENDORSE_BY.Consumer_id = CSE.Endorsed_by
WHERE ENDORSE_BY.Fname = 'Mustafa' AND ENDORSE_BY.Lname = 'Kalýr'
	  AND CSE.Skill_name IN (SELECT CO.Skill_acquisition
							 FROM  INSTRUCTOR AS I, COURSE AS CO
							 WHERE ENDORSE_BY.Consumer_id = I.Consumer_id AND
								   CO.Given_by = I.Consumer_id AND
								   ENDORSE_BY.Fname = 'Mustafa' AND ENDORSE_BY.Lname = 'Kalýr')

--Students' first name, last name and skill name whose skills are endorsed by their teachers
SELECT CO.Fname, CO.Lname ,CSE.Skill_name
FROM CONSUMER_SKILL_ENDORSE AS CSE
	 INNER JOIN CONSUMER_SKILL AS CS ON CSE.Endorsed_consumer = CS.Consumer_id AND CSE.Skill_name = CS.Skill_name
	 INNER JOIN STUDENT AS S ON CS.Consumer_id = S.Consumer_id
	 INNER JOIN STUDENT_COURSE AS SC ON S.Consumer_id = SC.Student_id
	 INNER JOIN COURSE AS C ON SC.Course_id = C.Course_id 
	 INNER JOIN CONSUMER AS CO ON CO.Consumer_id = CS.Consumer_id
	 WHERE CSE.Skill_name = C.Skill_acquisition AND C.Given_by = CSE.Endorsed_by					 

--First name, last name and skills of the students registered in the education system
SELECT C.Fname, c.Lname, CS.Skill_name
FROM CONSUMER_SKILL AS CS
	 RIGHT JOIN CONSUMER AS C ON CS.Consumer_id = C.Consumer_id
	 INNER JOIN STUDENT AS S ON S.Consumer_id = C.Consumer_id

--Number of members in groups related to courses
SELECT COUNT(Member_id), CMM.Community_id
FROM COMMUNITY_MEMBER AS CMM
	 INNER JOIN COMMUNITY AS CM ON CMM.Community_id = CM.Community_id
	 INNER JOIN INSTRUCTOR AS I ON CM.Creater_id = I.Consumer_id
	 INNER JOIN COURSE AS CR ON I.Consumer_id = CR.Given_by
WHERE CM.Community_name = CR.Course_name AND CM.Community_subject = 'Course' 
GROUP BY CMM.Community_id

--People who posted the submission in community about 'Programming Language' course
SELECT CO.Fname, CO.Lname, S.Assignment_name, S.Grade, C.Community_name
FROM SUBMISSION_POST AS SP 
	 INNER JOIN POST AS P ON SP.Post_id = P.Post_id
	 INNER JOIN COMMUNITY AS C ON P.Shared_comm_id = C.Community_id
	 INNER JOIN CONSUMER AS CO ON CO.Consumer_id = P.Sender_cons_id
	 INNER JOIN SUBMISSION AS S ON SP.Submission_id = S.Submission_id
WHERE EXISTS(SELECT* 
			 FROM ASSIGNMENT AS A, COURSE 
		     WHERE S.Assignment_name=A.Assignment_name AND S.Course_id = A.Course_id AND
			 COURSE.Course_id = A.Course_id AND COURSE.Course_name = 'Programlama Dilleri')
