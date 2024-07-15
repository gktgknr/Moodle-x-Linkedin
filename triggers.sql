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

