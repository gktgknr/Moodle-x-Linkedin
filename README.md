# LinkedinMoodle-database

## Explanation About Scope of LinkedIn

LinkedIn is a professional business network and social sharing platform in general. It allows people in the business world to communicate with each other. Posts are generally related more business and education. With LinkedIn, users can share posts, organize events, create and join groups, write articles. Also users can publish their work experience, skills, education, courses and languages they known.

## Explanation About Scope of Moodle

Moodle (Modular Object Oriented Dynamic Learning Environment) is a free and open source distance education system. Moodle is used by instructors and students. Shares are made about the courses. Instructors can share assignments about courses and students can add submission to assignments.

## Aim of LinkedIn

Aim of LinkedIn is to bring people in the business world together and provide communicate with each other. It also allows people to find new job opportunities by publishing their education and job histories. LınkedIn provides a more professional network than normal social networking platforms.

## Main Entities of LinkedIn

**USER:** Keeps information about users.

**SKILL:** Keeps information about skills.

**GROUP:** It is the entity where groups records are kept.

**POST:** It is the entity where post records are kept.

**COMMENT:** It is the entity where comment records are kept.

**COMPANY:** Keeps information about the companies.

## Characteristics of Each Entity in LinkedIn

**USER:** User\_id, Name (FName, Lname), Location (City, Country), Birth\_date, Gender, Email, Phone, {Language}, {Course}

**SKILL:** Skill\_id, Skill\_name

**GROUP:** Group\_id, Group\_name, Group\_subject

**POST:** Post\_id, Content, Date

**COMMENT:** Comment\_id, Content, Date

**COMPANY:** Company\_id, Company\_name, Location (City, Country), Industry

## Relationships Among the Entities in LinkedIn

USER _ **HAS** _ SKILL

USER _ **ENDORSE** _ USER\_SKILL

USER _ **MESSAGE** _ USER

USER _ **CREATE** _ GROUP

USER _ **MEMBER** _ GROUP

USER _ **POSTS** _ POST

USER _ **LIKES** _ POST

POST _ **SHARES\_IN** _ GROUP

USER _ **SEND** _ COMMENT

USER _ **LIKES** _ COMMENT

USER _ **ACCOUNT\_CREATER** _ COMPANY

USER _ **GETS\_EDUCATION** _ COMPANY

USER _ **WORKS** _ COMPANY

## Constraints Related to Entities, Their Characteristics and The Relationships Among Them in Linkedin

The database keep user data (USER) and each user has a unique identifier (User\_id), unique e-mail (Email), name (Name, composed of first name (Fname), last name (Lname)), location (Location, composed of country (Country), city (City)), birth date (Birth\_date), gender (Gender), phone number (Phone), languages (Language), courses (Course). A user can have multiple languages and courses.

A user can have any number of skills (SKILL). The database keep skill data (SKILL) and each skill has a unique identifier (Skill\_id), skill name (Skill\_name). A skill can have by any number of user. A user can endorse any number of users' skills, and a user's skill can be endorsed by any number of users.

A user can send message any number of users. A user can receive message from any number of users. The database keeps track of the unique message identifier (Message\_id), date (Date) and content (Content) for each message.

A user can create any number of groups (GROUP).

A user can be a member of any number of groups.

A user can post any number of posts (POST).

A user can like any number of posts.

A user can send any number of comments (COMMENT).

A user can like any number of comments.

A user can be an account creator for any number of companies (COMPANY).

A user can get education from any number of companies. The database keeps track of start date of the education (Start\_date), end date of the education (End\_date), department name (Dept\_name) of the user.

A user can work for any number of companies. The database keeps track of start date (Start\_date), end date (End\_date) and position (Position) of the user.

The database keep group data (GROUP) ans each group has a unique identifier (Group\_id), group name (Gorup\_Name), subject (Group\_subject).

A group can created by only one user.

There is at least one user who is a member of a group.

A group can share any number of posts.

The database keep post data (POST) and each post has a unique identifier (Post\_id), content (Content), date (Date).

A post can liked by any number of users.

A post shares ın only one group or not.

A post posts by only one user.

A post can have any number of comments.

The database keep comment data (Comment). Comment depends on post and each comment has a unique identifier (Comment\_id), content (Content), date (Date).

A comment belongs to only one post.

