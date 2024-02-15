-- ----------------------------
--  Database : hr - Human Resources
--  Make sure to create a database called "hr"
-- ----------------------------

-- ----------------------------
--  Table : employees
-- ----------------------------
DROP TABLE IF EXISTS "public"."employees";
CREATE TABLE "public"."employees" (
    employee_id numeric(6,0) DEFAULT (0)::numeric NOT NULL,
    first_name character varying(20) DEFAULT NULL::character varying,
    last_name character varying(25) NOT NULL,
    email character varying(125) NOT NULL,
    phone_number character varying(20) DEFAULT NULL::character varying,
    hire_date date NOT NULL,
    job_id character varying(10) NOT NULL,
    salary numeric(8,2) DEFAULT NULL::numeric,
    commission_pct numeric(2,2) DEFAULT NULL::numeric,
    manager_id numeric(6,0) DEFAULT NULL::numeric,
    department_id numeric(4,0) DEFAULT NULL::numeric
)
WITH (OIDS=FALSE);

BEGIN;
INSERT INTO "public"."employees" VALUES (100,'Tia','Leo','tialeo@company.com','515.123.4567','2020-06-17','AD_PRES','150000','0','0','90');
INSERT INTO "public"."employees" VALUES (100,'Steven','King','steven.king@company.com','515.123.4567','2020-06-17','AD_PRES','24000','0','0','90');
INSERT INTO "public"."employees" VALUES (101,'Neena','Kochhar','neena.kochhar@company.com','515.123.4568','2020-06-18','AD_VP','17000','0','100','90');
INSERT INTO "public"."employees" VALUES (102,'Lex','De Haan','lex.de haan@company.com','515.123.4569','2020-06-19','AD_VP','17000','0','100','90');
INSERT INTO "public"."employees" VALUES (103,'Alexander','Hunold','alexander.hunold@company.com','590.423.4567','2020-06-20','IT_PROG','9000','0','102','60');
INSERT INTO "public"."employees" VALUES (104,'Bruce','Ernst','bruce.ernst@company.com','590.423.4568','2020-06-21','IT_PROG','6000','0','103','60');
INSERT INTO "public"."employees" VALUES (105,'David','Austin','david.austin@company.com','590.423.4569','2020-06-22','IT_PROG','4800','0','103','60');
INSERT INTO "public"."employees" VALUES (106,'Valli','Pataballa','valli.pataballa@company.com','590.423.4560','2020-06-23','IT_PROG','4800','0','103','60');
INSERT INTO "public"."employees" VALUES (107,'Diana','Lorentz','diana.lorentz@company.com','590.423.5567','2020-06-24','IT_PROG','4200','0','103','60');
INSERT INTO "public"."employees" VALUES (114,'Den','Raphaely','den.raphaely@company.com','515.127.4561','2020-07-01','PU_MAN','11000','0','100','30');
INSERT INTO "public"."employees" VALUES (115,'Alexander','Khoo','alexander.khoo@company.com','515.127.4562','2020-07-02','PU_CLERK','3100','0','114','30');
INSERT INTO "public"."employees" VALUES (116,'Shelli','Baida','shelli.baida@company.com','515.127.4563','2020-07-03','PU_CLERK','2900','0','114','30');
INSERT INTO "public"."employees" VALUES (117,'Sigal','Tobias','sigal.tobias@company.com','515.127.4564','2020-07-04','PU_CLERK','2800','0','114','30');
INSERT INTO "public"."employees" VALUES (108,'Nancy','Greenberg','nancy.greenberg@company.com','515.999.4569','2020-06-25','FI_MGR','12000','0','101','100');
INSERT INTO "public"."employees" VALUES (109,'Daniel','Faviet','daniel.faviet@company.com','515.999.4169','2020-06-26','FI_ACCOUNT','9000','0','108','100');
INSERT INTO "public"."employees" VALUES (110,'John','Chen','john.chen@company.com','515.999.4269','2020-06-27','FI_ACCOUNT','8200','0','108','100');
INSERT INTO "public"."employees" VALUES (111,'Ismael','Sciarra','ismael.sciarra@company.com','515.999.4369','2020-06-28','FI_ACCOUNT','7700','0','108','100');
INSERT INTO "public"."employees" VALUES (112,'Jose Manuel','Urman','jose manuel.urman@company.com','515.999.4469','2020-06-29','FI_ACCOUNT','7800','0','108','100');
INSERT INTO "public"."employees" VALUES (113,'Luis','Popp','luis.popp@company.com','515.999.4567','2020-06-30','FI_ACCOUNT','6900','0','108','100');
INSERT INTO "public"."employees" VALUES (133,'Jason','Mallin','jason.mallin@company.com','650.127.1934','2020-07-20','ST_CLERK','3300','0','122','50');
INSERT INTO "public"."employees" VALUES (134,'Michael','Rogers','michael.rogers@company.com','650.127.1834','2020-07-21','ST_CLERK','2900','0','122','50');
INSERT INTO "public"."employees" VALUES (135,'Ki','Gee','ki.gee@company.com','650.127.1734','2020-07-22','ST_CLERK','2400','0','122','50');
INSERT INTO "public"."employees" VALUES (136,'Hazel','Philtanker','hazel.philtanker@company.com','650.127.1634','2020-07-23','ST_CLERK','2200','0','122','50');
INSERT INTO "public"."employees" VALUES (137,'Renske','Ladwig','renske.ladwig@company.com','650.121.1234','2020-07-24','ST_CLERK','3600','0','123','50');
INSERT INTO "public"."employees" VALUES (138,'Stephen','Stiles','stephen.stiles@company.com','650.121.2034','2020-07-25','ST_CLERK','3200','0','123','50');
INSERT INTO "public"."employees" VALUES (139,'John','Seo','john.seo@company.com','650.121.2019','2020-07-26','ST_CLERK','2700','0','123','50');
INSERT INTO "public"."employees" VALUES (140,'Joshua','Patel','joshua.patel@company.com','650.121.1834','2020-07-27','ST_CLERK','2500','0','123','50');
INSERT INTO "public"."employees" VALUES (129,'Laura','Bissot','laura.bissot@company.com','650.999.5234','2020-07-16','ST_CLERK','3300','0','121','50');
INSERT INTO "public"."employees" VALUES (130,'Mozhe','Atkinson','mozhe.atkinson@company.com','650.999.6234','2020-07-17','ST_CLERK','2800','0','121','50');
INSERT INTO "public"."employees" VALUES (131,'James','Marlow','james.marlow@company.com','650.999.7234','2020-07-18','ST_CLERK','2500','0','121','50');
INSERT INTO "public"."employees" VALUES (132,'TJ','Olson','tj.olson@company.com','650.999.8234','2020-07-19','ST_CLERK','2100','0','121','50');
INSERT INTO "public"."employees" VALUES (141,'Trenna','Rajs','trenna.rajs@company.com','650.121.8009','2020-07-28','ST_CLERK','3500','0','124','50');
INSERT INTO "public"."employees" VALUES (142,'Curtis','Davies','curtis.davies@company.com','650.121.2994','2020-07-29','ST_CLERK','3100','0','124','50');
INSERT INTO "public"."employees" VALUES (143,'Randall','Matos','randall.matos@company.com','650.121.2874','2020-07-30','ST_CLERK','2600','0','124','50');
INSERT INTO "public"."employees" VALUES (144,'Peter','Vargas','peter.vargas@company.com','650.121.2004','2020-07-31','ST_CLERK','2500','0','124','50');
INSERT INTO "public"."employees" VALUES (145,'John','Russell','john.russell@company.com','011.44.1344.429268','2020-08-01','SA_MAN','14000','0.4','100','80');
INSERT INTO "public"."employees" VALUES (146,'Karen','Partners','karen.partners@company.com','011.44.1344.467268','2020-08-02','SA_MAN','13500','0.3','100','80');
INSERT INTO "public"."employees" VALUES (147,'Alberto','Errazuriz','alberto.errazuriz@company.com','011.44.1344.429278','2020-08-03','SA_MAN','12000','0.3','100','80');
INSERT INTO "public"."employees" VALUES (148,'Gerald','Cambrault','gerald.cambrault@company.com','011.44.1344.619268','2020-08-04','SA_MAN','11000','0.3','100','80');
INSERT INTO "public"."employees" VALUES (149,'Eleni','Zlotkey','eleni.zlotkey@company.com','011.44.1344.429018','2020-08-05','SA_MAN','10500','0.2','100','80');
INSERT INTO "public"."employees" VALUES (150,'Peter','Tucker','peter.tucker@company.com','011.44.1344.129268','2020-08-06','SA_REP','10000','0.3','145','80');
INSERT INTO "public"."employees" VALUES (118,'Guy','Himuro','guy.himuro@company.com','515.127.4565','2020-07-05','PU_CLERK','2600','0','114','30');
INSERT INTO "public"."employees" VALUES (119,'Karen','Colmenares','karen.colmenares@company.com','515.127.4566','2020-07-06','PU_CLERK','2500','0','114','30');
INSERT INTO "public"."employees" VALUES (120,'Matthew','Weiss','matthew.weiss@company.com','650.123.1234','2020-07-07','ST_MAN','8000','0','100','50');
INSERT INTO "public"."employees" VALUES (121,'Adam','Fripp','adam.fripp@company.com','650.123.2234','2020-07-08','ST_MAN','8200','0','100','50');
INSERT INTO "public"."employees" VALUES (122,'Payam','Kaufling','payam.kaufling@company.com','650.123.3234','2020-07-09','ST_MAN','7900','0','100','50');
INSERT INTO "public"."employees" VALUES (123,'Shanta','Vollman','shanta.vollman@company.com','650.123.4234','2020-07-10','ST_MAN','6500','0','100','50');
INSERT INTO "public"."employees" VALUES (124,'Kevin','Mourgos','kevin.mourgos@company.com','650.123.5234','2020-07-11','ST_MAN','5800','0','100','50');
INSERT INTO "public"."employees" VALUES (151,'David','Bernstein','david.bernstein@company.com','011.44.1344.345268','2020-08-07','SA_REP','9500','0.25','145','80');
INSERT INTO "public"."employees" VALUES (152,'Peter','Hall','peter.hall@company.com','011.44.1344.478968','2020-08-08','SA_REP','9000','0.25','145','80');
INSERT INTO "public"."employees" VALUES (153,'Christopher','Olsen','christopher.olsen@company.com','011.44.1344.498718','2020-08-09','SA_REP','8000','0.2','145','80');
INSERT INTO "public"."employees" VALUES (154,'Nanette','Cambrault','nanette.cambrault@company.com','011.44.1344.987668','2020-08-10','SA_REP','7500','0.2','145','80');
INSERT INTO "public"."employees" VALUES (155,'Oliver','Tuvault','oliver.tuvault@company.com','011.44.1344.486508','2020-08-11','SA_REP','7000','0.15','145','80');
INSERT INTO "public"."employees" VALUES (156,'Janette','King','janette.king@company.com','011.44.1345.429268','2020-08-12','SA_REP','10000','0.35','146','80');
INSERT INTO "public"."employees" VALUES (157,'Patrick','Sully','patrick.sully@company.com','011.44.1345.929268','2020-08-13','SA_REP','9500','0.35','146','80');
INSERT INTO "public"."employees" VALUES (158,'Allan','McEwen','allan.mcewen@company.com','011.44.1345.829268','2020-08-14','SA_REP','9000','0.35','146','80');
INSERT INTO "public"."employees" VALUES (159,'Lindsey','Smith','lindsey.smith@company.com','011.44.1345.729268','2020-08-15','SA_REP','8000','0.3','146','80');
INSERT INTO "public"."employees" VALUES (125,'Julia','Nayer','julia.nayer@company.com','650.999.1214','2020-07-12','ST_CLERK','3200','0','120','50');
INSERT INTO "public"."employees" VALUES (126,'Irene','Mikkilineni','irene.mikkilineni@company.com','650.999.1224','2020-07-13','ST_CLERK','2700','0','120','50');
INSERT INTO "public"."employees" VALUES (127,'James','Landry','james.landry@company.com','650.999.1334','2020-07-14','ST_CLERK','2400','0','120','50');
INSERT INTO "public"."employees" VALUES (128,'Steven','Markle','steven.markle@company.com','650.999.1434','2020-07-15','ST_CLERK','2200','0','120','50');
INSERT INTO "public"."employees" VALUES (160,'Louise','Doran','louise.doran@company.com','011.44.1345.629268','2020-08-16','SA_REP','7500','0.3','146','80');
INSERT INTO "public"."employees" VALUES (161,'Sarath','Sewall','sarath.sewall@company.com','011.44.1345.529268','2020-08-17','SA_REP','7000','0.25','146','80');
INSERT INTO "public"."employees" VALUES (162,'Clara','Vishney','clara.vishney@company.com','011.44.1346.129268','2020-08-18','SA_REP','10500','0.25','147','80');
INSERT INTO "public"."employees" VALUES (163,'Danielle','Greene','danielle.greene@company.com','011.44.1346.229268','2020-08-19','SA_REP','9500','0.15','147','80');
INSERT INTO "public"."employees" VALUES (164,'Mattea','Marvins','mattea.marvins@company.com','011.44.1346.329268','2020-08-20','SA_REP','7200','0.1','147','80');
INSERT INTO "public"."employees" VALUES (165,'David','Lee','david.lee@company.com','011.44.1346.529268','2020-08-21','SA_REP','6800','0.1','147','80');
INSERT INTO "public"."employees" VALUES (166,'Sundar','Ande','sundar.ande@company.com','011.44.1346.629268','2020-08-22','SA_REP','6400','0.1','147','80');
INSERT INTO "public"."employees" VALUES (167,'Amit','Banda','amit.banda@company.com','011.44.1346.729268','2020-08-23','SA_REP','6200','0.1','147','80');
INSERT INTO "public"."employees" VALUES (168,'Lisa','Ozer','lisa.ozer@company.com','011.44.1343.929268','2020-08-24','SA_REP','11500','0.25','148','80');
INSERT INTO "public"."employees" VALUES (169,'Harrison','Bloom','harrison.bloom@company.com','011.44.1343.829268','2020-08-25','SA_REP','10000','0.2','148','80');
INSERT INTO "public"."employees" VALUES (170,'Tayler','Fox','tayler.fox@company.com','011.44.1343.729268','2020-08-26','SA_REP','9600','0.2','148','80');
INSERT INTO "public"."employees" VALUES (171,'William','Smith','william.smith@company.com','011.44.1343.629268','2020-08-27','SA_REP','7400','0.15','148','80');
INSERT INTO "public"."employees" VALUES (172,'Elizabeth','Bates','elizabeth.bates@company.com','011.44.1343.529268','2020-08-28','SA_REP','7300','0.15','148','80');
INSERT INTO "public"."employees" VALUES (173,'Sundita','Kumar','sundita.kumar@company.com','011.44.1343.329268','2020-08-29','SA_REP','6100','0.1','148','80');
INSERT INTO "public"."employees" VALUES (174,'Ellen','Abel','ellen.abel@company.com','011.44.1644.429267','2020-08-30','SA_REP','11000','0.3','149','80');
INSERT INTO "public"."employees" VALUES (175,'Alyssa','Hutton','alyssa.hutton@company.com','011.44.1644.429266','2020-08-31','SA_REP','8800','0.25','149','80');
INSERT INTO "public"."employees" VALUES (176,'Jonathon','Taylor','jonathon.taylor@company.com','011.44.1644.429265','2020-09-01','SA_REP','8600','0.2','149','80');
INSERT INTO "public"."employees" VALUES (177,'Jack','Livingston','jack.livingston@company.com','011.44.1644.429264','2020-09-02','SA_REP','8400','0.2','149','80');
INSERT INTO "public"."employees" VALUES (178,'Kimberely','Grant','kimberely.grant@company.com','011.44.1644.429263','2020-09-03','SA_REP','7000','0.15','149','0');
INSERT INTO "public"."employees" VALUES (179,'Charles','Johnson','charles.johnson@company.com','011.44.1644.429262','2020-09-04','SA_REP','6200','0.1','149','80');
INSERT INTO "public"."employees" VALUES (180,'Winston','Taylor','winston.taylor@company.com','650.507.9876','2020-09-05','SH_CLERK','3200','0','120','50');
INSERT INTO "public"."employees" VALUES (181,'Jean','Fleaur','jean.fleaur@company.com','650.507.9877','2020-09-06','SH_CLERK','3100','0','120','50');
INSERT INTO "public"."employees" VALUES (182,'Martha','Sullivan','martha.sullivan@company.com','650.507.9878','2020-09-07','SH_CLERK','2500','0','120','50');
INSERT INTO "public"."employees" VALUES (183,'Girard','Geoni','girard.geoni@company.com','650.507.9879','2020-09-08','SH_CLERK','2800','0','120','50');
INSERT INTO "public"."employees" VALUES (184,'Nandita','Sarchand','nandita.sarchand@company.com','650.509.1876','2020-09-09','SH_CLERK','4200','0','121','50');
INSERT INTO "public"."employees" VALUES (185,'Alexis','Bull','alexis.bull@company.com','650.509.2876','2020-09-10','SH_CLERK','4100','0','121','50');
INSERT INTO "public"."employees" VALUES (186,'Julia','Dellinger','julia.dellinger@company.com','650.509.3876','2020-09-11','SH_CLERK','3400','0','121','50');
INSERT INTO "public"."employees" VALUES (187,'Anthony','Cabrio','anthony.cabrio@company.com','650.509.4876','2020-09-12','SH_CLERK','3000','0','121','50');
INSERT INTO "public"."employees" VALUES (188,'Kelly','Chung','kelly.chung@company.com','650.505.1876','2020-09-13','SH_CLERK','3800','0','122','50');
INSERT INTO "public"."employees" VALUES (189,'Jennifer','Dilly','jennifer.dilly@company.com','650.505.2876','2020-09-14','SH_CLERK','3600','0','122','50');
INSERT INTO "public"."employees" VALUES (190,'Timothy','Gates','timothy.gates@company.com','650.505.3876','2020-09-15','SH_CLERK','2900','0','122','50');
INSERT INTO "public"."employees" VALUES (191,'Randall','Perkins','randall.perkins@company.com','650.505.4876','2020-09-16','SH_CLERK','2500','0','122','50');
INSERT INTO "public"."employees" VALUES (192,'Sarah','Bell','sarah.bell@company.com','650.501.1876','2020-09-17','SH_CLERK','4000','0','123','50');
INSERT INTO "public"."employees" VALUES (193,'Britney','Everett','britney.everett@company.com','650.501.2876','2020-09-18','SH_CLERK','3900','0','123','50');
INSERT INTO "public"."employees" VALUES (194,'Samuel','McCain','samuel.mccain@company.com','650.501.3876','2020-09-19','SH_CLERK','3200','0','123','50');
INSERT INTO "public"."employees" VALUES (195,'Vance','Jones','vance.jones@company.com','650.501.4876','2020-09-20','SH_CLERK','2800','0','123','50');
INSERT INTO "public"."employees" VALUES (196,'Alana','Walsh','alana.walsh@company.com','650.507.9811','2020-09-21','SH_CLERK','3100','0','124','50');
INSERT INTO "public"."employees" VALUES (197,'Kevin','Feeney','kevin.feeney@company.com','650.507.9822','2020-09-22','SH_CLERK','3000','0','124','50');
INSERT INTO "public"."employees" VALUES (198,'Donald','OConnell','donald.oconnell@company.com','650.507.9833','2020-09-23','SH_CLERK','2600','0','124','50');
INSERT INTO "public"."employees" VALUES (199,'Douglas','Grant','douglas.grant@company.com','650.507.9844','2020-09-24','SH_CLERK','2600','0','124','50');
INSERT INTO "public"."employees" VALUES (200,'Jennifer','Whalen','jennifer.whalen@company.com','515.123.4444','2020-09-25','AD_ASST','4400','0','101','10');
INSERT INTO "public"."employees" VALUES (201,'Michael','Hartstein','michael.hartstein@company.com','515.123.5555','2020-09-26','MK_MAN','13000','0','100','20');
INSERT INTO "public"."employees" VALUES (202,'Pat','Fay','pat.fay@company.com','603.123.6666','2020-09-27','MK_REP','6000','0','201','20');
INSERT INTO "public"."employees" VALUES (203,'Susan','Mavris','susan.mavris@company.com','515.123.7777','2020-09-28','HR_REP','6500','0','101','40');
INSERT INTO "public"."employees" VALUES (204,'Hermann','Baer','hermann.baer@company.com','515.123.8888','2020-09-29','PR_REP','10000','0','101','70');
INSERT INTO "public"."employees" VALUES (205,'Shelley','Higgins','shelley.higgins@company.com','515.123.8080','2020-09-30','AC_MGR','12000','0','101','110');
INSERT INTO "public"."employees" VALUES (206,'William','Gietz','william.gietz@company.com','515.123.8181','2020-10-01','AC_ACCOUNT','8300','0','205','110');
COMMIT;

