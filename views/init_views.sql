-- This view provides a comprehensive list of employees along with their corresponding department details.
CREATE VIEW EmployeeDetails AS
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Email,
    d.DepartmentName,
    d.Location
FROM 
    Employees e
JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID;

-- This view summarizes the number of projects and total budget allocated to each department.
CREATE VIEW DepartmentProjectSummary AS
SELECT 
    d.DepartmentName,
    COUNT(p.ProjectID) AS ProjectCount,
    SUM(p.Budget) AS TotalBudget
FROM 
    Departments d
LEFT JOIN 
    Projects p ON d.DepartmentID = p.DepartmentID
GROUP BY 
    d.DepartmentName;

-- This view lists each employee with their respective salary and bonus information.
CREATE VIEW EmployeeSalaries AS
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    s.Salary,
    s.Bonus
FROM 
    Employees e
JOIN 
    Salaries s ON e.EmployeeID = s.EmployeeID;

-- This view details which employees are assigned to specific projects along with their assignment dates.
CREATE VIEW ProjectAssignments AS
SELECT 
    p.ProjectID,
    p.ProjectName,
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    pa.AssignmentDate
FROM 
    Projects p
JOIN 
    ProjectAssignments pa ON p.ProjectID = pa.ProjectID
JOIN 
    Employees e ON pa.EmployeeID = e.EmployeeID;

-- This view identifies employees who earn a salary greater than $100,000.
CREATE VIEW HighSalaryEmployees AS
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    s.Salary
FROM 
    Employees e
JOIN 
    Salaries s ON e.EmployeeID = s.EmployeeID
WHERE 
    s.Salary > 100000;  -- Threshold for high salary

-- This view provides basic contact information for each employee.
CREATE VIEW EmployeeContactInfo AS
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Email,
    e.PhoneNumber
FROM 
    Employees e;

-- This view shows the number of employees in each department.
CREATE VIEW DepartmentHeadcount AS
SELECT 
    d.DepartmentName,
    COUNT(e.EmployeeID) AS EmployeeCount
FROM 
    Departments d
LEFT JOIN 
    Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY 
    d.DepartmentName;

-- This view provides details of project budgets along with their corresponding department names.
CREATE VIEW ProjectBudgetAllocation AS
SELECT 
    p.ProjectName,
    p.Budget,
    d.DepartmentName
FROM 
    Projects p
JOIN 
    Departments d ON p.DepartmentID = d.DepartmentID;

-- This view calculates and displays the tenure of each employee in years.
CREATE VIEW EmployeeTenure AS
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    DATEDIFF(YEAR, e.HireDate, GETDATE()) AS TenureYears
FROM 
    Employees e;

-- This view shows the total annual salary expenditure for each department.
CREATE VIEW AnnualSalaryExpenditure AS
SELECT 
    d.DepartmentName,
    SUM(s.Salary) AS TotalAnnualSalary
FROM 
    Departments d
JOIN 
    Employees e ON d.DepartmentID = e.DepartmentID
JOIN 
    Salaries s ON e.EmployeeID = s.EmployeeID
GROUP BY 
    d.DepartmentName;


