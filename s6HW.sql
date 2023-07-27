-- Задание 1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

CREATE PROCEDURE IF NOT EXISTS secs_to_days(IN secs_in INT)
BEGIN
	DECLARE days INT;
	DECLARE hours INT;
	DECLARE minutes INT;
	DECLARE secs INT;
	SET days = FLOOR(secs_in / (24 * 3600));
	SET hours = FLOOR(secs_in % (24 * 3600) / 3600);
	SET minutes = FLOOR(secs_in % 3600 / 60);
	SET secs = secs_in - days * (24 * 3600) - hours * 3600 - minutes * 60;

	SELECT CONCAT_WS(" ", days, "days", hours, "hours", minutes, "minutes", secs, "seconds");
END

CALL secs_to_days(123456)  --Вызов функции


-- Задание 2. Выведите только четные числа от 1 до 10. Пример: 2,4,6,8,10

WITH RECURSIVE numbers AS (
  SELECT 1 AS num
  UNION ALL
  SELECT num + 1
  FROM numbers
  WHERE num < 10
)
SELECT num
FROM numbers
WHERE num % 2 = 0;