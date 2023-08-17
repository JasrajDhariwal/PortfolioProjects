Select * 
From CovidData..CovidDeaths
where continent is not null
Order by 3,4

--Select * 
--From PortfolioProject1..CovidVaccinations
--Order by 3,4

-- Retrieving relevant data
Select Location,date, total_cases, new_cases, total_deaths, population
From CovidData..CovidDeaths
where continent is not null
Order by 1,2

-- Total Cases Vs Total Deaths in UK
Select Location,date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
From CovidData..CovidDeaths
WHERE location like '%kingdom%' and total_deaths IS NOT NULL
Order by 1,2

-- Total Cases VS Population in UK
Select Location,date, total_cases, population, (total_cases/population) * 100 as DeathPercentage
From CovidData..CovidDeaths
where continent is not null
--Where location like '%kingdom%'
Order by 1,2

-- Countries with highest infection rate vs population
Select Location,Population, MAX(total_cases) as HighestInfection, MAX((total_cases/population)) * 100 as PercentageInfection
From CovidData..CovidDeaths
where continent is not null
group by Location, population
Order by PercentageInfection desc

-- Countries with the highest death count per population
Select Location, MAX(cast(total_deaths as int)) as HighDeathCount
From CovidData..CovidDeaths
where continent is not null
group by Location
Order by HighDeathCount desc

-- Continent Overview

-- Continents with highest death count

Select continent, MAX(cast(total_deaths as int)) as HighDeathCount
From CovidData..CovidDeaths
where continent is not null
group by continent
Order by HighDeathCount desc

-- Continents with highest death count

Select location, MAX(cast(total_deaths as int)) as HighDeathCount
From CovidData..CovidDeaths
where continent is not null
group by location
Order by HighDeathCount desc

-- Global Total Death Percentage

SELECT SUM(new_cases) AS TotalCases, SUM(cast(new_deaths AS int)) AS TotalDeaths, ROUND((SUM(cast(new_deaths AS int))/SUM(new_cases))*100, 2) AS DeathPercentage
FROM CovidData..CovidDeaths
WHERE continent is NOT NULL
--GROUP BY date
ORDER BY 1,2

-- Covid Vaccinations

SELECT *
FROM CovidData..CovidVaccinations

-- Joining the two tables

SELECT *
FROM CovidData..CovidDeaths AS dea
JOIN CovidData..CovidVaccinations AS vax
	ON dea.location = vax.location
	AND dea.date = vax.date

-- Total Population vs Vaccinations

SELECT dea.continent, dea.location, dea.date, dea.population, vax.new_vaccinations
, SUM(CONVERT(int, vax.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location,
dea.date) AS rollingVaxCount
FROM CovidData..CovidDeaths AS dea
JOIN CovidData..CovidVaccinations AS vax
	ON dea.location = vax.location
	AND dea.date = vax.date
WHERE dea.continent is not null
ORDER BY 2,3


-- Using a CTE to calculate on a partition by

With PopVax (Continent, Location, Date, population, new_vaccinations, rollingVaxCount)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vax.new_vaccinations
, SUM(CONVERT(int, vax.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location,
dea.date) AS rollingVaxCount
FROM CovidData..CovidDeaths AS dea
JOIN CovidData..CovidVaccinations AS vax
	ON dea.location = vax.location
	AND dea.date = vax.date
WHERE dea.continent is not null
--ORDER BY 2,3
)
SELECT *, (rollingVaxCount/population)*100
FROM PopVax


-- TEMP TABLE

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255), 
date datetime, 
Population numeric, 
New_Vaccinations numeric, 
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vax.new_vaccinations, SUM(CONVERT(int,vax.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM CovidData..CovidDeaths dea
JOIN CovidData..CovidVaccinations vax
	ON dea.location = vax.location
	and dea.date = vax.date
WHERE dea.continent is NOT NULL 

SELECT *, ROUND((RollingPeopleVaccinated/Population)*100,2) AS RollingPercent
FROM #PercentPopulationVaccinated
