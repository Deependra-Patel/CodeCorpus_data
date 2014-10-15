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
	attempted numeric(5)
);
create table problems(
	code varchar(50) primary key,
	name varchar(200),
	link varchar(300),
	doa date,
	difficulty numeric(1,0),
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
	userid varchar(20) primary key,
	rank numeric,
	personal personal_info,
	role boolean
);
create table tags(
	tagid numeric primary key,
	name varchar(100),
	description varchar(1000)
);

--Relation tables here
create table attempted(
	userid varchar(20) references users,
	code varchar(50) references problems,
	solved boolean,
	primary key (userid, code)
);

create table problems_tags(
	code varchar(50) references problems,
	tagid numeric references tags,
	primary key(code, tagid)
);

create table users_interests(
	userid varchar(20) references users,
	tagid numeric references tags
);

create table followers(
	follower varchar(20) references users(userid),
	followed varchar(20) references users(userid),
	primary key(follower, followed)		
);