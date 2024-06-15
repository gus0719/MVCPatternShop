drop table shop_product;

purge recyclebin;

create table SHOP_PRODUCT(
	product_code number(20) not null,
	product_category varchar2(20) not null,
	product_brand varchar2(20) not null,
	product_name varchar2(100) not null,
	product_price number(10) not null,
	product_explain varchar2(1000) not null,
	product_seller varchar2(20) not null,
	product_date date default sysdate,
	product_img varchar2(1000) not null
);