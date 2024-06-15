drop table shop_buy;

purge recyclebin;

create table shop_buy(
	buy_id varchar2(20),
	buy_productcode number(30),
	buy_productname varchar2(100),
	buy_productimg varchar2(100),
	buy_cnt number(20),
	buy_price number(20),
	buy_addr varchar2(100)
);

/*
create table shop_buy(
buy_id varchar2(20), --아이디
buy_productcode varchar2 -- 상품코드
buy_cnt number--개수
buy_price number--가격
buy_addr varchar2--주소
)
*/