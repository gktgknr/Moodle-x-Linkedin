CREATE VIEW UNI_INFO AS
SELECT C.Course_id,C.Course_name, D.Dept_name, U.Uni_name
FROM  COURSE AS C
	 INNER JOIN DEPARTMENT AS D ON C.Dept_id = D.Dept_id
     INNER JOIN UNIVERSITY AS U ON D.Uni_id = U.Uni_id
GO 