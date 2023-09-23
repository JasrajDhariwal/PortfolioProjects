SELECT *
FROM CabsData..cab_rides

SELECT *
FROM CabsData..weather_data

-- Checking for duplicate values in the id & product id column

SELECT id, COUNT(id) AS numOfDuplicates
FROM CabsData..cab_rides
GROUP BY id
HAVING COUNT(id) > 1;

SELECT product_id, COUNT(product_id) AS numOfDuplicates
FROM CabsData..cab_rides
GROUP BY product_id
HAVING COUNT(product_id) > 1;

-- Checking the correct data type of numerical columns

SELECT price, AVG(price) AS AvgPrice
FROM CabsData..cab_rides
GROUP BY price

SELECT surge_multiplier, AVG(surge_multiplier) AS AvgSMultiplier
FROM CabsData..cab_rides
GROUP BY surge_multiplier

-- Checking distinct values from surge_multiplier column

SELECT DISTINCT surge_multiplier
FROM CabsData..cab_rides
ORDER BY surge_multiplier ASC

-- Checking for value range on the id column

SELECT LEN(id)
FROM CabsData..cab_rides
--GROUP BY id

SELECT *
FROM CabsData..cab_rides
WHERE LEN(id) <> 36


-- Checking for missing values

SELECT *
FROM CabsData..cab_rides
WHERE id IS NULL

SELECT *
FROM CabsData..cab_rides
WHERE product_id IS NULL

SELECT *
FROM CabsData..cab_rides
WHERE destination IS NULL

SELECT *
FROM CabsData..cab_rides
WHERE source IS NULL

SELECT *
FROM CabsData..cab_rides
WHERE price IS NULL

-- Deleting rows where price is null

DELETE FROM cab_rides
WHERE price IS NULL

SELECT *
FROM CabsData..cab_rides
WHERE price IS NULL

-- Converting the time_stamp column from epoch to datetime

SELECT time_stamp
FROM CabsData..cab_rides

SELECT         
DATEADD(ss, [time_stamp]/1000, '1970-01-01 00:00:00') As date_time, time_stamp
FROM CabsData..cab_rides


UPDATE cab_rides --Setting the new date column to human readable format
SET date_time = DATEADD(ss, [time_stamp]/1000, '1970-01-01 00:00:00')

ALTER TABLE cab_rides -- Adding the new column into the table
ADD date_time datetime

ALTER TABLE cab_rides -- Removing the time_stamp column
DROP COLUMN time_stamp

SELECT *
FROM CabsData..cab_rides

-- Changing product_id values from variable length string an appropriate naming convention

SELECT DISTINCT product_id, name -- Checking distinct values from the product_id column
FROM CabsData..cab_rides

SELECT DISTINCT name, product_id  -- Checking distinct values from the name column
FROM CabsData..cab_rides

UPDATE cab_rides  -- Updating product_id values from variable length string to appropriate name
SET product_id = 'uber_pool'
WHERE name = 'UberPool'

UPDATE cab_rides  -- Updating product_id values from variable length string to appropriate name
SET product_id = 'uber_black'
WHERE name = 'Black'

UPDATE cab_rides  -- Updating product_id values from variable length string to appropriate name
SET product_id = 'uber_xl'
WHERE name = 'UberXL'

UPDATE cab_rides  -- Updating product_id values from variable length string to appropriate name
SET product_id = 'uber_x'
WHERE name = 'UberX'

UPDATE cab_rides  -- Updating product_id values from variable length string to appropriate name
SET product_id = 'uber_wav'
WHERE name = 'WAV'

UPDATE cab_rides  -- Updating product_id values from variable length string to appropriate name
SET product_id = 'uber_taxi'
WHERE name = 'Taxi'

UPDATE cab_rides  -- Updating product_id values from variable length string to appropriate name
SET product_id = 'uber_black_suv'
WHERE name = 'Black SUV'

SELECT DISTINCT product_id, name -- Checking the final result of updates made to product_id column
FROM CabsData..cab_rides

SELECT * -- Final check of the data in this table
FROM CabsData..cab_rides

-- Cleaning & preparing the date from the weather_data table

SELECT *
FROM CabsData..weather_data

SELECT location
FROM CabsData..weather_data
WHERE location IS NULL

SELECT temp
FROM CabsData..weather_data
WHERE temp IS NULL

SELECT clouds
FROM CabsData..weather_data
WHERE clouds IS NULL

SELECT pressure
FROM CabsData..weather_data
WHERE pressure IS NULL

SELECT time_stamp
FROM CabsData..weather_data
WHERE time_stamp IS NULL

SELECT humidity
FROM CabsData..weather_data
WHERE humidity IS NULL

SELECT wind
FROM CabsData..weather_data
WHERE wind IS NULL

SELECT rain
FROM CabsData..weather_data
WHERE rain IS NULL



---
SELECT DISTINCT location
FROM CabsData..weather_data
