# Chinook Media Store Data Analysis Using SQL
 
## Project Overview

This project focuses on exploring and working with the Chinook Media Store database.The aim was to develop and strengthen SQL skills by solving practical business-related queries across different departments including marketing,HR,accounting,IT and logistics.

The project involves working with customer,employee and invoice data to perform tasks such as data cleaning,data standardisation,data transformation and reporting.It also applies SQL concepts such as string functions data type conversion,filtering,UNION and UNION ALL to retrieve,organise and present information according to specific business requirements.

Through this project,I gained practical experience in writing SQL queries,manipulating data and generating reports to support business operations and decision-making.


## Project Objectives

- Apply SQL Server skills to retrieve and manipulate data from the Chinook database.
- Perform data cleaning and standardisation to improve data consistency.
- Use SQL functions to transform data into meaningful formats.
- Combine data from multiple tables using UNION and UNION ALL.
- Generate reports to address practical business requirements.
- Strengthen problem-solving skills through practical SQL exercises.

## Key Questions Answered

- How can customer and employee names be combined and standardised using SQL string functions?
- How can customer information be transformed to create new columns, such as city codes and customer identifiers?
- How can invoice dates and invoice IDs be converted into the required data types and formats?
- How can customer email domains be extracted using SQL functions?
- How can customer and employee records be combined using UNION and UNION ALL?
- How can unique cities and contact lists be retrieved from multiple tables?
- How can employee records be filtered based on job titles?

## Dataset Description

The project uses the Chinook Media Store sample database, which represents a digital media store and contains information about customers, employees, invoices, music, and sales transactions. The project mainly focuses on customer, employee, and invoice data to perform data cleaning, transformation, standardisation, and reporting.

## Data Dictionary

## Data Dictionary

### 1. Customer Table

| Column Name | Description | Data Type |
|---|---|---|
| CustomerId | Unique identifier for each customer. | INT |
| FirstName | Customer's first name. | NVARCHAR(40) |
| LastName | Customer's last name. | NVARCHAR(20) |
| Company | Customer's company name. | NVARCHAR(80) |
| City | Customer's city of residence. | NVARCHAR(40) |
| Email | Customer's email address. | NVARCHAR(60) |

### 2. Employee Table

| Column Name | Description | Data Type |
|---|---|---|
| EmployeeId | Unique identifier for each employee. | INT |
| FirstName | Employee's first name. | NVARCHAR(20) |
| LastName | Employee's last name. | NVARCHAR(20) |
| Title | Employee's job title. | NVARCHAR(30) |
| City | Employee's city. | NVARCHAR(30) |
| Phone | Employee's contact number. | NVARCHAR(24) |
| Email | Employee's email address. | NVARCHAR(60) |

### 3. Invoice Table

| Column Name | Description | Data Type |
|---|---|---|
| InvoiceId | Unique identifier for each invoice. | INT |
| CustomerId | Identifies the customer associated with the invoice. | INT |
| InvoiceDate | Date the invoice was generated. | DATETIME |
| Total | Total amount charged on the invoice. | NUMERIC(10,2) |
## Tools Used

- **Microsoft SQL Server (SSMS):** Used to create, manage, query, and analyse the Chinook Media Store database.
- **SQL (T-SQL):** Used to retrieve, clean, transform, standardise, and combine data.

## SQL Analysis and Queries 

**Q1: Customer Full Name Standardization**

For a personalized email campaign, the marketing team wants a single column for the full name of each customer, formatted as "Lastname, Firstname". They also need this name column to be in all uppercase for consistency.

```sql
SELECT [FirstName],
       [LastName],
       UPPER(CONCAT([FirstName], ' ', [LastName])) AS Full_Name
FROM [Chinook Media Store ].[dbo].[Customer];
```

**Q2: Employee Contact Details**

The HR department wants a clean report of all employees. They need a single column that combines the FirstName, LastName, Title, and Phone number, formatted as "Firstname Lastname, Title: Phone".

```sql
SELECT CONCAT([FirstName], ' ', [LastName], ' ', [Title], '  ', [Phone]) AS Employee_Details
FROM [Chinook Media Store ].[dbo].[Employee];
```

### Data Transformation and Reporting

**Q3: Customer City Code Generation**

The logistics team wants to analyze customer distribution. They need a report showing the CustomerId, FirstName, LastName, and a new column called CityCode. The CityCode should contain the first three characters of the City column, in lowercase.

```sql
SELECT [CustomerId],
       [FirstName],
       [LastName],
       LOWER(SUBSTRING([City], 1, 3)) AS CityCode
FROM [Chinook Media Store ].[dbo].[Customer];
```

**Q4: Invoice Date Formatting**

The accounting department needs a report of all invoices. They want the InvoiceDate to be formatted as a string in the YYYY-MM-DD format. The report should include the InvoiceId, CustomerId, and the new formatted date column.

```sql
SELECT [InvoiceId],
       [CustomerId],
       [InvoiceDate],
       CONVERT(DATE, [InvoiceDate]) AS InvoiceDates
FROM [Chinook Media Store ].[dbo].[Invoice];
```

**Q5: Customer ID Hash Generation**

For internal system checks, the IT department needs a unique, standardized identifier for each customer. Create a report with CustomerId and a new column called CustomerID_Hash. This hash should be a string created by concatenating the first two letters of the FirstName and the first two letters of the LastName, both in lowercase.

