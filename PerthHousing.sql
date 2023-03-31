SELECT *
FROM PerthHousePrices

SELECT TOP 10 * -- Selecting the top 10 rows of data
FROM PerthHousePrices

SELECT DISTINCT (SUBURB) -- Selecting the distinct values from the suburb column
FROM PerthHousePrices
ORDER BY SUBURB ASC

SELECT COUNT (DISTINCT SUBURB) AS NumOfSuburbs -- Retrieving the number of distinct suburbs
FROM PerthHousePrices

SELECT MAX(PRICE) AS MaxHousePrice -- Retrieving the highest value house price
FROM PerthHousePrices

SELECT MIN(PRICE) AS MinHousePrice -- Retrieving the lowest value house price
FROM PerthHousePrices

SELECT AVG(PRICE) AS AvgHousePrice -- Retrieving the average value house price
FROM PerthHousePrices

SELECT SUBURB, DATE_SOLD, PRICE -- Retrieving all records where the value of house sold is more than average
FROM PerthHousePrices
WHERE PRICE > 637072

SELECT SUBURB, DATE_SOLD, PRICE -- Retrieving all records where the value of house sold is less than average
FROM PerthHousePrices
WHERE PRICE < 637072

SELECT SUBURB, DATE_SOLD, PRICE, BEDROOMS -- Retrieving records where the house sold price is more than average and bedrooms are less than 4
FROM PerthHousePrices
WHERE PRICE > 637072 AND BEDROOMS < 4
ORDER BY PRICE DESC

SELECT * -- Using a wildcard to retrieve all records where the Suburb name begins with Al
FROM PerthHousePrices
WHERE SUBURB LIKE 'Al%'

SELECT * -- Using a wildcard to retrieve all records where the Suburb name begins with Ea
FROM PerthHousePrices
WHERE SUBURB LIKE 'Ea%'

SELECT * -- Using a wildcard to retrieve all records where the Suburb name begins with E and has an 'a' in any position of the string
FROM PerthHousePrices
WHERE SUBURB LIKE 'E%a%'
ORDER BY SUBURB ASC

SELECT * -- Retrieving all records where the NEAREST_SCH_RANK column is not null
FROM PerthHousePrices
WHERE NEAREST_SCH_RANK IS NOT NULL

SELECT * -- Using IN to retrieve all records where the suburb is Wandi and Atwell
FROM PerthHousePrices
WHERE SUBURB IN ('Wandi' , 'Atwell')
ORDER BY PRICE DESC

SELECT SUBURB, COUNT (SUBURB) As HousesSold -- Retrieving the amount of Houses Sold in each suburb
FROM PerthHousePrices
GROUP BY SUBURB
ORDER BY HousesSold DESC

SELECT SUBURB, AVG(PRICE) AS AvgHousePrice -- Retrieving the average house price in Bertram
FROM PerthHousePrices
WHERE SUBURB = 'Bertram'
GROUP BY SUBURB


SELECT SUBURB, AVG(BEDROOMS) AS AvgBedrooms -- Retrieving the average Number of Bedrooms in Bertram
FROM PerthHousePrices
WHERE SUBURB = 'Bertram'
GROUP BY SUBURB

SELECT SUBURB, AVG(BATHROOMS) AS AvgBathrooms -- Retrieving the average Number of Bathrooms in Bertram
FROM PerthHousePrices
WHERE SUBURB = 'Bertram'
GROUP BY SUBURB

SELECT SUBURB, AVG(LAND_AREA) AS AvgLandArea -- Retrieving the average Land Area in Bertram
FROM PerthHousePrices
WHERE SUBURB = 'Bertram'
GROUP BY SUBURB

SELECT SUBURB, AVG(FLOOR_AREA) AS AvgFloorArea -- Retrieving the average Floor Area in Bertram
FROM PerthHousePrices
WHERE SUBURB = 'Bertram'
GROUP BY SUBURB


SELECT SUBURB, MAX(BEDROOMS) AS MaxBredrooms -- Maximum number of bedrooms in Bertam
FROM PerthHousePrices
WHERE SUBURB = 'Bertram'
GROUP BY SUBURB

