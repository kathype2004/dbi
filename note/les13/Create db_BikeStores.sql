use master
go
DROP DATABASE IF EXISTS BikeStores;
GO

CREATE database BikeStores;
go

use BikeStores;
go

-- create schemas
CREATE SCHEMA production;
go

CREATE SCHEMA sales;
go

-- create tables
CREATE TABLE production.categories (
	category_id INT IDENTITY (1, 1) PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);

CREATE TABLE production.brands (
	brand_id INT IDENTITY (1, 1) PRIMARY KEY,
	brand_name VARCHAR (255) NOT NULL
);

CREATE TABLE production.products (
	product_id INT IDENTITY (1, 1) PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	model_year SMALLINT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	FOREIGN KEY (category_id) REFERENCES production.categories (category_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (brand_id) REFERENCES production.brands (brand_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE sales.customers (
	customer_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255) NOT NULL,
	street VARCHAR (255),
	city VARCHAR (50),
	state VARCHAR (25),
	zip_code VARCHAR (5)
);

CREATE TABLE sales.stores (
	store_id INT IDENTITY (1, 1) PRIMARY KEY,
	store_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255),
	street VARCHAR (255),
	city VARCHAR (255),
	state VARCHAR (10),
	zip_code VARCHAR (5)
);

CREATE TABLE sales.staffs (
	staff_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (255) NOT NULL UNIQUE,
	phone VARCHAR (25),
	active tinyint NOT NULL,
	store_id INT NOT NULL,
	manager_id INT,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (manager_id) REFERENCES sales.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sales.orders (
	order_id INT IDENTITY (1, 1) PRIMARY KEY,
	customer_id INT,
	order_status tinyint NOT NULL,
	-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	order_date DATE NOT NULL,
	required_date DATE NOT NULL,
	shipped_date DATE,
	store_id INT NOT NULL,
	staff_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES sales.customers (customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (staff_id) REFERENCES sales.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sales.order_items (
	order_id INT,
	item_id INT,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
	PRIMARY KEY (order_id, item_id),
	FOREIGN KEY (order_id) REFERENCES sales.orders (order_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES production.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE production.stocks (
	store_id INT,
	product_id INT,
	quantity INT,
	PRIMARY KEY (store_id, product_id),
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES production.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

use BikeStores;

SET IDENTITY_INSERT production.brands ON;  

INSERT INTO production.brands(brand_id,brand_name) VALUES(1,'Electra')
INSERT INTO production.brands(brand_id,brand_name) VALUES(2,'Haro')
INSERT INTO production.brands(brand_id,brand_name) VALUES(3,'Heller')
INSERT INTO production.brands(brand_id,brand_name) VALUES(4,'Pure Cycles')
INSERT INTO production.brands(brand_id,brand_name) VALUES(5,'Ritchey')
INSERT INTO production.brands(brand_id,brand_name) VALUES(6,'Strider')
INSERT INTO production.brands(brand_id,brand_name) VALUES(7,'Sun Bicycles')
INSERT INTO production.brands(brand_id,brand_name) VALUES(8,'Surly')
INSERT INTO production.brands(brand_id,brand_name) VALUES(9,'Trek')

SET IDENTITY_INSERT production.brands OFF;  

SET IDENTITY_INSERT production.categories ON;  
INSERT INTO production.categories(category_id,category_name) VALUES(1,'Children Bicycles')
INSERT INTO production.categories(category_id,category_name) VALUES(2,'Comfort Bicycles')
INSERT INTO production.categories(category_id,category_name) VALUES(3,'Cruisers Bicycles')
INSERT INTO production.categories(category_id,category_name) VALUES(4,'Cyclocross Bicycles')
INSERT INTO production.categories(category_id,category_name) VALUES(5,'Electric Bikes')
INSERT INTO production.categories(category_id,category_name) VALUES(6,'Mountain Bikes')
INSERT INTO production.categories(category_id,category_name) VALUES(7,'Road Bikes')

SET IDENTITY_INSERT production.categories OFF;  

SET IDENTITY_INSERT production.products ON;
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(1,'Trek 820 - 2016',9,6,2016,379.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(2,'Ritchey Timberwolf Frameset - 2016',5,6,2016,749.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(3,'Surly Wednesday Frameset - 2016',8,6,2016,999.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(4,'Trek Fuel EX 8 29 - 2016',9,6,2016,2899.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(5,'Heller Shagamaw Frame - 2016',3,6,2016,1320.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(6,'Surly Ice Cream Truck Frameset - 2016',8,6,2016,469.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(7,'Trek Slash 8 27.5 - 2016',9,6,2016,3999.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(8,'Trek Remedy 29 Carbon Frameset - 2016',9,6,2016,1799.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(9,'Trek Conduit+ - 2016',9,5,2016,2999.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(10,'Surly Straggler - 2016',8,4,2016,1549)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(11,'Surly Straggler 650b - 2016',8,4,2016,1680.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(12,'Electra Townie Original 21D - 2016',1,3,2016,549.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(13,'Electra Cruiser 1 (24-Inch) - 2016',1,3,2016,269.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(14,'Electra Girl''s Hawaii 1 (16-inch) - 2015/2016',1,3,2016,269.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(15,'Electra Moto 1 - 2016',1,3,2016,529.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(16,'Electra Townie Original 7D EQ - 2016',1,3,2016,599.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(17,'Pure Cycles Vine 8-Speed - 2016',4,3,2016,429)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(18,'Pure Cycles Western 3-Speed - Women''s - 2015/2016',4,3,2016,449)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(19,'Pure Cycles William 3-Speed - 2016',4,3,2016,449)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(20,'Electra Townie Original 7D EQ - Women''s - 2016',1,3,2016,599.99)

SET IDENTITY_INSERT production.products OFF;

-- sales.customers table
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Debra','Burks',NULL,'debra.burks@yahoo.com','9273 Thorne Ave. ','Orchard Park','NY',14127);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Kasha','Todd',NULL,'kasha.todd@yahoo.com','910 Vine Street ','Campbell','CA',95008);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Tameka','Fisher',NULL,'tameka.fisher@aol.com','769C Honey Creek St. ','Redondo Beach','CA',90278);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Daryl','Spence',NULL,'daryl.spence@aol.com','988 Pearl Lane ','Uniondale','NY',11553);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Charolette','Rice','(916) 381-6003','charolette.rice@msn.com','107 River Dr. ','Sacramento','CA',95820);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Lyndsey','Bean',NULL,'lyndsey.bean@hotmail.com','769 West Road ','Fairport','NY',14450);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Latasha','Hays','(716) 986-3359','latasha.hays@hotmail.com','7014 Manor Station Rd. ','Buffalo','NY',14215);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Jacquline','Duncan',NULL,'jacquline.duncan@yahoo.com','15 Brown St. ','Jackson Heights','NY',11372);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Genoveva','Baldwin',NULL,'genoveva.baldwin@msn.com','8550 Spruce Drive ','Port Washington','NY',11050);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Pamelia','Newman',NULL,'pamelia.newman@gmail.com','476 Chestnut Ave. ','Monroe','NY',10950);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Deshawn','Mendoza',NULL,'deshawn.mendoza@yahoo.com','8790 Cobblestone Street ','Monsey','NY',10952);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Robby','Sykes','(516) 583-7761','robby.sykes@hotmail.com','486 Rock Maple Street ','Hempstead','NY',11550);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Lashawn','Ortiz',NULL,'lashawn.ortiz@msn.com','27 Washington Rd. ','Longview','TX',75604);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Garry','Espinoza',NULL,'garry.espinoza@hotmail.com','7858 Rockaway Court ','Forney','TX',75126);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Linnie','Branch',NULL,'linnie.branch@gmail.com','314 South Columbia Ave. ','Plattsburgh','NY',12901);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Emmitt','Sanchez','(212) 945-8823','emmitt.sanchez@hotmail.com','461 Squaw Creek Road ','New York','NY',10002);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Caren','Stephens',NULL,'caren.stephens@msn.com','914 Brook St. ','Scarsdale','NY',10583);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Georgetta','Hardin',NULL,'georgetta.hardin@aol.com','474 Chapel Dr. ','Canandaigua','NY',14424);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Lizzette','Stein',NULL,'lizzette.stein@yahoo.com','19 Green Hill Lane ','Orchard Park','NY',14127);
INSERT INTO sales.customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Aleta','Shepard',NULL,'aleta.shepard@aol.com','684 Howard St. ','Sugar Land','TX',77478);


-- stores

INSERT INTO sales.stores(store_name, phone, email, street, city, state, zip_code)
VALUES('Santa Cruz Bikes','(831) 476-4321','santacruz@bikes.shop','3700 Portola Drive', 'Santa Cruz','CA',95060),
      ('Baldwin Bikes','(516) 379-8888','baldwin@bikes.shop','4200 Chestnut Lane', 'Baldwin','NY',11432),
      ('Rowlett Bikes','(972) 530-5555','rowlett@bikes.shop','8000 Fairway Avenue', 'Rowlett','TX',75088);


-- production.stocks 
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,1,27);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,2,5);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,3,6);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,4,23);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,5,22);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,6,0);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,7,8);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,8,0);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,9,11);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,10,15);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,11,8);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,12,16);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,13,13);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,14,8);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,15,3);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,16,4);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,17,2);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,18,16);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,19,4);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(1,20,26);

