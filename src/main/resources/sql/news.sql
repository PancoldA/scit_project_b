--뉴스 테이블 생성
create table news(
    newsno number primary key,
    newsdate varchar2(20),
    popular varchar2(20),
    subject varchar2(300),
    article clob,
    sentiment number,
    company varchar2(20),
    imgurl varchar2(300));
create sequence news_seq;