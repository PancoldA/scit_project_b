
/* Drop Tables */

DROP TABLE categoryinfo CASCADE CONSTRAINTS;
DROP TABLE news CASCADE CONSTRAINTS;
DROP TABLE posting CASCADE CONSTRAINTS;
DROP TABLE userresume CASCADE CONSTRAINTS;
DROP TABLE userinfo CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_categoryInfo_category_no;
DROP SEQUENCE SEQ_news_newsno;
DROP SEQUENCE SEQ_userresume_resume_no;




/* Create Sequences */

CREATE SEQUENCE SEQ_categoryInfo_category_no INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_news_newsno INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_userresume_resume_no INCREMENT BY 1 START WITH 1;



/* Create Tables */

-- 카테고리
CREATE TABLE categoryinfo
(
	-- category_no : 카테고리 넘버
	category_no number NOT NULL,
	-- category_list : 카테고리
	category_list varchar2(12) NOT NULL,
	-- 단어 : 단어
	category_word varchar2(12) NOT NULL,
	-- 언급수 : 언급된 횟수
	category_count number NOT NULL,
	PRIMARY KEY (category_no)
);


-- 기업 뉴스
CREATE TABLE news
(
	-- 일련 번호 : 일련 번호
	newsno number NOT NULL,
	-- 뉴스 기사 등록일 : 뉴스 기사 날짜
	newsdate varchar2(20),
	-- 카테고리 : 카테고리
	popular varchar2(20),
	-- 뉴스 타이틀 : 뉴스 타이틀
	subject varchar2(300),
	-- 뉴스 기사 내용 : 뉴스 기사 내용
	article clob,
	-- sentiment : 감정 분석
	sentiment number,
	-- 언론사
	company varchar2(20),
	-- 이미지 : 이미지 주소
	imgurl varchar2(300),
	-- linkurl : 기사 본문 주소
	linkurl varchar2(200),
	PRIMARY KEY (newsno)
);


-- 채용 공고
CREATE TABLE posting
(
	-- 채용 공고 id : 채용 공고 id
	posting_id number NOT NULL,
	-- 채용공고 제목 : 채용공고 제목
	posting_title varchar2(300) NOT NULL,
	-- 채용공고 진행여부 : 채용공고 진행여부
	posting_active number NOT NULL,
	-- 채용공고 기업명 : 채용공고 기업명
	posting_company varchar2(100) NOT NULL,
	-- 채용공고 근무지 : 채용공고 근무지
	posting_location varchar2(255) NOT NULL,
	-- 채용공고 경력코드 : 채용공고 경력코드
	posting_career_code number NOT NULL,
	-- 채용공고 학력코드 : 채용공고 학력코드
	posting_education_code number NOT NULL,
	-- 채용공고 근무형태 : 채용공고 근무형태
	posting_type varchar2(500) NOT NULL,
	-- 채용공고 키워드 : 채용공고 키워드
	posting_keyword varchar2(4000) NOT NULL,
	-- 채용공고 직종 : 채용공고 직종
	posting_job_category varchar2(1000) NOT NULL,
	-- 채용공고 URL : 채용공고 URL
	posting_url varchar2(200) NOT NULL,
	PRIMARY KEY (posting_id)
);


-- 유저 정보
CREATE TABLE userinfo
(
	-- 이메일 : 소셜 로그인 또는 자체가입 시 이메일 인증
	user_email varchar2(30) NOT NULL,
	-- 비밀번호 : 소셜 로그인일 경우 null
	password varchar2(10),
	-- 유저 이름 : 유저 이름
	user_name varchar2(15),
	-- 회원가입 일 : 회원가입 일
	user_regist_date date DEFAULT sysdate NOT NULL,
	-- 회원 정보 수정일 : 회원 정보 수정일
	user_modify_date date DEFAULT sysdate,
	-- 유저 sns 키 : 유저 sns 키
	user_sns_key varchar2(300),
	-- 유저 sns 타입 : 유저 sns 타입
	user_sns_type varchar2(10),
	PRIMARY KEY (user_email)
);


-- 유저 이력서
CREATE TABLE userresume
(
	-- 이력서 일련 번호 : 이력서 일련 번호 sequence
	resume_no number NOT NULL,
	-- 이메일 : 소셜 로그인 또는 자체가입 시 이메일 인증
	user_email varchar2(30) NOT NULL,
	-- resume_title
	resume_title varchar2(100) NOT NULL,
	-- 이력서 내용 : 이력서 내용
	resume_content varchar2(4000) NOT NULL,
	-- 카테고리 타입
	category_list varchar2(12) NOT NULL,
	-- 이력서 등록일 : 이력서 등록일
	resume_regist_date date DEFAULT SYSDATE NOT NULL,
	-- 이력서 최종 수정일 : 이력서 최종 수정일
	resume_modify_date date DEFAULT SYSDATE,
	PRIMARY KEY (resume_no)
);



