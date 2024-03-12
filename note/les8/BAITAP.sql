CREATE TABLE customers (
	customer_id int PRIMARY KEY,
	first_name nvarchar(255) NOT NULL,
	last_name nvarchar(255) NOT NULL,
	phone varchar(25),
	email varchar(255) NOT NULL,
	street varchar(255),
	city varchar(50),
	state varchar(25),
	zip_code varchar(5)
)
USE BikeStores

CREATE TABLE products (
	product_id int PRIMARY KEY,
	product_name varchar(255) not null,
	brand_id int not null,
	category_id int not null,
	model_year smallint not null,
	list_price decimal(10,2) not null
)
USE BikeStores

CREATE TABLE order_items (
	order_id int,
	item_id int,
	PRIMARY KEY(order_id,item_id),
	product_id int not null FOREIGN KEY
		REFERENCES products(product_id),
	quantity int not null,
	list_price decimal(10,2) not null,
	discount decimal(4,2) not null default((0))
)
USE BikeStores

CREATE TABLE brands (
	brand_id int PRIMARY KEY,
	brand_name varchar(255) not null
)
USE BikeStores

CREATE TABLE staffs (
	staff_id int PRIMARY KEY,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email varchar(255) not null,
	phone varchar(25),
	active tinyint not null,
	store_id int not null,
	manager_id int
)
USE BikeStores

CREATE TABLE categories (
	category_id int PRIMARY KEY,
	category_name varchar(255) not null
)
USE BikeStores

CREATE TABLE stores (
	store_id int PRIMARY KEY,
	store_name varchar(255) not null,
	phone varchar(25),
	email varchar(255),
	street varchar(255),
	city varchar(255),
	state varchar(10),
	zip_code varchar(5)
)
USE BikeStores

CREATE TABLE orders (
	order_id int PRIMARY KEY,
	customer_id int FOREIGN KEY
		REFERENCES customers(customer_id),
	order_status tinyint not null,
	order_date date not null,
	required_date date not null,
	shipped_date date,
	store_id int not null FOREIGN KEY
		REFERENCES stores(store_id),
	staff_id int not null FOREIGN KEY
		REFERENCES staffs(staff_id)
)
USE BikeStores
