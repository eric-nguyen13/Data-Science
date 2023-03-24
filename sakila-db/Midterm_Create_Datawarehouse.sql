# Eric Nguyen - wvu9cs
# DS 2002: Midterm Project
# Due: 03/16/23

# ----------------------------------------------

#DROP database `sakila_dw`;
CREATE DATABASE `Sakila_DW` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;

# ---------------------------------------------- Create Tables







#DROP TABLE `dim_stores`;
CREATE TABLE `dim_stores` (
  `store_id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `manager_staff_id` tinyint unsigned NOT NULL,
  `address_id` smallint unsigned NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`store_id`),
  UNIQUE KEY `idx_unique_manager` (`manager_staff_id`),
  KEY `idx_fk_address_id` (`address_id`)
  #CONSTRAINT `fk_store_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  #CONSTRAINT `fk_store_staff` FOREIGN KEY (`manager_staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


#DROP TABLE `dim_rentals`;
CREATE TABLE `dim_rentals` (
  `rental_id` int NOT NULL AUTO_INCREMENT,
  `rental_date` datetime NOT NULL,
  `inventory_id` mediumint unsigned NOT NULL,
  `customer_id` smallint unsigned NOT NULL,
  `return_date` datetime DEFAULT NULL,
  `staff_id` tinyint unsigned NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rental_id`),
  UNIQUE KEY `rental_date` (`rental_date`,`inventory_id`,`customer_id`),
  KEY `idx_fk_inventory_id` (`inventory_id`),
  KEY `idx_fk_customer_id` (`customer_id`),
  KEY `idx_fk_staff_id` (`staff_id`)
  #CONSTRAINT `fk_rental_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  #CONSTRAINT `fk_rental_inventory` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  #CONSTRAINT `fk_rental_staff` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16050 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


# DROP TABLE `fact_sales`;
CREATE TABLE `fact_sales` (
	`fact_sales_key` int NOT NULL AUTO_INCREMENT, # New Primary Key
    `store_id` int DEFAULT NULL,
    `rental_id` int DEFAULT NULL,
    #`date_id` int DEFAULT NULL,
	`order_date` datetime DEFAULT NULL,
	`rental_duration` decimal(18,4) NOT NULL DEFAULT '0.0000',
    `return_date` datetime DEFAULT NULL,
    `rental_rate` decimal(18,4) NOT NULL DEFAULT '0.0000',
    `late_fee_rate` decimal(19,4) DEFAULT '0.0000',
    `discount_rate` double NOT NULL DEFAULT '0',
    `taxes` decimal(19,4) DEFAULT '0.0000',
    `total_payment_amount` decimal(19,4) DEFAULT '0.0000',
    PRIMARY KEY (`fact_order_key`),
    KEY `store_id` (`store_id`),
    KEY `rental_id` (`rental_id`)
    #KEY `date_id` (`date_id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4;

TRUNCATE TABLE `sakila_dw`.`fact_sales`;


# ---------------------------------------------- Populate Tables

INSERT INTO `sakila_dw`.`dim_stores`
(`store_id`,
`manager_staff_id`,
`address_id`,
`last_update`)
SELECT `store_id`,
`manager_staff_id`,
`address_id`,
`last_update`
FROM sakila.store;

SELECT * FROM sakila_dw.dim_stores;

INSERT INTO `sakila_dw`.`dim_rentals`
(`rental_id`,
`rental_date`,
`inventory_id`,
`customer_id`,
`return_date`,
`staff_id`,
`last_update`)
SELECT `rental_id`,
`rental_date`,
`inventory_id`,
`customer_id`,
`return_date`,
`staff_id`,
`last_update`
FROM sakila.rental;

SELECT * FROM sakila_dw.dim_rentals;






