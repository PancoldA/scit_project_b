drop table posting;
--채용공고 테이블 생성
create table posting(
posting_id number primary key,
posting_title varchar2(300) not null,
posting_active number not null,
posting_company varchar2(100) not null,
posting_location varchar2(255) not null,
posting_career_code number not null,
posting_education_code number not null,
posting_type varchar2(500) not null,
posting_keyword varchar2(4000) not null,
posting_job_category varchar2(1000) not null,
posting_url varchar2(200) not null
);