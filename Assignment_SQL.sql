/*select all students and display StudentID, Fullname, DOB, Address and ProgramingName regist programming has ProgrammingID is 'SE' 
*/
select s.StudentID ,s.FullName,s.DOB, s.[Address], p.ProgrammingName from 
Students s inner join Programmings p on s.ProgrammingID = p.ProgrammingID
where p.ProgrammingID = 'SE'

/*
Display each programming has information about ProgrammingID, ProgrammingName, and NumberOfStudent by programing 
*/
select p.ProgrammingID,p.ProgrammingName,COUNT(s.StudentID) as NumberOfStudent from
Students s inner join Programmings p on s.ProgrammingID = p.ProgrammingID
group by p.ProgrammingID,p.ProgrammingName

/*
Display each programming has information about ProgrammingID, ProgrammingName, and NumberOfStudent by programing 
*/
select p.ProgrammingID,p.ProgrammingName,COUNT(s.StudentID) as NumberOfStudent from
Students s inner join Programmings p on s.ProgrammingID = p.ProgrammingID
group by p.ProgrammingID,p.ProgrammingName

/*
Display all information of each student and sort them by FullName by asc, if two people have same name order by Address desc
*/
select * from Students order by FullName asc, [Address] desc
/*
Display LectureID and LectureName who supervise more than two group
*/
select l.LecturerID,l.LecName,COUNT(g.CourseID) as NumberOfCourse  from 
Groups g inner join Lecturers l on l.LecturerID = g.LecturerID
group by l.LecturerID,l.LecName
having COUNT(g.CourseID) > 2
/*
Display LectureID and LectureName who supervise a group that has more than two people
*/
select l.LecturerID,l.LecName  from
(select COUNT(m.StudentID) as NumberOfStudent, g.LecturerID from Groups g inner join MarkReports m on g.GroupID = m.GroupID
group by m.GroupID,g.LecturerID) as NumberOfStudent, Lecturers as l
where NumberOfStudent.NumberOfStudent > 2 and l.LecturerID = NumberOfStudent.LecturerID;

/*
Display LectureID and LectureName who supervise a group that has more than two people
*/
--SELECT s.StudentID,s.FullName
--FROM Students s
--WHERE ROUND(DATEDIFF(year, s.DOB ,GETDATE())) >
--       (SELECT AVG(ROUND(DATEDIFF(YEAR,s1.DOB,GETDATE())))
 --      FROM Students s1 
--        );
/*
Display all students who have studentid start with 'HE'
*/
select * from Students
where StudentID like '%HE[0-9][0-9][0-9][0-9][0-9][0-9]%'
/*
Display all couple of students has the same address
*/
select s1.[Address],s.FullName,s1.FullName from Students s
inner join Students s1 on s.StudentID > s1.StudentID and s.[Address] = s1.[Address]

/*
Display all TotalMark of all students 
*/
select m.StudentID,s.FullName,m.GroupID,SUM(md.Score * a.[Weight]) as TotalMark from 
MarkReports m inner join MarkReportDetails md on m.MarkReportID = md.MarkReportID
inner join Assesments a on a.AssesmentID = md.AssesmentID
inner join Students s on s.StudentID = m.StudentID
Group by m.MarkReportID,m.StudentID,s.FullName,m.GroupID

/*
Update all total mark of all student by cursor
*/
declare @id int
declare @total float

declare point cursor for
(select md.MarkReportID, SUM(a.[Weight]*md.Score) from 
Assesments a inner join MarkReportDetails md on a.AssesmentID = md.AssesmentID
Group by md.MarkReportID) 
open point
FETCH NEXT FROM point
into @id, @total
while @@FETCH_STATUS = 0
begin
	update MarkReports
	set TotalMark = @total
	where @id = MarkReportID
	FETCH NEXT FROM point
	into @id, @total
end
CLOSE point 
DEALLOCATE point

select * from MarkReports
/*
Create a store procedure to search and print total mark of student by CourseID and StudentID 
*/
--drop proc TotalOfStudent
create proc TotalOfStudent 
@idStudent varchar(8),
@idCourse varchar(8)
as
begin
	declare @total float
	select @total = m.TotalMark from MarkReports m inner join Groups g on m.GroupID = g.GroupID  
	where m.StudentID = @idStudent and g.CourseID = @idCourse
	print 'Total mark is:' + CAST(@total as varchar(8))
end

exec TotalOfStudent @idStudent = 'HE160710', @idCourse = 'CSD'

/*
Create trigger
*/
drop trigger insert_update_delete_score
create trigger insert_update_delete_score
on MarkReportDetails
after insert, update, delete
as 
begin
	update MarkReports
	set TotalMark = TotalMark + tbs.UpGrade
	from MarkReports m
	inner join
	(select i.MarkReportID,SUM(i.Score*a.Weight) as UpGrade from inserted i inner join Assesments a on i.AssesmentID = a.AssesmentID
	group by i.MarkReportID) as tbs
	on m.MarkReportID = tbs.MarkReportID

	update MarkReports
	set TotalMark = TotalMark - tbs2.DownGrade
	from MarkReports m
	inner join
	(select d.MarkReportID,SUM(d.Score*a.Weight) as DownGrade from deleted d inner join Assesments a on d.AssesmentID = a.AssesmentID
	group by d.MarkReportID) as tbs2
	on m.MarkReportID = tbs2.MarkReportID
end


update MarkReportDetails 
set Score = 4
where MarkReportDetails.AssesmentID = 'ACSD' and MarkReportDetails.MarkReportID = 1
exec TotalOfStudent @idStudent = 'HE160710', @idCourse = 'CSD'

/*
Create trigger
*/

create view student_mark_status
as
select m.GroupID,m.StudentID,m.TotalMark, IIF(m.TotalMark>=5,'Pass','Not Pass') as [Status] from MarkReports m

select * from student_mark_status

/*
Create trigger
*/
select * from Students
drop index index_ma on Students
create nonclustered index index_ma on Students(StudentID)