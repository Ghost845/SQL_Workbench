-- Напишите запрос, с помощью которого можно найти дубли в поле email из таблицы Sfaff.

SELECT *
FROM staff
WHERE email IN (SELECT email FROM staff 
                GROUP BY email HAVING COUNT(*) > 1)
ORDER BY email                


-- Напишите запрос, с помощью которого можно определить возраст каждого сотрудника из таблицы Staff на момент запроса.

SELECT DATE_PART('year', AGE(current_date, birthday))::INTEGER AS age
FROM staff


-- Напишите запрос, с помощью которого можно определить должность (Jobtitles.name) со вторым по величине уровнем зарплаты.

SELECT name
FROM jobtitles
    LEFT JOIN
    staff
    USING (jobtitle_id)
WHERE salary = (SELECT MAX(salary) FROM staff WHERE salary < (SELECT MAX(salary) FROM staff))
GROUP BY name