A comment sends by only one user.

A comment can liked by any number of users.

The database keep company data (Company) and each company has a unique identifier (Company\_id), unique name (Company\_name), related industry (Industry), location (Location, composed of country (Country), city (City)).

A company has only one page creater user.

Any number of users can get educaction from a company.

Any number of users can work for a company.

## Aim of Moodle

Aim of Moodle is to enable education to be conducted remotely. It also provides an environment where students and instructors can always be in touch. It allows sharing of documents related to courses. With this application, students can view the courses in a more compact way. Because everything related to course content is can be found in this application.

## Main Entities of Moodle

**USER:** It is the entity where user records are kept. User must be a student or teacher.

**STUDENT:** It is the entity where student records are kept. Subclass of User.

**INSTRUCTOR:** It is the entity where instructor records are kept. Subclass of User.

**COURSE:** It is the entity where courses records are kept.

**ASSIGNMENT:** It is the entity where assignment records are kept. It depends on Course.

## Characteristics of Each Entity in Moodle

**USER:** User\_id, Name (Fname, Lname), Location (City, Country), Email, Phone

**STUDENT:** (Subclass of user)

**INSTRUCTOR:** (Subclass of user) Position

**COURSE:** Course\_id, Course\_name, year, sem

**ASSIGNMENT:** Assignment \_name, Start\_date, End\_date, Content

## Relationships Among the Entities in Moodle

STUDENT _ **TAKES** _ COURSE

INSTRUCTOR _ **GIVES** _ COURSE

INSTRUCTOR _ **SHARES** _ ASSIGNMENT

COURSE _ **HAS** _ ASSIGNMENT

STUDENT _ **ADD\_SUBMISSION** _ ASSIGNMENT

## Constraints Related to Entities, Their Characteristics and The Relationships Among Them in Moodle

The database keep user data (USER) and each user has a unique identifier (User\_id), name (Name, composed of first name (Fname), last name (Lname)), location (Location, composed of country (Country), city (City)), e-mail (Email), phone number (Phone).

A user must be a student (STUDENT) or instructor (INSTRUCTOR).

The database keep student data (STUDENT).

The database keep instructor data (INSTRUCTOR) and each instructor has position (Position).

A instructor can give any number of course (COURSE).

The database keep course data (COURSE) and each course has a unique identifier (Course\_id), name (Course\_name), year (Year), semester (Sem). There is only one course with the same name, given in the same year and semester.

A course gives by only one instructor or not.

Course can be taken by any number of students.

A course has any number of assignment (ASSIGNMENT).

The database keep assignment data (ASSIGNMENT). Assignment depends on course and each assignment has a partially unique name (Assignment\_name (uniqe with Course\_id)), start date (Start\_date), end date (End\_date), content (Content).

A assignment belongs to only one course.

A assignment shares by only one instructor.

A instructor can share any number of assignment.

Any number of student can add submission to assignment. The database keeps track of name (Submission\_name), date (Date), content (Content), grade (Grade) of the student's submission.

A student can add submission to any number of assignment.

A student can take any number of course. The database keeps track of grade of students for each course.

## LinkedinMoodle

Consumers must be registered to use the application. After signing up, they can log in with their password.

The application has a social sharing section and an education section. From the social sharing section, consumers can share and like posts and comments, send messages to other consumers, create communities and join these communities. They can also open company pages. Users can add their skills, courses they have taken, languages they have known, educational backgrounds and work histories and make them available to everyone. At the same time, a consumer can endorse skills owned by other consumers. In the education part, there are departments and courses of the universities that are registered to the system. Instructors and students can share about courses in this application. Instructors give assignments to students and students add submissions to these assignments. The course grades of the students are determined by the grades they get from the submissions.

Universites that want to use the education section apply to the relevant authorities of the application. They tell which departments and the courses of those departments will be found in the education system. Then, this university, department and course information is saved in the database. In this section, first of all, when registering the university, a company page of that university must be present, otherwise the university cannot be added. In addition, different passwords are kept in the database for each department and course. When the department or course is added to the database, the relevant passwords are automatically assigned to a department or course. These passwords are validation passwords required for consumers to enter the education system and register for courses.

