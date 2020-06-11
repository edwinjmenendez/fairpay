-- add default test data starting with company table-- creates tables in our databases with relevant columns, setting their serial _id columns as the primary key
-- TO RUN, SWITCH TO TOP LEVEL DIRECTORY 
-- INVOKE: psql -d <DB URI> -f fairpay_postgres_create.sql

CREATE TABLE public.users
(
  "_id" serial,
  "linkedin_user_id" varchar,
  -- user id provided from linked
  "image_url" varchar,
  "name" varchar,
  "company_id" bigint,
  -- foreign key refers to company table _id
  "salary_id" bigint,
  -- foreign key refers to salary table _id
  "sexuality" varchar,
  "age" varchar,
  "actual_age" integer,
  "gender" varchar,
  "race" varchar,
  "city" varchar,
  "state" varchar,
  "zipcode" varchar,
  "email" varchar,
  "oauthtoken" varchar,
  "refreshtoken" varchar,
  "expiresin" integer,
  CONSTRAINT "users_pk" PRIMARY KEY ("_id"),
  CONSTRAINT "unique_linkedin_user_id" UNIQUE ("linkedin_user_id")
  -- sets the linkedin_user_id as a unique identifier this is needed because ?
)
WITH (
  OIDS=FALSE
);

CREATE TABLE public.salary
(
  "_id" serial,
  "company_id" bigint,
  -- foreign key refers to company table _id
  "job_title" varchar,
  -- job title at company
  "user_id" bigint,
  "employee_type" varchar,
  -- salary or hourly
  "years_at_company" integer,
  "years_of_experience" integer,
  "base_salary" integer,
  "annual_bonus" integer,
  "stock_options" integer,
  "signing_bonus" integer,
  "full_time_status" varchar,
  "active" boolean,
  CONSTRAINT "salary_pk" PRIMARY KEY ("_id")
)
WITH (
  OIDS=FALSE
);

CREATE TABLE public.company
(
  "_id" serial,
  "linkedin_id" varchar,
  -- company name given to us by linkedin
  "name" varchar,
  "city" varchar,
  "industry" varchar,
  "region" varchar,
  "zipcode" varchar,
  CONSTRAINT "company_pk" PRIMARY KEY ("_id"),
  CONSTRAINT "unique_linkedin_id" UNIQUE ("linkedin_id"),
  CONSTRAINT "name_" UNIQUE ("name")
)
WITH (
  OIDS=FALSE
);

-- 
ALTER TABLE public.users ADD CONSTRAINT "users_fk0" FOREIGN KEY ("company_id") REFERENCES public.company("_id");
ALTER TABLE public.users ADD CONSTRAINT "users_fk1" FOREIGN KEY ("salary_id") REFERENCES public.salary("_id");
ALTER TABLE public.salary ADD CONSTRAINT "salary_fk0" FOREIGN KEY ("company_id") REFERENCES public.company("_id");
ALTER TABLE public.salary ADD CONSTRAINT "salary_fk1" FOREIGN KEY ("user_id") REFERENCES public.users("_id");


-- add default test data starting with company table
INSERT INTO company (linkedin_id, name, city, industry, region, zipcode) VALUES ('Codesmith-LLC', 'Codesmith', 'Venice', 'Software Engineering Boot Camp', 'West Coast USA', '90291');
INSERT INTO company (linkedin_id, name, city, industry, region, zipcode) VALUES ('Microsoft, Inc', 'Microsoft', 'Redmond', 'Software', 'Worldwide', '98052');
INSERT INTO company (linkedin_id, name, city, industry, region, zipcode) VALUES ('Google, Inc', 'Google', 'Mountain View', 'Technology', 'Worldwide', '94043');
INSERT INTO company (linkedin_id, name, city, industry, region, zipcode) VALUES ('Facebook, Inc', 'Facebook', 'Menlo Park', 'Social Media', 'Worldwide', '94025');
INSERT INTO company (linkedin_id, name, city, industry, region, zipcode) VALUES ('Apple, Inc', 'Apple', 'Cupertino', 'Consumer Electronics', 'Worldwide', '95014');
INSERT INTO company (linkedin_id, name, city, industry, region, zipcode) VALUES ('Twitter, Inc', 'Twitter', 'San Francisco', 'Social Media', 'Worldwide', '94103'); 

-- added company dummy data
insert into company (linkedin_id, name, city) values (1, 'Hulu', 'San Francisco');
insert into company (linkedin_id, name, city) values (2, 'Amazon', 'San Diego');
insert into company (linkedin_id, name, city) values (3, 'Oracle', 'San Diego');
insert into company (linkedin_id, name, city) values (4, 'Uber', 'Los Angeles');
insert into company (linkedin_id, name, city) values (5, 'Cisco Systems', 'Los Angeles');
insert into company (linkedin_id, name, city) values (6, 'SpaceX', 'San Diego');


