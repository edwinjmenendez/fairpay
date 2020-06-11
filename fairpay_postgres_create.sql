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
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (9, 'Backend Engineer', 10, 10, 67207, 3949, 424, 6042);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (10, 'Software Engineer', 11, 2, 154901, 4206, 474, 4630);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (2, 'Frontend Engineer', 13, 11, 83606, 1678, 202, 5030);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (12, 'Backend Engineer', 8, 9, 179584, 8147, 308, 8654);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (3, 'Frontend Engineer', 1, 13, 242257, 2154, 381, 3383);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (1, 'Web Developer', 6, 3, 113498, 2500, 283, 5810);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (11, 'Frontend Engineer', 13, 15, 183369, 1583, 63, 7429);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (4, 'Frontend Engineer', 15, 15, 240226, 9513, 52, 4074);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (12, 'Fullstack Engineer', 8, 4, 170274, 9799, 471, 3586);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (8, 'Software Engineer', 15, 10, 171965, 8007, 493, 4953);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (6, 'Software Engineer', 0, 15, 106026, 3682, 87, 5815);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (10, 'Frontend Engineer', 0, 13, 181769, 8092, 66, 9686);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (7, 'Backend Engineer', 10, 0, 77687, 9709, 82, 6784);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (9, 'Fullstack Engineer', 5, 8, 103493, 8464, 299, 7219);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (9, 'Fullstack Engineer', 10, 15, 153764, 9476, 440, 2618);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (1, 'Backend Engineer', 7, 3, 72883, 9499, 348, 9433);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (2, 'Software Engineer', 6, 7, 179723, 2555, 433, 4117);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (4, 'Fullstack Engineer', 11, 8, 51146, 2445, 313, 5196);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (7, 'Frontend Engineer', 7, 8, 76499, 2859, 275, 5742);
insert into salary (company_id, job_title, years_at_company, years_of_experience, base_salary, annual_bonus, stock_options, signing_bonus) values (5, 'Fullstack Engineer', 9, 2, 67357, 5591, 234, 5185);


-- added users dummy data
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('ee11f7047673a9148a1504a133bf9b704cadb9d9', 'Baxy Steeden', 9, 1, '36 - 50', 'Male', 'White', 'Los Angeles', 'California', 'bsteeden0@redcross.org');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('57dde9bff9bb3d5bd8d40830a9ba0c26610157a4', 'Base Sinclar', 7, 2, '36 - 50', 'Male', 'White', 'San Francisco', 'California', 'bsinclar1@spotify.com');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('887fe3585bee050010aafa9a34aebef07710a8bd', 'Lew Geeve', 6, 3, '36 - 50', 'Male', 'American Indian/Alaska Native', 'San Diego', 'California', 'lgeeve2@spotify.com');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('7ce2c6d3abdf8cf636d3676fd331496184bfb9ca', 'Jay Thompkins', 10, 4, '51+', 'Male', 'White', 'San Diego', 'California', 'jthompkins3@accuweather.com');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('13c15f830e46f1447dfb492eda6e37bc20011234', 'Meaghan McCague', 4, 5, '18 - 35', 'Female', 'American Indian/Alaska Native', 'Los Angeles', 'California', 'mmccague4@shop-pro.jp');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('73fd295c0c3e708b954f43f6069d5c515176d446', 'Parry Langhor', 6, 6, '18 - 35', 'Male', 'White', 'Los Angeles', 'California', 'planghor5@yahoo.com');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('ee1ab28fac11d5d8db655c8e3f017f6d435183bf', 'Guenna Weddell', 3, 7, '18 - 35', 'Female', 'American Indian/Alaska Native', 'Los Angeles', 'California', 'gweddell6@booking.com');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('b31a197d9fe69803c16d7161b102ecaaa3d095bd', 'Nikki Notley', 10, 8, '18 - 35', 'Female', 'Hispanic or Latino', 'Los Angeles', 'California', 'nnotley7@apple.com');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('4598fdd102e339694c9e81434391da481952160f', 'Kalie Brandle', 11, 9, '18 - 35', 'Female', 'White', 'San Diego', 'California', 'kbrandle8@stumbleupon.com');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('c836d6831bdf5575674fef940ed9ee69e9f0b988', 'Jenn Stokes', 4, 10, '18 - 35', 'Female', 'Asian or Pacific Islander', 'San Diego', 'California', 'jstokes9@exblog.jp');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('c60f937d4f09b4a5d2f4f24e4aa3a8d2000e6697', 'Florance Napolione', 8, 11, '51+', 'Female', 'Asian or Pacific Islander', 'San Diego', 'California', 'fnapolionea@java.com');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('a244c6d881aca68ff0ca7489918a64b25510c409', 'Cahra Mathelon', 11, 12, '18 - 35', 'Female', 'White', 'San Diego', 'California', 'cmathelonb@bravesites.com');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('009f2a2596d706463adddec44f9e60180182d171', 'Patrice Widdicombe', 2, 13, '36 - 50', 'Male', 'Black', 'San Diego', 'California', 'pwiddicombec@desdev.cn');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('1ef64a2077869916f242ce2353dd2f42a9a4f74a', 'Edin Thames', 5, 14, '36 - 50', 'Female', 'Hispanic or Latino', 'San Diego', 'California', 'ethamesd@4shared.com');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('1b9c22a124aa4bf9098c7eec9355a3784dfef5ba', 'Archibold Rignoldes', 5, 15, '18 - 35', 'Male', 'White', 'Los Angeles', 'California', 'arignoldese@storify.com');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('149a05086320cf466c8204d5eef42c51c706be1b', 'Abigail Clausen', 3, 16, '51+', 'Female', 'White', 'San Francisco', 'California', 'aclausenf@naver.com');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('b02cd5ea9d20dc8e2b32b37ae7a46edd9219d866', 'Benjamin Haney', 9, 17, '36 - 50', 'Male', 'Asian or Pacific Islander', 'San Francisco', 'California', 'bhaneyg@comcast.net');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('f63b69bf372b40554aec0fd2116900a5895fb67b', 'Holmes Gravestone', 10, 18, '36 - 50', 'Male', 'Black', 'San Francisco', 'California', 'hgravestoneh@merriam-webster.com');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('d3d347cc86aee1daeb498b1f41f82124ccf7984b', 'Edwina Chettoe', 8, 19, '18 - 35', 'Female', 'White', 'Los Angeles', 'California', 'echettoei@aboutads.info');
insert into users (linkedin_user_id, name, company_id, salary_id, age, gender, race, city, state, email) values ('078e2490a5160ba71fe8e49fd40990b73a22a5ec', 'Ingaborg Wennam', 3, 20, '36 - 50', 'Female', 'Asian or Pacific Islander', 'Los Angeles', 'California', 'iwennamj@msn.com');


