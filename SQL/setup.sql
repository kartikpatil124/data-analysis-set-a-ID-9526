create database routes;

use routes;

create table RoutesTable(
route_id varchar(10) primary key,
route varchar(50),
service_type varchar(50)
);

create table delivers(
record_id varchar(10) primary key,
month varchar(5),
route_id varchar(10),
hub varchar(50),
promised_days int not null,
actual_days int not null
);

set global local_infile = 1;
show variables like 'local_infile';

-- load data infile "C:/Users/Admin/OneDrive/Desktop/kartik/routes.csv"
-- into table RoutesTable
-- fields terminated by ','
-- optionally enclosed by '"'(
-- lines terminated by '\n'
-- ignore 1 rows
-- (route_id, route, service_type);


insert into RoutesTable (route_id, route, service_type) values
('R1','Metro Link','Express'),
('R2','City Dash','Express'),
('R3','Highway Freight','Standard'),
('R4','Rural Feeder','Standard');

INSERT INTO delivers (record_id, month, route_id, hub, promised_days, actual_days) VALUES
(1, 'Jan', 'R1', 'Mumbai', 2, 2),
(2, 'Jan', 'R2', 'Chennai', 3, 4),
(3, 'Jan', 'R3', 'Delhi', 5, 8),
(4, 'Jan', 'R4', 'Mumbai', 6, 10),
(5, 'Feb', 'R1', 'Chennai', 2, 5),
(6, 'Feb', 'R2', 'Delhi', 3, 3),
(7, 'Feb', 'R3', 'Delhi', 5, 10),
(8, 'Feb', 'R4', 'Chennai', 6, 7),
(9, 'Mar', 'R1', 'Delhi', 2, 8),
(10, 'Mar', 'R2', 'Mumbai', 3, 5),
(11, 'Mar', 'R3', 'Chennai', 5, 5),
(12, 'Mar', 'R4', 'Mumbai', 6, 15);

SELECT
  r.service_type,
  SUM(CASE WHEN d.actual_days > d.promised_days
           THEN d.actual_days - d.promised_days
           ELSE 0 END) AS total_delay_days
FROM delivers d
JOIN RoutesTable r ON d.route_id = r.route_id
GROUP BY r.service_type
ORDER BY total_delay_days DESC;

SELECT
  d.route_id,
  r.RoutesTable,
  SUM(CASE WHEN d.actual_days > d.promised_days
           THEN d.actual_days - d.promised_days
           ELSE 0 END) AS total_delay_days
FROM delivers d
JOIN RoutesTable r ON d.route_id = r.route_id
GROUP BY d.route_id, r.route
HAVING total_delay_days > 8
ORDER BY total_delay_days DESC;

SELECT
  d.hub,
  SUM(CASE WHEN d.actual_days > d.promised_days
           THEN d.actual_days - d.promised_days
           ELSE 0 END) AS total_delay_days
FROM delivers d
GROUP BY d.hub
ORDER BY total_delay_days DESC, d.hub ASC
LIMIT 2;




