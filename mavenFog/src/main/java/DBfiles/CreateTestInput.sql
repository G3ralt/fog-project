INSERT INTO users (account_id, email, password, first_name, last_name, phone_number, address, zip_code, role, creation_date, user_status) VALUES ('1', 'fog_admin@gmail.com', 'fog_admin', 'Admin', 'Fog', 12345678, 'Fog Admin 34', 3456, 2, CURDATE(), 1);
INSERT INTO users (account_id, email, password, first_name, last_name, phone_number, address, zip_code, role, creation_date, user_status) VALUES ('2', 'customer@gmail.com', 'customer', 'First', 'Customer', 12345678, 'Customer 34', 5555, 0, CURDATE(), 1);
INSERT INTO users (account_id, email, password, first_name, last_name, phone_number, address, zip_code, role, creation_date, user_status) VALUES ('3', 'customer2@gmail.com', 'customer2', 'Second', 'Customer', 23335577, 'Customer 22', 6666, 0, CURDATE(), 1);
INSERT INTO users (account_id, email, password, first_name, last_name, phone_number, address, zip_code, role, creation_date, user_status) VALUES ('4', 'andrian@fog.dk','69696969','Andrian','Vangelov',77733399,'@home123', 2200, 1, CURDATE(), 1);
INSERT INTO users (account_id, email, password, first_name, last_name, phone_number, address, zip_code, role, creation_date, user_status) VALUES ('5', 'patrick@fog.dk','69696969','Patrick','Fenger',11188555,'@home456', 2100, 1, CURDATE(), 1);
INSERT INTO users (account_id, email, password, first_name, last_name, phone_number, address, zip_code, role, creation_date, user_status) VALUES ('6', 'petru@fog.dk','69696969','Petru','Catana',00077999,'@home789', 2300, 1, CURDATE(), 1);
INSERT INTO users (account_id, email, password, first_name, last_name, phone_number, address, zip_code, role, creation_date, user_status) VALUES ('7', 'alexandar@fog.dk','69696969','Alexandar','Osenov',66699000,'@home101', 3460, 1, CURDATE(), 1);
INSERT INTO products (product_id, price, inner_height, width, length, has_shed, rooftop_type, name) VALUES ('1',3495.0, 2.5, 2.5, 6.5, 0, 0, 'CAR01');
INSERT INTO products (product_id, price, inner_height, width, length, has_shed, rooftop_type, shed_length, shed_width, name) VALUES ('2',7995.0, 3.3, 2.6, 7.3, 1, 0, 2.0, 2.0, 'CAR01R');
INSERT INTO products (product_id, price, inner_height, width, length, has_shed, rooftop_type, rooftop_angle, rooftop_height, name) VALUES ('3',12995.0, 4.3, 2.7, 5.3, 0, 1, 30, 0.5, 'CAR01H');
INSERT INTO products (product_id, price, inner_height, width, length, has_shed, rooftop_type, shed_length, shed_width, rooftop_angle, rooftop_height, name) VALUES ('4',18995.0, 5.3, 2.8, 8.3, 1, 1, 1.5, 1.5, 25, 0.8, 'CAR01HR');
INSERT INTO orders (order_id, creation_date, customer_id, order_status) VALUES ('1',CURDATE(), 2, 1);
INSERT INTO orders (order_id, creation_date, customer_id, order_status) VALUES ('2',CURDATE(), 2, 1);
INSERT INTO orders (order_id, creation_date, customer_id, order_status) VALUES ('3',CURDATE(), 3, 1);
INSERT INTO orders (order_id, creation_date, customer_id, order_status) VALUES ('4',CURDATE(), 3, 1);
INSERT INTO order_details (order_id, product_id) VALUES ('1','1');
INSERT INTO order_details (order_id, product_id) VALUES ('2','2');
INSERT INTO order_details (order_id, product_id) VALUES ('3','3');
INSERT INTO order_details (order_id, product_id) VALUES ('4','4');
INSERT INTO delivery (delivery_id, delivery_date, delivery_status, price) VALUES ('1','2017-05-05', 0, 250.0);
INSERT INTO delivery (delivery_id, delivery_date, delivery_status, price) VALUES ('2','2017-05-15', 0, 1475.0);
INSERT INTO delivery (delivery_id, delivery_date, delivery_status, price) VALUES ('3','2017-05-25', 0, 1875.0);
INSERT INTO delivery (delivery_id, delivery_date, delivery_status, price) VALUES ('4','2017-06-30', 0, 250.0);
INSERT INTO invoice (invoice_id, creation_date, total_price) VALUES ('1','2017-05-06', 3700.0);
INSERT INTO invoice (invoice_id, creation_date, total_price) VALUES ('2','2017-05-06', 8500.0);
INSERT INTO invoice (invoice_id, creation_date, total_price) VALUES ('3','2017-05-06', 15000.0);
INSERT INTO invoice (invoice_id, creation_date, total_price) VALUES ('4','2017-05-06', 19300.0);
UPDATE order_details SET sales_rep_id = '4', delivery_id ='1', invoice_id = '1' WHERE order_id = '1';
UPDATE order_details SET sales_rep_id = '5', delivery_id ='2', invoice_id = '2' WHERE order_id = '2';
UPDATE order_details SET sales_rep_id = '6', delivery_id ='3', invoice_id = '3' WHERE order_id = '3';
UPDATE order_details SET sales_rep_id = '7', delivery_id ='4', invoice_id = '4' WHERE order_id = '4';