If consumers want to add that they are get eduction somewhere or they are working as a instructor in a university, they need to enter a verification password in order to enter the education system. The password entered comes to the database with the API and if the relevant password matches the password of the university where they are get education or working, they are added to the education system as a student or instructor. Once students and teachers enter the education system, they do not have access to the courses there. In order to access the courses, they have to enter the verification passwords of the courses on the application. Again, this password is sent to the database by the API, and if the password matches the course password they enroll in the course.

A community with the name of the course is automatically opened from its own account after insturctors register for the course. After a student enrolls in a course, they are automatically added to the community of the instructor who gives that course. Instructors and students can share about courses in this community. A instructor can only share assignments related to the course he has given. A student can only add a submission about the courses he has taken. Otherwise, adding assignment or submission is not allowed. A student can share a submission on social sharing section. When a student registers for a course, the grade he got from that course is also recorded. The student's grade is calculated by dividing the sum of the grades received from the submissions added to the assginments for a course by the number of assignments. Each time a submission is added, the grade for that course is updated. After the relevant semester is over, if that student's grade is over 60, the skill acquisiton of the lesson is automatically added to the consumer's skills and is automatically endorsed by the instructor giving the course. At the same time, the name of the course is automatically added to the courses section of the student because he/she has completed that course.

## Main Entities of LinkedinMoodle

**Consumer:** It is the entity where consumer records are kept. Consumer can be student or instructor.

**Community:** It is the entity where community records are kept.

**Post:** It is the entity where post records are kept.

**Comment:** It is the entity where comment records are kept.

**Skill:** It is the entity where skill records are kept.

**Company:** It is the entity where company records are kept.

**University:** It is the entity where university records are kept.

**Password:** It is the entity where password records are kept. A password must be department password or course password.

**Dept\_password:** It is the entity where department password records are kept. Subclass of Password.

**Course\_password:** It is the entity where course password records are kept. Subclass of Password.

**Department:** It is the entity where department records are kept.

**Student:** It is the entity where student records are kept. Subclass of Consumer.

**Instructor:** It is the entity where instructor records are kept. Subclass of Consumer.

**Course:** It is the entity where course records are kept.

**Assignment:** It is the entity where assginment records are kept. It depends on Course.

**Submission:** It is the entity where submission records are kept.

**Submission\_post:** It is the entity where submission post records are kept. Subclass of Post.

## Caracteristics of Each Entity in LinkedinMoodle

**Consumer:** Consumer\_id, Email, Login\_password, Name (Fname, Lname), Location (City, Country), Birth\_date, Gender, {Course}, {Language}

**Community:** Community\_id, Community\_name, Community\_subject

**Post:** Post\_id, Post\_time, Content

**Comment:** Comment\_id, Content, Comment\_time

**Skill:** Skill\_name

**Company:** Company\_id, Company\_name, Location (City, Country), Company\_industry

**University:** Uni\_id, Uni\_name, Location (City, Country)

**Password:** Password\_id

**Dept\_password:** Dept\_ins\_pwd, Dept\_stu\_pwd

**Course\_password:** Course\_ins\_pwd, Course\_stu\_pwd

**Department:** Dept\_id, Dept\_name

**Student:** (Subclass of Consumer)

**Instructor:** Ins\_rank (Subclass of Consumer)

**Course:** Course\_id, Course\_name, Course\_year, Course\_sem, Skill\_acquisition

**Assignment:** Course\_id, Assignment\_name, Assn\_start\_date, Assn\_end\_date, Content, Shared\_by)

**Submission:** Submission\_id, Submission\_name, Sub\_date, Content, Grade

**Submission\_post:** (Subclass of Post)

## Relationships Among the Entities in LinkedinMoodle

CONSUMER _ **HAS** _ SKILL

CONSUMER _ **ENDORSE** _ CONSUMER\_SKILL

CONSUMER _ **MESSAGE** _ CONSUMER

CONSUMER _ **CREATE** _ COMMUNITY

CONSUMER _ **MEMBER** _ COMMUNITY

CONSUMER _ **POSTS** _ POST

CONSUMER _ **LIKES** _ POST

CONSUMER _ **SENDS** _ COMMENT

CONSUMER _ **LIKES** _ COMMENT

CONSUMER _ **ACCOUNT\_CREATER** _ COMPANY

CONSUMER _ **GETS\_EDUCATION** _ COMPANY

