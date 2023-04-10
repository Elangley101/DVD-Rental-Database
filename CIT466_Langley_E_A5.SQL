--Solution 1
CREATE DATABASE BigCompany
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
--Solution 2
Create Schema internal;

--Solution 3

CREATE TABLE internal.Regions 
(
	Region_ID INTEGER PRIMARY KEY,
	Region_Number VARCHAR(25)
);

CREATE TABLE internal.Countries 
(
	Country_ID CHAR(2) PRIMARY KEY,
	Country_Name VARCHAR(40),
	Region_ID INTEGER REFERENCES internal.regions(Region_ID)
);

CREATE TABLE internal.Locations 
(
	Location_ID INTEGER PRIMARY KEY,
	Street_Address VARCHAR(25),
	Postal_Code VARCHAR(12),
	City VARCHAR(30),
	State_Province VARCHAR(12),
	Country_ID CHAR(2) REFERENCES internal.countries (Country_ID)
);

CREATE TABLE internal.Departments 
(
	Department_ID INTEGER PRIMARY KEY,
	Department_Name VARCHAR(30),
	Manager_ID INTEGER,
	Location_ID INTEGER REFERENCES internal.locations (Location_ID)
);

CREATE TABLE internal.Jobs 
(
	Job_ID VARCHAR(10) PRIMARY KEY,
	Job_Title VARCHAR(35),
	Min_Salary INTEGER DEFAULT 0,
	Max_Salary INTEGER DEFAULT 1000000
);

CREATE TABLE internal.Employees 
(
	Employee_ID INTEGER PRIMARY KEY,
	First_Name VARCHAR(20) NOT NULL,
	Last_Name VARCHAR(25) NOT NULL,
	EMail VARCHAR(25) UNIQUE NOT NULL,
	Phone_Number VARCHAR(20),
	Hire_Date DATE,
	Job_ID VARCHAR(10) REFERENCES internal.jobs (Job_ID),
	SALARY INTEGER,
	Commission_PCT INTEGER,
	Manager_ID INTEGER,
	Department_ID INTEGER REFERENCES internal.departments (Department_ID)
);

CREATE TABLE internal.Job_History 
(
	Employee_ID INTEGER REFERENCES internal.employees (Employee_ID),
	START_DATE DATE,
	End_Date DATE,
	Job_ID VARCHAR(10) REFERENCES internal.jobs (Job_ID),
	Department_ID INTEGER,
	PRIMARY KEY (Employee_ID, START_DATE)
);

CREATE TABLE internal.Jobs_Grades 
(
	Grade_Level VARCHAR(2) PRIMARY KEY,
	Lowest_Sal INTEGER DEFAULT 0,
	Highest_Sal INTEGER DEFAULT 1000000
);

--Demonstrate table alteration
ALTER TABLE IF EXISTS internal.Jobs_Grades
RENAME COLUMN Grade_Level
TO Hello_World
;

ALTER TABLE IF EXISTS internal.Jobs_Grades
RENAME COLUMN Hello_World
TO Grade_Level
;

--Generated Data
--regions
insert into internal.regions (REGION_ID, REGION_NUMBER) values ('29349', '21247');
insert into internal.regions (REGION_ID, REGION_NUMBER) values ('22913', '67375');
insert into internal.regions (REGION_ID, REGION_NUMBER) values ('25153', '58615');
insert into internal.regions (REGION_ID, REGION_NUMBER) values ('97762', '39456');
insert into internal.regions (REGION_ID, REGION_NUMBER) values ('49290', '77524');
insert into internal.regions (REGION_ID, REGION_NUMBER) values ('53816', '43668');
insert into internal.regions (REGION_ID, REGION_NUMBER) values ('18772', '05784');
insert into internal.regions (REGION_ID, REGION_NUMBER) values ('97464', '03514');
insert into internal.regions (REGION_ID, REGION_NUMBER) values ('29403', '60460');
insert into internal.regions (REGION_ID, REGION_NUMBER) values ('83317', '25843');

