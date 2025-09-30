# The following script is a Data Analysis project



SELECT 
    *
FROM
    world_life_expentancy.world_life_expectancy;


#We execute this code and we see in the Output that some countries
#have 0 in their MIN and MAX.
SELECT Country, MIN(`Life expectancy`), MAX(`Life expectancy`)
FROM world_life_expectancy
GROUP BY Country
ORDER BY Country DESC
;

#HAVING a MIN (‘Life expectancy’) and a MAX (‘Life expectancy’) not equal to 0.
SELECT Country, MIN(`Life expectancy`), MAX(`Life expectancy`)
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0 
AND MAX(`Life expectancy`) <> 0
ORDER BY Country DESC
;

#We execute the following code the same as the previous one adding the following:
#MAX(`Life expectancy`) - MIN(`Life expectancy`)
SELECT Country,
MIN(`Life expectancy`),
MAX(`Life expectancy`),
MAX(`Life expectancy`) - MIN(`Life expectancy`)
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0 
AND MAX(`Life expectancy`) <> 0
ORDER BY Country DESC
;

#Now the ROUND up the last column in the Output, the one named Life_Increase_15_Years
SELECT Country,
MIN(`Life expectancy`),
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0 
AND MAX(`Life expectancy`) <> 0
ORDER BY Country DESC
;

#Now we execute the last code but this time ORDER BY Life_Increase_15_Years DESC
SELECT Country,
MIN(`Life expectancy`),
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0 
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years DESC
;

#Now we execute the same code but now this time in ASC - ORDER BY Life_Increase_15_Years ASC -
SELECT Country,
MIN(`Life expectancy`),
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0 
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years ASC
;

SELECT Year, AVG(`Life expectancy`)
FROM world_life_expectancy
GROUP BY Year
ORDER BY Year
;

#We execute the same code but this time we ROUND up to two decimal places
SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
GROUP BY Year
ORDER BY Year
;


#Query not for zeros Life expectancy  - WHERE `Life expectancy` <> 0
#AND `Life expectancy` <> 0
SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year
;

SELECT Country, `Life expectancy`, GDP
FROM world_life_expectancy
;


SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
;


#We execute the same code as before but now we add ORDER BY Life_Exp ASC
#After executing it we see in the Output that we have a lot that have 0 Life Expectancy.
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
ORDER BY Life_Exp ASC
;


#Now we do the following code with - HAVING Life_Exp > 0 and AND GDP > 0, so both having 
#a value greater than zero
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY Life_Exp ASC
;


#Now we execute the same code as above but now we ORDER BY GDP ASC
#Lower GDP correlates with lower Life Expectancy. This is the 
#Exploratory Data Analysis or EDA.
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP ASC
;

#The we do the same code by ORDER BY GDP DESC
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC
;

SELECT *
FROM world_life_expectancy
ORDER BY GDP
;


SELECT 
CASE
	WHEN GDP >= 1500 THEN 1
    ELSE 0
END High_GDP_Count
FROM world_life_expectancy
;


#In the following code we do a SUM of the CASE to count - So we have 
#1326 rows of data with GDP >= 1500.
SELECT 
SUM(CASE
	WHEN GDP >= 1500 THEN 1
    ELSE 0
END) High_GDP_Count
FROM world_life_expectancy
;


#Here is the AVG of the Life Expectancy (when is has a value 
#and when its 0) when the GDP > 1500.
#This query analyzes records in the world_life_expectancy table and returns:
#The number of countries (or rows) where GDP is 1500 or higher.
#The average life expectancy of those countries (or rows) with GDP ≥ 1500.
SELECT
SUM(CASE WHEN GDP >=1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >=1500 THEN `Life expectancy` ELSE 0 END) High_GDP_Life_Expectancy
FROM world_life_expectancy
;



#This SQL query calculates:
#The number of entries (countries or records) where the GDP is 1500 or more.
#The average life expectancy only for those entries with GDP ≥ 1500.
#Let’s do NULL as the zeros ‘0’ are affecting the AVG.
SELECT
SUM(CASE WHEN GDP >=1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >=1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy
FROM world_life_expectancy
;


#Now we are doing:
#Low_GDP_Count when SUM of GDP <= 1500.
#High_GDP_Count when AVG of GDP <= 1500 then we have a value for Life Expectancy and NULL for zeros.
#We see in the Output that 1326 Countries with High_GDP and 1612 Countries with Low_GDP, and look at
#their Life Expectancies. 
#So High_GDP countries have a higher Life Expectancy than those countries where there is a Low_GDP.
#We see a high Correlation between High_GDP and High_GDP_Life_Expectancy.
SELECT
SUM(CASE WHEN GDP >=1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >=1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <=1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <=1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
FROM world_life_expectancy
;

#We execute the following code and we see in the Output that Developed
#countries have a higher Life Expectancy.
SELECT Status, ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status
;

#COUNT(DISTINCT Country) meaning count the unique names of countries.
SELECT Status, COUNT(DISTINCT Country)
FROM world_life_expectancy
GROUP BY Status
;

#We execute the following code and we see in the Output 
#Interesting insights that we find in the values between
#the Developed and Developing countries data.
SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status
;

#We execute the following code and we see in the Output that - BMI (Body Mass Index) - Higher 
#BMI are keen to heart attacks and dying early. 
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI DESC
;

#Lets do the same code but now do ORDER BY BMI ASC
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI ASC
;

#Remember that:
#PARTITION BY Country
#This divides the dataset into groups by country.
#The running sum is reset for each country.
#Think of it as: "start a new calculation for each country."
SELECT Country,
Year,
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year)
FROM world_life_expectancy
;


#Do the same code but this time give the aliase of Rolling_Total
#We see in the Output that Rolling_Total adds 1st row 321 and then 
#the 2nd row 316 = 637. And so on through the subsequent rows.
SELECT Country,
Year,
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
;

#A rolling total, also known as a running total or cumulative sum, 
#is a calculation that progressively sums values across a dataset based
#on a specific ordering, usually by date or time. It is often used to 
#track performance or trends over time by calculating the cumulative sum at each point in the dataset. 
SELECT Country,
Year,
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
WHERE Country LIKE '%United%'
;



