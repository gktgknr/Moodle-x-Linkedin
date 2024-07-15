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