drop table shop_interest;
purge recyclebin;

create table shop_interest(
	interest_id varchar2(20), 
	interest_product_code number(30),
	interest_product_name varchar2(100),
	interest_product_img varchar2(100)
);
/*
create table shop_interest(
interest_id varchar2(20),  --아이디
interest_productcode number(30), --상품코드
interest_product_name varchar2(30), -- 상품명
interest_product_img varchar2(30) -- 상품이미지
)*/