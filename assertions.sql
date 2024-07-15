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