CONSUMER _ **WORKS\_FOR** _ COMPANY

COMPANY _ **INDICATE** _ UNIVERSITY

POST _ **HAS** _ COMMENT

POST _ **SHARES\_IN** _ COMMUNTY

UNIVERSITY _ **ADMINS** _ DEPARTMENT

INSTRUCTOR _ **WORKS** _ DEPARTMENT

DEPARTMENT _ **HAS** _ STUDENT

DEPARTMENT _ **OFFER** _ COURSE

DEPARTMENT _ **HAS** _ DEPT\_PASSWORD

COURSE _ **HAS** _ COURSE\_PASSWORD

INSTRUCTOR _ **GIVES** _ COURSE

INSTRUCTOR _ **SHARES** _ ASSIGNMENT

STUDENT _ **TAKES** _ COURSE

COURSE _ **HAS** _ ASSIGNMENT

STUDENT _ **ADD** _ SUBMISSION

SUBMISSION _ **RELATES** _ ASSIGMENT

SUBMISSION\_POST _ **CONTAIN** _ SUBMISSION

## Constraints Related to Entities, Their Characteristics and The Relationships Among Them in LinkedinMoodle

The database keep consumer data (CONSUMER) and each consumer has a unique identifier (Consumer\_id), unique e-mail (Email), name (Name, composed of first name (Fname), last name (Lname)), location (Location, composed of country (Country), city (City)), birth date (Birth\_date), gender (Gender), password for login (Login\_password), languages (Language), courses (Course). A consumer can have multiple languages and courses.

A consumer can be a student (STUDENT).

A consumer can be a instructor (INSTRUCTOR).

A consumer can have any number of skills (SKILL). The database keep skill data (SKILL) and each skill has a unique name (Skill\_name). A skill can have by any number of consumer. A consumer can endorse any number of users' skills, and a consumer's skill can be endorsed by any number of consumers.

A consumer can send message any number of consumers. A consumer can receive message from any number of consumers. The database keeps track of the unique message identifier (Message\_id), date (Send\_date) and content (Content) for each message.

A consumer can create any number of community (COMMUNITY).

A consumer can be a member of any number of community.

A consumer can post any number of posts (POST).

A consumer can like any number of posts.

A consumer can send any number of comments (COMMENT).

A consumer can like any number of comments.

A consumer can be an account creator for any number of companies (COMPANY).

A consumer can get education from any number of companies. The database keeps track of start date of the education (Edu\_start\_date), end date of the education (Edu\_end\_date), department name (Dept\_name) of the user.

A consumer can work for any number of companies. The database keeps track of start date (Work\_start\_date), end date (Work\_end\_date) and position (Position) of the user.

The database keep community data (COMMUNITY) ans each community has a unique identifier (Community\_id), community name (Community\_name), subject (Community\_subject).

A community can created by only one consumer.

There is at least one consumer who is a member of a community.

A community can share any number of posts.

The database keep post data (POST) and each post has a unique identifier (Post\_id), content (Content), date (Post\_date).

A post can be submission post (SUBMISSION\_POST).

A post can liked by any number of consumers.

A post shares in only one community or not.

A post posts by only one consumer.

A post can have any number of comments.

The database keep comment data (Comment). Comment depends on post and each comment has a unique identifier (Comment\_id), content (Content), date (Comment\_time).

A comment belongs to only one post.

A comment sends by only one consumer.

A comment can liked by any number of consumers.

The database keep company data (Company) and each company has a unique identifier (Company\_id), unique name (Company\_name), related industry (Company\_industry), location (Location, composed of country (Country), city (City)).

A company has only one page creater consumer.

Any number of consumers can get educaction from a company.

Any number of consumers can work for a company.

A company indicate to only one university (UNIVERSITY) or not.

The database keep password data (PASSWORD) and each password has a unique identifier (Password\_id).

A password must be department password (DEPT\_PASSWORD) or course password (COURSE\_PASSWORD).

The database keep department password data (DEPT\_PASSWORD) and each department password has unique password for students (Dept\_stu\_pwd), unique password for instructors (Dept\_ins\_pwd) Also student passwords and instructor passwords are different from each other.

A department password belongs to only one department (DEPARTMENT).

The database keep course password data (COURSE\_PASSWORD) and each course password has unique password for students (Course\_stu\_pwd), unique password for instructors (Course\_ins\_pwd) Also student passwords and instructor passwords are different from each other.

