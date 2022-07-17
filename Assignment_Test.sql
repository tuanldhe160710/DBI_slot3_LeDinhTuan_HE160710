create table Programmings (
	ProgrammingID varchar(8)primary key,
	ProgrammingName nvarchar(255)
)

create table Students (
	StudentID varchar(8) primary key,
	FullName nvarchar(255),
	ProgrammingID varchar(8),
	DOB date,
	PhoneNumber varchar(10),
	[Address] nvarchar(300),
	Gender bit default 1,
	Email nvarchar(255)
	foreign key (ProgrammingID) references Programmings(ProgrammingID)
)



create table Courses(
	CourseID varchar(8) primary key,
	CourseName nvarchar(255),
)

create table Contain (
	ProgrammingID varchar(8),
	CourseID varchar(8), 
	Semester int,
	foreign key (CourseID) references Courses(CourseID), 
	foreign key (ProgrammingID) references Programmings(ProgrammingID) 
)

create table Lecturers (
	LecturerID varchar(8) primary key,
	LecName nvarchar(255),
	LecDOB date,
	LecPhoneNumber varchar(10),
	LecEmail nvarchar(255)
)

create table Groups(
	GroupID int primary key,
	CourseID varchar(8),
	LecturerID varchar(8),
	foreign key (CourseID) references Courses(CourseID),
	foreign key (LecturerID) references Lecturers(LecturerID)
)


create table MarkReports(
	MarkReportID int primary key,
	GroupID int,
	StudentID varchar(8),
	TotalMark float,
	StatusResult bit,
	foreign key (GroupID) references Groups(GroupID),
	foreign key (StudentID) references Students(StudentID)
)

create table Assesments(
	AssesmentID varchar(8) primary key,
	AssesmentName varchar(50),
	[Weight] float
)

create table MarkReportDetails(
	MarkReportID int,
	AssesmentID varchar(8),
	Score float,
	foreign key (MarkReportID) references MarkReports(MarkReportID),
	foreign key (AssesmentID) references Assesments(AssesmentID)
)

select * from MarkReportDetails
--
insert into Contain
values 
('SE','PRF',1),('SE','PRO',2),('SE','PRJ',3)
--
insert into Assesments
values 
('ADBI','ASSIGNMENT DBI', 0.3),('AJDP','ASSIGNMENT JDP', 0.3),('ACSD','ASSIGNMENT CSD',0.3),('AMAD','ASSIGNMENT MAD',0.3),('AMAE','ASSIGNMENT MAS',0.3),('AMAS','ASSIGNMENT MAS',0.3),
('APRF','ASSIGNMENT PRF', 0.3),('APRJ','ASSIGNMENT PRJ', 0.3),('APRO','ASSIGNMENT PRO',0.3),('AMKB','ASSIGNMENT MKB',0.3),('AMKA','ASSIGNMENT MKA',0.3),('AMKM','ASSIGNMENT MKM',0.3),
('ALGB','ASSIGNMENT LGB', 0.3),('ALGA','ASSIGNMENT LGA', 0.3),('ALGM','ASSIGNMENT LGM',0.3),('ASSL','ASSIGNMENT SSL',0.3),('ASSG','ASSIGNMENT SSG',0.3),
('PDBI','PROGRESS TEST DBI', 0.3),('PJDP','PROGRESS TEST JDP', 0.3),('PCSD','PROGRESS TEST CSD',0.3),('PMAD','PROGRESS TEST MAD',0.3),('PMAE','PROGRESS TEST MAS',0.3),('PMAS','PROGRESS TEST MAS',0.3),
('PPRF','PROGRESS TEST PRF', 0.3),('PPRJ','PROGRESS TEST PRJ', 0.3),('PPRO','PROGRESS TEST PRO',0.3),('PMKB','PROGRESS TEST MKB',0.3),('PMKA','PROGRESS TEST MKA',0.3),('PMKM','PROGRESS TEST MKM',0.3),
('PLGB','PROGRESS TEST LGB', 0.3),('PLGA','PROGRESS TEST LGA', 0.3),('PLGM','PROGRESS TEST LGM',0.3),('PSSL','PROGRESS TEST SSL',0.3),('PSSG','PROGRESS TEST SSG',0.3),
('FDBI','FINAL EXAM DBI', 0.4),('FJDP','FINAL EXAM JDP', 0.4),('FCSD','FINAL EXAM CSD',0.4),('FMAD','FINAL EXAM MAD',0.4),('FMAE','FINAL EXAM MAS',0.4),('FMAS','FINAL EXAM MAS',0.4),
('FPRF','FINAL EXAM PRF', 0.4),('FPRJ','FINAL EXAM PRJ', 0.4),('FPRO','FINAL EXAM PRO',0.4),('FMKB','FINAL EXAM MKB',0.4),('FMKA','FINAL EXAM MKA',0.4),('FMKM','FINAL EXAM MKM',0.4),
('FLGB','FINAL EXAM LGB', 0.4),('FLGA','FINAL EXAM LGA', 0.4),('FLGM','FINAL EXAM LGM',0.4),('FSSL','FINAL EXAM SSL',0.4),('FSSG','FINAL EXAM SSG',0.4)
select * from MarkReportDetails
select * from MarkReports
select c.CourseName,g.GroupID from Groups g inner join Courses c on c.CourseID = g.CourseID

insert into MarkReportDetails
values 
(1,'ACSD',8),(1,'PCSD',8.2),(1,'FCSD',7.8),(2,'ACSD',6),(2,'PCSD',2),(2,'FCSD',6),(3,'AMAD',6),
(3,'PMAD',8),(4,'AMAD',8.8),(4,'FMAD',7.8),(5,'APRO',6),(6,'APRO',7),(7,'AJDP',6.5),(8,'AMAE',8),
(9,'APRF',9),(10,'ADBI',8.8),(11,'AMAS',7.2),(12,'APRJ',6.5),(13,'AMKB',7),(14,'ASSL',6.9),(15,'AMKB',8),
(16,'ASSL',8),(17,'AMKA',8.8),(18,'ASSG',9),(19,'AMKM',6),(20,'AMAS',7),(21,'ALGB',8.2),(22,'ASSL',8),
(23,'ALGA',8.5),(24,'ASSG',8.5),(25,'ALGA',7.2),(26,'ASSG',6),(27,'ALGM',7),(28,'AMAS',5.6)

select * from Students