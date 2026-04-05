/*Module End Assignment: 
------------------------- “Analyzing E-Learning Platform Purchases using MySQL -------------------------------------
*/

/*Tasks
1. Create the database and schema. Populate the Schema:
●	Create a Database for this project and
●	Create all three tables in MySQL with appropriate data types and relationships.
*/
CREATE DATABASE IF NOT EXISTS e_learning_platform_db;
USE e_learning_platform_db;
CREATE TABLE IF NOT EXISTS learners(
		learner_id INT PRIMARY KEY AUTO_INCREMENT,
        full_name VARCHAR(100) NOT NULL,
        Country VARCHAR(100) NOT NULL
);

/*●	Insert sample data covering at least:
○	4–5 learners
○	4–5 courses (spread across multiple categories)
○	6–8 purchase records
*/

INSERT INTO learners(full_name,Country) VALUES ('Sakthi','India'),('Revathi','UK'),('Tweny','Paris'),('Hari','India'),('Scottie','Scotland'),('Marlowe','Canada'),
							('Liam Connor','Ireland'),('Priya Patel','India'),('Lukas Fischer','Irish'),('Fatima Al-Mansoori','UAE'),('Isabella Rossi','Italy'),
							('James Okonkwo','Nigeria'),('Mei Lin','Malaysia'),('Kaelen Voss','Norway'),('Ishana Perer','Sri Lanka'),('Sione Tui','Tonga'),
                            ('Ajith','Canada'),('Devika','Paris'),('Krishvitha','London'),('Saranya','Canada'),('Carlos Silva', 'Brazil'),
                            ('Sarah Johnson', 'Canada'),('Ahmed Mansour', 'Egypt'),('Hans Gruber', 'Austria'),('Aisha Khan', 'Pakistan'),
							('Jake Williams','UK'),('Mei Lin', 'Malaysia'),('Rowan','Irish'),('Carlos Mendez','Spain'),('Sara','India'),
                            ('John Smith', 'USA'),('Maria Garcia', 'Mexico'),('Wei Zhang', 'China'),('Sophie Dubois', 'France'),('Raj Patel', 'India');
SELECT * FROM learners;
select * from purchases;


delete from learners where learner_id between 36 and 70; 
CREATE TABLE IF NOT EXISTS courses(
		course_id INT PRIMARY KEY AUTO_INCREMENT,
        course_name VARCHAR(100) NOT NULL,
        category VARCHAR(100),
        unit_price DECIMAL(10,2)
);
SELECT * FROM courses;
DESCRIBE courses;
INSERT INTO courses(course_name,category,unit_price)
							VALUES ('Python Bootcamp', 'Technology', 1500.99),
							('Data Science', 'Technology', Null),
							('Web Development', 'Technology', 1039.99),
							('Digital Marketing Pro', 'Business', 2069.99),
							('Project Management', 'Business',1079.99),
							('Financial Accounting Basics', 'Business',1444.99),
							('Adobe Photoshop CC', 'Design', 1029.99),
							('Figma UI/UX Design', 'Design',Null),
							('Spanish for Beginners', 'Language', 1000.00),
							('Business English', 'Language', 1000.00);

CREATE TABLE IF NOT EXISTS purchases(
		purchase_id INT PRIMARY KEY AUTO_INCREMENT,
        learner_id INT,
        course_id INT,
		Quantity INT CHECK (Quantity > 0),
        purchase_date DATE DEFAULT(CURRENT_TIMESTAMP),
        FOREIGN KEY(learner_id) REFERENCES learners(learner_id),
        FOREIGN KEY(course_id) REFERENCES courses(course_id)
);

