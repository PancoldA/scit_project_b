create table user_table
(
    user_id number primary key,
    authorization_id varchar2(100) not null,  
    user_email varchar2(100) not null, 
	user_password varchar2(50) not null, 
	user_name varchar2(50), 
    user_create_date varchar2(50), 
	user_modify_date varchar2(50) ,
	user_emailauthkey varchar2(100) , 
	sns_key varchar2(100),
	sns_type varchar2(100), 
	helper varchar2(100) 
);