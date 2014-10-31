drop table attempted;
drop table problems_tags;
drop table users_interests;
drop table followers;
drop table problems;
drop table users;
drop table tags;
drop type stats;
drop type personal_info;

create type stats as(
	solved numeric(5),
	accuracy numeric(5,2)
);
create table problems(
	code varchar(50) primary key,
	name varchar(200),
	link varchar(300),
	doa date,
	difficulty varchar(20),
	statistic stats
);

create type personal_info as(
	name varchar(100),
	dob date,
	region varchar(100),
	email_id varchar(50),
	institution varchar(200)
); 

create table users(
	userid serial primary key,
	handle varchar(30) unique not null,
	passwd varchar(100),
	rank numeric,
	role boolean,
	personal personal_info 
);
create table tags(
	tagid numeric primary key,
	name varchar(100),
	description varchar(1000)
);

--Relation tables here
create table attempted(
	userid int references users ON DELETE CASCADE,
	code varchar(50) references problems ON DELETE CASCADE,
	solved boolean,
	primary key (userid, code)
);

create table problems_tags(
	code varchar(50) references problems ON DELETE CASCADE,
	tagid numeric references tags ON DELETE CASCADE,
	primary key(code, tagid)
);

create table users_interests(
	userid serial references users ON DELETE CASCADE,
	tagid numeric references tags ON DELETE CASCADE
);

create table followers(
	follower serial references users(userid) ON DELETE CASCADE,
	followed serial references users(userid) ON DELETE CASCADE,
	primary key(follower, followed)		
);