/* Create Foreign Keys */

ALTER TABLE userresume
	ADD FOREIGN KEY (user_email)
	REFERENCES userinfo (user_email)
	ON DELETE CASCADE
;



/* Comments */

COMMENT ON TABLE categoryinfo IS '카테고리';
COMMENT ON COLUMN categoryinfo.category_no IS 'category_no : 카테고리 넘버';
COMMENT ON COLUMN categoryinfo.category_list IS 'category_list : 카테고리';
COMMENT ON COLUMN categoryinfo.category_word IS '단어 : 단어';
COMMENT ON COLUMN categoryinfo.category_count IS '언급수 : 언급된 횟수';
COMMENT ON TABLE news IS '기업 뉴스';
COMMENT ON COLUMN news.newsno IS '일련 번호 : 일련 번호';
COMMENT ON COLUMN news.newsdate IS '뉴스 기사 등록일 : 뉴스 기사 날짜';
COMMENT ON COLUMN news.popular IS '카테고리 : 카테고리';
COMMENT ON COLUMN news.subject IS '뉴스 타이틀 : 뉴스 타이틀';
COMMENT ON COLUMN news.article IS '뉴스 기사 내용 : 뉴스 기사 내용';
COMMENT ON COLUMN news.sentiment IS 'sentiment : 감정 분석';
COMMENT ON COLUMN news.company IS '언론사';
COMMENT ON COLUMN news.imgurl IS '이미지 : 이미지 주소';
COMMENT ON COLUMN news.linkurl IS 'linkurl : 기사 본문 주소';
COMMENT ON TABLE posting IS '채용 공고';
COMMENT ON COLUMN posting.posting_id IS '채용 공고 id : 채용 공고 id';
COMMENT ON COLUMN posting.posting_title IS '채용공고 제목 : 채용공고 제목';
COMMENT ON COLUMN posting.posting_active IS '채용공고 진행여부 : 채용공고 진행여부';
COMMENT ON COLUMN posting.posting_company IS '채용공고 기업명 : 채용공고 기업명';
COMMENT ON COLUMN posting.posting_location IS '채용공고 근무지 : 채용공고 근무지';
COMMENT ON COLUMN posting.posting_career_code IS '채용공고 경력코드 : 채용공고 경력코드';
COMMENT ON COLUMN posting.posting_education_code IS '채용공고 학력코드 : 채용공고 학력코드';
COMMENT ON COLUMN posting.posting_type IS '채용공고 근무형태 : 채용공고 근무형태';
COMMENT ON COLUMN posting.posting_keyword IS '채용공고 키워드 : 채용공고 키워드';
COMMENT ON COLUMN posting.posting_job_category IS '채용공고 직종 : 채용공고 직종';
COMMENT ON COLUMN posting.posting_url IS '채용공고 URL : 채용공고 URL';
COMMENT ON TABLE userinfo IS '유저 정보';
COMMENT ON COLUMN userinfo.user_email IS '이메일 : 소셜 로그인 또는 자체가입 시 이메일 인증';
COMMENT ON COLUMN userinfo.password IS '비밀번호 : 소셜 로그인일 경우 null';
COMMENT ON COLUMN userinfo.user_name IS '유저 이름 : 유저 이름';
COMMENT ON COLUMN userinfo.user_regist_date IS '회원가입 일 : 회원가입 일';
COMMENT ON COLUMN userinfo.user_modify_date IS '회원 정보 수정일 : 회원 정보 수정일';
COMMENT ON COLUMN userinfo.user_sns_key IS '유저 sns 키 : 유저 sns 키';
COMMENT ON COLUMN userinfo.user_sns_type IS '유저 sns 타입 : 유저 sns 타입';
COMMENT ON TABLE userresume IS '유저 이력서';
COMMENT ON COLUMN userresume.resume_no IS '이력서 일련 번호 : 이력서 일련 번호 sequence';
COMMENT ON COLUMN userresume.user_email IS '이메일 : 소셜 로그인 또는 자체가입 시 이메일 인증';
COMMENT ON COLUMN userresume.resume_title IS 'resume_title';
COMMENT ON COLUMN userresume.resume_content IS '이력서 내용 : 이력서 내용';
COMMENT ON COLUMN userresume.category_list IS '카테고리 타입';
COMMENT ON COLUMN userresume.resume_regist_date IS '이력서 등록일 : 이력서 등록일';
COMMENT ON COLUMN userresume.resume_modify_date IS '이력서 최종 수정일 : 이력서 최종 수정일';