SET IDENTITY_INSERT sales.staffs ON;  

INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(1,'Fabiola','Jackson','fabiola.jackson@bikes.shop','(831) 555-5554',1,1,NULL);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(2,'Mireya','Copeland','mireya.copeland@bikes.shop','(831) 555-5555',1,1,1);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(3,'Genna','Serrano','genna.serrano@bikes.shop','(831) 555-5556',1,1,2);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(4,'Virgie','Wiggins','virgie.wiggins@bikes.shop','(831) 555-5557',1,1,2);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(5,'Jannette','David','jannette.david@bikes.shop','(516) 379-4444',1,2,1);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(6,'Marcelene','Boyer','marcelene.boyer@bikes.shop','(516) 379-4445',1,2,5);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(7,'Venita','Daniel','venita.daniel@bikes.shop','(516) 379-4446',1,2,5);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(8,'Kali','Vargas','kali.vargas@bikes.shop','(972) 530-5555',1,3,1);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(9,'Layla','Terrell','layla.terrell@bikes.shop','(972) 530-5556',1,3,7);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(10,'Bernardine','Houston','bernardine.houston@bikes.shop','(972) 530-5557',1,3,7);

SET IDENTITY_INSERT sales.staffs OFF;  

SET IDENTITY_INSERT sales.orders ON;  

INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) 
VALUES(1,1,4,'20160101','20160103','20160103',1,2);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) 
VALUES(2,2,4,'20160101','20160104','20160103',2,6);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) 
VALUES(3,3,4,'20160102','20160105','20160103',2,7);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) 
VALUES(4,4,4,'20160103','20160104','20160105',1,3);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) 
VALUES(5,5,4,'20160103','20160106','20160106',2,6);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) 
VALUES(6,6,4,'20170104','20170107','20170105',2,6);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) 
VALUES(7,1,4,'20170104','20170107','20170105',2,6);

SET IDENTITY_INSERT sales.orders OFF;  

INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(1,1,20,1,599.99,0.2);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(1,2,8,2,1799.99,0.07);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(1,3,10,2,1549.00,0.05);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(1,4,16,2,599.99,0.05);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(1,5,4,1,2899.99,0.2);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(2,1,20,1,599.99,0.07);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(2,2,16,2,599.99,0.05);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(3,1,3,1,999.99,0.05);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(3,2,20,1,599.99,0.05);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(4,1,2,2,749.99,0.1);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(5,1,10,2,1549.00,0.05);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(5,2,17,1,429.00,0.07);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(5,3,20,1,599.99,0.07);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(6,1,18,1,449.00,0.07);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(6,2,12,2,549.99,0.05);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(6,3,20,1,599.99,0.1);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(6,4,3,2,999.99,0.07);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(6,5,9,2,2999.99,0.07);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(7,1,15,1,529.99,0.07);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(7,2,3,1,999.99,0.1);

