# Tạo các bảng dữ liệu cho cơ sở dữ liệu

use project2_db;

# Tạo bảng thông tin về địa lý
DROP TABLE IF EXISTS geolocations;
CREATE TABLE geolocations (
    geolocation_zip_code_prefix varchar(50) NOT NULL,
    geolocation_lat float,
    geolocation_lng float,
    geolocation_city varchar(255),
    geolocation_state varchar(50),
    PRIMARY KEY (geolocation_zip_code_prefix)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Tạo bảng dữ liệu thông tin khách hàng "customers"
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id varchar(50) NOT NULL,
    customer_unique_id varchar(50),
    customer_zip_code_prefix varchar(50),
    customer_city varchar(255),
    customer_state varchar(255),
    PRIMARY KEY (customer_id),
    FOREIGN KEY (customer_zip_code_prefix) REFERENCES geolocations(geolocation_zip_code_prefix)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Tạo bảng thông tin về người bán hàng
DROP TABLE IF EXISTS sellers;
CREATE TABLE sellers (
    seller_id varchar(50) NOT NULL,
    seller_zip_code_prefix varchar(255),
    seller_city varchar(255),
    seller_state varchar(50),
    PRIMARY KEY (seller_id),
    FOREIGN KEY (seller_zip_code_prefix) REFERENCES geolocations(geolocation_zip_code_prefix)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Tạo bảng thông tin về bảng dịch tên sản phẩm từ tiếng bồ đào nha sang tiếng anh
DROP TABLE IF EXISTS product_translation;
CREATE TABLE product_translation(
    product_category_name varchar(255) NOT NULL,
    product_category_name_english varchar(255),
    PRIMARY KEY (product_category_name)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Tạo bảng thông tin về chi tiết sản phẩm
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id varchar(50) NOT NULL,
    product_category_name varchar(255),
    product_name_lenght int,
    product_description_lenght int,
    product_photos_qty int,
    product_weight_g float,
    product_length_cm float,
    product_height_cm float,
    product_width_cm float,
    PRIMARY KEY (product_id),
    FOREIGN KEY (product_category_name) REFERENCES product_translation(product_category_name)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Tạo bảng thông tin về đơn hàng
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (
    order_id varchar(50) NOT NULL,
    order_item_id varchar(50),
    product_id varchar(50),
    seller_id varchar(255),
    shipping_limit_date datetime,
    price float,
    freight_value float,
    PRIMARY KEY (order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Tạo bảng thông tin về thanh toán
DROP TABLE IF EXISTS order_payments;
CREATE TABLE order_payments (
    order_id varchar(50) NOT NULL,
    payment_sequential int,
    payment_type varchar(50),
    payment_installments int,
    payment_value float,
    PRIMARY KEY (order_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Tạo bảng thông tin về sự đánh giá phản hồi của khách hàng
DROP TABLE IF EXISTS order_reviews;
CREATE TABLE order_reviews (
    review_id VARCHAR(50) NOT NULL,
    order_id VARCHAR(50) NOT NULL,
    review_score INT,
    review_comment_title VARCHAR(50),
    review_comment_message VARCHAR(255),
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME,
    PRIMARY KEY (order_id)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

# Tạo bảng thông tin về chi tiết đơn đặt hàng
DROP TABLE IF EXISTS order_details;
CREATE TABLE order_details(
    order_id VARCHAR(50) NOT NULL,
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME,
    PRIMARY KEY (order_id),
    CONSTRAINT order_details_ibfk_1 FOREIGN KEY (order_id) REFERENCES order_reviews (order_id),
    CONSTRAINT order_details_ibfk_2 FOREIGN KEY (order_id) REFERENCES order_payments (order_id),
    CONSTRAINT order_details_ibfk_3 FOREIGN KEY (order_id) REFERENCES order_items (order_id),
    CONSTRAINT order_details_ibfk_4 FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;