--countries
insert into internal.countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) values ('54', 'Philippines', '29349');
insert into internal.countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) values ('21', 'Israel', '22913');
insert into internal.countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) values ('75', 'Ukraine', '25153');
insert into internal.countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) values ('58', 'Indonesia', '97762');
insert into internal.countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) values ('36', 'Poland', '49290');
insert into internal.countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) values ('40', 'Indonesia', '53816');
insert into internal.countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) values ('99', 'South Africa', '18772');
insert into internal.countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) values ('78', 'China', '97464');
insert into internal.countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) values ('83', 'Thailand', '29403');
insert into internal.countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) values ('57', 'China', '83317');

--locations
insert into internal.locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) values ('59073', '48 Ilene Center', '85934', 'Sioux Falls', 'South Dakota', '54');
insert into internal.locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) values ('47444', '75359 Westport Pass', '42491', 'Springfield', 'Illinois', '21');
insert into internal.locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) values ('70610', '96873 Northwestern Circle', '38445', 'Macon', 'Georgia', '75');
insert into internal.locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) values ('27679', '6 Amoth Center', '02036', 'Toledo', 'Ohio', '58');
insert into internal.locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) values ('27449', '52 Armistice Park', '61553', 'San Francisco', 'California', '36');
insert into internal.locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) values ('54041', '1612 Doe Crossing Plaza', '13120', 'Fresno', 'California', '40');
insert into internal.locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) values ('91209', '60 Hoard Hill', '42879', 'Lexington', 'Kentucky', '99');
insert into internal.locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) values ('70565', '4 Vahlen Plaza', '40809', 'Van Nuys', 'California', '78');
insert into internal.locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) values ('28052', '902 Lerdahl Way', '83289', 'Herndon', 'Virginia', '83');
insert into internal.locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) values ('11720', '5 Mendota Center', '98371', 'Oklahoma City', 'Oklahoma', '57');

--departments
insert into internal.departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) values ('81244', 'Marketing', '03802', '59073');
insert into internal.departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) values ('56661', 'Engineering', '01669', '47444');
insert into internal.departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) values ('16169', 'Product Management', '70946', '70610');
insert into internal.departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) values ('16684', 'Training', '22542', '27679');
insert into internal.departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) values ('70110', 'Accounting', '51541', '27449');
insert into internal.departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) values ('00339', 'Marketing', '45159', '54041');
insert into internal.departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) values ('62261', 'Business Development', '41498', '91209');
insert into internal.departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) values ('30698', 'Training', '80331', '70565');
insert into internal.departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) values ('38457', 'Support', '27920', '28052');
insert into internal.departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) values ('85811', 'Human Resources', '25853', '11720');

--jobs
insert into internal.jobs (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) values ('04070', 'Recruiter', 70, 5444);
insert into internal.jobs (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) values ('05403', 'VP Marketing', 71, 3769);
insert into internal.jobs (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) values ('11737', 'Geologist II', 40, 6149);
insert into internal.jobs (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) values ('94097', 'Media Manager IV', 5, 6331);
insert into internal.jobs (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) values ('73255', 'Librarian', 42, 1969);
insert into internal.jobs (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) values ('99117', 'Dental Hygienist', 76, 8253);
insert into internal.jobs (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) values ('89323', 'Physical Therapy Assistant', 29, 9787);
insert into internal.jobs (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) values ('16024', 'Statistician II', 58, 374);
insert into internal.jobs (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) values ('45262', 'Physical Therapy Assistant', 36, 2082);
insert into internal.jobs (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) values ('56852', 'Staff Scientist', 56, 3563);