ALTER TABLE "public"."employees" ADD PRIMARY KEY ("employee_id") NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."employees" ADD CONSTRAINT "fk_employee_job_id" FOREIGN KEY ("job_id") REFERENCES "public"."jobs" ("job_id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."employees" ADD CONSTRAINT "fk_employee_department_id" FOREIGN KEY ("department_id") REFERENCES "public"."departments" ("department_id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Table : job_history
-- ----------------------------
DROP TABLE IF EXISTS "public"."job_history";
CREATE TABLE "public"."job_history" (
    employee_id numeric(6,0) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    job_id character varying(10) NOT NULL,
    department_id numeric(4,0) DEFAULT NULL::numeric
)
WITH (OIDS=FALSE);

BEGIN;
INSERT INTO "public"."job_history" VALUES (102,'1993-01-13','2010-07-24','IT_PROG','60');
INSERT INTO "public"."job_history" VALUES (101,'1989-09-21','2010-10-27','AC_ACCOUNT','110');
INSERT INTO "public"."job_history" VALUES (101,'1993-10-28','2020-03-15','AC_MGR','110');
INSERT INTO "public"."job_history" VALUES (201,'1996-02-17','1999-12-19','MK_REP','20');
INSERT INTO "public"."job_history" VALUES (114,'1998-03-24','1999-12-31','ST_CLERK','50');
INSERT INTO "public"."job_history" VALUES (122,'1999-01-01','1999-12-31','ST_CLERK','50');
INSERT INTO "public"."job_history" VALUES (200,'1987-09-17','1993-06-17','AD_ASST','90');
INSERT INTO "public"."job_history" VALUES (176,'1998-03-24','1998-12-31','SA_REP','80');
INSERT INTO "public"."job_history" VALUES (176,'1999-01-01','1999-12-31','SA_MAN','80');
INSERT INTO "public"."job_history" VALUES (200,'1994-07-01','2020-12-31','AC_ACCOUNT','90');
COMMIT;

ALTER TABLE "public"."job_history" ADD CONSTRAINT "fk_job_history_employee_id" FOREIGN KEY ("employee_id") REFERENCES "public"."employees" ("employee_id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."job_history" ADD CONSTRAINT "fk_job_history_job_id" FOREIGN KEY ("job_id") REFERENCES "public"."jobs" ("job_id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;


-- ----------------------------
--  Table : regions
-- ----------------------------
DROP TABLE IF EXISTS "public"."regions";
CREATE TABLE "public"."regions" (
    region_id numeric(10,0) NOT NULL,
    region_name character(25)
)
WITH (OIDS=FALSE);

BEGIN;
INSERT INTO "public"."regions" VALUES (1,'Europe');
INSERT INTO "public"."regions" VALUES (2,'Americas');
INSERT INTO "public"."regions" VALUES (3,'Asia');
INSERT INTO "public"."regions" VALUES (4,'Middle East and Africa');
COMMIT;

ALTER TABLE "public"."regions" ADD PRIMARY KEY ("region_id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Table : countries
-- ----------------------------
DROP TABLE IF EXISTS "public"."countries";
CREATE TABLE "public"."countries" (
    country_id character varying(2) NOT NULL,
    country_name character varying(40) DEFAULT NULL::character varying,
    region_id numeric(10,0) DEFAULT NULL::numeric
)
WITH (OIDS=FALSE);

BEGIN;
INSERT INTO "public"."countries" VALUES ('AR','Argentina','2');
INSERT INTO "public"."countries" VALUES ('AU','Australia','3');
INSERT INTO "public"."countries" VALUES ('BE','Belgium','1');
INSERT INTO "public"."countries" VALUES ('BR','Brazil','2');
INSERT INTO "public"."countries" VALUES ('CA','Canada','2');
INSERT INTO "public"."countries" VALUES ('CH','Switzerland','1');
INSERT INTO "public"."countries" VALUES ('CN','China','3');
INSERT INTO "public"."countries" VALUES ('DE','Germany','1');
INSERT INTO "public"."countries" VALUES ('DK','Denmark','1');
INSERT INTO "public"."countries" VALUES ('EG','Egypt','4');
INSERT INTO "public"."countries" VALUES ('FR','France','1');
INSERT INTO "public"."countries" VALUES ('HK','HongKong','3');
INSERT INTO "public"."countries" VALUES ('IL','Israel','4');
INSERT INTO "public"."countries" VALUES ('IN','India','3');
INSERT INTO "public"."countries" VALUES ('IT','Italy','1');
INSERT INTO "public"."countries" VALUES ('JP','Japan','3');
INSERT INTO "public"."countries" VALUES ('KW','Kuwait','4');
INSERT INTO "public"."countries" VALUES ('MX','Mexico','2');
INSERT INTO "public"."countries" VALUES ('NG','Nigeria','4');
INSERT INTO "public"."countries" VALUES ('NL','Netherlands','1');
INSERT INTO "public"."countries" VALUES ('SG','Singapore','3');
INSERT INTO "public"."countries" VALUES ('UK','United Kingdom','1');
INSERT INTO "public"."countries" VALUES ('US','United States of America','2');
INSERT INTO "public"."countries" VALUES ('ZM','Zambia','4');
INSERT INTO "public"."countries" VALUES ('ZW','Zimbabwe','4');
COMMIT;

ALTER TABLE "public"."countries" ADD PRIMARY KEY ("country_id") NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."countries" ADD CONSTRAINT "fk_country_region" FOREIGN KEY ("region_id") REFERENCES "public"."regions" ("region_id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Table : locations
-- ----------------------------
DROP TABLE IF EXISTS "public"."locations";
CREATE TABLE "public"."locations" (
    location_id numeric(4,0) DEFAULT (0)::numeric NOT NULL,
    street_address character varying(40) DEFAULT NULL::character varying,
    postal_code character varying(12) DEFAULT NULL::character varying,
    city character varying(30) NOT NULL,
    state_province character varying(25) DEFAULT NULL::character varying,
    country_id character varying(2) DEFAULT NULL::character varying
)
WITH (OIDS=FALSE);

BEGIN;
INSERT INTO "public"."locations" VALUES (1000,'1297 Via Cola di Rie','989','Roma',null,'IT');
INSERT INTO "public"."locations" VALUES (1100,'93091 Calle della Testa','10934','Venice',null,'IT');
INSERT INTO "public"."locations" VALUES (1200,'2017 Shinjuku-ku','1689','Tokyo','Tokyo Prefecture','JP');
INSERT INTO "public"."locations" VALUES (1300,'9450 Kamiya-cho','6823','Hiroshima',null,'JP');
INSERT INTO "public"."locations" VALUES (1400,'2014 Jabberwocky Rd','26192','Southlake','Texas','US');
INSERT INTO "public"."locations" VALUES (1500,'2011 Interiors Blvd','99236','South San Francisco','California','US');
INSERT INTO "public"."locations" VALUES (1600,'2007 Zagora St','50090','South Brunswick','New Jersey','US');
INSERT INTO "public"."locations" VALUES (1700,'2004 Charade Rd','98199','Seattle','Washington','US');
INSERT INTO "public"."locations" VALUES (1800,'147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA');
INSERT INTO "public"."locations" VALUES (1900,'6092 Boxwood St','YSW 9T2','Whitehorse','Yukon','CA');
INSERT INTO "public"."locations" VALUES (2000,'40-5-12 Laogianggen','190518','Beijing',null,'CN');
INSERT INTO "public"."locations" VALUES (2100,'1298 Vileparle (E)','490231','Bombay','Maharashtra','IN');
INSERT INTO "public"."locations" VALUES (2200,'12-98 Victoria Street','2901','Sydney','New South Wales','AU');
INSERT INTO "public"."locations" VALUES (2300,'198 Clementi North','540198','Singapore',null,'SG');
INSERT INTO "public"."locations" VALUES (2400,'8204 Arthur St',null,'London',null,'UK');
COMMIT;

ALTER TABLE "public"."locations" ADD PRIMARY KEY ("location_id") NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."locations" ADD CONSTRAINT "fk_location_country" FOREIGN KEY ("country_id") REFERENCES "public"."countries" ("country_id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Table : departments
-- ----------------------------
DROP TABLE IF EXISTS "public"."departments";
CREATE TABLE "public"."departments" (
    department_id numeric(4,0) NOT NULL,
    department_name character varying(30) NOT NULL,
    manager_id numeric(6,0) DEFAULT NULL::numeric,
    location_id numeric(4,0) DEFAULT NULL::numeric
)
WITH (OIDS=FALSE);

BEGIN;
INSERT INTO "public"."departments" VALUES (10,'Administration','200','1700');
INSERT INTO "public"."departments" VALUES (20,'Marketing','201','1800');
INSERT INTO "public"."departments" VALUES (30,'Purchasing','114','1700');
INSERT INTO "public"."departments" VALUES (40,'Human Resources','203','2400');
INSERT INTO "public"."departments" VALUES (50,'Shipping','121','1500');
INSERT INTO "public"."departments" VALUES (60,'IT','103','1400');
INSERT INTO "public"."departments" VALUES (70,'Public Relations','204','2400');
INSERT INTO "public"."departments" VALUES (80,'Sales','145','2500');
INSERT INTO "public"."departments" VALUES (90,'Executive','100','1700');
INSERT INTO "public"."departments" VALUES (100,'Finance','108','1700');
INSERT INTO "public"."departments" VALUES (110,'Accounting','205','1700');
INSERT INTO "public"."departments" VALUES (120,'Treasury','0','1700');
INSERT INTO "public"."departments" VALUES (130,'Corporate Tax','0','1700');
INSERT INTO "public"."departments" VALUES (140,'Control And Credit','0','1700');
INSERT INTO "public"."departments" VALUES (150,'Shareholder Services','0','1700');
INSERT INTO "public"."departments" VALUES (160,'Benefits','0','1700');
INSERT INTO "public"."departments" VALUES (170,'Manufacturing','0','1700');
INSERT INTO "public"."departments" VALUES (180,'Construction','0','1700');
INSERT INTO "public"."departments" VALUES (190,'Contracting','0','1700');
INSERT INTO "public"."departments" VALUES (200,'Operations','0','1700');
INSERT INTO "public"."departments" VALUES (210,'IT Support','0','1700');
INSERT INTO "public"."departments" VALUES (220,'NOC','0','1700');
INSERT INTO "public"."departments" VALUES (230,'IT Helpdesk','0','1700');
INSERT INTO "public"."departments" VALUES (240,'Government Sales','0','1700');
INSERT INTO "public"."departments" VALUES (250,'Retail Sales','0','1700');
INSERT INTO "public"."departments" VALUES (260,'Recruiting','0','1700');
INSERT INTO "public"."departments" VALUES (270,'Payroll','0','1700');
COMMIT;

ALTER TABLE "public"."departments" ADD PRIMARY KEY ("department_id") NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."departments" ADD CONSTRAINT "fk_department_location" FOREIGN KEY ("location_id") REFERENCES "public"."locations" ("location_id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Table : jobs
-- ----------------------------
DROP TABLE IF EXISTS "public"."jobs";
CREATE TABLE "public"."jobs" (
    job_id character varying(10) DEFAULT ''::character varying NOT NULL,
    job_title character varying(35) NOT NULL,
    min_salary numeric(6,0) DEFAULT NULL::numeric,
    max_salary numeric(6,0) DEFAULT NULL::numeric
)
WITH (OIDS=FALSE);

BEGIN;
INSERT INTO "public"."jobs" VALUES ('AD_PRES','President','20000','40000');
INSERT INTO "public"."jobs" VALUES ('AD_VP','Administration Vice President','15000','30000');
INSERT INTO "public"."jobs" VALUES ('AD_ASST','Administration Assistant','3000','6000');
INSERT INTO "public"."jobs" VALUES ('FI_MGR','Finance Manager','8200','16000');
INSERT INTO "public"."jobs" VALUES ('FI_ACCOUNT','Accountant','4200','9000');
INSERT INTO "public"."jobs" VALUES ('AC_MGR','Accounting Manager','8200','16000');
INSERT INTO "public"."jobs" VALUES ('AC_ACCOUNT','Public Accountant','4200','9000');
INSERT INTO "public"."jobs" VALUES ('SA_MAN','Sales Manager','10000','20000');
INSERT INTO "public"."jobs" VALUES ('SA_REP','Sales Representative','6000','12000');
INSERT INTO "public"."jobs" VALUES ('PU_MAN','Purchasing Manager','8000','15000');
INSERT INTO "public"."jobs" VALUES ('PU_CLERK','Purchasing Clerk','2500','5500');
INSERT INTO "public"."jobs" VALUES ('ST_MAN','Stock Manager','5500','8500');
INSERT INTO "public"."jobs" VALUES ('ST_CLERK','Stock Clerk','2000','5000');
INSERT INTO "public"."jobs" VALUES ('SH_CLERK','Shipping Clerk','2500','5500');
INSERT INTO "public"."jobs" VALUES ('IT_PROG','IT Programmer','4000','10000');
INSERT INTO "public"."jobs" VALUES ('MK_MAN','Marketing Manager','9000','15000');
INSERT INTO "public"."jobs" VALUES ('MK_REP','Marketing Representative','4000','9000');
INSERT INTO "public"."jobs" VALUES ('HR_REP','Human Resources Representative','4000','9000');
INSERT INTO "public"."jobs" VALUES ('PR_REP','Public Relations Representative','4500','10500');
COMMIT;

ALTER TABLE "public"."jobs" ADD PRIMARY KEY ("job_id") NOT DEFERRABLE INITIALLY IMMEDIATE;

