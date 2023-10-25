--bài tập 1
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM 
(SELECT company_id, title, description, 
COUNT(job_id) AS job_count
FROM job_listings
GROUP BY company_id, title, description) AS job_count_cte
WHERE job_count > 1;
-- bài tập 2
SELECT category, product,total_spend FROM
(SELECT category, product, SUM(spend) AS total_spend
FROM product_spend
WHERE EXTRACT(YEAR FROM transaction_date)='2022'
GROUP BY  category, product
ORDER BY total_spend DESC)AS RANKED_SPENDING
ORDER BY category,total_spend LIMIT 4
--bài tập 3
SELECT COUNT(policy_holder_id) AS member_count
FROM 
(SELECT policy_holder_id,
COUNT(case_id) AS call_count
FROM callers
GROUP BY policy_holder_id
HAVING COUNT(case_id) >= 3) AS call_records;
--bài tập 4
SELECT A.page_id
FROM pages AS A 
LEFT JOIN page_likes AS B 
ON A.page_id=B.page_id
WHERE B.page_id IS NULL
-- bài tập 5 
WITH cte1 AS 
(SELECT user_id, EXTRACT(month FROM event_date) AS month_number
  FROM user_actions
  WHERE EXTRACT(month FROM event_date) = 7 AND EXTRACT(YEAR FROM event_date) = 2022),
cte2 AS 
(SELECT user_id, EXTRACT(month FROM event_date) AS month_number
FROM user_actions
WHERE EXTRACT(month FROM event_date) = 6 AND EXTRACT(YEAR FROM event_date) = 2022)
SELECT cte1.month_number, COUNT(DISTINCT cte1.user_id) AS monthly_active_users 
FROM cte1
JOIN cte2 ON cte1.user_id = cte2.user_id
GROUP BY cte1.month_number;
-- bài tập 6 
SELECT CONCAT(YEAR(trans_date),'-',MONTH(trans_date)) AS MONTH,COUNTRY,COUNT(STATE) AS trans_count
SUM(CASE WHEN STATE='approved' THEN 1 ELSE 0 END) AS approved_count,
SUM(amount) AS trans_total_amount,
SUM(CASE WHEN STATE='approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY CONCAT(YEAR(trans_date),'-',MONTH(trans_date)),COUNTRY
ORDER BY MONTH,COUNTRY DESC
-- bài tập 7 
WITH Min_Product AS 
(SELECT s.product_id, MIN(s.year) AS first_year
FROM Sales s
GROUP BY s.product_id)

SELECT s.product_id, m.first_year, s.quantity, s.price
FROM Sales s
INNER JOIN Min_Product m ON s.product_id = m.product_id AND s.year = m.first_year;
-- bài tập 8 
SELECT customer_id
FROM customer
GROUP BY customer_id
HAVING COUNT( DISTINCT product_key) = (SELECT COUNT(*) FROM product)
-- bài tập 9
SELECT E.employee_id
FROM Employees AS E
LEFT JOIN Employees AS M ON E.manager_id = M.employee_id
WHERE E.salary < 30000
AND E.manager_id IS NOT NULL
AND M.employee_id IS NULL
-- bài tập 10 
WITH job_count_cte AS 
(SELECT company_id,title,description,
COUNT(job_id) AS job_count
FROM job_listings
GROUP BY company_id, title, description)

SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM job_count_cte
WHERE job_count > 1;
