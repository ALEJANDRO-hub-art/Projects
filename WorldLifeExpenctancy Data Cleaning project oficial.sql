SELECT * FROM world_life_expentancy.world_life_expectancy;

SELECT *
FROM world_life_expectancy
;

#CHECK if we have duplicates, and we do
SELECT Country, Year, concat(Country, Year)
FROM world_life_expectancy
;

#Use the count function and see if any of the rows count to 2 (that will signal a duplicate) 
SELECT Country, Year, concat(Country, Year), count(concat(Country, Year))
FROM world_life_expectancy
group by Country, Year, concat(Country, Year)
HAVING count(concat(Country, Year)) > 1
;

SELECT VERSION()




#Let’s identify the Row_ID of the duplicates. Use PARTITION BY and ROW_NUMBER.
SELECT *
FROM (
	SELECT Row_ID,
    CONCAT(Country, Year),
    ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
    FROM world_life_expectancy
    ) AS Row_Table
WHERE Row_Num > 1
;
#Thanks for sharing the query — you're trying to delete duplicate rows from a table using ROW_NUMBER() and a CTE/subquery. 
#Your logic is sound, but the error you're seeing — Error 1175 — is happening because MySQL’s Safe Update Mode is 
#preventing a DELETE that doesn't use a key column directly in the outer WHERE.
#Let’s go step by step to fix this. 
#Add the following line before your query to disable safe update mode for this session:
SET SQL_SAFE_UPDATES = 0;

#Lets make the deletion now
DELETE FROM world_life_expectancy
WHERE
	Row_ID IN (
    SELECT Row_ID
FROM (
	SELECT Row_ID,
    CONCAT(Country, Year),
    ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
    FROM world_life_expectancy
    ) AS Row_Table
WHERE Row_Num > 1 
)
;

#Lets chech if it was deleted, We checked in the Action Output and 3 rows were affected so it worked.
SELECT *
FROM (
	SELECT Row_ID,
    CONCAT(Country, Year),
    ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
    FROM world_life_expectancy
    ) AS Row_Table
WHERE Row_Num > 1
;

#lets check how many BLANKs and NULLs we have. WHERE Status = BLANKs ‘ ‘.
SELECT *
FROM world_life_expectancy
WHERE Status = ''
;

#Here we are calling for DISTINCT (Status), meaning unique names 
#of Status (we have either ‘Developing’ or ‘Developed’); 
#and WHERE Status <> (this sign means is not) BLANK ‘ ‘, dont leave space between the quotes, write
#it like ''.
SELECT DISTINCT(Status)
FROM world_life_expectancy
WHERE Status <> ''
;

#In here SELECT DISTINCT (unique names of Countries), WHERE the Status is ‘Developing’.
SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing'

#We are doing an INNER JOIN to itself.
#Here if there are any BLANKS they should be populated.
#SET t1.Status to Developing WHERE t1.Status is BlANK’ and SET t2.Status where
#is not BLANK to ‘Developing’ (this is where we have NULLs) and SET t2.Status 
#to ‘Developing’ where is equal to ‘Developing’.
SET Status = 'Developing'
WHERE Country IN (SELECT DISTINCT(Country)
				FROM world_life_expectancy
                WHERE Status = 'Developing');
                
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developing'
#there we check in the Action Output that 7 rows were affected s it worked.

#Here we run the code and saw that still have one Status as BLANK (it didn’t populate).
SElECT *
FROM world_life_expectancy
WHERE Status = ''
;

#With the following code we check the Status column and saw that 
#these are ‘Develop’ not ‘Developing’. So update for these. 
SELECT *
FROM world_life_expectancy
WHERE Country = 'United States of America'
;

#Here is the update and it worked, we checked it in the ACtion Output and 1 row was affected.
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed'
;

#Lets check if it was populated with the following code, and it was populated
SELECT *
FROM world_life_expectancy
WHERE Country = 'United States of America'
;

#This code will check for BLANKS in the Status column, we checked and there were no BLANKS any more.
SELECT *
FROM world_life_expectancy
WHERE Status = ''
;

##This code will check for NULLS in the Status column, we checked and there were no BLANKS any more.
SELECT *
FROM world_life_expectancy
WHERE Status IS NULL
;


#Remember that we use the ticks ```` (locate it above the tab key to the left of the 1 key) when
# we have a string with spaces between them and when it turns red means that is working.
# We see in the Output that we have blanks for 'life expectancy'
SELECT *
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;


#Run the following code.
#Look that the values of this 'life expectancy' column increase steadily. So get the next year 
#and the previous year values and populate the BLANK with the average of the two.
SELECT *
FROM world_life_expectancy
;



#Do a JOIN to itself the first table is where is BLANK for the value 
#then do table two and find the next year value and then do table three with the previous year.
#The t2.Year – 1 is the previous year.
SELECT t1.Country, t1.Year, t1.`Life expectancy`, t2.Country, t2.Year, t2.`Life expectancy`
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
    
#Lets add The t3.Year + 1 is the next year. We execute the code and we saw in the Output
# that we had some BLANKS  
SELECT t1.Country, t1.Year, t1.`Life expectancy`,
t2.Country, t2.Year, t2.`Life expectancy`,    
t3.Country, t3.`Life expectancy`
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
;


#Lets paste the same code but adding the WHERE statement at the end where 'Life expectancy'
# is BLANK, we run it and we see that we have BLANKS for Afghanistan and Albania

SELECT t1.Country, t1.Year, t1.`Life expectancy`,
t2.Country, t2.Year, t2.`Life expectancy`,    
t3.Country, t3.`Life expectancy`
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;

#ROUND it to one decimal point 
#Add this line --ROUND(t2.`Life expectancy`+ t3.`Life expectancy`)/2,1)--  to the previous code 
#to round it out.
SELECT t1.Country, t1.Year, t1.`Life expectancy`,
t2.Country, t2.Year, t2.`Life expectancy`,    
t3.Country, t3.`Life expectancy`,
ROUND((t2.`Life expectancy`+ t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;


#Now let’s populate table 1 where we have the BLANKs under the Life expectancy column.
#Here we do UPDATE the JOINS of both tables (one with the previous year and one with the 
#next year), then we do SET the ‘Life expectancy’ table to do the mathematical calculation
# of the two tables (the previous and the next year), WHERE the ‘Life expectancy’ column in
# table one is BLANK ‘ ‘.
#Is the following code:
#SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
#WHERE t1.`Life expectancy` = ''. look it at the bottom of the following code
#We ran the code and ckeched the Action Output and 2 rows were updated
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year -1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year +1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;


#We run this code to see if we have BLANKS and we see in the Output that they were removed.
SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;