-- OG salary data
INSERT INTO salary (company_id, job_title, employee_type, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) VALUES (1, 'Resident', 'Salary', 1, 1, 100000, 0, 0, 0, 'yes', 'true');
INSERT INTO salary (company_id, job_title, employee_type, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) VALUES (2, 'Software Engineer', 'Salary', 1, 1, 120000, 20000, 0, 10000, 'yes', 'true');
INSERT INTO salary (company_id, job_title, employee_type, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) VALUES (3, 'Software Engineer', 'Salary', 1, 1, 130000, 20000, 0, 10000, 'yes', 'true');
INSERT INTO salary (company_id, job_title, employee_type, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) VALUES (2, 'Software Developer', 'Salary', 1, 1, 110000, 15000, 0, 5000, 'yes', 'true');
INSERT INTO salary (company_id, job_title, employee_type, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) VALUES (3, 'Software Developer', 'Salary', 1, 1, 140000, 10000, 0, 15000, 'yes', 'true');
INSERT INTO salary (company_id, job_title, employee_type, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) VALUES (2, 'Mobile Developer', 'Hourly', 1, 1, 125000, 15000, 0, 14000, 'yes', 'true');
INSERT INTO salary (company_id, job_title, employee_type, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) VALUES (3, 'Mobile Developer', 'Hourly', 1, 1, 115000, 10000, 0, 16000, 'yes', 'true');
INSERT INTO salary (company_id, job_title, employee_type, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) VALUES (2, 'Software Engineer', 'Salary', 1, 1, 150000, 10000, 0, 10000, 'yes', 'true');
INSERT INTO salary (company_id, job_title, employee_type, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) VALUES (2, 'Software Engineer', 'Salary', 1, 1, 144000, 12000, 0, 11000, 'yes', 'true');

