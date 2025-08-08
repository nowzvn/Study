create table book_list (
	book_no 	varchar(16) not null, 
	book_name	varchar(50),
	writer 		varchar(50),
	publisher 	varchar(30),
	reg_data 	date,
	price 		int	
);

show databases;
use mysql;

select * from book_list;

insert into book_list values ('123123123', '세이노의가르침', '세이노', '데이원','20230302','7200');

alter table book_list add column description varchar(1000);

alter table book_list modify column book_name varchar(100);

desc book_list

alter table book_list change column description book_desc varchar(1000);

alter table book_list drop column book_desc;

alter table book_list rename book_info;

select * from book_info;

-- 모든 데이터 삭제, 롤백 불가능(신중)
-- delete보다 빠르기때문에 대용량 삭제
truncate table book_info;

-- 테이블과 정보 전부 삭제
drop table book_info;

-- 없어짐
select * from book_info;