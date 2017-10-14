create database [dbname];
flush privileges;
use mysql;
insert into user (Host, User, Password) VALUES ('%', '[db_user]', PASSWORD('[db_pwd]'));
flush privileges;
grant all privileges on [dbname].* to [db_user]@'%';
flush privileges;
exit
