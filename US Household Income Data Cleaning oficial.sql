
#We execute this command and we see in the Output that the name of the first
#column is 'ï»¿id' lets fix that.
SELECT * FROM us_project.ushouseholdincome_statistics;


#Lets fix this name column 'ï»¿id' here
#Remember to put the ticks ```` in the name columns. These ticks are located to the left
#of the key 1 and above the tab key
ALTER TABLE us_project.ushouseholdincome_statistics RENAME COLUMN `ï»¿id` TO `id`;




#Lets run the following code and see it we fix it.... and yes it was fixed
SELECT * FROM us_project.ushouseholdincome_statistics;

#Here we are counting the number of records
SELECT COUNT(id)
FROM us_project.us_household_income;


#Here we are counting the number of records for the statistics csv
SELECT COUNT(id)
FROM us_project.us_household_income_statistics;

#We run this code and we see in the Output that we have some names that
#are not upper case for the State_Name column, for example 'alabama'
#Futher more in the AWater column we have some zeros for some values as well
#for columns like Mean, Median, Stdev and sum_w column
SELECT *
FROM us_project.us_household_income;

SELECT *
FROM us_project.us_household_income_statistics;


#Here we are counting duplicates of the id column.
SELECT id, COUNT(id)
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1


#ROW_NUMBER()	Assigns a unique row number to each row within a group (starts at 1)
#PARTITION BY id	Groups the rows by id — numbering starts over in each id group
#ORDER BY id	Sorts the rows within each partition — but this does nothing here, see below
SELECT row_id,
id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id)
FROM us_project.us_household_income;


#Use a subquery as we have done before.
#See in the out that we have several row_num with 2 thats the duplicates
SELECT *
FROM (
SELECT row_id,
id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
FROM us_project.us_household_income
) duplicates
WHERE row_num > 1
;



#Now lets delete the duplicates with a subquery
DELETE FROM us_household_income
WHERE row_id IN (
	SELECT row_id
    FROM (
		SELECT row_id,
		id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
		FROM us_project.us_household_income
) duplicates
WHERE row_num > 1)
;


#Lets run the following code to see if we see in the row_num colum any 2
#meaning that there are still duplicates.
#We run it and saw in the Output nothing so the previous code to delete
#the duplicates was succesfull
SELECT *
FROM (
SELECT row_id,
id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
FROM us_project.us_household_income
) duplicates
WHERE row_num > 1
;

#Now let’s do it for the statistics table, and we see in the 
#Output that we don’t have any duplicates.
SELECT id, COUNT(id)
FROM us_project.us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1
;


#We run the following code and we see in the State_Name column 'alabama' in
#lower case
SELECT *
FROM us_project.us_household_income
;


#We run the following code and we see in the State_Name colum 'georia' (badly written)
SELECT State_Name, COUNT(State_Name)
FROM us_project.us_household_income
GROUP BY State_Name
;


#Do a DISTINCT which are display unique names and ORDER BY 1 meaning order
#by first column.
#We still don’t find ‘alabama’ lower case.
SELECT DISTINCT State_Name
FROM us_project.us_household_income
ORDER BY 1
;


#We ran the code right down here for fixing 'georia' and we were getting an
#error 1175 so run the following code and after that rin the UPDATE code again
SET SQL_SAFE_UPDATES = 0;

#Lets fix the 'georia' name
UPDATE us_project.us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';


#We run the following code to check if we fix the 'georia' error and we 
#saw in the Output 'Georgia' so it was fixed succesfully
SELECT DISTINCT State_Name
FROM us_project.us_household_income
ORDER BY 1
;


#Now lets fix the 'alabama' lower case error
#After run it we saw no error so no need to run SET SQL_SAFE_UPDATES = 0
UPDATE us_project.us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';


#lets run the following code and see if we see any 'alabama'. We run it and saw all
#of them in upper case
SELECT *
FROM us_project.us_household_income;


#Run the following code
#We saw in the Output nothing wrong, everything looks OK here.
SELECT DISTINCT State_ab
FROM us_project.us_household_income
ORDER BY 1
;


#We run the following code and we see in the Place column BLANK rows
SELECT *
FROM us_project.us_household_income
ORDER BY 1
;

#We run the following code and we see in the Output that the Place
#column was BLANK for row_id 32
SELECT *
FROM us_project.us_household_income
WHERE Place = ''
ORDER BY 1
;

#After runnning this code we see that for the County colum where is 'Autauga County' and the 
#City 'Vinemont' the Place column was BLANK lets fix that
SELECT *
FROM us_project.us_household_income
WHERE County = 'Autauga County'
ORDER BY 1
;

#Lets fix this BLANK here
#We ran the code and in the Action Out we see that two rows were affected
#so the code ran succesfully
UPDATE us_household_income
SET Place = 'Autagaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont';

#Lets run the following code to see if the BLANK was fixed; and yes after
#running it we wat that Place = 'Autagaville' was populated
SELECT *
FROM us_project.us_household_income
WHERE County = 'Autauga County'
ORDER BY 1
;

#Here with the code we count the types of Type column we have.
#We saw in the Output that we have a duplication error, Boroughs is showed twice 
SELECT Type, COUNT(Type)
FROM us_project.us_household_income
GROUP BY Type
ORDER BY 1
;

#Lets fixed the 'Borough' problem
UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs';

#We run the following code to see if it was fixed and in the Output we saw
#it was fixed
SELECT Type, COUNT(Type)
FROM us_project.us_household_income
GROUP BY Type
ORDER BY 1
;


#We run the following code WHERE AWater = 0 OR AWater = '' OR AWater IS NULL
SELECT ALand, Awater
FROM us_project.us_household_income
WHERE AWater = 0 OR AWater = '' OR AWater IS NULL
;


#We run the following code and we see
#DISTINCT AWater meaning unique name for AWater and we 
#see they are all zeros ‘0’, there is no BLANK or NULL data.
SELECT DISTINCT AWater
FROM us_project.us_household_income
WHERE AWater = 0 OR AWater = '' OR AWater IS NULL
;


#We ran the following code and we see in the Output that there are no
#NULL or BLANKS so we don’t need to fix anything.
SELECT ALand, AWater
FROM us_project.us_household_income
WHERE (Aland = 0 OR Aland = '' OR AWater IS NULL)
;






