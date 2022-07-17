create table Programmings (
	StudentID varchar(8),
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
	Semester varchar(8),
	[Year] int,
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
	AssesmentID int primary key,
	AssesmentName varchar(50),
	[Weight] float
)

create table MarkReportDetails(
	MarkReportID int,
	AssesmentID int,
	Score float,
	foreign key (MarkReportID) references MarkReports(MarkReportID),
	foreign key (AssesmentID) references Assesments(AssesmentID)
)

