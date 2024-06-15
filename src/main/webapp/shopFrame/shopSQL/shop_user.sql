drop table SHOP_USER;
purge recyclebin;

CREATE TABLE SHOP_USER (
	user_id varchar2 (20),
	user_pwd varchar2 (20) not null,
	user_name varchar2 (10) not null,
	user_phone varchar2 (20) not null,
	user_email varchar2 (20) not null,
	user_addr varchar2 (100) not null,
	user_rank varchar2(30)
);

/*
 CREATE TABLE SHOP_USER (
	user_id varchar2 (20), 					-- 아이디
	user_pwd varchar2 (20) not null,	-- 비밀번호
	user_name varchar2 (10) not null,	-- 이름
	user_phone varchar2 (15) not null,	-- 전화번호
	user_email varchar2 (20) not null,	-- 이메일
	user_addr varchar2 (100) not null,	-- 주소
	user_rank varchar2(30)					-- 등급
);
  */