-- OG users data, but modified the salary_id slightly to correspond with new data
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('andrew-cho-37990193', 'Andrew Cho', 1, 1, 'Straight', '36 - 50', 'male', 'asian', 'Sherman Oaks', 'California', 'andrewjcho84@gmail.com', 'oauthtoken1', 'refreshtoken1', 10000, '91411');
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('carlos-perez-01894592', 'Carlos Perez', 2, 2, 'Straight', '18 - 35', 'male', 'hispanic', 'Santa Monica', 'California', 'crperez@gmail.com', 'oauthtoken2', 'refreshtoken2', 10000, '90404');
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('saejin-kang-98165483', 'Saejin Kang', 3, 3, 'Straight', '18 - 35', 'male', 'asian', 'Glendale', 'California', 'saejin.kang1004@gmail.com', 'oauthtoken3', 'refreshtoken3', 10000, '91201');
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('aaron-bumanglag-95165447', 'Aaron Bumanglag', 2, 4, 'Straight', '18 - 35', 'male', 'asian', 'Gardena', 'California', 'aaron.k.bumanglag@gmail.com', 'oauthtoken4', 'refreshtoken4', 10000, '90248');
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('tyler-sullberg-19847523', 'Tyler Sullberg', 3, 5, 'Straight', '18 - 35', 'male', 'caucasian', 'Los Angeles', 'California', 'tysullberg@gmail.com', 'oauthtoken5', 'refreshtoken5', 10000, '90008');
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('reid-klarsfeld-09845136', 'Reid Klarsfeld', 2, 6, 'Straight', '18 - 35', 'male', 'caucasian', 'Venice', 'California', 'reidklarsfeld@gmail.com', 'oauthtoken6', 'refreshtoken6', 10000, '90292');
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('vivian-cermeno-76589495', 'Vivan Cermeno', 3, 7, 'Straight', '18 - 35', 'female', 'hispanic', 'Rowland Heights', 'California', 'viviancermeno@gmail.com', 'oauthtoken7', 'refreshtoken7', 10000, '91748');
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('bren-yamaguchi-56179413', 'Bren Yamaguchi', 2, 8, 'Straight', '18 - 35', 'male', 'asian', 'Torrance', 'California', 'brenyamaguchi@gmail.com', 'oauthtoken8', 'refreshtoken8', 10000, '90505');
INSERT INTO users (linkedin_user_id, name, company_id, salary_id, sexuality, age, gender, race, city, state, email, oauthtoken, refreshtoken, expiresin, zipcode) VALUES ('stephanie-wood-76123485', 'Stephanie Wood', 2, 9, 'Straight', '36 - 50', 'female', 'caucasian', 'Long Beach', 'California', 'stephaniewood@gmail.com', 'oauthtoken9', 'refreshtoken9', 10000, '90814');



