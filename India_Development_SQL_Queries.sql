
# For all developing countries and their population.
select countryname, population_2023, DevelopmentStatus
from countries
where DevelopmentStatus='developing';

# Top 5 countries in a particular year by GDP per capita 
/* Here we will be using ORDER BY, LIMIT 
        ORDER BY: sort your results(ASC/DESC)
        LIMIT: restrict number of rows */
select CountryID, gdp_percapita_usd_nominal as GDP_2021
from economicindicators
where year = 2021
order by GDP_PerCapita_USD_Nominal desc
limit 5; 


# Want a list of all unique years for which HDI data is available
# We will be using DISTINCT, this will removes duplicate entries from a column
select distinct year from HDI;


/* AND, OR, NOT 
	AND: both conditions true
    OR: either condition true
    NOT: negates the condition */
select CountryName, Region, DevelopmentStatus
from countries  
where region = 'south asia' and DevelopmentStatus='developing';  


/* IN, BETWEEN, LIKE
	IN: check for multiple values
    BETWEEN: range
    LIKE: pattern matching */
select CountryName
from countries  
where region in ('south aisa','sub-saharan africa'); # Filters countries in south aisa or sub-saharan africa

select countryid,year, HDI_value 
from HDI
where year between 2015 and 2022; # Selects HDI data between 2015-2022

select CountryName 
from countries
where CountryName like 'ind%'; # Finds countries whose name starts with 'Ind' (like 'India','Indonesia')    
     

# STEP2: Aggregation Functions (COUNT, SUM, AVG, MIN, MAX, GROUPBY, HAVING)
/* We will cover in this 
	1.COUNT(): Counts the number of rows
    2.SUM():
    3.AVG():
    4.MIN()/MAX():
    5.GROUP BY: Used to aggregate values based on the category
    6.HAVING: Used like WHERE, but after GROUP BY to filter aggregated data */
select DevelopmentStatus, count(*) as TotalCountries 
from countries    
group by DevelopmentStatus; # Groups countries based on their development status and counts how many countries fall into each.

select region, sum(population_2023) as TotalPopulation, avg(Area_SqKm) as AvgArea
from countries
group by Region; # Shows total population and average area for each region.

select min(gdp_percapita_usd_nominal) as MinGDP, max(gdp_percapita_usd_nominal) as MaxGDP
from economicindicators
where year = 2022; # Gives the minimum and maximum GDP per capita across all countries for 2022

select CountryID, avg(HDI_Value) as Avg_HDI
from hdi
group by CountryID; # Calculates the average HDI value over all years for each country

select CountryID, avg(GiniCoefficient) as AVG_Gini
from economicindicators
group by CountryID
having avg(GiniCoefficient) > 40; # Filters and shows only countries with high income inequality (Gini > 40)



# Count the number of countries in each group
select region, count(*) as countrycount
from countries
group by Region;


# JOINS
/* Joins are used to combine rows from two or more tables based on a related column (usually a foregin key)
In our case:
Most tables are linked by CountryID, and we'll use it for joining */

# INNER JOIN
# Get all countries wwith HDI values for 2022
SELECT c.CountryName, h.Year, h.HDI_Value
FROM Countries c
INNER JOIN HDI h ON c.CountryID = h.CountryID
WHERE h.Year = 2022;

# LEFT JOIN
# List all countries and their GDP for any particular year
/* Here you can see the output that in in the year 2020, 2021, 2022
Inidia position it is almost bottom of the table */
select c.countryname, e.year, e.gdp_percapita_usd_nominal
from countries c
left join economicindicators e on c.countryid=e.CountryID
where e.year = 2022
order by e.GDP_PerCapita_USD_Nominal desc;


# RIGHT JOIN
SELECT e.CountryID, c.CountryName, e.GDP_PerCapita_USD_Nominal
FROM EconomicIndicators e
RIGHT JOIN Countries c ON e.CountryID = c.CountryID
WHERE e.Year = 2022;

