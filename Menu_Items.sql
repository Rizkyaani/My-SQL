USE restaurant;

-- --------------------------------------------------------------------------
-- -----------------------------TABEL MENU_ITEMS-----------------------------
-- melihat tabel menu item
SELECT * FROM menu_items;

-- mengubah nama kolom menu item id
ALTER TABLE menu_items RENAME COLUMN ï»¿menu_item_id TO menu_item_id;

-- berapa jumlah items dalam menu?
SELECT COUNT(*) FROM menu_items;

-- apa item yang paling mahal dan murah?
SELECT * FROM menu_items
ORDER BY price DESC;

SELECT * FROM menu_items
ORDER BY price ASC;


-- berapa jumlah menu dari kategori italian?
SELECT COUNT(*) FROM menu_items
WHERE category = 'Italian';

-- apa menu dari kategori italian yang paling mahal dan murah?
SELECT * FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC; 

SELECT * FROM menu_items
WHERE category = 'Italian'
ORDER BY price ASC; 

-- berapa banyak item makanan disetiap kategori?
SELECT category, COUNT(menu_item_id) AS num_dishes
FROM menu_items
GROUP BY category;

-- berapa rata-rata harga makanan disetiap kategori?
SELECT category, AVG(price) AS avg_price
FROM menu_items
GROUP BY category;