INSERT INTO purchases (learner_id, course_id, Quantity, purchase_date) 
VALUES 
(12, 1, 3, '2023-11-15'),
(5, 4, 4, '2024-01-20'),
(18, 3, 2, '2025-02-22'),
(7, 9, 2, '2024-03-01'),
(25, 5, 2, '2026-02-10'),
(3, 10, 3, '2025-04-14'),
(20, 7, 6, '2023-06-18'),
(14, 4, 3, '2024-07-05'),
(1, 2, 7, '2026-03-12'),
(27, 6, 2, '2025-08-15'),
(9, 8, 4, '2024-09-20'),
(30, 1, 5, '2026-01-02'),
(16, 3, 3, '2023-10-05'),
(2, 7, 2, '2025-11-10'),
(24, 5, 2, '2024-12-18'),
(11, 9, 5, '2023-04-22'),
(28, 2, 2, '2025-05-01'),
(6, 10, 3, '2024-02-05'),
(21, 4, 2, '2026-06-10'),
(13, 6, 3, '2023-07-15'),
(4, 8, 1, '2024-08-20'),
(26, 1, 1, '2025-09-01'),
(10, 9, 2, '2023-12-05'),
(17, 3, 1, '2026-04-10'),
(29, 5, 1, '2024-06-12'),
(8, 7, 1, '2025-01-15'),
(22, 4, 1, '2023-03-18'),
(15, 10, 1, '2026-05-20'),
(19, 2, 1, '2024-11-22'),
(23, 6, 1, '2025-12-25');
----------------------------------------------------------------------------------------------------
/*2. Data Exploration Using Joins
		 Data Presentation Guidelines for the following query 
/*● Format currency values to 2 decimal places.
● Use aliases for column names (e.g., AS total_revenue).
● Sort results appropriately (e.g., highest total_spent first).
*/

SELECT c.course_id,c.course_name,FORMAT(
        SUM(IFNULL(c.unit_price, (SELECT AVG(unit_price) FROM courses)) * p.quantity),2) AS Total_Revenue,
		DENSE_RANK() OVER (
        ORDER BY SUM(IFNULL(c.unit_price, (SELECT AVG(unit_price) FROM courses)) * p.quantity) DESC) AS DenseRank
FROM courses c
JOIN purchases p ON c.course_id = p.course_id
GROUP BY c.course_id,c.course_name
ORDER BY SUM(IFNULL(c.unit_price, (SELECT AVG(unit_price) FROM courses)) * p.quantity) DESC;


/*Use SQL INNER JOIN, LEFT JOIN, and RIGHT JOIN to:
●	Combine learner, course, and purchase data.
●	Display each learner’s purchase details (course name, category, quantity, total amount, and purchase date).
*/
SELECT 
    l.learner_id,l.full_name,c.course_name,c.category,p.quantity,c.unit_price,
    FORMAT(IFNULL(c.unit_price, (SELECT AVG(unit_price) FROM courses)) * p.quantity, 2) AS total_amount,
    p.purchase_date 
FROM purchases p
INNER JOIN courses c ON p.course_id = c.course_id
LEFT JOIN learners l ON l.learner_id = p.learner_id
UNION ALL
SELECT 
    l.learner_id,l.full_name,c.course_name,c.category,p.quantity,c.unit_price,
    FORMAT(IFNULL(c.unit_price, (SELECT AVG(unit_price) FROM courses)) * p.quantity, 2) AS total_amount,
    p.purchase_date 
FROM purchases p
INNER JOIN courses c ON p.course_id = c.course_id
Right JOIN learners l ON l.learner_id = p.learner_id;


select * from courses;
UPDATE courses 
set unit_price = (select Avg_price from(SELECT AVG(unit_price) as Avg_price FROM courses ) as Temp)
where unit_price is null;
select * from courses;
-- =================================================================================================== --
/*
3. Analytical Queries
		Write SQL queries to answer the following questions:
Q1. Display each learner’s total spending (quantity × unit_price) along with their country.
*/

SELECT l.learner_id, l.full_name, l.country,
       FORMAT(SUM(p.quantity * c.unit_price), 2) AS Total_spending
FROM learners l
JOIN purchases p ON l.learner_id = p.learner_id
JOIN courses c ON p.course_id = c.course_id
GROUP BY l.learner_id, l.full_name, l.country
ORDER BY l.learner_id;

