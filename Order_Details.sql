-- --------------------------------------------------------------------------
-- -----------------------------TABEL ORDER_DETAILS---------------------------

-- melihat tabel order_details
SELECT * FROM order_details;

-- mengubah nama kolom order details id
ALTER TABLE order_details RENAME COLUMN ï»¿order_details_id TO order_details_id;

-- berapa rentang tanggal dari tabel?
SELECT MIN(order_date), MAX(order_date) FROM order_details;

-- berapa banyak pesanan yang dibuat?
SELECT COUNT(DISTINCT order_id) FROM order_details;

-- berapa banyak item yang dipesan?
SELECT count(*) FROM order_details;

-- pesanan apa yang paling banyak dipesan?
SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;

-- berapa banyak pesanan yang dipesan lebih dari 12 item
SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
HAVING num_items>12;

-- jumlah data dari banyak pesanan yang dipesan lebih dari 12 item
SELECT COUNT(*) FROM

(SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
HAVING num_items>12) AS num_orders;