A course password belongs to only one course (COURSE).

The database keep univeristy data (UNIVERSITY) and each university has a unique identifier (University\_id), unique name (University\_name), location (Location, composed of country (Country), city (City)).

A university must indicate by only one company.

A university can have any number of department.

The database keep department data (DEPARTMENT) and each department has a unique identifier (Dept\_id), name (Dept\_name).

A department belongs only one university.

Any number of instructors can work for a department.

A department has any number of students.

A department can offer any number of course.

A department has only one department password.

The database keep student data (STUDENT).

A student has only one department.

A student can take any number of course. The database keeps track of grade (Grade) for each student's course.

A student can add any number of submission (SUBMISSION).

The database keep instructor data (INSTRUCTOR) and each instructor has rank (Ins\_rank).

A instructor works for only one department.

A instructor can give any number of course.

A instructor can share any number of assignment (ASSIGNMENT).

The database keep course data (COURSE) and each course has a unique identifier (Course\_id), name (Course\_name), year (Year), semester (Sem). There is only one course with the same name, given in the same year and semester.

A course offered by only one department.

A course gives by only one instructor or not.

A course can takes by any number of students.

A course has only one course password.

A course has any number of assignment.

The database keep assignment data (ASSIGNMENT). Assignment depends on course and each assignment has a partially unique name (Assignment\_name (uniqe with Course\_id)), start date (Assn\_start\_date), end date (Assn\_end\_date), content (Content).

A assignment belongs to only one course.

A assignment shares by only one instructor.

There may be any number of submissions related to a assignment.

The database keep submission data (SUBMISSION) and each submission has unique id (Submission\_id), name (Submission\_name), date (Sub\_date), content (Content), grade (Grade).

A submission relates only one assignment.

A submission adds by only one student.

There may be any number of submission post contain a submission.

The database keep submission post data (SUBMISSION\_POST).

A submission post contains only one submission.