-- added salary dummy data
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (9, 'Web Developer', 10, 8, 130504, 6396, 411, 3796, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (1, 'Software Engineer', 7, 10, 139921, 9716, 195, 9052, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (7, 'Web Developer', 6, 14, 78927, 8948, 269, 6834, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (7, 'Backend Engineer', 0, 10, 204224, 8157, 115, 1016, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (1, 'Web Developer', 11, 11, 140682, 9818, 381, 4797, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (10, 'Backend Engineer', 2, 5, 230192, 9425, 486, 3434, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (11, 'Frontend Engineer', 1, 0, 63115, 9501, 88, 7549, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (3, 'Backend Engineer', 12, 11, 217129, 4165, 207, 9377, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (9, 'Fullstack Engineer', 14, 12, 105931, 7268, 349, 1559, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (2, 'Backend Engineer', 5, 2, 108788, 1793, 306, 7387, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (7, 'Web Developer', 5, 13, 104387, 9426, 399, 1024, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (3, 'Software Engineer', 13, 9, 102599, 8696, 484, 3378, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (3, 'Software Engineer', 9, 11, 94597, 8087, 312, 3551, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (2, 'Backend Engineer', 15, 12, 173959, 6773, 489, 5428, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (9, 'Fullstack Engineer', 1, 7, 155865, 2749, 204, 8902, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (9, 'Software Engineer', 7, 1, 202197, 4557, 85, 2358, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (4, 'Software Engineer', 13, 2, 123070, 8886, 95, 7959, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (1, 'Web Developer', 5, 12, 58420, 2113, 305, 8782, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (6, 'Software Engineer', 6, 4, 84344, 1328, 400, 4936, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (2, 'Frontend Engineer', 10, 0, 94989, 4581, 127, 4286, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (8, 'Backend Engineer', 13, 12, 141499, 4952, 272, 7423, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (1, 'Software Engineer', 5, 1, 235782, 1135, 78, 1607, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (2, 'Web Developer', 3, 15, 67209, 3876, 490, 2093, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (2, 'Frontend Engineer', 14, 13, 68116, 3315, 445, 1744, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (12, 'Backend Engineer', 1, 14, 158612, 9961, 113, 2842, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (11, 'Frontend Engineer', 11, 4, 107501, 7324, 340, 6125, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (10, 'Web Developer', 10, 1, 81104, 3856, 323, 4160, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (5, 'Web Developer', 6, 3, 113138, 8054, 204, 7311, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (6, 'Frontend Engineer', 8, 14, 131807, 9783, 477, 1270, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (12, 'Web Developer', 12, 4, 85455, 6270, 437, 8301, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (2, 'Software Engineer', 3, 8, 236867, 3131, 388, 7388, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (1, 'Frontend Engineer', 8, 8, 121072, 7690, 99, 7577, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (4, 'Software Engineer', 11, 2, 106916, 8077, 305, 3518, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (12, 'Backend Engineer', 6, 4, 122630, 2525, 257, 7648, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (1, 'Software Engineer', 15, 4, 132839, 1714, 468, 8409, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (1, 'Frontend Engineer', 13, 9, 169510, 7744, 323, 3217, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (8, 'Frontend Engineer', 10, 8, 91270, 4759, 357, 8507, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (1, 'Software Engineer', 11, 13, 84774, 8441, 175, 5418, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (8, 'Web Developer', 11, 13, 212806, 4281, 259, 6228, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (7, 'Web Developer', 1, 11, 96541, 6595, 376, 7274, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (11, 'Fullstack Engineer', 2, 11, 153254, 8305, 240, 6757, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (8, 'Software Engineer', 2, 1, 189112, 7148, 193, 3656, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (2, 'Fullstack Engineer', 8, 9, 111951, 6637, 129, 2318, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (3, 'Software Engineer', 13, 2, 82521, 6287, 86, 7358, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (5, 'Fullstack Engineer', 7, 13, 78474, 2292, 405, 9294, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (12, 'Backend Engineer', 6, 4, 119319, 7724, 295, 2141, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (9, 'Fullstack Engineer', 1, 6, 185740, 6810, 478, 3077, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (3, 'Frontend Engineer', 7, 8, 198681, 4786, 483, 8494, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (4, 'Backend Engineer', 7, 7, 222344, 5049, 243, 8275, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (8, 'Web Developer', 1, 7, 177174, 3640, 357, 7732, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (8, 'Web Developer', 14, 2, 68763, 5519, 312, 5010, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (2, 'Fullstack Engineer', 11, 15, 228501, 6925, 477, 5661, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (8, 'Backend Engineer', 13, 13, 66164, 8558, 149, 3864, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (2, 'Web Developer', 12, 12, 118004, 4316, 168, 1599, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (2, 'Backend Engineer', 4, 4, 229948, 7463, 400, 5073, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (9, 'Backend Engineer', 14, 0, 182651, 5639, 208, 7070, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (6, 'Web Developer', 15, 5, 184026, 6395, 99, 5404, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (12, 'Frontend Engineer', 7, 11, 172751, 3646, 184, 9369, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (11, 'Backend Engineer', 6, 12, 94545, 1076, 434, 1509, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (5, 'Fullstack Engineer', 3, 4, 120643, 3872, 68, 1897, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (8, 'Software Engineer', 9, 0, 162438, 9183, 371, 3031, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (2, 'Frontend Engineer', 0, 7, 59350, 3038, 201, 8105, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (11, 'Web Developer', 5, 15, 157623, 3601, 209, 4994, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (2, 'Software Engineer', 13, 12, 235623, 2041, 423, 2194, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (5, 'Software Engineer', 1, 6, 223586, 6438, 224, 3896, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (9, 'Fullstack Engineer', 2, 3, 84114, 4298, 91, 6653, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (8, 'Web Developer', 4, 6, 149137, 3121, 309, 2518, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (1, 'Software Engineer', 8, 13, 97862, 7969, 302, 4240, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (5, 'Fullstack Engineer', 3, 11, 115583, 8147, 350, 7485, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (8, 'Software Engineer', 9, 9, 139022, 6223, 194, 1026, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (11, 'Software Engineer', 2, 3, 148117, 4881, 394, 7779, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (10, 'Fullstack Engineer', 14, 14, 130962, 2381, 82, 2824, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (12, 'Frontend Engineer', 2, 12, 87510, 4019, 313, 8297, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (7, 'Software Engineer', 6, 10, 178439, 4835, 444, 3448, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (8, 'Fullstack Engineer', 7, 12, 158667, 8115, 438, 9891, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (12, 'Frontend Engineer', 10, 6, 209265, 4241, 245, 3298, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (1, 'Software Engineer', 5, 2, 245264, 1263, 463, 8964, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (11, 'Fullstack Engineer', 1, 8, 111575, 8828, 119, 2161, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (8, 'Fullstack Engineer', 2, 0, 212939, 8278, 349, 3396, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (2, 'Software Engineer', 12, 8, 147628, 9982, 193, 5331, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (10, 'Frontend Engineer', 8, 1, 226946, 2936, 282, 8098, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (3, 'Web Developer', 8, 9, 188085, 3758, 145, 3257, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (11, 'Backend Engineer', 0, 12, 227334, 8329, 234, 6371, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (5, 'Backend Engineer', 12, 10, 171143, 4876, 232, 4054, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (6, 'Frontend Engineer', 0, 7, 184406, 4940, 67, 5084, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (3, 'Software Engineer', 9, 7, 97546, 3936, 471, 9536, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (10, 'Software Engineer', 0, 8, 113595, 5077, 353, 4188, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (4, 'Fullstack Engineer', 2, 12, 231336, 7510, 463, 3506, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (6, 'Software Engineer', 10, 12, 86133, 6694, 407, 2585, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (2, 'Software Engineer', 1, 6, 144275, 3088, 255, 6129, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (1, 'Software Engineer', 12, 8, 227794, 4778, 434, 1400, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (11, 'Backend Engineer', 8, 7, 143936, 9549, 195, 2518, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (9, 'Backend Engineer', 5, 13, 243463, 3022, 380, 8111, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (1, 'Web Developer', 4, 8, 81903, 5117, 404, 4342, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (7, 'Web Developer', 3, 6, 159226, 9135, 362, 6153, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (9, 'Fullstack Engineer', 12, 11, 63022, 8341, 419, 4357, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (9, 'Software Engineer', 11, 0, 228265, 4740, 349, 6081, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (2, 'Backend Engineer', 6, 10, 72376, 3241, 242, 6527, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (1, 'Fullstack Engineer', 4, 9, 57690, 5071, 188, 4333, 'yes', 'true');
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus, full_time_status, active) values (6, 'Web Developer', 1, 7, 162470, 7170, 54, 2203, 'yes', 'true');

-- added users dummy data
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('e03eb98c333c7536b75b69c005680df1a408fe43', 'Nealon Triplet', 3, 1, 'No', '18 - 35', 23, 'Male', 'White', 'San Francisco', 'California', 'ntriplet0@vinaora.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('397d19492e84c25caaba9f155cbf714b1205182f', 'Sadella McKeever', 2, 2, 'No', '18 - 35', 40, 'Female', 'White', 'San Diego', 'California', 'smckeever1@slideshare.net');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('392bee515c548d56e9529103eb3857168d79bad2', 'Chaddie Gorcke', 12, 3, 'No', '36 - 50', 42, 'Male', 'White', 'Los Angeles', 'California', 'cgorcke2@networkadvertising.org');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('5f0122711e84aa06980864bd26fd0ffc154d21cb', 'Tanitansy Huntress', 5, 4, 'No', '36 - 50', 56, 'Female', 'Black', 'San Diego', 'California', 'thuntress3@opera.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('1f2c1aae83024c19cf7c296d6724612d30cf27fd', 'Grantham Wohlers', 3, 5, 'No', '36 - 50', 31, 'Male', 'Black', 'San Francisco', 'California', 'gwohlers4@printfriendly.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('54180edc66c668861911edd58ad7fd92e47ba9f2', 'Terencio Wrightem', 5, 6, 'No', '51+', 70, 'Male', 'Black', 'San Diego', 'California', 'twrightem5@uiuc.edu');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('0cbf8d42c96079fbfa1f4240b042fe898db087a1', 'Ignazio Fareweather', 8, 7, 'No', '18 - 35', 45, 'Male', 'White', 'San Francisco', 'California', 'ifareweather6@people.com.cn');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('131c241ffd5e08d9a1a00b00e539c346238c6293', 'Obediah McCrossan', 1, 8, 'No', '36 - 50', 63, 'Male', 'Black', 'San Francisco', 'California', 'omccrossan7@economist.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('fbd42559dbc45458dcda1e84a3374c22b6485cd7', 'Georgiana Joannic', 4, 9, 'No', '51+', 42, 'Female', 'White', 'San Francisco', 'California', 'gjoannic8@smugmug.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('7709594bc39c261800eaea820d0ef8c46c20f321', 'Ansel McQuarrie', 5, 10, 'Yes', '36 - 50', 67, 'Male', 'White', 'San Diego', 'California', 'amcquarrie9@netvibes.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('68549b2c459a545d1f42b8169a2ad98b1c94d329', 'Maurita Cartmael', 9, 11, 'No', '36 - 50', 63, 'Female', 'White', 'Los Angeles', 'California', 'mcartmaela@cbsnews.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('274088fcbb4ee8d1deedb229af79fd8b20c4ab9b', 'Bastian Luberti', 3, 12, 'No', '36 - 50', 37, 'Male', 'White', 'San Diego', 'California', 'blubertib@biglobe.ne.jp');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('4819909ec48dfa6fcb602e11e5ef5db0bd28059a', 'Taddeusz Tulip', 4, 13, 'No', '51+', 47, 'Male', 'White', 'Los Angeles', 'California', 'ttulipc@chron.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('353320b5dbca7201607d8cd6b28e68b819c0b87a', 'Morgana Sproat', 8, 14, 'No', '36 - 50', 63, 'Female', 'White', 'San Francisco', 'California', 'msproatd@moonfruit.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('46b7cb10ededcb6429d8359caf186c988bce8373', 'Quintin Camerello', 6, 15, 'No', '36 - 50', 38, 'Male', 'White', 'Los Angeles', 'California', 'qcamerelloe@hao123.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('0fa033c322dd5c95927e2903ffc18f70b1c5d496', 'Charlene Bagot', 3, 16, 'No', '51+', 23, 'Female', 'Black', 'Los Angeles', 'California', 'cbagotf@slashdot.org');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('097c060710081194e59d1a86f95e29cd2cb299cf', 'Chrotoem Pestor', 8, 17, 'No', '36 - 50', 70, 'Male', 'White', 'San Francisco', 'California', 'cpestorg@china.com.cn');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('399021cbfb7261b995757e3fd3e2a6ec749c657f', 'Ari Pittam', 5, 18, 'No', '51+', 44, 'Male', 'Black', 'San Diego', 'California', 'apittamh@jalbum.net');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('8fe22056c2ee4a8d1597950655b34e7ce441e160', 'Hermine Ferenc', 3, 19, 'Yes', '51+', 35, 'Female', 'White', 'San Francisco', 'California', 'hferenci@ucla.edu');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('73283f1086a59a1febffc992b57e25b2cea4f9ea', 'Nickolaus Costar', 9, 20, 'No', '36 - 50', 45, 'Male', 'Black', 'Los Angeles', 'California', 'ncostarj@army.mil');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('6cfa9dc634ab551eae3c88cb7fa6ea4a3e3b8fa2', 'Claudian Pressman', 7, 21, 'Yes', '18 - 35', 55, 'Male', 'Black', 'San Francisco', 'California', 'cpressmank@sun.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('10c9ed70a07b46999a4061277c6e6b26fcdd7ca5', 'Antons Hallt', 3, 22, 'No', '18 - 35', 57, 'Male', 'White', 'San Francisco', 'California', 'ahalltl@princeton.edu');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('978704106a29d5154b8fd585383b941f19347bfd', 'Bronnie Redding', 11, 23, 'No', '36 - 50', 47, 'Male', 'White', 'Los Angeles', 'California', 'breddingm@mit.edu');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('aafeae8ed9dadad662c52e101af85e1430b13486', 'Sven Finnie', 4, 24, 'No', '36 - 50', 64, 'Male', 'Black', 'San Francisco', 'California', 'sfinnien@nasa.gov');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('e3d4b66704526d4f1be44c8ffe65fcce3fdb1802', 'Benoite Clark', 9, 25, 'No', '51+', 51, 'Female', 'Black', 'Los Angeles', 'California', 'bclarko@1688.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('a1d502a2721bd27dd4cb5ae3d960e1fe1b5f1ab2', 'Ethelyn Tapenden', 3, 26, 'No', '18 - 35', 19, 'Female', 'White', 'San Diego', 'California', 'etapendenp@digg.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('16cddfe87c76503b2e2beef648bb532fc035ff5a', 'Geno Timmons', 12, 27, 'No', '18 - 35', 42, 'Male', 'White', 'San Francisco', 'California', 'gtimmonsq@huffingtonpost.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('3147118fa7e3e0a053a7e67cbccf31494425656c', 'Wesley Songer', 2, 28, 'No', '18 - 35', 20, 'Male', 'White', 'Los Angeles', 'California', 'wsongerr@elegantthemes.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('4793d6509eec7d28c729376c9a53c441d5cd2f2a', 'Barrie Varah', 10, 29, 'Yes', '51+', 29, 'Female', 'White', 'San Diego', 'California', 'bvarahs@addtoany.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('a5d0df220a3bc1f051a7123b30f0acf8fb17c784', 'Dasya Maides', 2, 30, 'No', '36 - 50', 66, 'Female', 'Black', 'San Diego', 'California', 'dmaidest@unesco.org');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('49fd809ed2c9f0907980b7b2c1e13b463b65fa28', 'Sonnie Petican', 8, 31, 'No', '18 - 35', 47, 'Female', 'White', 'Los Angeles', 'California', 'speticanu@cisco.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('4db73ce2eeefd695372d3478e7215ed22f8e2ee5', 'Lynnet Ruppelin', 1, 32, 'No', '51+', 59, 'Female', 'White', 'San Diego', 'California', 'lruppelinv@un.org');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('0036dbfc6badeb51655c49fb5a44bb4a8e7276d6', 'Kipp Prescott', 12, 33, 'No', '51+', 32, 'Male', 'Black', 'San Francisco', 'California', 'kprescottw@sun.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('eb880de63e2dc14d90dfcb1c22316f165245ebe9', 'Edna Barens', 9, 34, 'No', '36 - 50', 53, 'Female', 'White', 'San Diego', 'California', 'ebarensx@paginegialle.it');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('e800aea353b1ea845cd99ab71de2791401e486c5', 'Cinda Petrashkov', 4, 35, 'No', '51+', 70, 'Female', 'White', 'Los Angeles', 'California', 'cpetrashkovy@wix.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('ed5786f011fe3013819f053cdb6c2d2f8589720d', 'Tara Whitehair', 6, 36, 'No', '36 - 50', 57, 'Female', 'Black', 'San Diego', 'California', 'twhitehairz@1688.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('a350ccba8f30acb2d0cfa0880dbe8d9f73267d08', 'Carey McIntee', 7, 37, 'No', '36 - 50', 52, 'Female', 'Black', 'San Diego', 'California', 'cmcintee10@businessweek.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('f6427b9a18f0b3308e618d2767e625705ce9ac13', 'Morton Heckney', 6, 38, 'No', '51+', 43, 'Male', 'White', 'Los Angeles', 'California', 'mheckney11@nih.gov');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('9c618db232068cbfe4302464be32a9c51df3ee82', 'Aggi Keniwell', 3, 39, 'No', '18 - 35', 33, 'Female', 'White', 'Los Angeles', 'California', 'akeniwell12@engadget.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('ad9b859fd1071b7b4917c27acb63952ddc27ee79', 'Rich Phinnis', 3, 40, 'No', '36 - 50', 59, 'Male', 'White', 'Los Angeles', 'California', 'rphinnis13@pbs.org');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('c6b81c32cae366888050e42b779350b7f43764fa', 'Annadiana Colwill', 12, 41, 'No', '18 - 35', 69, 'Female', 'Black', 'San Diego', 'California', 'acolwill14@reverbnation.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('a778103cd82d56a20e7815237ec9e1f38e69dca7', 'Terrell Ledgerton', 3, 42, 'No', '18 - 35', 69, 'Male', 'White', 'Los Angeles', 'California', 'tledgerton15@ifeng.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('8f6a5494333b85e3e2702e9a6608bf79f2bc675b', 'Nicole Crecy', 4, 43, 'No', '18 - 35', 36, 'Female', 'White', 'San Francisco', 'California', 'ncrecy16@deviantart.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('5bd20a8497866d338af36db91f75ced185810f91', 'Blondelle Roland', 9, 44, 'No', '51+', 52, 'Female', 'White', 'San Francisco', 'California', 'broland17@acquirethisname.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('3a67b7eadeafb1a7cc167008cdc7a4be34da740c', 'Jennee Leahy', 1, 45, 'No', '51+', 28, 'Female', 'White', 'San Francisco', 'California', 'jleahy18@google.pl');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('dd5e836343f2fab1aec6dc28769f54535b782b4a', 'Gwenette Milstead', 4, 46, 'No', '18 - 35', 47, 'Female', 'White', 'Los Angeles', 'California', 'gmilstead19@oracle.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('80f00f0ce047fec0b61549ab591fe9b33e698352', 'Benita Shepeard', 2, 47, 'No', '36 - 50', 20, 'Female', 'White', 'San Diego', 'California', 'bshepeard1a@sohu.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('2055872711f9f1508d51590389ffbae51b1f2f7c', 'Daniel Tailby', 1, 48, 'No', '18 - 35', 67, 'Male', 'White', 'San Francisco', 'California', 'dtailby1b@infoseek.co.jp');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('b792dcfd4108082c9afcbeeac4294305cba38405', 'Terencio Shimon', 9, 49, 'No', '51+', 37, 'Male', 'Black', 'San Francisco', 'California', 'tshimon1c@disqus.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('045be2eed6ecad71a0ae0f200bb8cf28941cb932', 'Cherilynn Spooner', 12, 50, 'No', '51+', 37, 'Female', 'White', 'Los Angeles', 'California', 'cspooner1d@slashdot.org');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('64ad5444b12dc4d826186eaf62d46ffc0b6a2143', 'Natassia Tomaszewicz', 6, 51, 'No', '36 - 50', 36, 'Female', 'White', 'San Diego', 'California', 'ntomaszewicz1e@topsy.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('fb472fdf48f00568577a90016218d6679bbd5d36', 'Rorie Racine', 5, 52, 'No', '36 - 50', 67, 'Female', 'White', 'San Diego', 'California', 'rracine1f@multiply.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('6d0b2ab73fc1e85d30adbaaf7c3a157928905a00', 'Madalyn Wathall', 3, 53, 'No', '18 - 35', 63, 'Female', 'Black', 'Los Angeles', 'California', 'mwathall1g@alexa.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('3472f9c06ab810c277a5c42891faba2bb4d75d37', 'Jud Alvey', 11, 54, 'No', '36 - 50', 20, 'Male', 'White', 'San Diego', 'California', 'jalvey1h@bbb.org');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('5b429f24ddc617c3a9d03c4c58f3cda96fc98daf', 'Faye Molineaux', 10, 55, 'No', '51+', 25, 'Female', 'White', 'San Francisco', 'California', 'fmolineaux1i@hexun.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('18137cae3a041275aa663d18d00e7a9f6acabb95', 'Lorelle Rubanenko', 7, 56, 'No', '51+', 62, 'Female', 'White', 'San Francisco', 'California', 'lrubanenko1j@yandex.ru');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('cbe1079f34b7963af8d417ce4260f6c23de93b4e', 'Gelya Paver', 11, 57, 'Yes', '36 - 50', 36, 'Female', 'White', 'San Francisco', 'California', 'gpaver1k@stanford.edu');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('1b9176a19e71b89255d7a0a1a9b207ff3a767fee', 'Weber Yusupov', 7, 58, 'No', '36 - 50', 21, 'Male', 'White', 'San Francisco', 'California', 'wyusupov1l@1und1.de');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('355a2281930ceecfccea50fb8a0c7ca3e7ce10b9', 'Lyndy McFadyen', 3, 59, 'No', '36 - 50', 46, 'Female', 'White', 'San Diego', 'California', 'lmcfadyen1m@jiathis.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('6475470b2e75921b00ffc8daf41489909f8a4f08', 'Roxy Corbie', 6, 60, 'No', '51+', 36, 'Female', 'Black', 'Los Angeles', 'California', 'rcorbie1n@drupal.org');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('5d304fb6d6c8053b3ac1a873584afcd50d432011', 'Sheryl Wankling', 1, 61, 'No', '36 - 50', 56, 'Female', 'White', 'Los Angeles', 'California', 'swankling1o@gnu.org');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('6b5e59141ba5adb1363b50a762f2b723bff29be1', 'Phaidra Brandi', 10, 62, 'No', '51+', 31, 'Female', 'White', 'San Francisco', 'California', 'pbrandi1p@123-reg.co.uk');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('b6049b69d3562217a1aac06543c5246c4f68999d', 'Ellette Vasichev', 1, 63, 'No', '51+', 58, 'Female', 'White', 'Los Angeles', 'California', 'evasichev1q@google.co.jp');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('56f27c63a76347279dc3a9cb2eb7448dd29e9f40', 'Svend Loseby', 9, 64, 'No', '51+', 53, 'Male', 'White', 'Los Angeles', 'California', 'sloseby1r@fda.gov');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('9925e30a2bd4ebe7bc683aced3474c2acaa50f3b', 'Umberto Dongate', 7, 65, 'No', '36 - 50', 54, 'Male', 'White', 'San Diego', 'California', 'udongate1s@apache.org');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('2d5606aa57bc7e5893dd2fb3fea6a44e4ba02919', 'Lorelei Blick', 4, 66, 'No', '36 - 50', 57, 'Female', 'White', 'Los Angeles', 'California', 'lblick1t@deviantart.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('be8a5a78db792171d3562bfc88cd8174120988a3', 'Myrlene Iacovazzi', 9, 67, 'No', '36 - 50', 41, 'Female', 'White', 'San Diego', 'California', 'miacovazzi1u@bloglovin.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('2c61142b82ea0fb6ea315993b9eda34f85945698', 'Sander Lichtfoth', 5, 68, 'No', '18 - 35', 27, 'Male', 'White', 'San Diego', 'California', 'slichtfoth1v@globo.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('7cabde0023497f7ea19e81936e8461b68d31bc8d', 'Rosco Gulliman', 5, 69, 'No', '36 - 50', 30, 'Male', 'Black', 'San Francisco', 'California', 'rgulliman1w@ft.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('dfd5dae79b7fc628fd3f177cb1b2b7f22543b058', 'Jacinta Stocky', 1, 70, 'No', '36 - 50', 59, 'Female', 'White', 'San Diego', 'California', 'jstocky1x@dot.gov');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('f7c06aa58b168c7e8b233104e085acd6a904f7b0', 'Andreas Di Gregorio', 6, 71, 'No', '18 - 35', 33, 'Male', 'White', 'San Francisco', 'California', 'adi1y@harvard.edu');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('9cecd50c7d88dc0c0a90a1724f9c8958964f4b8f', 'Timmi Telezhkin', 9, 72, 'No', '18 - 35', 66, 'Female', 'White', 'San Francisco', 'California', 'ttelezhkin1z@bravesites.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('3cd0f2ceb32247fd1efe876d136cd992307a23eb', 'Yorgo Arkin', 12, 73, 'Yes', '51+', 25, 'Male', 'White', 'San Diego', 'California', 'yarkin20@narod.ru');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('5e767eee20084c8a96ab384a5c38c469898aba90', 'Arabelle Skokoe', 7, 74, 'No', '51+', 67, 'Female', 'White', 'Los Angeles', 'California', 'askokoe21@rediff.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('bda975d74d9fcae5dd3f0639042705a767a27c83', 'Lacee Hars', 1, 75, 'No', '51+', 64, 'Female', 'White', 'San Diego', 'California', 'lhars22@etsy.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('95cd1effba7db79826ba9b184d2750e66ff58075', 'Gonzalo Plitz', 9, 76, 'No', '18 - 35', 31, 'Male', 'White', 'San Diego', 'California', 'gplitz23@sitemeter.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('aecdff1df74ec0a116a645c49114898bf1a62e86', 'Oliy Vigne', 8, 77, 'No', '18 - 35', 35, 'Female', 'White', 'Los Angeles', 'California', 'ovigne24@dion.ne.jp');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('7e103b1264637b5a9e8d45f7453689b44359d7d9', 'Gage Whittenbury', 10, 78, 'No', '36 - 50', 62, 'Male', 'White', 'San Francisco', 'California', 'gwhittenbury25@list-manage.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('9a9e4b54e55e4a947673181aa920de4ef8ae8ce2', 'Fabe Pietzke', 10, 79, 'No', '51+', 46, 'Male', 'Black', 'Los Angeles', 'California', 'fpietzke26@telegraph.co.uk');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('6d5f6a4ee75b645028a6d9e6cb6d7bb26f8ab937', 'Husain Bourrel', 12, 80, 'No', '36 - 50', 57, 'Male', 'White', 'San Francisco', 'California', 'hbourrel27@businessinsider.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('848deff2631e277ef86c3386f1ae5efd26dc9abd', 'Adah Dagleas', 4, 81, 'No', '18 - 35', 47, 'Female', 'White', 'San Diego', 'California', 'adagleas28@princeton.edu');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('b34fccf8cfa5b13110e78c4c0f9d507a7951e4f5', 'Timmie Dockreay', 3, 82, 'No', '18 - 35', 46, 'Female', 'White', 'Los Angeles', 'California', 'tdockreay29@xing.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('45f55bd1f41ded25cad56e56ffa28890fc44ff2a', 'Quincey Fulmen', 11, 83, 'No', '51+', 67, 'Male', 'White', 'San Diego', 'California', 'qfulmen2a@netlog.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('80a3e29fc6254085721418dac8eddae49ffff540', 'Larisa Pioch', 2, 84, 'No', '51+', 68, 'Female', 'White', 'San Diego', 'California', 'lpioch2b@un.org');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('14ae0e014430316fb7d1006d31fb1e97dcc7fd47', 'Wilfred O''Ruane', 10, 85, 'No', '36 - 50', 69, 'Male', 'Black', 'Los Angeles', 'California', 'woruane2c@artisteer.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('5e21759083a17caf75258796282e42499374f50b', 'Gianina Barbe', 1, 86, 'No', '18 - 35', 29, 'Female', 'White', 'San Francisco', 'California', 'gbarbe2d@ucsd.edu');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('2364dccef76adb09ebb4b5b7b0dcf0500073ca2b', 'Casey Coneron', 11, 87, 'Yes', '18 - 35', 28, 'Male', 'White', 'San Francisco', 'California', 'cconeron2e@instagram.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('eb781dacbf640b7f52645cf9f0de39ccae05e4e7', 'Renado Klos', 7, 88, 'No', '18 - 35', 40, 'Male', 'White', 'San Diego', 'California', 'rklos2f@deviantart.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('b4afb52b0cef9bae95bec7dd6839499a21a6f789', 'Arty Greer', 8, 89, 'No', '51+', 35, 'Male', 'White', 'Los Angeles', 'California', 'agreer2g@ftc.gov');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('759c0e15c17e3a1bf7fda31bce8682fd5c393a4a', 'Ferdinande Neil', 7, 90, 'No', '36 - 50', 43, 'Female', 'White', 'San Francisco', 'California', 'fneil2h@xinhuanet.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('1b411401fd1f2bad5088efa115cac59ce975bfb5', 'Violet Kittman', 5, 91, 'No', '18 - 35', 63, 'Female', 'White', 'San Diego', 'California', 'vkittman2i@simplemachines.org');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('3aa96c3d98c02d3742269cb43543a83ddc62aa38', 'Florida Pepye', 2, 92, 'No', '36 - 50', 34, 'Female', 'Black', 'San Diego', 'California', 'fpepye2j@ifeng.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('914f43b1346201e6c899ae67528668c64f28950f', 'Ardeen Eakly', 6, 93, 'No', '18 - 35', 62, 'Female', 'White', 'San Francisco', 'California', 'aeakly2k@scribd.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('9099246116bf7034e4fed6aac75e6f8c3d869811', 'Bertie Artingstall', 8, 94, 'Yes', '36 - 50', 41, 'Female', 'White', 'Los Angeles', 'California', 'bartingstall2l@foxnews.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('c42d7a923e5eac236e1becebed3b1b86e12cf8fb', 'Deanne Banes', 5, 95, 'No', '51+', 41, 'Female', 'White', 'Los Angeles', 'California', 'dbanes2m@kickstarter.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('265b7a6d5e88b59964c8823c066b4202b2edbff3', 'Guendolen Tidbald', 5, 96, 'No', '18 - 35', 21, 'Female', 'Black', 'San Francisco', 'California', 'gtidbald2n@indiatimes.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('9fddc96b0ec74fb327eaa0009e10442933b40b86', 'Fonzie Tatersale', 7, 97, 'No', '18 - 35', 54, 'Male', 'Black', 'San Francisco', 'California', 'ftatersale2o@vimeo.com');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('80554df41b81b7a039a4ca0a09c3a5944d536d67', 'Angel Totton', 2, 98, 'No', '36 - 50', 32, 'Male', 'Black', 'San Diego', 'California', 'atotton2p@google.co.uk');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('d171b148b89f92507268f95f216d34b3d3a95165', 'Dionisio Masselin', 10, 99, 'No', '36 - 50', 31, 'Male', 'White', 'San Francisco', 'California', 'dmasselin2q@privacy.gov.au');
insert into users (linkedin_user_id, name, company_id, salary_id, sexuality, age, actual_age, gender, race, city, state, email) values ('3f23f8cf4c7bc7cd3542d3feea997dd252eafcad', 'Lotty Twiddy', 4, 100, 'No', '51+', 23, 'Female', 'White', 'San Diego', 'California', 'ltwiddy2r@gmpg.org');

-- OG users data, but modified the salary_id slightly to correspond with new data
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('andrew-cho-37990193', 'Andrew Cho', 1, 101, 'Straight', '36 - 50', 'male', 'asian', 'Sherman Oaks', 'California', 'andrewjcho84@gmail.com', 'oauthtoken1', 'refreshtoken1', 10000, '91411');
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('carlos-perez-01894592', 'Carlos Perez', 2, 102, 'Straight', '18 - 35', 'male', 'Latino', 'Santa Monica', 'California', 'crperez@gmail.com', 'oauthtoken2', 'refreshtoken2', 10000, '90404');
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('saejin-kang-98165483', 'Saejin Kang', 3, 103, 'Straight', '18 - 35', 'male', 'asian', 'Glendale', 'California', 'saejin.kang1004@gmail.com', 'oauthtoken3', 'refreshtoken3', 10000, '91201');
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('aaron-bumanglag-95165447', 'Aaron Bumanglag', 2, 104, 'Straight', '18 - 35', 'male', 'asian', 'Gardena', 'California', 'aaron.k.bumanglag@gmail.com', 'oauthtoken4', 'refreshtoken4', 10000, '90248');
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('tyler-sullberg-19847523', 'Tyler Sullberg', 3, 105, 'Straight', '18 - 35', 'male', 'White', 'Los Angeles', 'California', 'tysullberg@gmail.com', 'oauthtoken5', 'refreshtoken5', 10000, '90008');
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('reid-klarsfeld-09845136', 'Reid Klarsfeld', 2, 106, 'Straight', '18 - 35', 'male', 'White', 'Venice', 'California', 'reidklarsfeld@gmail.com', 'oauthtoken6', 'refreshtoken6', 10000, '90292');
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('vivian-cermeno-76589495', 'Vivan Cermeno', 3, 107, 'Straight', '18 - 35', 'female', 'Latino', 'Rowland Heights', 'California', 'viviancermeno@gmail.com', 'oauthtoken7', 'refreshtoken7', 10000, '91748');
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('bren-yamaguchi-56179413', 'Bren Yamaguchi', 2, 108, 'Straight', '18 - 35', 'male', 'asian', 'Torrance', 'California', 'brenyamaguchi@gmail.com', 'oauthtoken8', 'refreshtoken8', 10000, '90505');
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('stephanie-wood-76123485', 'Stephanie Wood', 2, 109, 'Straight', '36 - 50', 'female', 'White', 'Long Beach', 'California', 'stephaniewood@gmail.com', 'oauthtoken9', 'refreshtoken9', 10000, '90814');