SELECT product_name,list_price
FROM production.products
Where list_price > (
	SELECT AVG(list_price)
	FROM production.products
	WHERE brand_id in (
		SELECT brand_id
		FROM production.brands
		WHERE brand_name = 'Strider' OR brand_name = 'Trek'
		)
	);
SELECT Order_id, Order_date,(
	SELECT MAX(list_price)
	FROM sales.order_items i
	WHERE i.order_id = o.order_id
)	AS max_list_price
FROM sales.orders o;

SELECT AVG(CAST(order_count as float)) average_order_count		--CAST �p ki?u d? li?u
FROM (
	SELECT staff_id, COUNT(order_id) order_count
	FROM sales.orders
	GROUP BY staff_id
) T;

SELECT customer_id, first_name, last_name, city
FROM sales.customers c
WHERE (
	EXISTS (			
	SELECT customer_id
	FROM sales.orders o
	WHERE o.customer_id = c.customer_id AND YEAR(order_date) = 2017
	)
);

SELECT staff_id, COUNT(order_id) order_count
FROM sales.orders
GROUP BY staff_id
	HAVING COUNT(order_id) >= ALL (
		SELECT COUNT(order_id) order_count
		FROM sales.orders
		GROUP BY staff_id
);

CREATE FUNCTION sales.udfNetSale(
	@quantity INT, @list_price DEC(10,2), @discount DEC(4,2)
) RETURNS DEC(10,2)
AS
BEGIN
	DECLARE @result DEC(10,2)
	SET @result = @quantity * @list_price * (1 - @discount)
	RETURN @result
END


SELECT CONCAT(c.first_name,' ',c.last_name) AS CustomerName, c.email, o.order_id, (
	SELECT SUM(sales.udfNetSale(quantity,list_price, discount)) net_amount
	FROM sales.order_items oi
	WHERE oi.order_id = o.order_id
	GROUP BY order_id
) 'TotalNetAmount'
FROM sales.customers c
INNER JOIN sales.orders o ON c.customer_id = o.customer_id
WHERE c.customer_id = 1;

DROP PROCEDURE uspFindProducts;
CREATE PROCEDURE uspFindProducts(
	@min_list_price AS DECIMAL,
	@max_list_price AS DECIMAL,
	@name AS varchar(max)
)
AS
BEGIN
	SELECT product_name, list_price
	FROM production.products
	WHERE list_price >= @min_list_price AND list_price <= @max_list_price
		AND product_name LIKE '%' + @name + '%'
	ORDER BY list_price;
END;

EXEC uspFindProducts 
	300,1000,'Trek';

CREATE TRIGGER trCheckQuantity on sales.order_items AFTER INSERT, UPDATE
AS
	DECLARE @ID_product int
	DECLARE @quantity int
	DECLARE @selling int

	SELECT @ID_product = Inserted.product_id,
	@selling = inserted.quantity
	FROM inserted --order_items

	Select @quantity = s.quantity
	FROM production.products p INNER JOIN production.stocks s ON p.product_id = s.product_id
	WHERE s.product_id = @ID_product;

	IF(@selling > @quantity)
	BEGIN
		print('Quantity is NOT enough to sell')
		ROLLBACK TRANSACTION
	END