--employees
insert into internal.employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) values ('27754', 'Josey', 'Blackaby', 'jkaby0@mtv.com', '116-888-5493', '6/11/2021', '04070', 4113, 9260, '45099', '81244');
insert into internal.employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) values ('55216', 'Wallie', 'Borless', 'wbrless1@google.cn', '703-920-0201', '9/11/2021', '05403', 6499, 7051, '36571', '56661');
insert into internal.employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) values ('00291', 'Gradey', 'Wearing', 'ging2@webmd.com', '946-884-0247', '3/3/2021', '11737', 2626, 604, '82623', '16169');
insert into internal.employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) values ('40933', 'Elvin', 'Bartoszewski', 'wski3@mozilla.com', '522-495-6560', '6/1/2021', '94097', 8342, 2862, '21239', '16684');
insert into internal.employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) values ('18827', 'Whitney', 'Boxen', 'en4@bravesites.com', '199-838-0581', '11/5/2021', '73255', 7918, 1025, '94163', '70110');
insert into internal.employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) values ('48323', 'Carlen', 'Bonnyson', 'son5@addthis.com', '974-375-6961', '8/17/2021', '99117', 4851, 4230, '70645', '00339');
insert into internal.employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) values ('91807', 'Hatti', 'Dayton', 'n6@google.com', '753-890-2727', '9/8/2021', '89323', 8986, 5261, '11132', '62261');
insert into internal.employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) values ('65667', 'Janaya', 'Kiljan', 'n7@1688.com', '438-256-9700', '3/13/2021', '16024', 5330, 4216, '13274', '30698');
insert into internal.employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) values ('87694', 'Maegan', 'Baversor', 'or8@aboutads.info', '515-156-5385', '5/26/2021', '45262', 2290, 4579, '74436', '38457');
insert into internal.employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) values ('34400', 'Morty', 'Edgerly', 'rly9@blogs.com', '994-164-9521', '5/22/2021', '56852', 3494, 416, '84355', '85811');

--job_history
insert into internal.job_history (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) values ('27754', '1/22/2021', '6/24/2022', '04070', '60166');
insert into internal.job_history (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) values ('55216', '5/18/2021', '3/13/2022', '05403', '48466');
insert into internal.job_history (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) values ('00291', '10/1/2021', '4/22/2022', '11737', '50401');
insert into internal.job_history (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) values ('40933', '9/27/2021', '8/19/2022', '94097', '52977');
insert into internal.job_history (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) values ('18827', '8/19/2021', '1/3/2022', '73255', '89855');
insert into internal.job_history (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) values ('48323', '12/22/2020', '1/5/2022', '99117', '86169');
insert into internal.job_history (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) values ('91807', '10/26/2021', '4/12/2022', '89323', '12844');
insert into internal.job_history (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) values ('65667', '12/28/2020', '5/21/2022', '16024', '92716');
insert into internal.job_history (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) values ('87694', '8/15/2021', '12/11/2022', '45262', '75724');
insert into internal.job_history (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) values ('34400', '5/19/2021', '12/29/2022', '56852', '47325');

--job_grades
insert into internal.jobs_grades (GRADE_LEVEL, LOWEST_SAL, HIGHEST_SAL) values ('43', 84, 5061);
insert into internal.jobs_grades (GRADE_LEVEL, LOWEST_SAL, HIGHEST_SAL) values ('77', 37, 3235);
insert into internal.jobs_grades (GRADE_LEVEL, LOWEST_SAL, HIGHEST_SAL) values ('19', 75, 1677);
insert into internal.jobs_grades (GRADE_LEVEL, LOWEST_SAL, HIGHEST_SAL) values ('29', 14, 1674);
insert into internal.jobs_grades (GRADE_LEVEL, LOWEST_SAL, HIGHEST_SAL) values ('22', 67, 6247);
insert into internal.jobs_grades (GRADE_LEVEL, LOWEST_SAL, HIGHEST_SAL) values ('25', 98, 9197);
insert into internal.jobs_grades (GRADE_LEVEL, LOWEST_SAL, HIGHEST_SAL) values ('32', 98, 3136);
insert into internal.jobs_grades (GRADE_LEVEL, LOWEST_SAL, HIGHEST_SAL) values ('86', 86, 781);
insert into internal.jobs_grades (GRADE_LEVEL, LOWEST_SAL, HIGHEST_SAL) values ('08', 29, 4755);
insert into internal.jobs_grades (GRADE_LEVEL, LOWEST_SAL, HIGHEST_SAL) values ('85', 56, 4981);



--Demonstrate update
UPDATE 
	internal.Jobs_Grades
	
	SET HIGHEST_SAL = DEFAULT
WHERE
	Highest_Sal = 781
;

--Demonstrate delete
DELETE FROM 
	internal.Jobs_Grades
WHERE
	Lowest_Sal = 0
;