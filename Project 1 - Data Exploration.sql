--Imported this 2 tables from an excel file
Select * from [Project Portfolio]..CovidDeaths;

Select * from [Project Portfolio]..CovidVaccination;

--Using Order by with a column number reference, which starts counting at 1
Select * from [Project Portfolio]..CovidDeaths
Order by 3,4;

-- querying every record with the specified columns
Select location,date, total_cases,new_cases,total_deaths,population
from [Project Portfolio]..CovidDeaths
Order by 1,2;

--How many case are there in india and how many peoples died and diagonosed (percentage of people)
--the purpose of using NULLIF in this case is to avoid division by zero, which would otherwise result in an error.
SELECT
  location,
  date,
  total_cases,
  new_cases,
  total_deaths,
  (CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 as DeathPercentage
FROM
  [Project Portfolio]..CovidDeaths
WHERE
  location LIKE 'India'
ORDER BY
   date,DeathPercentage;
     --India reported 21,821 new COVID-19 cases,The country’s total coronavirus caseload reached 10,266,674, including 148,738 total deaths. By end of year Dec 31,2020


--What percentage of population has gotten covid in india
SELECT
  location,
  date,
  total_cases,
  population,
  (CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0)) * 100 as PersentagePopulationInfected
FROM
  [Project Portfolio]..CovidDeaths
--WHERE
--  location LIKE 'India'
ORDER BY
   1,2;


--looking at countries with highest infection rate compared to population
SELECT
  location,
  population,
  max(total_cases) as HighestInfectedCount,
  Max(CONVERT(float, total_cases)) / max(NULLIF(CONVERT(float, population), 0)) * 100 as PersentagePopulationInfected
FROM
  [Project Portfolio]..CovidDeaths
Group by location,population
ORDER BY PersentagePopulationInfected desc;

--Showing the countries with highest death count per population
SELECT
  location,
  MAX(cast(total_deaths as int))as TotalDeathCount
FROM
  [Project Portfolio]..CovidDeaths
  where continent is not null
Group by location
ORDER BY TotalDeathCount desc;