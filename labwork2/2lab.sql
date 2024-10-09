--1
create database lab2;
--2
create table countries(
    country_id serial primary key,
    country_name varchar,
    region_id integer,
    population integer
);
Select * from countries;
--3
insert into countries(country_name, region_id, population) values('Germany',1,500000);
--4
insert into countries(country_id,country_name)values(2,'Korea');
--5
insert into countries(country_name,  population) values('Spain',1234000);

--6
insert into countries(country_name, region_id, population)
values
('Russia',2,570000),
('Kyrgyzstan',3,45000),
('England',4,34000);
--7
alter table countries
alter column country_name set default 'Kazakhstan';
--8
insert into countries(country_name, region_id, population) values(default,5,200000);

--9
insert into countries(country_name, region_id, population) values(default,default,default);

--10
CREATE  table countries_new  (like countries including  all);

--11
select * from countries_new;
insert into countries_new
select * from countries;

--12
update countries
set region_id=1
where region_id isnull;

--13
select country_name,
       population*1.1 as "New population"
from countries;

--14
delete from countries
where population<100000;

--15
delete from countries_new
where country_id in (Select country_id From countries)
returning *;

--16
delete  from countries_new
returning  *;
