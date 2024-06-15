-- PL / SQL
delete from shop_notification;

drop sequence notification_seq;
create sequence notification_seq
	start with 1
	minvalue 1
	increment by 1;

declare
	type userList is table of shop_user.user_name%type
	index by binary_integer;
	
	idx binary_integer := -1;
	idx2 binary_integer := -1;
	userId userList;
begin
	for i in 0 .. 254 loop
		idx := idx + 1;
		for users in (select user_id from shop_user) loop
			idx2 := idx2 + 1;
			userId(idx2) := users.user_id;
		end loop;
		insert into shop_notification
		values(
			notification_seq.nextval,
			notification_seq.currval || '번째 글',
			userId(MOD(idx, idx2)),
			notification_seq.currval || '번째 글입니다',
			sysdate - idx
		);
		idx2 := -1;
	end loop;
end;