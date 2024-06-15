drop table shop_wiki;

purge recyclebin;

create table SHOP_WIKI(
	wiki_code number(20) not null,
	wiki_product_name varchar2(100) not null,
	wiki_text varchar2(4000) not null
);