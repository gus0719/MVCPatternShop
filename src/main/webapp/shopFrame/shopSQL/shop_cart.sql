drop table SHOP_CART;
purge recyclebin;

CREATE TABLE SHOP_CART (
	cart_id varchar2(20),
	cart_code number(20),
	cart_product_name varchar2(100),
	cart_product_img varchar2(100),
	cart_num number(10)
);

/*
CREATE TABLE SHOP_CART (
	cart_id varchar2(20),			-- 아이디
	cart_code number(20),	-- 상품 코드
	cart_productname varchar2(30), -- 상품명
	cart_productimg varchar2(30), -- 상품이미지
	cart_num number					-- 개수
);
*/