/*Q2. Find the top 3 most purchased courses based on total quantity sold.*/

SELECT c.course_id,c.course_name,sum(p.quantity) as Total_Sold_Quantity,
DENSE_RANK() OVER (ORDER BY sum(p.quantity) DESC) as DenseRank
FROM purchases p
INNER JOIN courses c on c.course_id=p.course_id
GROUP BY c.course_id,c.course_name
LIMIT 3;

/*Q3.Show each course category’s total revenue and the number of unique learners who purchased from that category.*/

SELECT DISTINCT c.category,
FORMAT(sum(p.quantity*c.unit_price) OVER (PARTITION BY c.category ),2)as Total_revenue,
count(l.learner_id) OVER (PARTITION BY c.category )as Number_of_learners  
FROM purchases p
JOIN courses c ON c.course_id = p.course_id
JOIN learners l ON l.learner_id=p.learner_id
ORDER BY Total_revenue DESC;

/*Q4. List all learners who have purchased courses from more than one category.*/


INSERT INTO purchases (learner_id, course_id, quantity, purchase_date) 
VALUES (1, 4, 2, '2026-04-01'); 
select * FROM courses;

SELECT 
    l.learner_id,
    l.full_name,
    l.country,
    COUNT(DISTINCT c.category) AS number_of_categories ,
    GROUP_CONCAT(DISTINCT c.category ORDER BY c.category SEPARATOR ', ') AS categories_purchased
FROM learners l
JOIN purchases p ON l.learner_id = p.learner_id
JOIN courses c ON p.course_id = c.course_id
GROUP BY l.learner_id, l.full_name, l.country
HAVING COUNT(DISTINCT c.category) > 1
ORDER BY number_of_categories DESC;

INSERT INTO courses (course_name, category, unit_price) 
VALUES ('Machine Learning Advanced', 'Technology', 1999.99);

-- Q5: Identify courses that have not been purchased at all
SELECT 
    c.course_id,
    c.course_name,
    c.category,
    c.unit_price
FROM courses c
LEFT JOIN purchases p ON c.course_id = p.course_id
WHERE p.purchase_id IS NULL;


/*Question 6: Categorize learners into: --- Extra Question

'High Spender' → total spent > $5000
'Medium Spender' → total spent between $2000–$5000
'Low Spender' → total spent < $2000
Show: learner_name, country, total_spent, spender_tier. Sort by total_spent descending.

*/

WITH learner_spending AS (
    SELECT 
        l.learner_id,
        l.full_name,
        l.country,
        FORMAT(SUM(p.quantity * IFNULL(c.unit_price, (SELECT AVG(unit_price) FROM courses))), 2) AS Total_Spent
    FROM purchases p
    INNER JOIN learners l ON l.learner_id = p.learner_id
    INNER JOIN courses c ON c.course_id = p.course_id
    GROUP BY l.learner_id, l.full_name, l.country
)
SELECT 
    full_name,
    country,
    Total_Spent,
    CASE
        WHEN Total_Spent > 5000 THEN 'High Spender'
        WHEN Total_Spent >= 2000 AND Total_Spent <= 5000 THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS Spender_Tier
FROM learner_spending
ORDER BY Total_Spent DESC;

/*Question7: Monthly Sales Trend with Running Total */ -- Extra Question
SELECT 
    DATE_FORMAT(p.purchase_date, '%Y-%m') AS month,
    FORMAT(SUM(p.quantity * c.unit_price), 2) AS monthly_revenue,
    FORMAT(SUM(SUM(p.quantity * c.unit_price)) OVER (ORDER BY DATE_FORMAT(p.purchase_date, '%Y-%m')), 2) AS running_total
FROM purchases p
INNER JOIN courses c ON p.course_id = c.course_id
GROUP BY DATE_FORMAT(p.purchase_date, '%Y-%m')
ORDER BY month;