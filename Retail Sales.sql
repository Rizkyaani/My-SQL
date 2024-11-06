CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

SELECT * FROM retail_sales;

-- ---------------DATA CLEANING---------------
-- MENGUBAH NAMA KOLOM
ALTER TABLE retail_sales RENAME COLUMN ï»¿transactions_id TO transactions_id;

-- JUMLAH DATASET
SELECT COUNT(*) FROM retail_sales;

-- CEK NILAI NULL
SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

-- CEK NULL SECARA BERSAMA
SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
    OR 
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR 
    gender IS NULL
    OR 
    category IS NULL
    OR 
    quantity IS NULL
    OR 
    cogs IS NULL
    OR 
    total_sale IS NULL;
    
-- MENGUBAH NAMA KOLOM QUANTITY
ALTER TABLE retail_sales RENAME COLUMN quantiy TO quantity;

-- HAPUS NILAI NULL
DELETE FROM retail_sales
WHERE 
	transactions_id IS NULL
    OR 
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR 
    gender IS NULL
    OR 
    category IS NULL
    OR 
    quantity IS NULL
    OR 
    cogs IS NULL
    OR 
    total_sale IS NULL;


-- ---------------DATA EXPLORATION---------------

-- BERAPA SALES DALAM DATA?
SELECT COUNT(*) AS total_sale FROM retail_sales;

-- BERAPA NILAI UNIK CUSTOMER?
SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales;

-- NILAI UNIK DARI CATEGORY
SELECT DISTINCT category FROM retail_sales;


-- ---------------DATA ANALYSIS AND FINDINGS---------------

-- 1. penjualan yang dilakukan pada '2022-11-05'
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- 2. transaksi dengan kategori 'Pakaian' dan jumlah yang terjual lebih dari 4 pada bulan Nov-2022:
SELECT *
FROM retail_sales
WHERE category = 'Clothing' 
	AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11' 
    AND quantity >= 4;
    
-- 3. total penjualan (total_sale) untuk setiap kategori
SELECT category, SUM(total_sale) AS net_sale, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY 1;

-- 4. usia rata-rata pelanggan yang membeli barang dari kategori 'Kecantikan'
SELECT AVG(age) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- 5. transaksi dengan total_sale lebih besar dari 1000
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- 6. jumlah total transaksi (transaction_id) yang dilakukan oleh setiap jenis kelamin di setiap kategori
SELECT COUNT(*) AS total_trans, category, gender
FROM retail_sales
GROUP BY category, gender
ORDER BY 1;

-- 7.rata-rata penjualan setiap bulan. Cari tahu bulan dengan penjualan terbaik setiap tahun
SELECT 
    year,
    month,
    avg_sale
FROM 
(
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        ROW_NUMBER() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank_num
    FROM retail_sales
    GROUP BY year, month
) AS t1
WHERE rank_num = 1;
 
 -- 8. 5 pelanggan teratas berdasarkan total penjualan tertinggi
 SELECT customer_id, SUM(total_sale) AS total_sales
 FROM retail_sales
 GROUP BY 1
 ORDER BY 2 DESC
 LIMIT 5;
 
 -- 9. jumlah pelanggan unik yang membeli item dari setiap kategori
 SELECT category, COUNT(DISTINCT customer_id) AS uniq_cust
 FROM retail_sales
 GROUP BY category;
 
 -- 10. membuat setiap shift dan jumlah pesanan (Contoh Pagi <12, Sore Antara 12 & 17, Malam >17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
