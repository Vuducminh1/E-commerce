# Tạo các bảng dữ liệu cho Cơ sở dữ liệu OLAP

use olap_project2_version2;

# Tạo các bảng Dimension

# Tạo bảng dim_payments
DROP TABLE IF EXISTS dim_payments;
CREATE TABLE dim_payments (
	order_id varchar(50) not null,
    payment_type varchar(50) null,
    pay_ins_type varchar(50) null,
    PRIMARY KEY (order_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Tạo bảng dim_product
DROP TABLE IF EXISTS dim_products;
CREATE TABLE dim_products (
	product_id int not null,
    product_name varchar(50) null,
    product_line varchar(50) null,
    product_size varchar(50) null,
    PRIMARY KEY (product_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Tạo bảng dim_review_score
DROP TABLE IF EXISTS dim_review_score;
CREATE TABLE dim_review_score (
    review_score int not null,
    PRIMARY KEY (review_score)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Tạo bảng dim_seller
DROP TABLE IF EXISTS dim_seller;
CREATE TABLE dim_seller (
    seller_id varchar(50) not null,
    seller_city varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci null,
    seller_state varchar(50) null,
    PRIMARY KEY (seller_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Tạo bảng dim_customer
DROP TABLE IF EXISTS dim_customer;
CREATE TABLE dim_customer (
    customer_id varchar(50) not null,
    customer_city varchar(255) null,
    customer_state varchar(50) null,
    PRIMARY KEY (customer_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Tạo bảng dim_date
DROP TABLE IF EXISTS dim_date;
CREATE TABLE dim_date (
    date_id date not null,
    day int not null,
    month int not null,
    quarter int not null,
    year int not null,
    PRIMARY KEY (date_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Tạo bảng dim_order_status
DROP TABLE IF EXISTS dim_order_status;
CREATE TABLE dim_order_status (
    order_status varchar(50) not null,
    PRIMARY KEY (order_status)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Tạo các bảng Fact

# Tạo bảng Fact_orders
DROP TABLE IF EXISTS fact_orders;
CREATE TABLE fact_orders (
    order_id varchar(50) not null,
    customer_id varchar(50) null,
    order_status varchar(50) null,
    orderDate date null,
    review_score int null,
    deliveryTime float null,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customer (customer_id),
    FOREIGN KEY (order_status) REFERENCES dim_order_status (order_status),
    FOREIGN KEY (order_id) REFERENCES dim_payments (order_id),
    FOREIGN KEY (orderDate) REFERENCES dim_date (date_id),
    FOREIGN KEY (review_score) REFERENCES dim_review_score (review_score)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Tạo bảng Fact_sales
DROP TABLE IF EXISTS fact_sales;
CREATE TABLE fact_sales (
	sales_id varchar(50) not null,
    order_id varchar(50) not null,
    seller_id varchar(50) null,
    customer_id varchar(50) null,
    product_id int null,
    dateTimes date null,
    sales float,
    PRIMARY KEY (sales_id),
    FOREIGN KEY (seller_id) REFERENCES dim_seller (seller_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customer (customer_id),
    FOREIGN KEY (product_id) REFERENCES dim_products (product_id),
    FOREIGN KEY (order_id) REFERENCES dim_payments (order_id),
    FOREIGN KEY (dateTimes) REFERENCES dim_date (date_id),
    FOREIGN KEY (order_id) REFERENCES fact_orders (order_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


