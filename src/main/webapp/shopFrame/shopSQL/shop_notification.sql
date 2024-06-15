drop table shop_notification;

purge recyclebin;

create table SHOP_NOTIFICATION(
notification_no number(23) not null,
notification_subject varchar2(200) not null,
NOTIFICATION_id varchar2(15) not null,
NOTIFICATION_CONTENT varchar2(4000),
NOTIFICATION_date date default sysdate
);