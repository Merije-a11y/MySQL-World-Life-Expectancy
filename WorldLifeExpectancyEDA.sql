  -- World Life Expectancy EDA
  
  SELECT country, 
    MIN(`Life expectancy`), 
    MAX(`Life expectancy`),
    ROUND( MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Lfe_Expectance_Growth
    FROM world_life_expectancy
    GROUP BY country
    HAVING MIN(`Life expectancy`) <> 0
    AND MAX(`Life expectancy`) <> 0
    ORDER BY Lfe_Expectance_Growth DESC
    ;
    
    SELECT Year, ROUND(AVG(`Life expectancy`), 2) AS Average_Life_Expectancy
    FROM world_life_expectancy
    WHERE `Life expectancy` <> 0
    AND `Life expectancy` <> 0
    GROUP BY Year
    ORDER BY Year
    ;
    
    SELECT *
    FROM world_life_expectancy
    ;
    
	SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),2) AS Avg_GDP
    FROM world_life_expectancy
    GROUP BY country
    HAVING Life_Exp > 0
    AND Avg_GDP > 0
    ORDER BY Avg_GDP DESC
    ;
    
    SELECT
    SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
    ROUND(AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE null END),2) Life_expectancy_by_High_GBP,
    SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
    ROUND(AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE null END),2) Life_expectancy_by_Low_GBP
    FROM world_life_expectancy
    ;
    
    SELECT status, ROUND(AVG(`Life expectancy`),1) AS Lfe_expectance_by_status
    FROM world_life_expectancy
    GROUP BY status
    ;
    
	SELECT status, COUNT(DISTINCT country), ROUND(AVG(`Life expectancy`),1) AS Lfe_expectance_by_status
    FROM world_life_expectancy
    GROUP BY status
    ;
    
    SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(BMI),2) AS Avg_BMI
    FROM world_life_expectancy
    GROUP BY country
    HAVING Life_Exp > 0
    AND Avg_BMI > 0
    ORDER BY Avg_BMI DESC
    ;
    
    SELECT country,
    Year,
    `Life expectancy`,
    `Adult Mortality`,
    SUM(`Adult Mortality`) OVER(PARTITION BY country ORDER BY Year) AS Rolling_Total
    FROM world_life_expectancy
    ;
    
