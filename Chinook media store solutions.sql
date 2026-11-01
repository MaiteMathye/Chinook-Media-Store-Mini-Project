--DATA CLEANING AND STANDARDIZATION

--For a personalized email campaign,the marketing team wants a single column for the full name of each customer, formatted as "Lastname, Firstname". They also need this 
--name column to be in all uppercase for consistency.
SELECT [FirstName],
       [LastName],
	   UPPER(CONCAT([FirstName],' ', [LastName])) AS Full_Name
FROM [Chinook Media Store ].[dbo].[Customer];


--The HR department wants a clean report of all employees.They need a single column that combines the FirstName, LastName,Title, and Phone number, formatted as "Firstname Lastname, Title:
--Phone".
SELECT CONCAT([FirstName],' ',[LastName],' ',[Title],'  ',[Phone]) AS Employee_Details
FROM [Chinook Media Store ].[dbo].[Employee];


--DATA TRANSFORMATION AND REPORTING

--The logistics team wants to analyze customer distribution. They need a report showing the CustomerId, FirstName, LastName,and a new column called CityCode. The CityCode should be the 
--first three characters of the City column, in lowercase.
SELECT [CustomerId],
       [FirstName],
	   [LastName],
	   LOWER(SUBSTRING([City],1,3)) AS CityCode
FROM [Chinook Media Store ].[dbo].[Customer];


--The accounting department needs a report of all invoices. They want the InvoiceDate to be formatted as a string in the YYYY-MM-DD format. The report should include the InvoiceId, CustomerId, and
--the new formatted date column.
SELECT [InvoiceId],
       [CustomerId],
	   [InvoiceDate],
	   CONVERT(DATE,[InvoiceDate]) AS InvoiceDates
FROM [Chinook Media Store ].[dbo].[Invoice];


--For internal system checks, the IT department needs a unique,standardized identifier for each customer. Create a report with CustomerId and a new column called CustomerID_Hash. This hash 
--should be a string created by concatenating the first two letters of the FirstName and the first two letters of the LastName, both in lowercase.
SELECT [CustomerId],
	   CONCAT(LOWER(SUBSTRING([FirstName],1,2)),LOWER(SUBSTRING([LastName],1,2))) AS CustomerID_Hash
FROM [Chinook Media Store ].[dbo].[Customer];


--ADVANCED REPORTING AND AUDITING

--The reporting tool used by management expects the InvoiceId to be a string. Create a query that shows the InvoiceId, but with its data type explicitly converted to CHAR (or VARCHAR) using CAST().
--Also, include the CustomerId and Total for each invoice
SELECT CONVERT(VARCHAR(50),[InvoiceId]) AS Invoice_ID,
       [CustomerId],
       [Total]
FROM [Chinook Media Store ].[dbo].[Invoice];


--The IT team wants to audit the email domains used by customers.Create a report that shows the FirstName, LastName, and a new column EmailDomain. The EmailDomain should be the portion of the 
--email address that comes after the '@' symbol
SELECT [FirstName],
       [LastName],
       [Email],
	   CHARINDEX('@',[Email]),
	   SUBSTRING([Email],CHARINDEX('@',[Email]),LEN(Email)) AS EmailDomain
FROM [Chinook Media Store ].[dbo].[Customer];



--The marketing team is running a survey and wants to know the length of each customer's first name. Create a report showing the CustomerId, FirstName, and a new column called
--NameLength that shows the number of characters in their first name.
SELECT [CustomerId],
       [FirstName],
	   LEN([FirstName]) AS NameLength
FROM [Chinook Media Store ].[dbo].[Customer];



--HR wants a report to audit employee titles. They've noticed some titles are in mixed cases and want to see them all in lowercase. Create a report showing EmployeeId, 
--LastName, and a new column Title_Lowercase with the title in all lowercase.
SELECT [EmployeeId],
       [LastName],
	   LOWER([Title]) AS Title_Lowercase
FROM [Chinook Media Store ].[dbo].[Employee];


--Create a Master Contact List (UNION ALL)

/*Instructions
Generate a consolidated list of all customers and all employees. The list must include their:

Full name
City
Email address
Include all rows, even if duplicates exist.*/
SELECT CONCAT([FirstName],' ',[LastName]) AS Full_Name,
       [City],
	   [Email]
FROM [Chinook Media Store ].[dbo].[Employee]
UNION ALL 
SELECT CONCAT([FirstName],' ',[LastName]) AS Full_Name,
       [City],
       [Email]
FROM [Chinook Media Store ].[dbo].[Customer];

--Identify Unique Cities with Company Contacts 

/*Instructions

Create a single list of unique cities where either a customer or an employee is located. Filter to include only:
Customers where Company is not NULL
Employees where Title is not NULL*/
SELECT [City]
FROM [Chinook Media Store ].[dbo].[Customer]
WHERE [Company] IS NOT NULL
UNION 
SELECT [City]
FROM [Chinook Media Store ].[dbo].[Employee]
WHERE [Title] IS NOT NULL;


--Alphabetical List of Contacts (UNION with Ordering)

/*Instructions

Generate a unified, alphabetically sorted list of all last names and first names from both the Customer and Employee tables.
Requirements

Output must contain exactly two columns: LastName, FirstName
Sort by LastName, then FirstName*/

SELECT [LastName],
       [FirstName] 
FROM [Chinook Media Store ].[dbo].[Customer]
UNION 
SELECT [LastName],
       [FirstName] 
FROM [Chinook Media Store ].[dbo].[Employee]

ORDER BY [LastName],[FirstName] ;

--Managers and IT Staff List (UNION)

/*Instructions

Create a single list showing the FullName and Title of employees whose title contains either "Manager" or "IT Staff". 
Each employee should appear only once in the final list, even if their title contains both terms.
Requirements

Output must contain two columns: FullName, Title
Remove duplicate entries
Sort by Title (ascending)*/
SELECT CONCAT([FirstName],' ',[LastName]) AS Full_Name,
       [Title]
FROM [Chinook Media Store ].[dbo].[Employee]
WHERE [Title] LIKE '%Manager%'
UNION
SELECT CONCAT([FirstName],' ',[LastName]) AS Full_Name,
       [Title]
FROM [Chinook Media Store ].[dbo].[Employee]
WHERE [Title] LIKE 'IT Staff';


















































































































