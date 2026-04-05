# E-Learning-Platform-Sales-and-Purchase-Analysis
A comprehensive MySQL-based analysis of learner purchasing behavior, course performance, category-wise revenue, and sales trends to support data-driven business decisions.
📖 Table of Contents
Project Overview

Data Source

Tools & Technologies

Data Cleaning & Preparation

Exploratory Data Analysis (EDA)

Key Insights

Recommendations

How to Use

📊 Project Overview
An online e-learning platform offers multiple courses across categories such as Technology, Business, Design, and Language. Learners from different countries can purchase one or more courses based on their interests and learning goals.

Business Problems Solved:

Lack of visibility into which course categories drive the highest demand and revenue

No systematic identification of top-performing courses based on total purchases and sales

High-value learners contributing the most revenue cannot be identified

Courses with low demand or zero purchases remain unknown

Missing course prices compromise accurate revenue analysis

This project uses MySQL to design a relational database, perform joins and analytical queries, and generate insights about learner spending, course popularity, category performance, and revenue growth.

🗂️ Data Source
Source: Sample data created for analysis purposes

Size: 30 learners, 11 courses, 30 purchase records

Time Period: 2023–2026

Key Tables:

learners (learner_id, full_name, country)

courses (course_id, course_name, category, unit_price)

purchases (purchase_id, learner_id, course_id, quantity, purchase_date)

Categories Covered: Technology, Business, Design, Language

🛠️ Tools & Technologies
Database: MySQL (CREATE, INSERT, JOIN, UPDATE, Window Functions)

Visualization: Power BI (Dashboard screenshots included)

Data Cleaning: SQL UPDATE statements, IFNULL(), subqueries

Documentation: Markdown / GitHub README

Key SQL Features Used:

INNER JOIN, LEFT JOIN, RIGHT JOIN

Window Functions (DENSE_RANK, SUM OVER)

Common Table Expressions (CTE)

CASE statements for spender tier classification

Subqueries for NULL value handling

🧹 Data Cleaning & Preparation
The following data cleaning steps were performed using MySQL:

Step	Action
1	Created database and three tables with appropriate data types and constraints
2	Established foreign key relationships between purchases and learners/courses
3	Inserted sample data covering 30 learners, 11 courses, and 30 purchase records
4	Identified NULL values in unit_price (Data Science, Figma UI/UX Design)
5	Replaced NULL prices with average course price using UPDATE statement
6	Added CHECK constraint on Quantity column (Quantity > 0)
7	Set DEFAULT CURRENT_TIMESTAMP on purchase_date
8	Created calculated metrics: Total Spending, Spender Tiers (CTE + CASE)
Key SQL Code:

sql
UPDATE courses 
SET unit_price = (SELECT AVG(unit_price) FROM courses) 
WHERE unit_price IS NULL;
🔍 Exploratory Data Analysis (EDA)
The following business questions were explored using SQL queries:

Question	SQL Feature Used
Which courses generate the highest total revenue?	SUM + IFNULL + DENSE_RANK
What is each learner's total spending by country?	SUM + GROUP BY + FORMAT
Which are the top 3 most purchased courses by quantity?	SUM + DENSE_RANK + LIMIT
What is each category's total revenue and unique learner count?	Window Functions (PARTITION BY)
Which learners purchased from more than one category?	COUNT(DISTINCT) + HAVING + GROUP_CONCAT
Which courses have never been purchased?	LEFT JOIN + IS NULL
How are learners categorized as High/Medium/Low Spenders?	CTE + CASE statement
What is the monthly sales trend with running total?	Window Functions (SUM OVER)
Tip: Insert your Power BI dashboard screenshot here.

💡 Key Insights
Category Performance
Technology category had the highest purchase quantity with 25 enrollments

Business category followed closely with 23 enrollments

Language and Design categories had lower demand with 16 and 14 purchases respectively

Geographic Insights
India recorded the highest purchase quantity with 16 enrollments

Canada followed with 11 enrollments

Learner Behavior
Sakthi was the top learner with 9 total purchases

Saranya made 6 purchases

A small group of repeat learners contributes a significant share of purchases

Course Performance
Digital Marketing Pro had the highest enrollment count with 5 unique learners

Data Science and Adobe Photoshop CC also performed strongly in purchase quantity

Sales Trends
Total cumulative sales reached approximately ₹1.03 lakh by 2026

Sales dropped in 2025 compared to 2024, possibly due to fewer course launches or lower marketing activity

Diagnostic Insights
Technology and Business courses performed better because learners prefer career-oriented and high-income skill development programs

Higher-priced courses like Data Science still achieved strong purchase volumes, showing learners are willing to invest more for better career opportunities

Lower-performing courses like Figma UI/UX Design and Project Management may have lower visibility or less attractive content

🚀 Recommendations
Priority	Recommendation	Expected Impact
High	Increase the number of Technology and Business courses	Capture growing learner demand
High	Promote high-performing courses (Digital Marketing Pro, Data Science, Adobe Photoshop CC) through ads and featured sections	Increase enrollments by 20-30%
High	Offer discounts, referral bonuses, and loyalty rewards to repeat learners like Sakthi and Saranya	Improve learner retention
Medium	Improve low-performing courses (Figma UI/UX Design, Project Management) by updating content, adding certifications, or creating bundle offers	Convert low-demand courses into revenue generators
Medium	Focus marketing campaigns in low-performing countries (Spain, Sri Lanka, Egypt)	Expand global reach
Low	Launch new Technology courses (AI, Cloud Computing, Power BI)	Capture emerging market trends
⚙️ How to Use
Prerequisites
MySQL Server (version 8.0+ recommended)

MySQL Workbench or any SQL client

Power BI Desktop (for viewing dashboard)

Setup Instructions
Clone this repository

bash
git clone https://github.com/yourusername/e-learning-platform-analysis.git
cd e-learning-platform-analysis
Run the SQL script

Open Analyzing E-Learning Platform Purchases using MySQL.sql in MySQL Workbench

Execute the entire script to create database, tables, insert data, and run analytical queries

Verify the setup

sql
USE e_learning_platform_db;
SELECT * FROM learners;
SELECT * FROM courses;
SELECT * FROM purchases;
Run analytical queries

The SQL file contains all 7 analytical queries with comments

Each query answers a specific business question

View the Power BI dashboard

Open the .pbix file (if available)

Refresh data connection if needed

Key Queries Included
Query	Description
Q1	Learner total spending by country
Q2	Top 3 most purchased courses
Q3	Category revenue and unique learners
Q4	Learners who purchased from multiple categories
Q5	Courses with zero purchases
Q6	Spender tier classification (High/Medium/Low)
Q7	Monthly sales trend with running total
Dependencies
No additional Python packages required

Pure SQL implementation

📊 Dashboard Preview
Insert your Power BI dashboard screenshots here

Key Dashboard Sections:

Overall purchase quantity by category

Top learners by purchase volume

Top courses by enrollment count

Yearly sales trend with running total

Country-wise purchase distribution
