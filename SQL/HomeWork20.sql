
/*Задание
В базе данных компании хранятся таблицы с информацией о сотрудниках и их департаментах. Ваша задача — выполнить следующие действия:

Создать табличную переменную для хранения сотрудников, проработавших в компании более заданного количества лет.
Извлечь уникальные записи об этих сотрудниках и заполнить табличную переменную.
Используя табличную переменную, выполнить анализ и вывести департаменты с наибольшим числом таких сотрудников.
Определить департаменты с менее чем 5 сотрудниками и отметить их специальным флагом.
Добавить нового сотрудника в таблицу сотрудников с использованием данных о департаменте.
Выполнить запрос, объединяющий таблицы сотрудников и департаментов, с применением CASE, GROUP BY, ORDER BY, и фильтров.*/

DECLARE @Year INT
SET @Year = 15

DECLARE @MyTable TABLE(
	EmploeedID INT,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	HireDate DATE,
	JobTitle NVARCHAR(50)
)

INSERT INTO @MyTable(EmploeedID , FirstName, LastName, HireDate, JobTitle)
SELECT hre.BusinessEntityID, FirstName, LastName, HireDate, JobTitle
FROM HumanResources.Employee hre 
JOIN Person.Person pp ON pp.BusinessEntityID = hre.BusinessEntityID
WHERE DATEDIFF(YEAR, hre.HireDate, GETDATE()) > @Year 

SELECT hd.[Name] AS NameDepartament, COUNT(1) AS EmploeeCount
		, CASE 
		  WHEN COUNT(1) < 5 
		  THEN 'Understaffed'
		  ELSE 'Staffed'
		  END 'Staffing'
FROM @MyTable mt
JOIN [HumanResources].[EmployeeDepartmentHistory] hed ON hed.BusinessEntityID = mt.EmploeedID
JOIN HumanResources.Department hd ON hd.DepartmentID = hed.DepartmentID
GROUP BY hd.[Name] 
ORDER BY COUNT(1) DESC


--СПОСОБ 2
DECLARE @MyTab TABLE (
	LoginID NVARCHAR(50),
	Tenure INT,
	DepartmentName NVARCHAR(50),
	More5year NVARCHAR(50)
	)

	

DECLARE @Years INT 
SET @Years = 15

INSERT INTO @MyTab (LoginID, Tenure, DepartmentName, More5year) 
SELECT DISTINCT
		  e.LoginID
		, DATEDIFF(YEAR, edh.StartDate, GETDATE()) AS Tenure
		, d.Name
		, CASE
		  WHEN DATEDIFF(YEAR, edh.StartDate, GETDATE()) >= 5
		  THEN 'YES'
		  ELSE 'NO'
		  END
FROM HumanResources.EmployeeDepartmentHistory edh
JOIN HumanResources.Employee e ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department d ON d.DepartmentID = edh.DepartmentID
WHERE DATEDIFF(YEAR, edh.StartDate, GETDATE()) > @Years
	AND edh.EndDate IS NULL

SELECT * 
FROM (SELECT DepartmentName
			 , COUNT(LoginID) AS EmCount
			   FROM @MyTab
			   GROUP BY DepartmentName) R
WHERE R.EmCount >= 5 
ORDER BY R.EmCount DESC


INSERT INTO HumanResources.Employee ( BusinessEntityID
								   , NationalIDNumber
								   , LoginID
								   , JobTitle
								   , BirthDate
								   , MaritalStatus
								   , Gender
								   , HireDate
								   , SalariedFlag
								   , VacationHours
								   , SickLeaveHours
								   , rowguid
								   , ModifiedDate)
SELECT 291
	 , '295967284'
	 , 'answer123'
	 , 'Eng'
	 , '19950201'
	 , 'M'
	 , 'M'
	 , '20040101'
	 , 1
	 , 50
	 , 0
	 ,'wefewfwef324'
	 , GETDATE() Modified

SELECT * FROM HumanResources.Employee
WHERE BusinessEntityID = 291