## EER Diagram of LinkedinMoodle
![EER Diagram](https://user-images.githubusercontent.com/112978786/194402657-a31ed67b-20ea-4ce7-b904-add4f4bb931b.jpg)

## Mapping of LinkedinMoodle

**Iteration 1**

**1.**

Community (Community\_id, Community\_name, Community\_subject)

Comment (Comment\_id, Content, Comment\_time)

Skill (Skill\_name)

Company (Company\_id, Company\_name, Country, City, Company\_industry)

University (Uni\_id, Uni\_name, Country, City)

Department (Dept\_id, Dept\_name)

Course (Course\_id, Course\_name, Course\_year, Course\_sem, Skill\_acquisition)

Submission (Submission\_id, Submission\_name, Sub\_date, Content, Grade)

**2.**

Assignment (Course\_id, Assignment\_name, Assn\_start\_date, Assn\_end\_date, Content)

**3.**

University (Uni\_id, Uni\_name, Country, City, Company\_id)

**4.**

Course (Course\_id, Course\_name, Course\_year, Course\_sem, Skill\_acquisition, Dept\_id)

Submission (Submission\_id, Submission\_name, Sub\_date, Content, Grade, Course\_id, Assignment\_name)

Department (Dept\_id, Dept\_name, Uni\_id)

**5.**

**6.**

**7.**

**8.**

**8.a**

Consumer (Consumer\_id, Email, Login\_password, Fname, Lname, Country, City, Birth\_date, Gender)

Student (Consumer\_id)

Instructor (Consumer\_id, Ins\_rank)

Post (Post\_id, Post\_time, Content)

Submission\_post (Post\_id)

**8.b**

Dept\_password (Password\_id, Dept\_ins\_pwd, Dept\_stu\_pwd)

Course\_password (Password\_id, Course\_ins\_pwd, Course\_stu\_pwd)

**9.**

**Iteration 2**

**1.**

**2.**

**3.**

Department (Dept\_id, Dept\_name, Uni\_id, Dept\_pwd\_id)

Course (Course\_id, Course\_name, Course\_year, Course\_sem, Skill\_acquisition, Dept\_id, Course\_pwd\_id)

**4.**

Company (Company\_id, Company\_name, Country, City, Company\_industry, Creater\_id)

Community (Community\_id, Community\_name, Community\_subject, Creater\_id)

Post (Post\_id, Post\_time, Content, Shared\_comm\_id)

Post (Post\_id, Post\_time, Content, Shared\_comm\_id, Sender\_cons\_id)

Submission\_post (Post\_id, Submission\_id)

Comment (Comment\_id, Content, Comment\_time, Post\_id)

Comment (Comment\_id, Content, Comment\_time, Post\_id, Sender\_cons\_id)

Student (Consumer\_id, Dept\_id)

Instructor (Consumer\_id, Ins\_rank, Dept\_İd)

Course (Course\_id, Course\_name, Course\_year, Course\_sem, Skill\_acquisition, Dept\_id, Course\_pwd\_id, Given\_by)

Assignment (Course\_id, Assignment\_name, Assn\_start\_date, Assn\_end\_date, Content, Shared\_by)

Submission (Submission\_id, Submission\_name, Sub\_date, Content, Grade, Course\_id, Assignment\_name, Added\_by)

**5.**

Gets\_education (Consumer\_id, Company\_id, Edu\_start\_date, Edu\_end\_date, Dept\_name)

Works\_for (Consumer\_id, Company\_id, Work\_start\_date, Work\_end\_date, Position)

Consumer\_skill (Consumer\_id, Skill\_name)

Consumer\_skill\_endorse (Endorsed\_consumer, Endorsed\_by, Skill\_name)

Consumer\_Message (Message\_id, Sender\_consumer, Receiver\_consumer, Send\_date, Content)

Community\_member (Community\_id, Member\_id)

Consumer\_comment\_like (Consumer\_id, Comment\_id)

Consumer\_post\_like (Consumer\_id, Post\_id)

Student\_course (Student\_id, Course\_id, Grade)

**6.**

Consumer\_course (Consumer\_id, Course\_name)

Consumer\_language (Consumer\_id, Language\_name)

**7.**

**8.**

**9.**

**Final Version of The Relational Model**

Consumer (Consumer\_id, Email, Login\_password, Fname, Lname, Country, City, Birth\_date, Gender)

Community (Community\_id, Community\_name, Community\_subject, Creater\_id)

Post (Post\_id, Post\_time, Content, Shared\_comm\_id, Sender\_cons\_id)

Comment (Comment\_id, Content, Comment\_time, Post\_id, Sender\_cons\_id)

Skill (Skill\_name)

Company (Company\_id, Company\_name, Country, City, Company\_industry, Creater\_id)

University (Uni\_id, Uni\_name, Country, City, Company\_id)

Dept\_password (Password\_id, Dept\_ins\_pwd, Dept\_stu\_pwd)

Course\_password (Password\_id, Course\_ins\_pwd, Course\_stu\_pwd)

Department (Dept\_id, Dept\_name, Uni\_id, Dept\_pwd\_id)

Student (Consumer\_id, Dept\_id)

Instructor (Consumer\_id, Ins\_rank, Dept\_İd)

Course (Course\_id, Course\_name, Course\_year, Course\_sem, Skill\_acquisition, Dept\_id, Course\_pwd\_id, Given\_by)

Assignment (Course\_id, Assignment\_name, Assn\_start\_date, Assn\_end\_date, Content, Shared\_by)

Submission (Submission\_id, Submission\_name, Sub\_date, Content, Grade, Course\_id, Assignment\_name, Added\_by)

Submission\_post (Post\_id, Submission\_id)

Gets\_education (Consumer\_id, Company\_id, Edu\_start\_date, Edu\_end\_date, Dept\_name)

Works\_for (Consumer\_id, Company\_id, Work\_start\_date, Work\_end\_date, Position)

Consumer\_skill (Consumer\_id, Skill\_name)

Consumer\_skill\_endorse (Endorsed\_consumer, Endorsed\_by, Skill\_name)

Consumer\_message (Message\_id, Sender\_consumer, Receiver\_consumer, Send\_date, Content)

Community\_member (Community\_id, Member\_id)

Consumer\_comment\_like (Consumer\_id, Comment\_id)

Consumer\_post\_like (Consumer\_id, Post\_id)

Student\_course (Student\_id, Course\_id, Grade)

Consumer\_course (Consumer\_id, Course\_name)

Consumer\_language (Consumer\_id, Language\_name)
