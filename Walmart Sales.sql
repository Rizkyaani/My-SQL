SELECT * FROM sales;

SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);


-- menambahkan kolom hari
SELECT
	date,
	DAYNAME(date)
FROM sales;


ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);



-- menambahkan kolom bulan
SELECT
	date,
	MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- nilai unik kota 
SELECT DISTINCT city FROM sales;

-- letak branch dalam kota
SELECT DISTINCT branch FROM sales;
SELECT DISTINCT city, branch FROM sales;

-- nilai unik payment
SELECT DISTINCT payment FROM sales;

-- ---------------------------------------------------------------------------
-- ----------------------------------REVENUE----------------------------------

-- total penerimaan berdasarkan bulan
SELECT
	month_name AS month, SUM(total) AS total_revenue
FROM sales
GROUP BY month_name 
ORDER BY total_revenue;

-- total penerimaan berdasarkan hari
SELECT
	day_name AS day, SUM(total) AS total_revenue
FROM sales
GROUP BY day_name
ORDER BY total_revenue;

-- total penerimaan berdasarkan branch dan kota
SELECT 
	branch, city, SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch
ORDER BY total_revenue;



-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- jumlah tiap gender
SELECT gender, COUNT(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- jumlah tiap payment
SELECT payment, COUNT(*) as payment_cnt
FROM sales
GROUP BY payment
ORDER BY payment_cnt DESC;

-- rata-rata rating berdasarkan time of day
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- rata-rata rating berdasarkan hari
SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name 
ORDER BY avg_rating DESC;