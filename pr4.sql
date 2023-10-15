--SELECT ROUND(AVG(ord_count), 2) AS orders_avg
--FROM (SELECT user_id, COUNT(order_id) AS ord_count
--    FROM user_actions
--    WHERE action = 'create_order'
--    GROUP BY user_id) AS subquery1


--WITH 
--subquery1 AS (
--    SELECT user_id, COUNT(order_id) AS ord_count
--    FROM user_actions
--    WHERE action = 'create_order'
--    GROUP BY user_id)
--
--SELECT ROUND(AVG(ord_count), 2) AS orders_avg
--FROM subquery1


--SELECT product_id, name, price
--FROM products
--WHERE price != (SELECT MIN(price) FROM products)
--ORDER BY product_id DESC


--WITH
--subquery1 AS (
--    SELECT AVG(price) FROM products)
--
--SELECT product_id, name, price
--FROM products
--WHERE price >= (SELECT * FROM subquery1) + 20
--ORDER BY product_id DESC

--SELECT COUNT(DISTINCT user_id) AS users_count
--FROM user_actions
--WHERE time > (SELECT MAX(time) - INTERVAL '1 week' FROM user_actions)

--SELECT MIN(AGE((SELECT MAX(time::DATE) FROM courier_actions), birth_date))::VARCHAR AS min_age
--FROM couriers
--WHERE sex = 'male'

--SELECT order_id
--FROM user_actions
--WHERE order_id NOT IN (SELECT order_id FROM user_actions WHERE action = 'cancel_order')
--ORDER BY order_id
--LIMIT 1000


-- WITH 
-- subquery1 AS(
--     SELECT ROUND(COUNT(DISTINCT order_id)::DECIMAL / COUNT(DISTINCT user_id), 2) FROM user_actions
--     WHERE order_id IN (SELECT order_id FROM user_actions WHERE action = 'create_order'))
    
-- SELECT user_id, COUNT(DISTINCT order_id) AS orders_count, (SELECT * FROM subquery1) AS orders_avg,
--     COUNT(DISTINCT order_id) - (SELECT * FROM subquery1) AS orders_diff
-- FROM user_actions
-- GROUP BY user_id
-- ORDER BY user_id
-- LIMIT 1000

-- ALTERN  /\  \/

-- with t1 as (SELECT user_id,
--                   count(order_id) as orders_count
--             FROM   user_actions
--             WHERE  action = 'create_order'
--             GROUP BY user_id)
-- SELECT user_id,
--       orders_count,
--       round((SELECT avg(orders_count)
--       FROM   t1), 2) as orders_avg, orders_count - round((SELECT avg(orders_count)
--                                                     FROM   t1), 2) as orders_diff
-- FROM   t1
--ORDER BY user_id limit 1000

-- SELECT product_id, name, price,
--     CASE
--     WHEN price >= ((SELECT ROUND(AVG(price), 2) FROM products) + 50)
--     THEN price * 0.85
--     WHEN price <= ((SELECT ROUND(AVG(price), 2) FROM products) - 50)
--     THEN price * 0.9
--     ELSE price
--     END AS new_price
-- FROM products
-- ORDER BY price DESC, product_id


-- SELECT COUNT(order_id) AS orders_count
-- FROM courier_actions
-- WHERE action = 'deliver_order'
--     AND order_id NOT IN (SELECT DISTINCT order_id FROM user_actions)
    

-- SELECT COUNT(DISTINCT order_id) AS orders_count
-- FROM courier_actions
-- WHERE order_id IN (SELECT order_id FROM user_actions WHERE action = 'cancel_order')


-- SELECT COUNT(order_id) AS orders_canceled,
-- COUNT(DISTINCT order_id) FILTER (WHERE action = 'deliver_order') AS orders_canceled_and_delivered
-- FROM courier_actions
-- WHERE order_id IN (SELECT order_id FROM user_actions WHERE action = 'cancel_order')


-- SELECT COUNT(order_id) FILTER (WHERE order_id IN
--     (SELECT order_id FROM user_actions WHERE action = 'cancel_order')) AS orders_canceled,
--     COUNT(order_id) FILTER (WHERE order_id NOT IN 
--     (SELECT order_id FROM courier_actions WHERE action = 'deliver_order')) AS orders_undelivered,
--     COUNT(order_id) FILTER (WHERE order_id NOT IN 
--     (SELECT order_id FROM courier_actions WHERE action = 'deliver_order')
--     AND order_id NOT IN (SELECT order_id FROM user_actions WHERE action = 'cancel_order')) AS orders_in_process
-- FROM courier_actions


-- SELECT user_id, birth_date
-- FROM users
-- WHERE sex = 'male'
--     AND birth_date < (SELECT MIN(birth_date) 
--                         FROM users
--                         WHERE sex = 'female')
-- ORDER BY user_id


-- SELECT order_id, product_ids 
-- FROM orders
-- WHERE order_id IN (SELECT order_id  
--                     FROM courier_actions 
--                     WHERE action = 'deliver_order'
--                     ORDER BY time DESC 
--                     LIMIT 100)
-- ORDER BY order_id


-- SELECT *
-- FROM couriers
-- WHERE courier_id IN (SELECT courier_id
--                     FROM courier_actions
--                     WHERE time BETWEEN '2022-09-01' AND '2022-10-01'
--                         AND action = 'deliver_order'
--                     GROUP BY courier_id
--                     HAVING COUNT(order_id) >= 30)
-- ORDER BY courier_id


SELECT ROUND(AVG(array_length(product_ids, 1)), 3) AS avg_order_size
FROM orders
WHERE order_id IN (SELECT order_id
                    FROM user_actions 
                    WHERE action = 'cancel_order')
        AND order_id IN (SELECT order_id FROM user_actions WHERE user_id IN (SELECT user_id
                        FROM users
                        WHERE sex = 'male'))
