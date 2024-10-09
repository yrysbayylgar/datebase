Drop database if exists lab1;
Create database lab1;
Drop table if exists users;
Create table users(
    id serial,
    firstname varchar(50),
    lastname varchar(50)
);

alter table users
add column isadmin int ;



alter table users
alter column isadmin type bool   using isadmin::Boolean;

alter table users
alter column isadmin set default false;

alter table users
add constraint  users_pkey  primary key(id);

drop table if exists tasks;
create  table tasks(
    id serial,
    name varchar(50),
    user_id int
);

drop  table tasks;

drop database lab1;