# FULL OUTER JOIN 
# Generally FULL OUTER JOIN is not available in MYSQL, so we are joining two joins using UNION 
SELECT CountryName, Year, GDP_PerCapita_USD_Nominal
FROM (
    SELECT c.CountryName, e.Year, e.GDP_PerCapita_USD_Nominal
    FROM Countries c
    LEFT JOIN EconomicIndicators e ON c.CountryID = e.CountryID

    UNION

    SELECT c.CountryName, e.Year, e.GDP_PerCapita_USD_Nominal
    FROM EconomicIndicators e
    LEFT JOIN Countries c ON e.CountryID = c.CountryID
) AS full_data;


# CROSS JOIN (Rare Use)
# List all combinations of countries and indicators for demo
/* LOGIC:
		Every country will be paired with every indicator name
        Used in matrix generation, testing, or generating combinations */
SELECT c.CountryName, i.IndicatorName
FROM Countries c
CROSS JOIN (
    SELECT DISTINCT IndicatorName FROM RuralUrbanDisparities
) i;


# Subquries 
# Get countries with GDP greater than the average GDP in 2022
SELECT c.CountryName, e.GDP_PerCapita_USD_Nominal
FROM Countries c
JOIN EconomicIndicators e ON c.CountryID = e.CountryID
WHERE e.Year = 2022
AND e.GDP_PerCapita_USD_Nominal > (
    SELECT AVG(GDP_PerCapita_USD_Nominal)
    FROM EconomicIndicators
    WHERE Year = 2022
);


# Subquery in FROM (Derived Table)
# Rank regions by total population
select region, sum(population) as totalpopulation
from (
	select region, population_2023 as population
    from countries)
  as POPData
  group by region
  order by totalpopulation DESC;
  
  
# Correlated Subquery
# Get countries whose population is above the regional average
select c.countryname, c.region, c.population_2023
from countries c
where c.Population_2023> (
select avg(Population_2023)
from countries
where region = c.Region);  



# WINDOW FUNCTIONS
/* Window functions allow you to:

Perform calculations across a set of rows related to the current row

Keep the detail rows (i.e., you don’t collapse data like in GROUP BY)

Add running totals, rankings, percentiles, and more 
 Most Used types
	. ROW_NUMBER()
    . RANK() & DENSE_RANK()
    . NTILE()
    . LEAD() & LAG()
    . SUM() / AVG() / COUNT() OVER() */


SELECT 
  CountryID,
  Year,
  HDI_Value,
  ROW_NUMBER() OVER (
    PARTITION BY CountryID       -- group by each country
    ORDER BY Year DESC           -- sort years in descending order
  ) AS row_num
FROM hdi;


# To get only the latest HDI value per country:
SELECT 
  CountryID,
  Year,
  HDI_Value
FROM (
  SELECT 
    CountryID,
    Year,
    HDI_Value,
    ROW_NUMBER() OVER (
      PARTITION BY CountryID
      ORDER BY Year DESC
    ) AS row_num
  FROM hdi
) AS sub
WHERE row_num = 1;  -- you will 1 row per country with the most recent HDI value.



# RANK()
# Rank countries by GDP per capita PPP in 2022
select 
	CountryID,
    GDP_PerCapita_USD_PPP,
    rank() over(
    order by GDP_PerCapita_USD_PPP desc
    ) as gdp_rank
from economicindicators
where year = 2022;  -- you can see in the output that INDIA's position is 13th


# DENSE RANK()
select 
	CountryID,
    HDI_Value,
    dense_rank() over (
    order by HDI_Value desc
    )as hdi_rank
from hdi    
where Year=2022; -- can see in the output that INDIA rank in HDI



# NTILE() 
SELECT 
  CountryID,
  GDP_PerCapita_USD_PPP,
  NTILE(4) OVER (
    ORDER BY GDP_PerCapita_USD_PPP DESC
  ) AS gdp_quartile
FROM economicindicators
WHERE Year = 2020;



 