#16.4.2.1 the plant table
CREATE TABLE plant (
    plant_id INT PRIMARY KEY AUTO_INCREMENT,
    plant_name VARCHAR(40),
    zone INT,
    season VARCHAR(40)
);

#16.4.2.2. The seeds Table
CREATE TABLE seeds (
    seed_id INT PRIMARY KEY AUTO_INCREMENT,
    expiration_date DATE,
    quantity INT,
    reorder BOOL,
    plant_id INT,
    FOREIGN KEY(plant_id) REFERENCES plant(plant_id)
);

#16.4.2.3. The garden_bed Table
CREATE TABLE garden_bed (
    space_number INT PRIMARY KEY AUTO_INCREMENT,
    date_planted DATE,
    doing_well BOOL,
    plant_id INT,
    FOREIGN KEY(plant_id) REFERENCES plant(plant_id)
);

#16.4.3.1. Inner Join
SELECT * FROM seeds AS t1 INNER JOIN garden_bed AS t2 ON t1.plant_id = t2.plant_id;

#16.4.3.2. Left Join
SELECT * FROM seeds AS t1 LEFT JOIN garden_bed AS t2 ON t1.plant_id = t2.plant_id;

#16.4.3.3. Right Join
SELECT * FROM seeds AS t1 RIGHT JOIN garden_bed AS t2 ON t1.plant_id = t2.plant_id;

#16.4.3.4. Full Join
SELECT * FROM seeds AS t1 LEFT JOIN garden_bed AS t2 ON t1.plant_id = t2.plant_id 
UNION 
SELECT * FROM seeds AS t1 RIGHT JOIN garden_bed AS t2 ON t1.plant_id = t2.plant_id;    
    
#16.4.4. Sub-Queries and Complex Queries
SELECT * FROM plant as A1 INNER JOIN
(SELECT t1.seed_id, t1.expiration_date, t2.plant_id, t2.space_number FROM seeds AS t1 
INNER JOIN garden_bed AS t2 ON t1.plant_id = t2.plant_id)as A2 ON A1.plant_id = A2.plant_id;

INSERT INTO seeds (expiration_date, quantity, reorder, plant_id) VALUES ('2020-05-08',100,false,
(SELECT plant_id FROM plant WHERE (plant_name LIKE 'Hosta')));

#16.4.5. Bonus Missions
SELECT * FROM seeds AS t1 LEFT JOIN garden_bed AS t2 ON t1.plant_id = t2.plant_id 
UNION ALL
SELECT * FROM seeds AS t1 RIGHT JOIN garden_bed AS t2 ON t1.plant_id = t2.plant_id;

SELECT plant_name, COUNT(plant_name) as count FROM plant as A1 INNER JOIN
(SELECT t1.seed_id, t1.expiration_date, t2.plant_id, t2.space_number FROM seeds AS t1 
INNER JOIN garden_bed AS t2 ON t1.plant_id = t2.plant_id)as A2 ON A1.plant_id = A2.plant_id
GROUP BY plant_name;

