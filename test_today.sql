--q1 
select e.SSN, e.FirstName +' '+ e.LastName as Fullname,DATEDIFF(hour,e.DOB,GETDATE())/8766 AS Age from 
Employees e inner join Departments d on e.DepartmentID = d.DepartmentID 
where e.Salary < 2000 and d.DepartmentName = 'Information System'

--q2
select e.FirstName +' '+ e.LastName as Fullname,pe.Position from 
(Employees e inner join Project_Employee pe on e.SSN = pe.SSN) 
inner join Projects p on pe.ProjectID = p.ProjectID
where p.EndDate is null and DATEDIFF(day,p.StartDate,GETDATE()) >= 0

--q3

select * from Projects
select * from Employees
select pe.ProjectID,pe.SSN from Project_Employee pe 
except
(select p.ProjectID, e.SSN from Projects p 
inner join Employees e on e.SSN = e.SSN 
except 
select pe.ProjectID,pe.SSN from Project_Employee pe)

--q4 
select e.FirstName +' '+ e.LastName as EmplayeeName,iif(super.SSN is null,'Have no supervisor',super.FirstName +' '+ super.LastName) as Supervisor from Employees e left join Employees super on e.Supervisor = super.SSN 
--q5
select e.FirstName +' '+ e.LastName as Fullname,SUM(pe.Hour) as TotalHour from 
(Employees e inner join Project_Employee pe on e.SSN = pe.SSN) 
inner join Projects p on pe.ProjectID = p.ProjectID
where p.EndDate is null and DATEDIFF(day,p.StartDate,GETDATE()) >= 0
group by e.SSN,e.LastName,e.FirstName
--q6
create proc rigisted_member 
@employeeid nvarchar(5), @projectid nvarchar(7), @[hour] int, @position nvarchar(3)
as
begin
	declare @count = select COUNT(pe.SSN) from Project_Employee pe group by pe.SSN
end

