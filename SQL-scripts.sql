CREATE TABLE CONSUMER
(
	Consumer_id INT NOT NULL IDENTITY,
	Email VARCHAR(150) NOT NULL,
	Login_password VARCHAR(30) NOT NULL,
	Fname VARCHAR(50) NOT NULL,
	Lname VARCHAR(50) NOT NULL,
	Country VARCHAR(50) NOT NULL,
	City VARCHAR(50) NOT NULL,
	Birth_date DATE,
	Gender CHAR(1) NOT NULL,
	PRIMARY KEY (Consumer_id),
	UNIQUE (Email)
	
);

CREATE TABLE COMMUNITY 
(
	Community_id INT NOT NULL IDENTITY,
	Community_name VARCHAR(50) NOT NULL,
	Community_subject VARCHAR(50) NOT NULL,
	Creater_id INT NOT NULL,
	PRIMARY KEY (Community_id),
	FOREIGN KEY (Creater_id) REFERENCES CONSUMER (Consumer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE POST 
(
	Post_id INT NOT NULL IDENTITY,
	Post_time DATE NOT NULL,
	Content VARCHAR(450) NOT NULL, 
	Shared_comm_id INT,
	Sender_cons_id INT NOT NULL,
	PRIMARY KEY (Post_id),
	FOREIGN KEY (Shared_comm_id) REFERENCES COMMUNITY (Community_id), 
	FOREIGN KEY (Sender_cons_id) REFERENCES CONSUMER (Consumer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE COMMENT 
(
	Comment_id INT NOT NULL IDENTITY,
	Content VARCHAR(250) NOT NULL,
	Comment_time DATE NOT NULL,
	Post_id INT NOT NULL, 
	Sender_cons_id INT NOT NULL,
	PRIMARY KEY (Comment_id),
	FOREIGN KEY (Post_id) REFERENCES POST (Post_id) ON DELETE CASCADE,
	FOREIGN KEY (Sender_cons_id) REFERENCES CONSUMER (Consumer_id)  ON UPDATE CASCADE
);

CREATE TABLE SKILL
(
	Skill_name VARCHAR(75) NOT NULL,
	PRIMARY KEY (Skill_name),
);

CREATE TABLE COMPANY
(
	Company_id INT NOT NULL IDENTITY,
	Company_name VARCHAR(100) NOT NULL, 
	Country VARCHAR(50) NOT NULL,
	City VARCHAR(50) NOT NULL,
	Company_industry VARCHAR(50) NOT NULL, 
	Creater_id INT NOT NULL,
	PRIMARY KEY (Company_id),
	UNIQUE (Company_name),
	FOREIGN KEY (Creater_id) REFERENCES CONSUMER (Consumer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE UNIVERSITY
(
	Uni_id INT NOT NULL IDENTITY,
	Uni_name VARCHAR(100) NOT NULL,
	Country VARCHAR(50) NOT NULL,
	City VARCHAR(50) NOT NULL, 
	Company_id INT,
	PRIMARY KEY (Uni_id),
	UNIQUE (Uni_name),
	FOREIGN KEY (Company_id) REFERENCES COMPANY (Company_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE DEPT_PASSWORD
(
	Password_id INT NOT NULL IDENTITY,
	Dept_ins_pwd VARCHAR(30) NOT NULL,
	Dept_stu_pwd VARCHAR(30) NOT NULL,
	PRIMARY KEY (Password_id),
	UNIQUE (Dept_ins_pwd), 
	UNIQUE (Dept_stu_pwd) 
);

CREATE TABLE COURSE_PASSWORD
(
	Password_id INT NOT NULL IDENTITY,
	Course_ins_pwd VARCHAR(30) NOT NULL, 
	Course_stu_pwd VARCHAR(30) NOT NULL,
	PRIMARY KEY (Password_id),
	UNIQUE (Course_ins_pwd),
	UNIQUE (Course_stu_pwd) 
);

CREATE TABLE DEPARTMENT 
(
	Dept_id INT NOT NULL IDENTITY,
	Dept_name VARCHAR(100) NOT NULL,
	Uni_id INT NOT NULL,
	Dept_pwd_id INT,
	PRIMARY KEY (Dept_id),
	UNIQUE (Dept_name, Uni_id),
	UNIQUE (Dept_pwd_id),
	FOREIGN KEY (Uni_id) REFERENCES UNIVERSITY (Uni_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Dept_pwd_id) REFERENCES DEPT_PASSWORD (Password_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE STUDENT
(
	Consumer_id INT NOT NULL, 
	Dept_id INT NOT NULL,
    PRIMARY KEY (Consumer_id),
	FOREIGN KEY (Consumer_id) REFERENCES CONSUMER (Consumer_id)  ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Dept_id) REFERENCES DEPARTMENT (Dept_id) 

);

CREATE TABLE INSTRUCTOR
(
	Consumer_id INT NOT NULL,
	Ins_rank VARCHAR(50) NOT NULL, 
	Dept_Ýd INT NOT NULL,
	PRIMARY KEY (Consumer_id),
	FOREIGN KEY (Consumer_id) REFERENCES CONSUMER (Consumer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Dept_id) REFERENCES DEPARTMENT (Dept_id) 

);

CREATE TABLE COURSE
(
	Course_id INT NOT NULL IDENTITY,
	Course_name VARCHAR(50) NOT NULL,
	Course_year INT NOT NULL,
	Course_sem CHAR NOT NULL, 
	Skill_acquisition VARCHAR(75) NOT NULL,
	Dept_id INT NOT NULL, 
	Course_pwd_id INT, 
	Given_by INT,
	PRIMARY KEY (Course_id),
	UNIQUE (Course_name, Course_year, Course_sem, Dept_id),
	UNIQUE (Course_pwd_id),
	FOREIGN KEY (Dept_id) REFERENCES DEPARTMENT (Dept_id) ,
	FOREIGN KEY (Course_pwd_id) REFERENCES COURSE_PASSWORD (Password_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Given_by) REFERENCES INSTRUCTOR (Consumer_id) ON DELETE SET NULL ON UPDATE CASCADE

);

CREATE TABLE ASSIGNMENT
(
	Course_id INT NOT NULL,
	Assignment_name VARCHAR(75) NOT NULL,
	Assn_start_date DATE NOT NULL,
	Assn_end_date DATE NOT NULL, 
	Content VARCHAR(8000) NOT NULL, 
	Shared_by INT NOT NULL,
	PRIMARY KEY (Course_id, Assignment_name),
	FOREIGN KEY (Course_id) REFERENCES COURSE (Course_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Shared_by) REFERENCES INSTRUCTOR (Consumer_id) 

);

CREATE TABLE SUBMISSION
(
	Submission_id INT NOT NULL IDENTITY, 
	Submission_name VARCHAR(75) NOT NULL, 
	Sub_date DATE NOT NULL,
	Content VARCHAR(8000) NOT NULL, 
	Grade INT NOT NULL, 
	Course_id INT NOT NULL,
	Assignment_name VARCHAR(75) NOT NULL, 
	Added_by INT NOT NULL, 
	PRIMARY KEY (Submission_id),
	UNIQUE  (Course_id, Assignment_name, Added_by),
	FOREIGN KEY (Course_id, Assignment_name) REFERENCES ASSIGNMENT (Course_id, Assignment_name),
	FOREIGN KEY (Added_by) REFERENCES STUDENT (Consumer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SUBMISSION_POST
(
	Post_id INT NOT NULL,
	Submission_id INT NOT NULL,
	PRIMARY KEY (Post_id),
	FOREIGN KEY (Post_id) REFERENCES POST (Post_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Submission_id) REFERENCES SUBMISSION (Submission_id) 

);

CREATE TABLE GETS_EDUCATION
(
	Consumer_id INT NOT NULL,
	Company_id INT NOT NULL, 
	Edu_start_date DATE NOT NULL,
	Edu_end_date DATE, 
	Dept_name VARCHAR(100) NOT NULL,
	PRIMARY KEY (Consumer_id, Company_id),
	FOREIGN KEY (Consumer_id) REFERENCES CONSUMER (Consumer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Company_id) REFERENCES COMPANY (Company_id) 

);

CREATE TABLE WORKS_FOR
(
	Consumer_id INT NOT NULL, 
	Company_id INT NOT NULL,
	Work_start_date DATE NOT NULL,
	Work_end_date DATE, 
	Position VARCHAR(50) NOT NULL,
	PRIMARY KEY (Consumer_id, Company_id),
	FOREIGN KEY (Consumer_id) REFERENCES CONSUMER (Consumer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Company_id) REFERENCES COMPANY (Company_id)

);

CREATE TABLE CONSUMER_SKILL
(
	Consumer_id INT NOT NULL,
	Skill_name VARCHAR(75) NOT NULL,
	PRIMARY KEY (Consumer_id, Skill_name),
	FOREIGN KEY (Consumer_id) REFERENCES CONSUMER (Consumer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Skill_name) REFERENCES SKILL (Skill_name) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE CONSUMER_SKILL_ENDORSE
(
	Endorsed_consumer INT NOT NULL, 
	Endorsed_by INT NOT NULL, 
	Skill_name VARCHAR(75) NOT NULL,
	PRIMARY KEY (Endorsed_consumer, Endorsed_by, Skill_name),
	FOREIGN KEY (Endorsed_consumer,Skill_name) REFERENCES CONSUMER_SKILL (Consumer_id,Skill_name) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Endorsed_by) REFERENCES CONSUMER (Consumer_id) 

);

CREATE TABLE CONSUMER_MESSAGE
(
	Message_id INT NOT NULL IDENTITY, 
	Sender_consumer INT NOT NULL,
	Receiver_consumer INT NOT NULL,
	Send_date DATE NOT NULL, 
	Content VARCHAR(250) NOT NULL,
	PRIMARY KEY (Message_id),
	FOREIGN KEY (Sender_consumer) REFERENCES CONSUMER (Consumer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Receiver_consumer) REFERENCES CONSUMER (Consumer_id) 

);

CREATE TABLE COMMUNITY_MEMBER
(
	Community_id INT NOT NULL,
	Member_id INT NOT NULL,
	PRIMARY KEY (Community_id, Member_id),
	FOREIGN KEY (Community_id) REFERENCES COMMUNITY (Community_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Member_id) REFERENCES CONSUMER (Consumer_id) 

);

CREATE TABLE CONSUMER_COMMENT_LIKE
(
	Consumer_id INT NOT NULL,
	Comment_id INT NOT NULL,
	PRIMARY KEY (Consumer_id, Comment_id),
	FOREIGN KEY (Consumer_id) REFERENCES CONSUMER (Consumer_id),
	FOREIGN KEY (Comment_id) REFERENCES COMMENT (Comment_id) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE CONSUMER_POST_LIKE
(
	Consumer_id INT NOT NULL, 
	Post_id INT NOT NULL,
	PRIMARY KEY (Consumer_id, Post_id),
	FOREIGN KEY (Consumer_id) REFERENCES CONSUMER (Consumer_id),
	FOREIGN KEY (Post_id) REFERENCES POST (Post_id) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE STUDENT_COURSE
(
	Student_id INT NOT NULL,
	Course_id INT NOT NULL,
	Grade INT DEFAULT 0,
	PRIMARY KEY (Student_id, Course_id),
	FOREIGN KEY (Student_id) REFERENCES STUDENT (Consumer_id),
	FOREIGN KEY (Course_id) REFERENCES COURSE (Course_id) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE CONSUMER_COURSE
(
	Consumer_id INT NOT NULL,
	Course_name VARCHAR(50),
	PRIMARY KEY (Consumer_id, Course_name),
	FOREIGN KEY (Consumer_id) REFERENCES CONSUMER (Consumer_id) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE CONSUMER_LANGUAGE
(
	Consumer_id INT NOT NULL, 
	Language_name VARCHAR(50) NOT NULL,
	PRIMARY KEY (Consumer_id, Language_name),
	FOREIGN KEY (Consumer_id) REFERENCES CONSUMER (Consumer_id) ON DELETE CASCADE ON UPDATE CASCADE

);

ALTER TABLE CONSUMER ADD CONSTRAINT CHECK_GENDER CHECK (Gender = 'F' OR Gender = 'M');
ALTER TABLE CONSUMER ADD CONSTRAINT CHECK_PWD_LEN CHECK (LEN(Login_password) >= 6);
ALTER TABLE CONSUMER ADD CONSTRAINT CHECK_AGE CHECK (YEAR(Birth_date) <= YEAR(GETDATE()) - 18);
ALTER TABLE DEPT_PASSWORD ADD CONSTRAINT CHECK_PSW_DEPT CHECK (DEPT_ins_pwd != DEPT_stu_pwd);
ALTER TABLE COURSE_PASSWORD ADD CONSTRAINT CHECK_PSW_COURSE CHECK (Course_ins_pwd != Course_stu_pwd);
ALTER TABLE SUBMISSION ADD CONSTRAINT CHECK_GRADE CHECK (Grade BETWEEN 0 AND 100);
ALTER TABLE CONSUMER_MESSAGE ADD CONSTRAINT CHECK_MESSAGE_RECEIVER CHECK (Sender_consumer != Receiver_consumer);
ALTER TABLE CONSUMER_MESSAGE ADD CONSTRAINT CHECK_MESSAGE_TIME CHECK (Send_date < GETDATE());
ALTER TABLE CONSUMER_SKILL_ENDORSE ADD CONSTRAINT CHECK_WHO_ENDORSED CHECK (Endorsed_consumer != Endorsed_by);
ALTER TABLE POST ADD CONSTRAINT CHECK_POST_TIME CHECK (Post_time < GETDATE());
ALTER TABLE COMMENT ADD CONSTRAINT CHECK_SEND_TIME CHECK (Comment_time < GETDATE());
ALTER TABLE COURSE ADD CONSTRAINT CHECK_SEM CHECK (Course_sem = '1' OR Course_sem = '2');
ALTER TABLE ASSIGNMENT ADD CONSTRAINT CHECK_DATE_ASSIGN CHECK (Assn_start_date < Assn_end_date);
ALTER TABLE GETS_EDUCATION ADD CONSTRAINT CHECK_DATE_EDU CHECK (Edu_start_date < Edu_end_date);
ALTER TABLE WORKS_FOR ADD CONSTRAINT CHECK_DATE_WORK CHECK (	(Work_end_date IS NULL AND Work_start_date < GETDATE()) OR 
																(Work_end_date IS NOT NULL AND Work_start_date < Work_end_date AND Work_end_date < GETDATE())	
															);


GO
CREATE TRIGGER CHECK_NUM_OF_INS_COURSE ON COURSE
AFTER INSERT
AS
	IF ( 3 < (
				SELECT COUNT(C.Course_id)
				FROM COURSE AS C, inserted AS I
				WHERE I.Given_by IS NOT NULL AND I.Given_by = C.Given_by
				GROUP BY C.Given_by
				)
		)
	BEGIN 
		ROLLBACK
		RAISERROR ('Istructor can not give more than 3 course', 16, 1);
	END
GO

CREATE TRIGGER CHECK_NUM_OF_STU_COURSE ON STUDENT_COURSE
AFTER INSERT
AS
	IF (10  < (
				SELECT COUNT(S.Course_id)
				FROM inserted AS I, STUDENT_COURSE AS S
				WHERE I.Student_id = S.Student_id
				GROUP BY S.Student_id
				)
		)
	BEGIN 
		ROLLBACK
		RAISERROR ('Student can not take more than 10 course', 16, 1);
	END
GO

CREATE TRIGGER CHECK_NUM_OF_COURSE_STU ON STUDENT_COURSE
AFTER INSERT
AS
	IF (250  < (SELECT COUNT(S.Student_id)
				FROM inserted AS I, STUDENT_COURSE AS S
				WHERE I.Course_id = S.Course_id
				GROUP BY S.Course_id))
	BEGIN 
		ROLLBACK
		RAISERROR ('No more than 250 students can take a course', 16, 1);
	END
GO

CREATE TRIGGER CHECK_SUB_DATE ON SUBMISSION
AFTER INSERT
AS 
	IF NOT EXISTS(
				   SELECT *
				   FROM inserted as I INNER JOIN ASSIGNMENT AS A ON I.Assignment_name = A.Assignment_name AND I.Course_id = A.Course_id
				   WHERE I.Sub_date BETWEEN A.Assn_start_date AND A.Assn_end_date
				 )
	BEGIN 
		ROLLBACK
		RAISERROR ('Submission date is not valid', 16, 1);
	END
GO

CREATE TRIGGER UPDATE_GRADE ON SUBMISSION
AFTER INSERT
AS
	declare @Total_grade INT 
	SET @Total_grade = (SELECT SUM(S.Grade) FROM inserted as I, SUBMISSION AS S WHERE I.Course_id = S.Course_id AND I.Added_by = S.Added_by);

	DECLARE @Number_of_assign INT
	SET @Number_of_assign = (SELECT COUNT(*)
	FROM  ASSIGNMENT AS A, inserted as I
	where A.Course_id = I.Course_id
	Group by A.Course_id)

	UPDATE STUDENT_COURSE
	SET Grade = (@Total_grade/@Number_of_assign)
	WHERE Student_id = (SELECT Added_by	FROM inserted) AND Course_id = (SELECT Course_id FROM inserted)
GO

CREATE TRIGGER CREATE_INS_COMM ON COURSE 
AFTER INSERT
AS
	INSERT INTO COMMUNITY (Community_name, Community_subject, Creater_id)
	SELECT Course_name, 'Course' ,Given_by
	FROM  inserted AS I
	WHERE I.Given_by IS NOT NULL
GO

CREATE TRIGGER ADD_CRETAR_TO_COMM_MEM ON COMMUNITY
AFTER INSERT
AS
	INSERT INTO COMMUNITY_MEMBER (Community_id,Member_id)
	SELECT Community_id, Creater_id
	FROM inserted 
GO

CREATE TRIGGER ADD_MEMBER_INS_COMM ON STUDENT_COURSE
AFTER INSERT
AS

	INSERT INTO COMMUNITY_MEMBER(Community_id,Member_id)
	SELECT COMM.Community_id, I.Student_id
	FROM inserted AS I 
		INNER JOIN COURSE AS C ON I.Course_id = C.Course_id
		INNER JOIN INSTRUCTOR AS INS ON C.Given_by = INS.Consumer_id
		INNER JOIN CONSUMER AS CON ON CON.Consumer_id = INS.Consumer_id
		INNER JOIN COMMUNITY AS COMM ON COMM.Creater_id = CON.Consumer_id
	WHERE COMM.Community_name = C.Course_name AND COMM.Community_subject = 'Course'
GO

CREATE TRIGGER CHECK_POSTED_BY_STU ON SUBMISSION_POST 
AFTER INSERT 
AS
	IF NOT EXISTS
				(
				SELECT *
				FROM inserted AS I 
					 INNER JOIN SUBMISSION AS S ON I.Submission_id = S.Submission_id
					 INNER JOIN POST AS P ON I.Post_id = P.Post_id 
				WHERE S.Added_by = P.Sender_cons_id
				)
BEGIN 
	ROLLBACK
		RAISERROR ('The person do not own this submission', 16, 1);
END
GO

CREATE TRIGGER CHECK_INS_WORKS_DEPT ON COURSE 
AFTER INSERT
AS
	DECLARE @given_by INT
	SET @given_by = (SELECT Given_by FROM inserted)
	IF (@given_by IS NOT NULL AND 
		NOT EXISTS  
				(
				SELECT *
				FROM inserted AS I
				INNER JOIN INSTRUCTOR AS INS ON I.Given_by = INS.Consumer_id
				WHERE I.Dept_id = INS.Dept_Ýd 
				))
	BEGIN 
			ROLLBACK
			RAISERROR ('The instructor do not working in this department', 16, 1);
	END
GO

CREATE TRIGGER CHECK_STU_DEPT ON STUDENT_COURSE 
AFTER INSERT
AS
	IF NOT EXISTS
				(
				SELECT *
				FROM inserted AS I
				INNER JOIN COURSE AS C ON I.Course_id = C.Course_id
				INNER JOIN STUDENT AS S ON I.Student_id = S.Consumer_id
				WHERE S.Dept_id = C.Dept_id
				)
	BEGIN 
			ROLLBACK
			RAISERROR ('The student is not in this department', 16, 1);
	END
GO

CREATE TRIGGER CHECK_INS_COURSE ON ASSIGNMENT
AFTER INSERT
AS 
	IF NOT EXISTS(
				  SELECT *
				  FROM inserted AS I
				  INNER JOIN INSTRUCTOR AS INS ON I.Shared_by = INS.Consumer_id
				  INNER JOIN COURSE AS C ON I.Course_id = C.Course_id
				  WHERE C.Given_by = INS.Consumer_id
				  )
	BEGIN
			ROLLBACK
			RAISERROR ('The instructor do no give this course', 16, 1);
	END
GO

CREATE TRIGGER CHECK_STU_COURSE ON SUBMISSION
AFTER INSERT
AS
	IF NOT EXISTS(
				  SELECT *
				  FROM inserted AS I
				  INNER JOIN STUDENT AS S ON I.Added_by = S.Consumer_id
				  INNER JOIN STUDENT_COURSE AS SC ON S.Consumer_id = SC.Student_id
				  WHERE I.Course_id = SC.Course_id
				  )
	BEGIN 
			ROLLBACK
			RAISERROR ('The student do not take this course', 16, 1);
	END

GO

CREATE TRIGGER CHECK_ENDORSE_SKILL ON CONSUMER_SKILL_ENDORSE
AFTER INSERT
AS
	IF NOT EXISTS (
				   SELECT *
				   FROM inserted AS I 
				   INNER JOIN CONSUMER_SKILL AS CS ON I.Endorsed_consumer = CS.Consumer_id AND I.Skill_name = CS.Skill_name
				  )
	BEGIN
			ROLLBACK
			RAISERROR ('The endorsed consumer do not have this skill', 16, 1);
	END
GO

CREATE TRIGGER ADD_COMPANY_TO_UNI ON UNIVERSITY
AFTER INSERT
AS
	DECLARE @inserted_com_id INT
	SET @inserted_com_id = (SELECT Company_id FROM inserted)
	IF(@inserted_com_id IS NOT NULL)
		BEGIN
		IF (@inserted_com_id != ( SELECT Company_id
							FROM COMPANY
							WHERE Company_name = (SELECT Uni_name 
												  FROM inserted)))
			BEGIN
				ROLLBACK
				RAISERROR ('The university name and company name do not match', 16, 1);
			END
		END
	
	ELSE
		BEGIN
			DECLARE @Company_id INT
			SET @Company_id = (select Company_id FROM COMPANY WHERE Company_name = (SELECT Uni_name FROM inserted))
			IF (@Company_id IS NOT NULL)
				BEGIN
					UPDATE UNIVERSITY	
					SET Company_id = @Company_id
					WHERE Uni_name = (SELECT Uni_name FROM inserted)
				END
			ELSE
				BEGIN
					ROLLBACK
					RAISERROR ('The university does not have a company record in its name', 16, 1);
				END	
		END
GO

CREATE TRIGGER ADD_PASSWORD_FOR_DEPT ON DEPARTMENT
AFTER INSERT
AS
	UPDATE DEPARTMENT
	SET Dept_pwd_id = (SELECT COUNT(*) FROM DEPARTMENT) 
	WHERE Dept_id = (SELECT Dept_id FROM inserted)	
GO

CREATE TRIGGER ADD_PASSWORD_FOR_COURSE ON COURSE
AFTER INSERT
AS
	UPDATE COURSE
	SET Course_pwd_id = (SELECT COUNT(*) FROM COURSE) 
	WHERE Course_id = (SELECT Course_id FROM inserted)
		
GO

CREATE TRIGGER CHECK_GROUP_POST ON POST
AFTER INSERT
AS 
	DECLARE @Community_id INT
	SET @Community_id = (SELECT Shared_comm_id FROM inserted)
	IF (@Community_id IS NOT NULL)
		BEGIN
			IF NOT EXISTS ( SELECT *
							FROM inserted AS I 
								INNER JOIN COMMUNITY AS C ON I.Shared_comm_id = C.Community_id
								INNER JOIN COMMUNITY_MEMBER AS CM ON C.Community_id = CM.Community_id
							WHERE CM.Member_id = I.Sender_cons_id
							)
			BEGIN 
				ROLLBACK
				RAISERROR ('Sender is not in related community', 16, 1);
			END
		END
GO

CREATE VIEW UNI_INFO AS
SELECT C.Course_id,C.Course_name, D.Dept_name, U.Uni_name
FROM  COURSE AS C
	 INNER JOIN DEPARTMENT AS D ON C.Dept_id = D.Dept_id
     INNER JOIN UNIVERSITY AS U ON D.Uni_id = U.Uni_id
GO 

CREATE PROCEDURE UPDATE_STUDENT_PROFILE
AS
	INSERT INTO CONSUMER_SKILL (Consumer_id, Skill_name)
	SELECT Student_id, Skill_acquisition
	FROM STUDENT_COURSE AS S 
		 INNER JOIN COURSE AS C ON S.Course_id = C.Course_id	
	WHERE S.Grade >= 60;

	INSERT INTO CONSUMER_SKILL_ENDORSE (Endorsed_consumer,Endorsed_by,Skill_name)
	SELECT Student_id,Given_by,Skill_acquisition
	FROM STUDENT_COURSE AS S 
		 INNER JOIN COURSE AS C ON S.Course_id = C.Course_id
	WHERE S.Grade >= 60;

	INSERT INTO CONSUMER_COURSE (Consumer_id,Course_name)
	SELECT Student_id, Course_name
	FROM STUDENT_COURSE AS S 
		 INNER JOIN COURSE AS C ON S.Course_id = C.Course_id
	WHERE S.Grade >= 60;
GO

INSERT INTO CONSUMER VALUES ('alper@gmail.com', '12345678','Alper','Çalýþkan','Türkiye','Ýzmir','2000-07-20','M'); 
INSERT INTO CONSUMER VALUES ('deniz@gmail.com', '123as4','Deniz','Uslu','Türkiye','Bursa','1970-04-12','M'); 
INSERT INTO CONSUMER VALUES ('mustafa@gmail.com', 'sc89axx','Mustafa','Kalýr','Türkiye','Ankara','1980-04-23','M'); 
INSERT INTO CONSUMER VALUES ('ali@gmail.com', 'sas12aTC','Ali','Mehmet','Türkiye','Sivas','2001-11-20','M');  
INSERT INTO CONSUMER VALUES ('ahmet@gmail.com', '5sCdvga','Ahmet','Soy','Türkiye','Bolu','1995-01-01','M');
INSERT INTO CONSUMER VALUES ('rýfký@gmail.com', 'sad5esa','Rýfký','Biçim','Türkiye','Manisa','1988-02-14','M');
INSERT INTO CONSUMER VALUES ('rüya@gmail.com', '254222','Rüya','Dede','Türkiye','Ýzmir','1960-05-13','F');
INSERT INTO CONSUMER VALUES ('yaðmur@gmail.com', '2452452','Yaðmur','Yaþar','Türkiye','Ýzmir','1964-05-13','F');
INSERT INTO CONSUMER VALUES ('sevgül@gmail.com', '24525424','Sevgül','Dede','Türkiye','Ýzmir','1977-05-13','F');
INSERT INTO CONSUMER VALUES ('erdoðan@gmail.com', 'fefef65','Erdoðan','Baba','Türkiye','Sivas','1972-03-13','M'); 
INSERT INTO CONSUMER VALUES ('ismail@gmail.com', 'fe45dsf5','Ýsmail','Yiðit','Türkiye','Samsun','1980-03-23','M');
INSERT INTO CONSUMER VALUES ('recep@gmail.com', 'h5wDf4sf','Recep','Kadir','Türkiye','Çanakkale','1999-07-10','M');
INSERT INTO CONSUMER VALUES ('doðuþ@gmail.com', 'fwf54fsd','Doðuþ','Rýza','Türkiye','Çanakkale','1989-05-30','M');
INSERT INTO CONSUMER VALUES ('kemal@gmail.com', 'dsa54as','Kemal','Yaman','Türkiye','Yozgat','1999-06-30','F');

INSERT INTO COMPANY VALUES ('Ege Üniversitesi', 'Türkiye', 'Ýzmir', 'Eðitim',1);
INSERT INTO COMPANY VALUES ('Dokuz Eylül Üniversitesi', 'Türkiye', 'Ýzmir', 'Eðitim',2);
INSERT INTO COMPANY VALUES ('Ýstanbul Teknik Üniversitesi', 'Türkiye', 'Ýzmir', 'Eðitim',3);
INSERT INTO COMPANY VALUES ('Arçelik', 'Türkiye', 'Ýstanbul', 'Beyaz Eþya',11);
INSERT INTO COMPANY VALUES ('Ubisoft', 'Fransa', 'Paris', 'Oyun',6);
INSERT INTO COMPANY VALUES ('Koç Üniversitesi', 'Türkiye', 'Ýstanbul', 'Eðitim',2);
INSERT INTO COMPANY VALUES ('Orta Doðu Teknik Üniversitesi', 'Türkiye', 'Ankara', 'Eðitim',5);
INSERT INTO COMPANY VALUES ('Tesla', 'Amerika', 'Kaliforniya', 'Otomotiv',12);
INSERT INTO COMPANY VALUES ('Ferrari', 'Ýtalya', 'Maranello', 'Otomotiv',10);
INSERT INTO COMPANY VALUES ('Vestel', 'Türkiye', 'Manisa', 'Ev Eþyalarý',5);

INSERT INTO UNIVERSITY (Uni_name,Country,City) VALUES ('Ege Üniversitesi', 'Türkiye', 'Ýzmir');
INSERT INTO UNIVERSITY (Uni_name,Country,City) VALUES ('Dokuz Eylül Üniversitesi', 'Türkiye', 'Ýzmir');
INSERT INTO UNIVERSITY (Uni_name,Country,City) VALUES ('Ýstanbul Teknik Üniversitesi', 'Türkiye', 'Ýstanbul');

INSERT INTO DEPT_PASSWORD VALUES('123456', '45645456');
INSERT INTO DEPT_PASSWORD VALUES('54545', '543442');
INSERT INTO DEPT_PASSWORD VALUES('22455424', '2452424');
INSERT INTO DEPT_PASSWORD VALUES('875872', '72724');
INSERT INTO DEPT_PASSWORD VALUES('27272453', '575424');
INSERT INTO DEPT_PASSWORD VALUES('572782', '278224');
INSERT INTO DEPT_PASSWORD VALUES('2782452', '27245525');
INSERT INTO DEPT_PASSWORD VALUES('27272527', '272727');

INSERT INTO COURSE_PASSWORD VALUES('54225444', '2722527');
INSERT INTO COURSE_PASSWORD VALUES('24225442', '2224520');
INSERT INTO COURSE_PASSWORD VALUES('58722245', 'DF2572');
INSERT INTO COURSE_PASSWORD VALUES('CSDC254', 'K245245');
INSERT INTO COURSE_PASSWORD VALUES('GH24524', '22HFDVS');
INSERT INTO COURSE_PASSWORD VALUES('254GJGJ', 'ASCV514');
INSERT INTO COURSE_PASSWORD VALUES('12HKHKHK', 'CDS54CDS');

INSERT INTO DEPARTMENT (Dept_name,Uni_id) VALUES ('Bilgisayar Mühendisliði', 1);
INSERT INTO DEPARTMENT (Dept_name,Uni_id) VALUES ('Eczacýlýk', 1);
INSERT INTO DEPARTMENT (Dept_name,Uni_id) VALUES ('Diþ Hekimliði', 2);
INSERT INTO DEPARTMENT (Dept_name,Uni_id) VALUES ('Bilgisayar Mühendisliði', 2);
INSERT INTO DEPARTMENT (Dept_name,Uni_id) VALUES ('Bilgisayar Mühendisliði', 3);
INSERT INTO DEPARTMENT (Dept_name,Uni_id) VALUES ('Anestezi', 3);

INSERT INTO INSTRUCTOR VALUES (1,'Profesör',1);
INSERT INTO INSTRUCTOR VALUES (2,'Doçent',4);
INSERT INTO INSTRUCTOR VALUES (3,'Profesör',5);

INSERT INTO COURSE (Course_name,Course_year,Course_sem,Skill_acquisition,Dept_id,Given_by) VALUES ('Nesneye Dayalý Programlama',2020,1,'Java',1,1);
INSERT INTO COURSE (Course_name,Course_year,Course_sem,Skill_acquisition,Dept_id,Given_by) VALUES ('Programlama Dilleri',2020,1,'C',4,2);
INSERT INTO COURSE (Course_name,Course_year,Course_sem,Skill_acquisition,Dept_id,Given_by) VALUES ('Olasýlýk ve Ýstatistik',2019,2,'Matlab',5,3);
INSERT INTO COURSE (Course_name,Course_year,Course_sem,Skill_acquisition,Dept_id,Given_by) VALUES ('Yapay Zeka Yöntemleri',2020,1,'Python',5,3);
INSERT INTO COURSE (Course_name,Course_year,Course_sem,Skill_acquisition,Dept_id,Given_by) VALUES ('Programlama Dilleri',2020,1,'C',5,3);

INSERT INTO STUDENT VALUES (4,4);
INSERT INTO STUDENT VALUES (5,5);
INSERT INTO STUDENT VALUES (6,5);
INSERT INTO STUDENT VALUES (7,5);
INSERT INTO STUDENT VALUES (8,5);
INSERT INTO STUDENT VALUES (9,5);
INSERT INTO STUDENT VALUES (10,5);

INSERT INTO STUDENT_COURSE (Student_id,Course_id) VALUES (4,2);
INSERT INTO STUDENT_COURSE (Student_id,Course_id) VALUES (5,3);
INSERT INTO STUDENT_COURSE (Student_id,Course_id) VALUES (6,3);
INSERT INTO STUDENT_COURSE (Student_id,Course_id) VALUES (7,3);
INSERT INTO STUDENT_COURSE (Student_id,Course_id) VALUES (9,3);
INSERT INTO STUDENT_COURSE (Student_id,Course_id) VALUES (5,4);
INSERT INTO STUDENT_COURSE (Student_id,Course_id) VALUES (8,4);
INSERT INTO STUDENT_COURSE (Student_id,Course_id) VALUES (9,4);
INSERT INTO STUDENT_COURSE (Student_id,Course_id) VALUES (9,5);
INSERT INTO STUDENT_COURSE (Student_id,Course_id) VALUES (10,5);

INSERT INTO ASSIGNMENT VALUES (2,'Proje1','2020-10-24','2020-10-30','(ÝÇERÝK)', 2);
INSERT INTO ASSIGNMENT VALUES (2,'Proje2','2020-11-24','2020-11-30','(ÝÇERÝK)', 2);

INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-10-25','(ÝÇERÝK)',96,2,'Proje1',4);
INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-11-29','(ÝÇERÝK)',75,2,'Proje2',4);

INSERT INTO ASSIGNMENT VALUES (3,'Proje1','2020-09-01','2020-09-05','(ÝÇERÝK)', 3);
INSERT INTO ASSIGNMENT VALUES (3,'Proje2','2020-12-12','2020-12-28','(ÝÇERÝK)', 3);
INSERT INTO ASSIGNMENT VALUES (3,'Proje3','2021-01-12','2021-01-20','(ÝÇERÝK)', 3);
INSERT INTO ASSIGNMENT VALUES (3,'Proje4','2020-09-12','2020-09-22','(ÝÇERÝK)', 3);

INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-09-05','(ÝÇERÝK)',80,3,'Proje1',5);
INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-12-27','(ÝÇERÝK)',50,3,'Proje2',5);

INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-09-02','(ÝÇERÝK)',60,3,'Proje1',6);
INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-12-18','(ÝÇERÝK)',55,3,'Proje2',6);
INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2021-01-15','(ÝÇERÝK)',78,3,'Proje3',6);
INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-09-20','(ÝÇERÝK)',100,3,'Proje4',6);

INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-09-01','(ÝÇERÝK)',45,3,'Proje1',7);
INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2021-01-14','(ÝÇERÝK)',30,3,'Proje3',7);
INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-09-18','(ÝÇERÝK)',75,3,'Proje4',7);

INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-09-02','(ÝÇERÝK)',40,3,'Proje1',9);
INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-12-19','(ÝÇERÝK)',50,3,'Proje2',9);
INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2021-01-14','(ÝÇERÝK)',65,3,'Proje3',9);
INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-09-19','(ÝÇERÝK)',52,3,'Proje4',9);

INSERT INTO ASSIGNMENT VALUES (4,'Proje1','2020-10-15','2020-10-20','(ÝÇERÝK)', 3);
INSERT INTO ASSIGNMENT VALUES (4,'Proje2','2020-12-18','2020-12-25','(ÝÇERÝK)', 3);

INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-10-16','(ÝÇERÝK)',98,4,'Proje1',5);
INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-12-20','(ÝÇERÝK)',46,4,'Proje2',5);

INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-10-17','(ÝÇERÝK)',24,4,'Proje1',8);
INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-12-18','(ÝÇERÝK)',58,4,'Proje2',8);

INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-10-17','(ÝÇERÝK)',88,4,'Proje1',9);
INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-12-20','(ÝÇERÝK)',94,4,'Proje2',9);

INSERT INTO ASSIGNMENT VALUES (5,'Proje1','2020-12-18','2020-12-30','(ÝÇERÝK)', 3);

INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-12-25','(ÝÇERÝK)',60,5,'Proje1',9);
INSERT INTO SUBMISSION VALUES ('Proje yüklemesi', '2020-12-20','(ÝÇERÝK)',59,5,'Proje1',10);

INSERT INTO SKILL VALUES ('Matlab');
INSERT INTO SKILL VALUES ('C');
INSERT INTO SKILL VALUES ('Java');
INSERT INTO SKILL VALUES ('Python');
INSERT INTO SKILL VALUES ('Liderlik');
INSERT INTO SKILL VALUES ('Grup Çalýþmasý');
INSERT INTO SKILL VALUES ('Ýletiþim');
INSERT INTO SKILL VALUES ('Kotlin');
INSERT INTO SKILL VALUES ('AutoCAD');
INSERT INTO SKILL VALUES ('SQL');

INSERT INTO CONSUMER_SKILL VALUES (4,'SQL');
INSERT INTO CONSUMER_SKILL VALUES (7,'Ýletiþim');
INSERT INTO CONSUMER_SKILL VALUES (12,'AutoCAD');
INSERT INTO CONSUMER_SKILL VALUES (1,'Grup Çalýþmasý');
INSERT INTO CONSUMER_SKILL VALUES (5,'Grup Çalýþmasý');
INSERT INTO CONSUMER_SKILL VALUES (2,'Liderlik');
INSERT INTO CONSUMER_SKILL VALUES (10,'SQL');
INSERT INTO CONSUMER_SKILL VALUES (4,'AutoCAD');

INSERT INTO CONSUMER_SKILL_ENDORSE VALUES (4,1,'AutoCAD');
INSERT INTO CONSUMER_SKILL_ENDORSE VALUES (5,3,'Grup Çalýþmasý');
INSERT INTO CONSUMER_SKILL_ENDORSE VALUES (2,10,'Liderlik');
INSERT INTO CONSUMER_SKILL_ENDORSE VALUES (4,12,'AutoCAD');
INSERT INTO CONSUMER_SKILL_ENDORSE VALUES (2,1,'Liderlik');
INSERT INTO CONSUMER_SKILL_ENDORSE VALUES (7,3,'Ýletiþim');
INSERT INTO CONSUMER_SKILL_ENDORSE VALUES (7,2,'Ýletiþim');

INSERT INTO POST VALUES ('2020-05-14', '(ÝÇERÝK)', null, 1);
INSERT INTO POST VALUES ('2021-04-12', '(ÝÇERÝK)', 2, 4);       
INSERT INTO POST VALUES ('2020-10-25', '(ÝÇERÝK)', null, 4);
INSERT INTO POST VALUES ('2020-11-16', '(ÝÇERÝK)', 2, 4);
INSERT INTO POST VALUES ('2021-03-17', '(ÝÇERÝK)', 3, 5);
INSERT INTO POST VALUES ('2019-01-18', '(ÝÇERÝK)', 4, 5);
INSERT INTO POST VALUES ('2020-10-19', '(ÝÇERÝK)', null, 11);
INSERT INTO POST VALUES ('2021-08-14', '(ÝÇERÝK)', 3, 7);
INSERT INTO POST VALUES ('2021-10-04', '(ÝÇERÝK)', 4, 8);
INSERT INTO POST VALUES ('2021-09-09', '(ÝÇERÝK)', 2, 2);
INSERT INTO POST VALUES ('2020-03-11', '(ÝÇERÝK)', 3, 5);
INSERT INTO POST VALUES ('2021-04-13', '(ÝÇERÝK)', 3, 6);
INSERT INTO POST VALUES ('2020-04-14', '(ÝÇERÝK)', null, 5);
INSERT INTO POST VALUES ('2021-12-19', '(ÝÇERÝK)', null, 5);
INSERT INTO POST VALUES ('2021-07-25', '(ÝÇERÝK)', null, 5);
INSERT INTO POST VALUES ('2021-10-19', '(ÝÇERÝK)', null, 11);
INSERT INTO POST VALUES ('2019-06-08', '(ÝÇERÝK)', null, 11);
INSERT INTO POST VALUES ('2020-01-26', '(ÝÇERÝK)', null, 12);
INSERT INTO POST VALUES ('2021-08-18', '(ÝÇERÝK)', null, 12);
INSERT INTO POST VALUES ('2019-10-19', '(ÝÇERÝK)', null, 13);

INSERT INTO SUBMISSION_POST VALUES (2,1);
INSERT INTO SUBMISSION_POST VALUES (3,1);
INSERT INTO SUBMISSION_POST VALUES (4,2);
INSERT INTO SUBMISSION_POST VALUES (5,3);
INSERT INTO SUBMISSION_POST VALUES (6,17);
INSERT INTO SUBMISSION_POST VALUES (8,10);
INSERT INTO SUBMISSION_POST VALUES (9,19);
INSERT INTO SUBMISSION_POST VALUES (11,17);
INSERT INTO SUBMISSION_POST VALUES (12,7);
INSERT INTO SUBMISSION_POST VALUES (13,4);
INSERT INTO SUBMISSION_POST VALUES (14,16);
INSERT INTO SUBMISSION_POST VALUES (15,3);

INSERT INTO WORKS_FOR VALUES (1,1,'2018-07-15', null, 'Profesör');
INSERT INTO WORKS_FOR VALUES (2,2,'2018-02-13', null, 'Doçent');
INSERT INTO WORKS_FOR VALUES (3,3,'2020-02-18',null,'Profesör');
INSERT INTO WORKS_FOR VALUES (11,4, '2015-05-16','2020-04-20', 'CEO');
INSERT INTO WORKS_FOR VALUES (12,4, '2015-06-08','2021-08-12','Sekreter');
INSERT INTO WORKS_FOR VALUES (13,5,'2015-04-05','2018-03-30','CEO');
INSERT INTO WORKS_FOR VALUES (11,5,'2020-07-20',null,'Yazýlým Uzmaný');
INSERT INTO WORKS_FOR VALUES (11,3, '2005-02-04', null,'Profesör');
INSERT INTO WORKS_FOR VALUES (13,4, '2002-10-10', '2020-05-13', 'Grafiker');
INSERT INTO WORKS_FOR VALUES (12,5, '2018-09-15', null, 'Müþteri Temsilcisi');

INSERT INTO GETS_EDUCATION VALUES (4,2,'2018-09-15',null,'Bilgisayar Mühendisliði');
INSERT INTO GETS_EDUCATION VALUES (5,3,'2019-09-20',null,'Bilgisayar Mühendisliði');
INSERT INTO GETS_EDUCATION VALUES (6,3,'2020-09-21',null,'Bilgisayar Mühendisliði');
INSERT INTO GETS_EDUCATION VALUES (7,3,'2018-09-19',null,'Bilgisayar Mühendisliði');
INSERT INTO GETS_EDUCATION VALUES (8,3,'2020-09-20',null,'Bilgisayar Mühendisliði');
INSERT INTO GETS_EDUCATION VALUES (9,3,'2021-09-20',null,'Bilgisayar Mühendisliði');

INSERT INTO GETS_EDUCATION VALUES (1,1,'2005-09-18','2009-06-20','Bilgisayar Mühendisliði');
INSERT INTO GETS_EDUCATION VALUES (2,2,'2009-09-13','2014-06-15','Bilgisayar Mühendisliði');
INSERT INTO GETS_EDUCATION VALUES (11,6,'2010-09-15',null,'Ýngiliz Dili ve Edebiyatý');
INSERT INTO GETS_EDUCATION VALUES (12,3,'2012-09-21',null,'Diþ Hekimliði');
INSERT INTO GETS_EDUCATION VALUES (11,7,'2014-09-20',null,'Kimya Mühendisliði');
INSERT INTO GETS_EDUCATION VALUES (13,2,'2018-09-25','2020-06-18','Bilgisayar Mühendisliði');

INSERT INTO COMMUNITY VALUES ('Kripto Para','Ekonomi',5)
INSERT INTO COMMUNITY VALUES ('Dijital Pazarlama','Finans',3)

INSERT INTO COMMUNITY_MEMBER VALUES (6,6)
INSERT INTO COMMUNITY_MEMBER VALUES (6,4)
INSERT INTO COMMUNITY_MEMBER VALUES (7,10)
INSERT INTO COMMUNITY_MEMBER VALUES (7,13)
INSERT INTO COMMUNITY_MEMBER VALUES (6,2)
INSERT INTO COMMUNITY_MEMBER VALUES (7,1)
INSERT INTO COMMUNITY_MEMBER VALUES (6,8)

EXEC UPDATE_STUDENT_PROFILE

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

SELECT *
FROM CONSUMER

UPDATE CONSUMER
SET Email = 'alper2@gmail.com', Login_password = 'sfFV445a'
WHERE Fname = 'Alper' AND Lname = 'Çalýþkan'

SELECT *
FROM CONSUMER

SELECT *
FROM COMPANY

UPDATE COMPANY
SET City = 'Ankara'
WHERE Company_name = 'Arçelik'

SELECT *
FROM COMPANY

SELECT *
FROM COMMUNITY

UPDATE COMMUNITY
SET Community_subject = 'Eðitim'
WHERE Community_subject = 'Ekonomi'

SELECT *
FROM COMMUNITY

SELECT *
FROM CONSUMER

UPDATE CONSUMER
SET Country = 'Fransa'
WHERE Lname LIKE '%a%'

SELECT *
FROM CONSUMER

DELETE FROM CONSUMER WHERE Fname = 'Kemal';
DELETE FROM CONSUMER_COURSE WHERE Course_name = 'Olasýlýk ve Ýstatistik';
DELETE FROM WORKS_FOR WHERE YEAR(Work_start_date) = 2018;
DELETE FROM SKILL WHERE Skill_name LIKE '_l%';
DELETE FROM POST WHERE YEAR(Post_time) = 2020;
DELETE FROM COMPANY WHERE City = 'Manisa';




	
