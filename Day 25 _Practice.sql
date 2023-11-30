-- bài tập 1
SELECT 
  PRODUCTLINE,
  YEAR_ID,
  DEALSIZE,
  SUM(sales) AS REVENUE
FROM public.sales_dataset_rfm_prj_clean
GROUP BY PRODUCTLINE, YEAR_ID, DEALSIZE
ORDER BY REVENUE DESC;
-- bài tập 2 
WITH MonthlyRevenueRank AS (
SELECT
    YEAR_ID,
    MONTH_ID,
    SUM(sales) AS REVENUE,
    COUNT(DISTINCT ORDERNUMBER) AS ORDER_NUMBER,
    RANK() OVER (PARTITION BY YEAR_ID ORDER BY SUM(sales) DESC) AS ranks
  FROM public.sales_dataset_rfm_prj_clean
  GROUP BY YEAR_ID, MONTH_ID)

SELECT
  YEAR_ID,
  MONTH_ID,
  REVENUE,
  ORDER_NUMBER
FROM MonthlyRevenueRank
WHERE ranks = 1;
-- bài tập 3
WITH NovemberSales AS (
  SELECT
    MONTH_ID,
    PRODUCTLINE,
    SUM(sales) AS REVENUE,
    COUNT(DISTINCT ORDER_NUMBER) AS ORDER_NUMBER
  FROM public.sales_dataset_rfm_prj_clean
  WHERE MONTH_ID = 11
  GROUP BY MONTH_ID, PRODUCTLINE)

SELECT
  MONTH_ID,
  PRODUCTLINE,
  REVENUE,
  ORDER_NUMBER
FROM NovemberSales
ORDER BY REVENUE DESC;
-- bai tập 4 
WITH UKYearlyProductRank AS (
  SELECT
    YEAR_ID,
    PRODUCTLINE,
    SUM(sales) AS REVENUE,
    RANK() OVER (PARTITION BY YEAR_ID ORDER BY SUM(sales) DESC) AS RANK
  FROM public.sales_dataset_rfm_prj_clean
  WHERE COUNTRY = 'UK'
  GROUP BY YEAR_ID, PRODUCTLINE
)

SELECT
  YEAR_ID,
  PRODUCTLINE,
  REVENUE,
  RANK
FROM UKYearlyProductRank
WHERE RANK = 1;
-- bài tập 5 


