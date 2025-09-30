SELECT State_Name, ALand, AWater
FROM us_project.us_household_income

SELECT State_Name, County, ALand, AWater
FROM us_project.us_household_income
;


SELECT State_Name, County, City, ALand, AWater
FROM us_project.us_household_income
;


SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name;

#Order By 2 meaning order by second column.
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 2 DESC;

#Run the following code and we see that Michigan has the most SUM of water.
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 3 DESC;


#Here we are ordering the top 10 States by Land
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10;

#Here we are ordering top 10 States by Water.
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10;

#Here we are typing JOIN which is an INNER JOIN.
SELECT *
FROM us_project.us_household_income u
JOIN us_project.us_household_income_statistics us
	ON u.id = us.id;


SELECT *
FROM us_project.us_household_income u
JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE u.id IS NULL;



#Type the following code and:
#Scroll to the right and see the alias ‘us’ table (which starts with the id column).
#We did a RIGHT JOIN so here we have all of the value rows for the ‘us’ table and
#only the matching records from the left table.
SELECT *
FROM us_project.us_household_income u
RIGHT JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE u.id IS NULL;


#We run the following code and we see a lot of zeros for 
#the Mean, Median, Stdev, sum_w corresponding for the State_Name California
SELECT *
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id;
    
#Now we do WHERE the Mean is not equal to zero
SELECT *
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0;


#Here we are pulling the u.State_Name from the ‘u’ table and we had to use 
#the ticks for `Primary` as MySQL was not recognizing it.
SELECT u.State_Name, County, Type, `Primary`, Mean, Median
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0;


#Notice that we moved the WHERE statement above the GROUP BY 
#as that is the correct order of writing the code.
SELECT u.State_Name, AVG(Mean), AVG(Median)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
;


#ROUND to 1 decimal place.
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
;


#ORDER BY 2 means in Ascending
#We run the following code and we see that Puerto Rico is the 
#lowest AVG house hold income.
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2
;

#Now lets limit by 5 the same code as above, meaning we are doing the bottom 
#five Lowest AVG income.
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2
LIMIT 5
;


#Now lets do the top 5 (ORDER BY 2 DESC) Highest AVG income.
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC
LIMIT 5
;


#lets do the same code but this time lets LIMIT by 10
#We see in the Output:
#District of Columbia has an AVG Mean of 90688.4$. 
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC
LIMIT 10
;


#Here we doing the Highest Median AVG with ORDER BY 3 DESC
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 3 DESC
LIMIT 10
;


#Here we doing from the Lowest Median AVG with ORDER BY 3 ASC
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 3 ASC
LIMIT 10
;



SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
;


#Here we are doing the same code as above but this time:
#GROUP BY 1, ORDER BY 3 DESC and LIMIT 20
#We see in the Output that Municipality has 1 (for COUNT(Type)) and 
#it has the Highest AVG Mean.
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
ORDER BY 3 DESC
LIMIT 20
;


#Now lets do ORDER BY 4 DESC:
#We see in the Output that CPD has the Highest AVG Median.
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
ORDER BY 4 DESC
LIMIT 20
;



SELECT *
FROM us_household_income
WHERE Type = 'Community'
;



#Sometimes we dont want to see for the COUNT(Type) values that are low like 1s or 2s
#so lets do HAVING COUNT(Type) > 100
#Remember that we use HAVING with aggregate functions.
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
HAVING COUNT(Type) > 100
ORDER BY 4 DESC
LIMIT 20
;


#ROUND the AVG Mean to 1 decimal place.
SELECT u.State_Name, City, ROUND(AVG(Mean),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
GROUP BY u.State_Name, City
;



#We see in the Output of the following code:
#Alaska, Delta Junction has the highest AVG Mean.
#by using the following code: ORDER BY ROUND(AVG(Mean),1) DESC
SELECT u.State_Name, City, ROUND(AVG(Mean),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(Mean),1) DESC
;


#add the column ROUND(AVG(Median),1) to the code
SELECT u.State_Name, City, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(Mean),1) DESC
;