SELECT SUBURB, MAX(FLOOR_AREA) AS MaxFloorArea -- Maximum number of bedrooms in Bertam
FROM PerthHousePrices
WHERE SUBURB = 'Bertram'
GROUP BY SUBURB

SELECT SUBURB,ADDRESS, MAX(BEDROOMS) AS MaxBredrooms -- Addresses of houses with the most bedrooms in Bertram
FROM PerthHousePrices
WHERE SUBURB = 'Bertram' AND BEDROOMS = 6
GROUP BY ADDRESS, SUBURB


SELECT COUNT (DISTINCT POSTCODE) AS NumOfPostcodes -- Count of Number of Postcodes in Perth
FROM PerthHousePrices

SELECT POSTCODE, AVG(PRICE) AS AvgPrice -- Average Price of Houses Sold by Postcode
FROM PerthHousePrices
GROUP BY POSTCODE
ORDER BY AvgPrice ASC

SELECT TOP 10 POSTCODE, AVG(PRICE) AS AvgPrice -- Average Price of Houses Sold by Top 10 Postcodes
FROM PerthHousePrices
GROUP BY POSTCODE
ORDER BY AvgPrice ASC

SELECT DISTINCT SUBURB -- Retrieving the suburb names from the Postcodes specified
FROM PerthHousePrices
WHERE POSTCODE IN (6011, 6009, 6015, 6012)


SELECT ADDRESS,PRICE, DATE_SOLD -- Retrieving houses sold which meet the criteria specified
FROM PerthHousePrices
WHERE BEDROOMS = 5 AND BATHROOMS =3
GROUP BY ADDRESS, PRICE, DATE_SOLD
ORDER BY PRICE DESC, DATE_SOLD, ADDRESS

SELECT * -- Selecting the most recent houses sold in this dataset
FROM PerthHousePrices
WHERE [DATE_SOLD] = (SELECT MAX([DATE_SOLD]) FROM PerthHousePrices)


SELECT * -- Selecting the first house sold in this dataset
FROM PerthHousePrices
WHERE [DATE_SOLD] = (SELECT MIN([DATE_SOLD]) FROM PerthHousePrices)

SELECT DISTINCT SUBURB, COUNT (SUBURB) AS HousesSold -- Retrieving number of Houses Sold per suburb where Price is above 550k
FROM PerthHousePrices
WHERE PRICE < 550000 
GROUP BY SUBURB
ORDER BY HousesSold DESC


SELECT ADDRESS,SUBURB,PRICE, BEDROOMS, BUILD_YEAR, DATE_SOLD, -- Retrieving records where price is not null and labelling each record based on the price
	CASE
		WHEN PRICE > 637072 THEN 'Above Average'
		WHEN PRICE BETWEEN 600000 AND 637072 THEN 'Average'
		ELSE 'Below Average'
END AS PriceType
FROM PerthHousePrices
WHERE SUBURB ='Bertram' AND PRICE IS NOT NULL
ORDER BY PRICE DESC

SELECT TOP 100 * -- Retrieving the top 100 rows of data and ordering by Price going up and Date Sold going down
FROM PerthHousePrices
ORDER BY PRICE ASC, DATE_SOLD DESC

SELECT TOP 10 SUBURB, COUNT (SUBURB) As HousesSold -- Retreiving the top 10 suburbs based on Number of houses sold
FROM PerthHousePrices
GROUP BY SUBURB
ORDER BY HousesSold DESC

SELECT TOP 10 SUBURB, COUNT (SUBURB) As HousesSold, AVG(PRICE) AS AvgPrice -- Retreiving the average price of house sold by top 10 suburbs of houses sold
FROM PerthHousePrices
GROUP BY SUBURB
ORDER BY HousesSold DESC

SELECT DISTINCT BEDROOMS As MinNumBedrooms -- Finding the lowest number of bedrooms a property has
FROM PerthHousePrices
WHERE [BEDROOMS] = (SELECT MIN([BEDROOMS]) FROM PerthHousePrices)

SELECT DISTINCT BEDROOMS As MinNumBedrooms -- Finding the highest number of bedrooms a property has
FROM PerthHousePrices
WHERE [BEDROOMS] = (SELECT MAX([BEDROOMS]) FROM PerthHousePrices)

