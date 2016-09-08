create database theeverafter;
flush privileges;
use mysql;
insert into user (Host, User, Password) VALUES ('localhost', 'wp_user', PASSWORD('devpass'));
flush privileges;
grant all privileges on theeverafter.* to wp_user@localhost;
flush privileges;
exit
