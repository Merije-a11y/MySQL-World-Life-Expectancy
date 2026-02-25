# World Life Expectancy Data Cleaning Project

    describe world_life_expectancy;

SELECT * 
FROM world_life_expectancy
;

SELECT Country, year, concat(country, year), count(concat(country, year))
FROM world_life_expectancy
GROUP BY Country, year, concat(country, year)
having count(concat(country, year)) > 1
;

SELECT *
FROM (
	SELECT Row_ID,
	concat(country, year),
	ROW_NUMBER() OVER(Partition by concat(country, year) ORDER BY concat(country, year)) As Row_Num
	FROM world_life_expectancy
	)AS Row_Table
    WHERE Row_Num > 1
    ;
    
DELETE FROM world_life_expectancy
WHERE
	Row_ID IN (
	SELECT Row_ID
FROM (
	SELECT Row_ID,
	concat(country, year),
	ROW_NUMBER() OVER(Partition by concat(country, year) ORDER BY concat(country, year)) As Row_Num
	FROM world_life_expectancy
	) AS Row_Table
WHERE Row_Num > 1
)
;

SELECT * 
FROM world_life_expectancy
WHERE Status = ""
;
    
SELECT DISTINCT(Status)
FROM world_life_expectancy
WHERE Status <> ""
;

SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing'
;


UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
SET t1.Status = 'Developing'
WHERE t1.status = ""
AND t2.status <> ""
AND t2.status = 'Developing'
;

SET SQL_SAFE_UPDATES = 0;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
SET t1.Status = 'Developed'
WHERE t1.status = ""
AND t2.status <> ""
AND t2.status = 'Developed'
;

SELECT * 
FROM world_life_expectancy
#WHERE `Life expectancy` = ""
;

SELECT country, Year, `Life expectancy`
FROM world_life_expectancy
#WHERE `Life expectancy` = ""
;

SELECT t1.country, t1.Year, t1.`Life expectancy`, 
t2.country, t2.Year, t2.`Life expectancy`,
t3.country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.country = t3.country
    AND t1.Year = t3.Year + 1
    WHERE t1.`Life expectancy` = ""
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.country = t3.country
    AND t1.Year = t3.Year + 1
    SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
    WHERE t1.`Life expectancy` = ""
    ;
    
 