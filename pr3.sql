--SELECT sex, COUNT(DISTINCT courier_id) AS couriers_count
--FROM couriers
--GROUP BY sex
--ORDER BY couriers_count

--SELECT action, COUNT(order_id) AS orders_count
--FROM user_actions
--GROUP BY action
--ORDER BY orders_count

--SELECT DATE_TRUNC('month', creation_time) AS month, COUNT(order_id) AS orders_count
--FROM orders
--GROUP BY DATE_TRUNC('month', creation_time)
--ORDER BY DATE_TRUNC('month', creation_time)

--SELECT DATE_TRUNC('month', time) AS month, action, COUNT(order_id) AS orders_count
--FROM user_actions
--GROUP BY DATE_TRUNC('month', time), action
--ORDER BY DATE_TRUNC('month', time), action

--SELECT sex, MAX(DATE_PART('month', birth_date))::INTEGER AS max_month
--FROM users
--GROUP BY sex
--ORDER BY sex

--SELECT sex, DATE_PART('month', MAX(birth_date))::INTEGER AS max_month
--FROM users
--GROUP BY sex
--ORDER BY sex

--SELECT sex, DATE_PART('year', AGE(current_date, MIN(birth_date)))::INTEGER AS max_age
--FROM users
--GROUP BY sex
--ORDER BY DATE_PART('year', AGE(current_date, MIN(birth_date)))::INTEGER

--SELECT DATE_PART('year', AGE(current_date, birth_date))::INTEGER AS age, sex, COUNT(user_id) AS users_count
--FROM users
--WHERE birth_date IS NOT NULL
--GROUP BY 1, 2
--ORDER BY 1, 2

--SELECT array_length(product_ids, 1) AS order_size, COUNT(order_id) AS orders_count
--FROM orders
--WHERE creation_time BETWEEN '2022-08-29' AND '2022-09-05'
--GROUP BY array_length(product_ids, 1)
--ORDER BY array_length(product_ids, 1)

--SELECT array_length(product_ids, 1) AS order_size, COUNT(order_id) AS orders_count
--FROM orders
--WHERE DATE_PART('isodow', creation_time) IN (1, 2, 3, 4, 5)
--GROUP BY array_length(product_ids, 1)
--HAVING COUNT(order_id) > 2000
--ORDER BY array_length(product_ids, 1)

--SELECT user_id, COUNT(order_id) AS created_orders
--FROM user_actions
--WHERE action = 'create_order'
--    AND DATE_PART('month', time) = 08
--GROUP BY user_id
--ORDER BY COUNT(order_id) DESC, user_id
--LIMIT 5

--SELECT courier_id
--FROM courier_actions
--WHERE DATE_PART('month', time) = 09
--    AND action = 'deliver_order'
--GROUP BY courier_id
--HAVING COUNT(order_id) = 1
--ORDER BY courier_id

--SELECT user_id
--FROM user_actions
--WHERE action = 'create_order'
--GROUP BY user_id
--HAVING MAX(time) BETWEEN MIN(time) AND '2022-09-08'
--ORDER BY user_id

--SELECT CASE WHEN TO_CHAR(creation_time, 'Dy') NOT IN ('Sat', 'Sun') THEN 'weekdays'
--WHEN TO_CHAR(creation_time, 'Dy') IN ('Sat', 'Sun') THEN 'weekend'
--        END AS week_part,
--        ROUND(AVG(array_length(product_ids, 1)), 2) AS avg_order_size
--FROM orders
-- BY week_part
--ORDER BY avg_order_size

--SELECT CASE WHEN date_part('year', age(current_date, birth_date)) BETWEEN 19 AND 24 THEN '19-24'
--            WHEN date_part('year', age(current_date, birth_date)) BETWEEN 25 AND 29 THEN '25-29'
--            WHEN date_part('year', age(current_date, birth_date)) BETWEEN 30 AND 35 THEN '30-35'
--            WHEN date_part('year', age(current_date, birth_date)) BETWEEN 36 AND 41 THEN '36-41'
--        END AS group_age,
--       COUNT(user_id) as users_count
--FROM   users
--WHERE CASE WHEN date_part('year', age(current_date, birth_date)) BETWEEN 19 AND 24 THEN '19-24'
--            WHEN date_part('year', age(current_date, birth_date)) BETWEEN 25 AND 29 THEN '25-29'
--            WHEN date_part('year', age(current_date, birth_date)) BETWEEN 30 AND 35 THEN '30-35'
--            WHEN date_part('year', age(current_date, birth_date)) BETWEEN 36 AND 41 THEN '36-41'
--        END IS NOT NULL
--GROUP BY 1
--ORDER BY 1

--SELECT user_id, COUNT(order_id) FILTER (WHERE action = 'create_order') AS orders_count, 
--        ROUND((COUNT(order_id) FILTER (WHERE action = 'cancel_order') / 
--        COUNT(DISTINCT order_id)::DECIMAL), 2) AS cancel_rate
-- user_actions
--GROUP BY user_id
--HAVING (ROUND((COUNT(order_id) FILTER (WHERE action = 'cancel_order') / 
--        COUNT(DISTINCT order_id)::DECIMAL), 2) >= 0.5)
--        AND COUNT(order_id) FILTER (WHERE action = 'create_order') > 3
--ORDER BY user_id

SELECT DATE_PART('isodow', time)::INTEGER AS weekday_number, TO_CHAR(time, 'Dy') AS weekday,
    COUNT(order_id) FILTER (WHERE action = 'create_order') AS created_orders,
    COUNT(order_id) FILTER (WHERE action = 'cancel_order') AS canceled_orders,
    COUNT(DISTINCT order_id) - COUNT(order_id) FILTER (WHERE action = 'cancel_order') AS actual_orders,
    ROUND((COUNT(DISTINCT order_id) - COUNT(order_id) FILTER (WHERE action = 'cancel_order')) / 
    COUNT(DISTINCT order_id)::DECIMAL, 3) AS success_rate
FROM user_actions
WHERE time BETWEEN '2022-08-24' AND '2022-09-07'
GROUP BY 1, 2
ORDER BY 1
-- Доработать строчки 114-116
