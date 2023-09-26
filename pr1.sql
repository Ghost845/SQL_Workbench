--SELECT product_id, name, price AS old_price, price * 1.05 AS new_price
--FROM products
--ORDER BY new_price DESC, product_id

--SELECT product_id, name, price AS old_price, round(price * 1.05, 1) AS new_price
--FROM products
--ORDER BY new_price DESC, product_id

--SELECT product_id, name, price AS old_price, round(price * 1.05, 1) AS new_price
--FROM products
--ORDER BY new_price DESC, product_id

--SELECT product_id, name, price AS old_price,
--CASE
--WHEN price = 800 THEN price
--WHEN price > 100 THEN price * 1.05
--ELSE price
--END AS new_price
--FROM products
--ORDER BY new_price DESC, product_id

SELECT product_id,
       name,
       price,
       round(price / 120 * 20, 2) as tax,
       round(price / 120 * 100, 2) as price_before_tax
FROM   products
ORDER BY price_before_tax desc, product_id