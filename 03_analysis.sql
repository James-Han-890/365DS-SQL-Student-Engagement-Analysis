-- Exploring dataset
SHOW TABLES;
DESCRIBE student_engagement;
DESCRIBE student_info;

SELECT COUNT(*)
FROM student_info;
SELECT COUNT(DISTINCT student_id)
FROM student_info;

SELECT * 
FROM student_purchases
LIMIT 10;
SELECT * 
FROM student_info
LIMIT 10;
SELECT * 
FROM student_engagement
LIMIT 10;

USE db_course_conversions;

SELECT MIN(date_purchased), MAX(date_purchased)
FROM student_purchases;

SELECT date_purchased, COUNT(student_id) 
FROM student_purchases
GROUP BY date_purchased 
ORDER BY date_purchased DESC;

-- Data Summary 
WITH base_data AS(
SELECT
	student_id,
    date_registered,
    MIN(date_watched) AS first_date_watched,
    first_date_purchased,
    date_diff_reg_watch,
    date_diff_watch_purch
    )    
SELECT i.student_id, i.date_registered, e.date_watched
FROM student_info i
LEFT JOIN student_engagement e ON i.student_id=e.student_id;

-- Written in CTE method
WITH first_engagement AS(
	SELECT
		student_id,
        MIN(date_watched) AS first_date_watched
	FROM student_engagement
    GROUP BY student_id),
first_purchased AS(
	SELECT
		student_id,
        MIN(date_purchased) AS first_date_purchased
	FROM student_purchases
    GROUP BY student_id),
temp_data AS(
	SELECT 
		i.student_id,
        i.date_registered,
        e.first_date_watched,
        p.first_date_purchased,
        DATEDIFF(e.first_date_watched, i.date_registered) as days_diff_reg_watch,
        DATEDIFF(p.first_date_purchased, e.first_date_watched) as days_diff_watch_purch
	FROM 
		first_engagement e
		JOIN student_info i ON e.student_id = i.student_id
        LEFT JOIN first_purchased p ON e.student_id = p.student_id)
SELECT *
	FROM temp_data
    HAVING first_date_purchased IS NULL
		OR first_date_watched <= first_date_purchased
;
       
-- Written in Subquery Method
SELECT 
	i.student_id,
    i.date_registered,
    MIN(e.date_watched) AS first_date_watched,
    MIN(p.date_purchased) AS first_date_purchased,
	DATEDIFF(MIN(e.date_watched), i.date_registered) AS days_diff_reg_watch,
    DATEDIFF(MIN(p.date_purchased), MIN(e.date_watched)) AS days_diff_watch_purch
FROM student_engagement e
JOIN student_info i ON e.student_id = i.student_id
LEFT JOIN student_purchases p ON e.student_id = p.student_id
GROUP BY e.student_id
HAVING first_date_purchased IS NULL
	OR first_date_watched <= first_date_purchased
;

-- business problem - free-to-paid conversion rate - 
-- for proper analysis, would need to know number of student who watched the video and purchased membership after.
-- conversion rate - number of student who watched a video and purchased membership thereafter.
-- av reg watch - interesting statistic - would be to figure out avg time it takes between registration and watching.
-- av watch purch - another interesting statistic would be to figure out avg time it takes to purchase after watching

-- Summary statistics using CTE
WITH summary_table AS(
WITH first_engagement AS(
	SELECT
		student_id,
        MIN(date_watched) AS first_date_watched
	FROM student_engagement
    GROUP BY student_id),
first_purchased AS(
	SELECT
		student_id,
        MIN(date_purchased) AS first_date_purchased
	FROM student_purchases
    GROUP BY student_id),
temp_data AS(
	SELECT 
		i.student_id,
        i.date_registered,
        e.first_date_watched,
        p.first_date_purchased,
        DATEDIFF(e.first_date_watched, i.date_registered) as days_diff_reg_watch,
        DATEDIFF(p.first_date_purchased, e.first_date_watched) as days_diff_watch_purch
	FROM 
		first_engagement e
		JOIN student_info i ON e.student_id = i.student_id
        LEFT JOIN first_purchased p ON e.student_id = p.student_id)
SELECT *
	FROM temp_data
    HAVING first_date_purchased IS NULL
		OR first_date_watched <= first_date_purchased
)
SELECT ROUND(COUNT(first_date_purchased)/COUNT(*)*100,2) conversation_rate,
	ROUND(AVG(days_diff_reg_watch),2) AS av_reg_watch,
    ROUND(AVG(days_diff_watch_purch),2) AS av_watch_purch
FROM summary_table;

-- Summary statistics using Subquery
SELECT 
    ROUND(COUNT(first_date_purchased) / COUNT(*) * 100, 2) AS conversion_rate,
    ROUND(AVG(days_diff_reg_watch), 2) AS av_reg_watch,
    ROUND(AVG(days_diff_watch_purch), 2) AS av_watch_purch
FROM (
    SELECT 
        e.student_id,
        i.date_registered,
        MIN(e.date_watched) AS first_date_watched,
        MIN(p.date_purchased) AS first_date_purchased,
        DATEDIFF(MIN(e.date_watched), i.date_registered) AS days_diff_reg_watch,
        DATEDIFF(MIN(p.date_purchased), MIN(e.date_watched)) AS days_diff_watch_purch
    FROM student_engagement e
    JOIN student_info i ON e.student_id = i.student_id
    LEFT JOIN student_purchases p ON e.student_id = p.student_id
    GROUP BY e.student_id
    HAVING first_date_purchased IS NULL 
        OR first_date_watched <= first_date_purchased
) AS summary_table; 