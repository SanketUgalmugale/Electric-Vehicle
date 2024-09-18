create schema sam;
use sam;

select * from Electric_Vehicle;

#1. Write a query to list all electric vehicles with their VIN (1-10), Make, and Model.
select `VIN (1-10)`, Make,Model 
from  Electric_Vehicle;
# 2. Write a query to display all columns for electric vehicles with a Model Year of 2020 or later.
SELECT * 
FROM 
    Electric_Vehicle
WHERE 
    `Model Year` >= 2020;
    
#3. Write a query to list electric vehicles manufactured by Tesla.
select * from Electric_Vehicle
where Make = 'TESLA';
    
# 4. Write a query to find all electric vehicles where the Model contains the word Leaf.
select * from Electric_Vehicle
where Model LIKE '%Leaf%';
    
# 5. Write a query to count the total number of electric vehicles in the dataset.
SELECT 
    COUNT(*) AS total_electric_vehicle
FROM 
    Electric_Vehicle;

#6. Find the average Electric Range of all electric vehicles.
SELECT 
    AVG(`Electric Range`) AS average_electric_range 
FROM 
    Electric_Vehicle;

#7. List the top 5 electric vehicles with the highest Base MSRP, sorted in descending order.
SELECT * FROM Electric_Vehicle 
ORDER BY 
    `Base MSRP` DESC 
LIMIT 5;


#8. List all pairs of electric vehicles that have the same Make and Model Year. Include columns for VIN_1, VIN_2, Make, and Model Year.
SELECT 
    ev1.`VIN (1-10)` AS VIN_1, 
    ev2.`VIN (1-10)` AS VIN_2, 
    ev1.Make, 
    ev1.`Model Year`
FROM 
    Electric_Vehicle ev1
JOIN 
    Electric_Vehicle ev2 
ON 
    ev1.Make = ev2.Make 
    AND ev1.`Model Year` = ev2.`Model Year` 
    AND ev1.`VIN (1-10)` < ev2.`VIN (1-10)`;
    
#9. Write a query to find the total number of electric vehicles for each Make. Display Make and the count of vehicles.
SELECT Make, 
COUNT(*) AS vehicle_count 
FROM  Electric_Vehicle
GROUP BY 
    Make;
    
    
#10.Write a query using a CASE statement to categorize electric vehicles into three categories based on their Electric Range: Short Range for ranges less than 100 miles, Medium Range for ranges between 100 and 200 miles, and Long Range for ranges more than 200 miles.
SELECT `VIN (1-10)`, Make, Model, `Electric Range`,
    CASE
        WHEN `Electric Range` < 100 THEN 'Short Range'
        WHEN `Electric Range` BETWEEN 100 AND 200 THEN 'Medium Range'
        ELSE 'Long Range'
    END AS Range_Category
FROM 
    Electric_Vehicle;

# 11. Write a query to add a new column Model_Length to the electric vehicles table that calculates the length of each Model name.
ALTER TABLE Electric_Vehicle
ADD COLUMN Model_Length INT;

UPDATE Electric_Vehicle
SET Model_Length = LENGTH(Model);

# 12. Write a query using an advanced function to find the electric vehicle with the highest Electric Range.
select * from Electric_Vehicle
order BY 'Electric Range' DESC
limit 1;

# 13. Create a view named HighEndVehicles that includes electric vehicles with a Base MSRP of $50,000 or higher.
CREATE VIEW HighEndVehicles AS
SELECT 
    * 
FROM 
    Electric_Vehicle
WHERE 
    `Base MSRP` >= 50000;
    
#14. Write a query using a window function to rank electric vehicles based on their Base MSRP within each Model Year.
SELECT 
    `VIN (1-10)`, 
    Make, 
    Model, 
    `Model Year`, 
    `Base MSRP`, 
    RANK() OVER (PARTITION BY `Model Year` ORDER BY `Base MSRP` DESC) AS msrp_rank
FROM 
    Electric_Vehicle;


#15. Write a query to calculate the cumulative count of electric vehicles registered each year sorted by Model Year.
SELECT 
    `Model Year`, 
    COUNT(*) OVER (ORDER BY `Model Year`) AS cumulative_count
FROM 
    Electric_Vehicle
ORDER BY 
    `Model Year`;

#16. Write a stored procedure to update the Base MSRP of a vehicle given its VIN (1-10) and new Base MSRP.
DELIMITER $$
CREATE PROCEDURE UpdateBaseMSRP(
    IN vin_param VARCHAR(10),
    IN new_msrp DECIMAL(10, 2)
)
BEGIN
    UPDATE electric_vehicles
    SET Base_MSRP = new_msrp
    WHERE SUBSTRING(VIN, 1, 10) = vin_param;
END$$
DELIMITER ;

#17. Write a query to find the county with the highest average Base MSRP for electric vehicles. Use subqueries and aggregate functions to achieve this.
SELECT 
    County, 
    AVG(`Base MSRP`) AS average_base_msrp 
FROM 
    Electric_Vehicle
GROUP BY 
    County 
ORDER BY 
    average_base_msrp DESC 
LIMIT 1;


#18. Write a query to find pairs of electric vehicles from the same City where one vehicle has a longer Electric Range than the other. Display columns for VIN_1, Range_1, VIN_2, and Range_2.
SELECT 
    ev1.`VIN (1-10)` AS VIN_1, 
    ev1.`Electric Range` AS Range_1, 
    ev2.`VIN (1-10)` AS VIN_2, 
    ev2.`Electric Range` AS Range_2
FROM 
    Electric_Vehicle ev1
JOIN 
    Electric_Vehicle ev2 
ON 
    ev1.City = ev2.City 
    AND ev1.`Electric Range` > ev2.`Electric Range`
    AND ev1.`VIN (1-10)` < ev2.`VIN (1-10)`;