```sql
SELECT [CustomerId],
       CONCAT(LOWER(SUBSTRING([FirstName], 1, 2)), 
              LOWER(SUBSTRING([LastName], 1, 2))) AS CustomerID_Hash
FROM [Chinook Media Store ].[dbo].[Customer];
```

### Advanced Reporting and Auditing

**Q6: Invoice ID Data Type Conversion**

The reporting tool used by management expects the InvoiceId to be a string. Create a query that shows the InvoiceId, with its data type explicitly converted to CHAR (or VARCHAR) using CAST(). Also, include the CustomerId and Total for each invoice.

```sql
SELECT CONVERT(VARCHAR(50), [InvoiceId]) AS Invoice_ID,
       [CustomerId],
       [Total]
FROM [Chinook Media Store ].[dbo].[Invoice];
```

**Q7: Customer Email Domain Extraction**

The IT team wants to audit the email domains used by customers. Create a report that shows the FirstName, LastName, and a new column EmailDomain. The EmailDomain should be the portion of the email address that comes after the '@' symbol.

```sql
SELECT [FirstName],
       [LastName],
       [Email],
       CHARINDEX('@', [Email]),
       SUBSTRING([Email], CHARINDEX('@', [Email]), LEN(Email)) AS EmailDomain
FROM [Chinook Media Store ].[dbo].[Customer];
```

**Q8: Customer First Name Length**

The marketing team is running a survey and wants to know the length of each customer's first name. Create a report showing the CustomerId, FirstName, and a new column called NameLength that shows the number of characters in their first name.

```sql
SELECT [CustomerId],
       [FirstName],
       LEN([FirstName]) AS NameLength
FROM [Chinook Media Store ].[dbo].[Customer];
```

**Q9: Employee Title Standardization**

HR wants a report to audit employee titles. They've noticed some titles are in mixed cases and want to see them all in lowercase. Create a report showing EmployeeId, LastName, and a new column Title_Lowercase with the title in all lowercase.

```sql
SELECT [EmployeeId],
       [LastName],
       LOWER([Title]) AS Title_Lowercase
FROM [Chinook Media Store ].[dbo].[Employee];
```

### Combining Data Using UNION and UNION ALL

**Q10: Create a Master Contact List (UNION ALL)**

Generate a consolidated list of all customers and employees. The list must include their:

- Full name
- City
- Email address

Include all rows, even if duplicates exist.

```sql
SELECT CONCAT([FirstName], ' ', [LastName]) AS Full_Name,
       [City],
       [Email]
FROM [Chinook Media Store ].[dbo].[Employee]

UNION ALL

SELECT CONCAT([FirstName], ' ', [LastName]) AS Full_Name,
       [City],
       [Email]
FROM [Chinook Media Store ].[dbo].[Customer];
```

**Q11: Identify Unique Cities with Company Contacts**

Create a single list of unique cities where either a customer or an employee is located. Filter to include only:

- Customers where Company is not NULL.
- Employees where Title is not NULL.

```sql
SELECT [City]
FROM [Chinook Media Store ].[dbo].[Customer]
WHERE [Company] IS NOT NULL

UNION

SELECT [City]
FROM [Chinook Media Store ].[dbo].[Employee]
WHERE [Title] IS NOT NULL;
```

**Q12: Alphabetical List of Contacts (UNION with Ordering)**

Generate a unified, alphabetically sorted list of all last names and first names from both the Customer and Employee tables.

Requirements:
- Output must contain exactly two columns: LastName, FirstName.
- Sort by LastName, then FirstName.

```sql
SELECT [LastName],
       [FirstName]
FROM [Chinook Media Store ].[dbo].[Customer]

UNION

SELECT [LastName],
       [FirstName]
FROM [Chinook Media Store ].[dbo].[Employee]

ORDER BY [LastName], [FirstName];
```

**Q13: Managers and IT Staff List (UNION)**

Create a single list showing the FullName and Title of employees whose title contains either "Manager" or "IT Staff". Each employee should appear only once in the final list, even if their title contains both terms.

Requirements:
- Output must contain two columns: FullName, Title.
- Remove duplicate entries.
- Sort by Title (ascending).

```sql
SELECT CONCAT([FirstName], ' ', [LastName]) AS Full_Name,
       [Title]
FROM [Chinook Media Store ].[dbo].[Employee]
WHERE [Title] LIKE '%Manager%'

UNION

SELECT CONCAT([FirstName], ' ', [LastName]) AS Full_Name,
       [Title]
FROM [Chinook Media Store ].[dbo].[Employee]
WHERE [Title] LIKE 'IT Staff';
```

## Key Insights

- SQL string functions such as `CONCAT()`, `UPPER()`, `LOWER()`, and `SUBSTRING()` were used to clean, combine, and standardise customer and employee information.
- `LEN()` and `CHARINDEX()` helped extract useful information from text fields, including name lengths and email domains.
- `CONVERT()` was used to change data formats and data types for reporting purposes.
- `UNION ALL` combined customer and employee records while retaining duplicates, whereas `UNION` returned distinct records.
- Filtering with `WHERE`, `IS NOT NULL`, and `LIKE` helped retrieve specific information based on business requirements.
- SQL queries can transform raw database information into structured reports that support different business departments.

## Conclusion

This project provided practical experience in using SQL Server to clean, transform, standardise, and retrieve data from the Chinook Media Store database. By working through business-related questions, I strengthened my understanding of SQL functions, data manipulation, filtering, and combining datasets. Overall, the project improved my SQL problem-solving skills and demonstrated how SQL can be used to organise data and generate meaningful information for business reporting and decision-making.
