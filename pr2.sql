--SELECT product_id, name, price AS old_price, price * 0.8 AS new_price
--FROM products
--WHERE price * 0.8 > 100
--ORDER BY product_id

--SELECT product_id, name
--FROM products
--WHERE LOWER(SPLIT_PART(name, ' ', 1)) = 'чай'
--        OR LENGTH(name) = 5
--ORDER BY product_id

--SELECT product_id, name
--FROM products
--WHERE LOWER(name) LIKE 'с%'
--        AND LOWER(name) NOT LIKE '% %'
--ORDER BY product_id

--SELECT product_id, name, price, '25%' AS discount, price * 0.75 AS new_price
--FROM products
--WHERE name LIKE '%чай%'
--        AND name NOT LIKE '%чайный гриб%'
--        AND price > 60
--ORDER BY product_id

--SELECT user_id, order_id, action, time
--FROM user_actions
--WHERE time BETWEEN '2022-08-25' AND '2022-09-05'
--        AND (user_id = 170
--        OR user_id = 200
--        OR user_id = 230)
--ORDER BY order_id DESC

--SELECT user_id, birth_date
--FROM users
--WHERE birth_date IS NOT NULL
--        AND sex = 'male'
--ORDER BY birth_date DESC
--LIMIT 50

--SELECT order_id, time
--FROM courier_actions
--WHERE courier_id = 100
--        AND action = 'deliver_order'
--ORDER BY time DESC
--LIMIT 10

--SELECT order_id, time
--FROM user_actions
--WHERE DATE_PART('month', time) = 08
--        AND action = 'create_order'
--ORDER BY order_id

--SELECT user_id, order_id, action, time
--FROM user_actions
--WHERE (DATE_PART('dow', time) = 4)
--AND (DATE_PART('month', time) = 8)
--        AND (DATE_PART('hour', time) BETWEEN 12 and 15)
--        AND action = 'cancel_order'
--ORDER BY order_id DESC

--SELECT user_id, order_id, action, time
--FROM user_actions
--WHERE (DATE_PART('month', time) = 8)
--        AND (DATE_PART('hour', time) BETWEEN 12 and 15)
--        AND (DATE_PART('dow', time) = 3)
--        AND action = 'cancel_order'
--ORDER BY order_id DESC

--SELECT product_id, name, price,
--    CASE WHEN name IN ('сахар', 'сухарики', 'сушки', 'семечки', 
--                        'масло льняное', 'виноград', 'масло оливковое', 
--                        'арбуз', 'батон', 'йогурт', 'сливки', 'гречка', 
--                        'овсянка', 'макароны', 'баранина', 'апельсины', 
--                        'бублики', 'хлеб', 'горох', 'сметана', 'рыба копченая', 
--                        'мука', 'шпроты', 'сосиски', 'свинина', 'рис', 
--                        'масло кунжутное', 'сгущенка', 'ананас', 'говядина', 
--                        'соль', 'рыба вяленая', 'масло подсолнечное', 'яблоки', 
--                        'груши', 'лепешка', 'молоко', 'курица', 'лаваш', 'вафли', 'мандарины')
--        THEN round(price / 110 * 10, 2)
--        ELSE round(price / 120 * 20, 2)
--        END AS tax,
--    CASE WHEN name IN ('сахар', 'сухарики', 'сушки', 'семечки', 
--                        'масло льняное', 'виноград', 'масло оливковое', 
--                        'арбуз', 'батон', 'йогурт', 'сливки', 'гречка', 
--                        'овсянка', 'макароны', 'баранина', 'апельсины', 
--                        'бублики', 'хлеб', 'горох', 'сметана', 'рыба копченая', 
--                        'мука', 'шпроты', 'сосиски', 'свинина', 'рис', 
--                        'масло кунжутное', 'сгущенка', 'ананас', 'говядина', 
--                        'соль', 'рыба вяленая', 'масло подсолнечное', 'яблоки', 
--                        'груши', 'лепешка', 'молоко', 'курица', 'лаваш', 'вафли', 'мандарины')
--        THEN round(price / 110 * 100, 2)
--        ELSE round(price / 120 * 100, 2)
--        END AS price_before_tax
--FROM products
--ORDER BY price_before_tax DESC, product_id

--SELECT MIN(time) AS first_delivery, MAX(time) AS last_delivery
--FROM courier_actions
--WHERE action = 'deliver_order'

--SELECT SUM(price) AS order_price
--FROM products
--WHERE name LIKE '%сухар%'
--        OR name LIKE '%чипс%'
--        OR name LIKE '%энергетич%'

--SELECT COUNT(order_id) AS orders
--FROM orders
--WHERE array_length(product_ids, 1) >= 9

--SELECT age(current_date, max(birth_date))::varchar as min_age
--FROM   couriers
--WHERE  sex = 'male'

--SELECT SUM(
--    CASE
--    WHEN name LIKE '%сухарик%' THEN price * 3
--    WHEN name LIKE '%чипс%' THEN price * 2
--    WHEN name LIKE '%энергет%' THEN price * 1
--    END
--    ) AS order_price
--FROM products

--SELECT ROUND(AVG(price), 2) AS avg_price
--FROM products
--WHERE (name LIKE '%чай%'
--    OR name LIKE '%кофе%')
--AND name NOT LIKE '%иван%'
--    AND name NOT LIKE '%гриб%'

--SELECT AGE(MAX(birth_date), MIN(birth_date))::VARCHAR AS age_diff
--FROM users
--WHERE sex = 'male'

--SELECT ROUND(AVG(array_length(product_ids, 1)), 2) AS avg_order_size
--FROM orders
--WHERE DATE_PART('dow', creation_time) = 0
--    OR DATE_PART('dow', creation_time) = 6

--SELECT COUNT(DISTINCT user_id) AS unique_users, COUNT(DISTINCT order_id) AS unique_orders,
--    ROUND(COUNT(DISTINCT order_id)::DECIMAL / COUNT(DISTINCT user_id), 2) AS orders_per_user
--FROM user_actions

--SELECT COUNT(DISTINCT user_id) 
--FILTER (WHERE action = 'create_order') - COUNT(DISTINCT user_id) 
--FILTER (WHERE action = 'cancel_order') AS users_count
--FROM user_actions

SELECT COUNT(order_id) AS orders, 
    COUNT(order_id) FILTER (WHERE array_length(product_ids, 1) >= 5) AS large_orders,
    ROUND(COUNT(order_id) FILTER (WHERE array_length(product_ids, 1) >= 5) / 
    COUNT(order_id)::DECIMAL, 2) AS large_orders_share
FROM orders