SELECT AVG(PRICE) As AvgPrice -- Retrieving the average price of houses sold by number of bedrooms in the range specified
FROM PerthHousePrices
WHERE BEDROOMS = 1 AND BEDROOMS <= 3

SELECT AVG(PRICE) As AvgPrice -- Retrieving the average price of houses sold by number of bedrooms in the range specified
FROM PerthHousePrices
WHERE BEDROOMS = 4 AND BEDROOMS <= 6

SELECT AVG(PRICE) As AvgPrice -- Retrieving the average price of houses sold by number of bedrooms in the range specified
FROM PerthHousePrices
WHERE BEDROOMS = 7 AND BEDROOMS <=10

SELECT DISTINCT BEDROOMS, AVG(PRICE) AS AvgPrice -- Retrieving average price of houses sold by Number of Bedrooms
FROM PerthHousePrices
GROUP BY BEDROOMS
ORDER BY BEDROOMS ASC

SELECT AVG (NEAREST_STN_DIST) As AvgStationDist -- Average distance to station from property
FROM PerthHousePrices

SELECT MIN (NEAREST_STN_DIST) As MinStationDist -- Minimum distance to station from property
FROM PerthHousePrices

SELECT MAX (NEAREST_STN_DIST) As MaxStationDist --Maximum distance to station from property
FROM PerthHousePrices

SELECT ADDRESS, SUBURB, PRICE, DATE_SOLD -- Retrieving the property details of properties with the lowest distance to a station
FROM PerthHousePrices
WHERE NEAREST_STN_DIST = 46

SELECT ADDRESS, SUBURB, PRICE, DATE_SOLD -- Retrieving the property details of properties with the highest distance to a station
FROM PerthHousePrices
WHERE NEAREST_STN_DIST = 35500

SELECT ADDRESS, SUBURB, PRICE, DATE_SOLD, NEAREST_STN_DIST -- Retrieving property details where the distance to station is around the average
FROM PerthHousePrices
WHERE NEAREST_STN_DIST >= 4520 AND NEAREST_STN_DIST <= 4600
 

SELECT DISTINCT SUBURB, -- Retrieving the average, minimum and maximum house price in each suburb in the dataset
	AVG(PRICE) As AvgPrice,
	MIN(PRICE) As MinPrice,
	MAX(PRICE) As MaxPrice
FROM PerthHousePrices
GROUP BY SUBURB
ORDER BY SUBURB ASC

-- Creating Views for Tableau Visualisatons

-- View 1

-- Average Price of Houses Sold by Top 10 Postcodes

CREATE VIEW Top10PostCodes AS
SELECT TOP 10 POSTCODE, AVG(PRICE) AS AvgPrice 
FROM PerthHousePrices
GROUP BY POSTCODE
ORDER BY AvgPrice ASC

-- View 2

-- Retrieving average price of houses sold by Number of Bedrooms

CREATE VIEW AvgPriceByBedrooms AS
SELECT DISTINCT BEDROOMS, AVG(PRICE) AS AvgPrice 
FROM PerthHousePrices
GROUP BY BEDROOMS
--ORDER BY BEDROOMS ASC

-- View 3

-- Retreiving the average price of house sold by top 10 suburbs of houses sold

CREATE VIEW AvgTop10Houses AS
SELECT TOP 10 SUBURB, COUNT (SUBURB) As HousesSold, AVG(PRICE) AS AvgPrice 
FROM PerthHousePrices
GROUP BY SUBURB
ORDER BY HousesSold DESC

-- View 4

SELECT AVG(PRICE) As FirstDecade
FROM PerthHousePrices
WHERE YEAR(DATE_SOLD) >= 1988 AND YEAR(DATE_SOLD) <= 1998

SELECT AVG(PRICE) As SecondDecade
FROM PerthHousePrices
WHERE YEAR(DATE_SOLD) >= 1998 AND YEAR(DATE_SOLD) <= 2008

SELECT AVG(PRICE)
FROM PerthHousePrices
WHERE YEAR(DATE_SOLD) >= 2008 AND YEAR(DATE_SOLD) <= 2018

SELECT AVG(PRICE)
FROM PerthHousePrices
WHERE YEAR(DATE_SOLD) >= 2018 AND YEAR(DATE_SOLD) <= 2020