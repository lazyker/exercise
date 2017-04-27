SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS H_COMPANY_USER;
DROP TABLE IF EXISTS H_RECRUIT;
DROP TABLE IF EXISTS H_USER;
DROP TABLE IF EXISTS I_ATTACH;
DROP TABLE IF EXISTS I_BOARD;
DROP TABLE IF EXISTS I_COMMENT;
DROP TABLE IF EXISTS I_COMPANY;
DROP TABLE IF EXISTS I_CONSULTANT;
DROP TABLE IF EXISTS I_HOLIDAY;
DROP TABLE IF EXISTS I_JOB_CD;
DROP TABLE IF EXISTS I_KPI;
DROP TABLE IF EXISTS I_LOGIN_INFO;
DROP TABLE IF EXISTS I_MARK;
DROP TABLE IF EXISTS I_PERSON;
DROP TABLE IF EXISTS I_POSITION;
DROP TABLE IF EXISTS I_PRO_STATUS;
DROP TABLE IF EXISTS I_REC_PRESENT;
DROP TABLE IF EXISTS I_SCHEDULE;
DROP TABLE IF EXISTS I_USER;
DROP TABLE IF EXISTS I_USER_ACADEMIC;




/* Create Tables */

-- 홈페이지-기업회원
CREATE TABLE H_COMPANY_USER
(
	COM_USR_ID varchar(11) COMMENT '기업회원 아이디',
	PASSWORD varchar(62) COMMENT '비밀번호',
	COM_NM varchar(30) COMMENT '회사명',
	SALES varchar(20) COMMENT '매출액',
	PEOPLE varchar(20) COMMENT '인원',
	MAJOR varchar(100) COMMENT '주요사업',
	URL varchar(40) COMMENT '홈페이지 주소',
	HR_NM varchar(20) COMMENT '인사담당자 이름',
	HR_RANK varchar(20) COMMENT '인사담당자 직급',
	HR_PHONE varchar(128) COMMENT '인사담당자 전화번호',
	HR_MOBILE varchar(128) COMMENT '인사담당자 휴대폰',
	HR_EMAIL varchar(128) COMMENT '인사담당자 이메일',
	REG_DATE datetime COMMENT '가입일시',
	MOD_DATE datetime COMMENT '수정일시',
	DEL_DATE datetime COMMENT '탈퇴여부'
) COMMENT = '홈페이지-기업회원';


-- 홈페이지-채용의뢰
CREATE TABLE H_RECRUIT
(
	REC_ID int NOT NULL COMMENT '채용의뢰 아이디',
	COM_NM varchar(30) COMMENT '회사명',
	SALES varchar(20) COMMENT '매출액',
	PEOPLE varchar(10) COMMENT '인원',
	MAJOR varchar(100) COMMENT '주요사업',
	URL varchar(40) COMMENT '홈페이지 주소',
	HR_NM varchar(20) COMMENT '인사담당자 이름',
	HR_RANK varchar(20) COMMENT '인사담당자 직급',
	HR_PHONE varchar(128) COMMENT '인사담당자 전화번호',
	HR_MOBILE varchar(128) COMMENT '인사담당자 휴대폰',
	HR_EMAIL varchar(128) COMMENT '인사담당자 이메일',
	POS_NM varchar(20) COMMENT '포지션 이름',
	RANK varchar(20) COMMENT '직급',
	DUTY varchar(20) COMMENT '직책',
	DEPT_NM varchar(20) COMMENT '근무부서',
	DEPT_PLACE varchar(20) COMMENT '근무지',
	TASK varchar(20000) COMMENT '업무내용',
	REC_CONDITION varchar(20000) COMMENT '자격요건',
	SALARY varchar(20) COMMENT '연봉수준',
	WELFARE varchar(100) COMMENT '복리후생',
	ETC varchar(20000) COMMENT '기타',
	REG_DATE datetime COMMENT '등록일시',
	PRIMARY KEY (REC_ID)
) COMMENT = '홈페이지-채용의뢰';


-- 홈페이지-개인회원
CREATE TABLE H_USER
(
	USR_ID varchar(11) COMMENT '후보자 아이디',
	PASSWORD varchar(62) COMMENT '비밀번호',
	USER_NM varchar(20) COMMENT '성명',
	GENDER char COMMENT '성별',
	MOBILE varchar(128) COMMENT '휴대폰',
	PHONE varchar(128) COMMENT '전화번호',
	EMAIL varchar(128) COMMENT '이메일',
	REG_DATE datetime COMMENT '가입일시',
	DEL_DATE datetime COMMENT '탈퇴여부'
) COMMENT = '홈페이지-개인회원';


-- 파일첨부
CREATE TABLE I_ATTACH
(
	ATT_ID varchar(11) NOT NULL COMMENT '첨부파일 아이디',
	ORG_ID varchar(11) COMMENT '게시물 아이디',
	-- 1 : 후보자(iuser01)
	-- 2 : 공지사항, 업무자료(board)
	-- 3 : 일정관리(schedule)
	-- 4 : 컨설턴트(consultant)
	FILE_TYPE char(1) COMMENT '파일 구분 : 1 : 후보자(iuser01)
2 : 공지사항, 업무자료(board)
3 : 일정관리(schedule)
4 : 컨설턴트(consultant)',
	-- type 1인 경우
	-- 1 : 국문이력서1
	-- 2 : 국문이력서2
	-- 3 : 영문이력서1
	-- 4 : 영문이력서2
	-- 5 : 추천서
	-- 6 : 기타
	FILE_ORDER char(1) COMMENT '파일 순서 : type 1인 경우
1 : 국문이력서1
2 : 국문이력서2
3 : 영문이력서1
4 : 영문이력서2
5 : 추천서
6 : 기타',
	ORIGINAL_FILE_NM varchar(200) COMMENT '원본 파일명',
	STORED_FILE_NM varchar(15) COMMENT '실제 저장된 파일명',
	FILE_PATH varchar(255) COMMENT '파일위치',
	FILE_SIZE int(11) COMMENT '파일크기',
	CON_ID varchar(20) COMMENT '작성자 아이디',
	REG_DATE datetime COMMENT '등록일시',
	DEL_DATE datetime COMMENT '삭제일시',
	PRIMARY KEY (ATT_ID)
) COMMENT = '파일첨부';


-- 게시판
CREATE TABLE I_BOARD
(
	BOD_ID int NOT NULL COMMENT '게시물 아이디',
	-- 1 : 공지사항
	-- 2 : 업무자료
	BOD_TYPE char(1) COMMENT '게시판 구분 : 1 : 공지사항
2 : 업무자료',
	TITLE varchar(50) COMMENT '제목',
	CONTENTS varchar(20000) COMMENT '내용',
	CON_ID varchar(20) COMMENT '컨설턴트 아이디',
	REG_DATE datetime COMMENT '등록일시',
	DEL_DATE datetime COMMENT '삭제일시',
	PRIMARY KEY (BOD_ID)
) COMMENT = '게시판';


-- 코멘트
CREATE TABLE I_COMMENT
(
	CMT_ID varchar(11) NOT NULL COMMENT '코멘트 아이디',
	-- 1 : 고객사
	-- 2 : 포지션
	-- 3 : 후보자
	CMT_TYPE char(1) COMMENT '구분 : 1 : 고객사
2 : 포지션
3 : 후보자',
	ITEM_ID varchar(11) COMMENT '대상 아이디',
	CON_ID varchar(20) COMMENT '컨설턴트 아이디',
	CONTENTS varchar(10000) COMMENT '내용',
	REG_DATE datetime COMMENT '등록일시',
	DEL_DATE datetime COMMENT '삭제일시',
	PRIMARY KEY (CMT_ID)
) COMMENT = '코멘트';


-- 고객사
CREATE TABLE I_COMPANY
(
	COM_ID varchar(11) NOT NULL COMMENT '회사아이디',
	COM_NM varchar(40) COMMENT '회사명',
	-- A : 고객사, B : 마케팅
	SECTION char(1) COMMENT '구분 : A : 고객사, B : 마케팅',
	-- A : 대기업, B : 중견기업, C : 중소기업, D : 외국계기업
	COM_TYPE char(1) COMMENT '기업형태 : A : 대기업, B : 중견기업, C : 중소기업, D : 외국계기업',
	SALES varchar(20) COMMENT '매출 ',
	PEOPLE varchar(20) COMMENT '인원',
	INDUSTRY1 varchar(11) COMMENT '업종 1단계',
	INDUSTRY2 varchar(11) COMMENT '업종 2단계',
	PUBLIC_YN char(1) COMMENT '내부공개여부',
	SUMMARY varchar(20000) COMMENT '회사개요',
	ADDRESS varchar(100) COMMENT '주소',
	STANDARD varchar(50) COMMENT '처우수준',
	URL varchar(40) COMMENT '홈페이지',
	-- 1 : TM, 2 : EM, 3 : 방문, 4 : 지인소개, 5 : 인바운드, 6 : 기타
	SOURCE char(1) COMMENT '등록경로 : 1 : TM, 2 : EM, 3 : 방문, 4 : 지인소개, 5 : 인바운드, 6 : 기타',
	COMMISSION varchar(50) COMMENT '수수료율',
	GUARANTEE varchar(2) COMMENT '개런티',
	USR_NM varchar(20) COMMENT '등록자 이름',
	CON_ID varchar(20) COMMENT '컨설턴트 아이디',
	REG_DATE datetime COMMENT '등록일시',
	MOD_DATE datetime COMMENT '수정일시',
	DEL_DATE datetime COMMENT '삭제일시',
	PRIMARY KEY (COM_ID)
) COMMENT = '고객사';


-- 컨설턴트
CREATE TABLE I_CONSULTANT
(
	CON_ID varchar(20) NOT NULL COMMENT '컨설턴트 아이디',
	PASSWORD varchar(62) COMMENT '암호',
	CON_NM varchar(20) COMMENT '컨설턴트 이름',
	RANK varchar(20) COMMENT '직급코드',
	RANK_NM varchar(20) COMMENT '직급명',
	CON_ORDER varchar(2) COMMENT '정렬순서',
	FIELD varchar(100) COMMENT '전문분야',
	PHONE varchar(128) COMMENT '연락처',
	MOBILE varchar(128) COMMENT '휴대폰',
	EMAIL varchar(128) COMMENT '이메일',
	EDU varchar(20000) COMMENT '학력/경력',
	ADMIN_YN char(1) DEFAULT 'N' COMMENT '관리자지정',
	-- 1 : 권한있음
	-- 0 : 권한없음
	AUTH_PUBLIC char(1) COMMENT '등록자료 공개여부 : 1 : 권한있음
0 : 권한없음',
	-- 1 : 권한있음
	-- 0 : 권한없음
	AUTH_COMPANY char(1) COMMENT '고객사관리 조회 여부 : 1 : 권한있음
0 : 권한없음',
	-- 1 : 권한있음
	-- 0 : 권한없음
	AUTH_POSITION char(1) COMMENT '포지션관리 조회 여부 : 1 : 권한있음
0 : 권한없음',
	-- 1 : 권한있음
	-- 0 : 권한없음
	AUTH_USER char(1) COMMENT '후보자관리 조회 여부 : 1 : 권한있음
0 : 권한없음',
	-- 1 : 전체이력조회
	-- 2 : 연락처를 제외한 이력조회
	-- 3 : 이력서 조회 불가
	AUTH_USER_TYPE char(1) COMMENT '후보자 이력서 조회 유형 : 1 : 전체이력조회
2 : 연락처를 제외한 이력조회
3 : 이력서 조회 불가',
	REG_DATE datetime COMMENT '등록일시',
	DEL_DATE datetime COMMENT '삭제일시',
	PRIMARY KEY (CON_ID)
) COMMENT = '컨설턴트';


-- 공휴일관리
CREATE TABLE I_HOLIDAY
(
	HLDY_YMD varchar(10) COMMENT '휴일날짜',
	HLDY_NM varchar(40) COMMENT '휴일 이름',
	REG_DATE datetime COMMENT '등록일시'
) COMMENT = '공휴일관리';


-- 업종,직무 코드
CREATE TABLE I_JOB_CD
(
	CD_ID varchar(11) COMMENT '코드 아이디',
	CD_TYPE char COMMENT '코드 구분',
	CD_LEVEL char COMMENT '코드 단계',
	PARENT_ID varchar(11) COMMENT '상위 코드 아이디',
	CD_NM varchar(50) COMMENT '코드 이름',
	CD_ORDER varchar(2) COMMENT '코드 순서'
) COMMENT = '업종,직무 코드';


-- KPI 현황
CREATE TABLE I_KPI
(
	CON_ID varchar(20) COMMENT '컨설턴트 아이디',
	SCON_ID varchar(20) COMMENT '부컨설턴트 아이디',
	POS_ID varchar(11) COMMENT '포지션 아이디',
	USR_ID varchar(11) COMMENT '후보자 아이디',
	COM_ID varchar(11) COMMENT '회사 아이디',
	REC_ID varchar(11) COMMENT '추천 아이디',
	STA_ID varchar(11) COMMENT '상태 아이디',
	ACTION varchar(12) COMMENT '액션 명칭',
	REG_DATE datetime COMMENT '등록일시',
	DEL_DATE datetime COMMENT '삭제일시'
) COMMENT = 'KPI 현황';


-- 로그인정보
CREATE TABLE I_LOGIN_INFO
(
	CON_ID varchar(20) COMMENT '컨설턴트 아이디',
	IP varchar(39) COMMENT '접속 IP',
	REG_DATE datetime COMMENT '접속일시',
	PASS_YN char(1) COMMENT '로그인 성공 여부'
) COMMENT = '로그인정보';


-- 관심DB
CREATE TABLE I_MARK
(
	MARK_ID int COMMENT '관심DB 아이디',
	CON_ID varchar(11) COMMENT '컨설턴트 아이디',
	USR_ID varchar(11) COMMENT '후보자 아이디',
	REG_DATE datetime COMMENT '등록일시'
) COMMENT = '관심DB';


-- 고객사-담당자
CREATE TABLE I_PERSON
(
	PERSON_ID int NOT NULL COMMENT '고객사담당자 아이디',
	COM_ID varchar(11) NOT NULL COMMENT '회사 아이디',
	PERSON_NM varchar(20) COMMENT '담당자 이름',
	DEPT_NM varchar(40) COMMENT '담당자 부서',
	POS_NM varchar(20) COMMENT '담당자 직위',
	PHONE1 varchar(128) COMMENT '담당자 연락처1',
	PHONE2 varchar(128) COMMENT '담당자 연락처2',
	EMAIL varchar(128) COMMENT '담당자 이메일',
	ETC varchar(50) COMMENT '비고',
	SORT char COMMENT '정렬 순서',
	REG_DATE datetime COMMENT '등록일시',
	MOD_DATE datetime COMMENT '수정일시',
	DEL_DATE datetime COMMENT '삭제일시',
	PRIMARY KEY (PERSON_ID)
) COMMENT = '고객사-담당자';


-- 포지션
CREATE TABLE I_POSITION
(
	POS_ID varchar(11) NOT NULL COMMENT '포지션 아이디',
	POS_CD varchar(20) COMMENT '포지션 코드',
	POS_NM varchar(20) COMMENT '포지션 이름',
	COM_ID varchar(11) COMMENT '회사 아이디',
	COM_NM varchar(30) COMMENT '회사명',
	RULE varchar(20) COMMENT '업무방식',
	H_PUBLIC_YN char(1) COMMENT '홈페이지공개여부',
	CON_ID varchar(20) COMMENT '주컨설턴트 아이디',
	S_CON_ID varchar(20) COMMENT '부컨설턴트 아이디',
	POS_STATUS char(1) COMMENT '진행상태',
	JOB varchar(2) COMMENT '직무',
	EDU char(1) COMMENT '학력',
	FROM_RANK char(1) COMMENT 'FROM 직즙',
	TO_RANK char(1) COMMENT 'TO 직급',
	CAREER varchar(2) COMMENT '경력',
	LANG varchar(40) COMMENT '외국어',
	PLACE varchar(20) COMMENT '근무지',
	PUBLIC_YN char(1) COMMENT '인트라넷(내부)공개여부',
	TASK varchar(20000) COMMENT '업무내용',
	POS_CONDITION varchar(20000) COMMENT '자격요건',
	FROM_TARGET varchar(4) COMMENT 'FROM 타켓연령',
	TO_TARGET varchar(4) COMMENT 'TO 연령',
	T_COMPANY varchar(50) COMMENT '선호기업',
	GENDER char(1) COMMENT '성별',
	LICENSE varchar(50) COMMENT '자격증',
	BASE tinyint COMMENT '기본급',
	BONUS tinyint COMMENT '성과급',
	ETC varchar(65353) COMMENT '기타정보',
	REG_DATE datetime COMMENT '등록일시',
	MOD_DATE datetime COMMENT '수정일시',
	DEL_DATE datetime COMMENT '삭제일시',
	PRIMARY KEY (POS_ID)
) COMMENT = '포지션';


-- 추천 진행상태
CREATE TABLE I_PRO_STATUS
(
	STA_ID varchar(11) COMMENT '진행상태 아이디',
	REC_ID varchar(11) COMMENT '추천 아이디',
	CON_ID varchar(11) COMMENT '컨설턴트 아이디',
	STATE varchar(2) COMMENT '진행상태값',
	STATE_NM varchar(20) COMMENT '진행상태명',
	REG_DATE datetime COMMENT '등록일시',
	DEL_DATE datetime COMMENT '삭제일시'
) COMMENT = '추천 진행상태';


-- 추천 진행현황
CREATE TABLE I_REC_PRESENT
(
	REC_ID varchar(11) NOT NULL COMMENT '추천 아이디',
	POS_ID varchar(11) NOT NULL COMMENT '포지션 아이디',
	USR_ID varchar(11) NOT NULL COMMENT '후보자 아이디',
	CON_ID varchar(20) COMMENT '컨설턴트 아이디',
	REG_DATE datetime COMMENT '추천일시',
	DEL_DATE datetime COMMENT '삭제일시',
	PRIMARY KEY (REC_ID, POS_ID, USR_ID)
) COMMENT = '추천 진행현황';


-- 일정관리
CREATE TABLE I_SCHEDULE
(
	SCH_ID int NOT NULL COMMENT '스케줄 아이디',
	SCH_TYPE char COMMENT '스케줄 구분',
	SCH_NM varchar(20) COMMENT '스케줄 이름',
	START_YMD varchar(10) COMMENT '시작일자',
	END_YMD varchar(10) COMMENT '종료일자',
	START_TM varchar(4) COMMENT '시작시간',
	END_TM varchar(4) COMMENT '종료시간',
	CON_ID varchar(11) COMMENT '컨설턴트 아이디',
	PLACE varchar(100) COMMENT '장소',
	PUBLIC_YN char COMMENT '공개여부',
	REG_DATE datetime COMMENT '등록일시',
	END_DATE datetime COMMENT '삭제일시',
	PRIMARY KEY (SCH_ID)
) COMMENT = '일정관리';


-- 후보자
CREATE TABLE I_USER
(
	USR_ID varchar(11) NOT NULL COMMENT '후보자 아이디',
	USR_NM varchar(20) COMMENT '후보자 이름',
	INDUSTRY varchar(2) COMMENT '업종',
	JOB varchar(2) COMMENT '직무',
	YEAR varchar(4) COMMENT '출생년도',
	GENDER char COMMENT '성별',
	ADDRESS varchar(100) COMMENT '주소',
	PUBLIC_YN char COMMENT '인트라넷(내부)공개여부',
	LANG varchar(40) COMMENT '외국어',
	LICENSE varchar(50) COMMENT '자격증',
	BASE int COMMENT '기본급',
	BONUS int COMMENT '성과급',
	C_NAME varchar(50) COMMENT '경력회사',
	SUMMARY varchar(20000) COMMENT '경력요약',
	DETAIL varchar(20000) COMMENT '상세경력',
	SOURCES varchar(2) COMMENT '출처',
	CON_ID varchar(20) COMMENT '등록자',
	PHONE varchar(128) COMMENT '연락처',
	MOBILE varchar(128) COMMENT '휴대폰',
	EMAIL varchar(128) COMMENT '이메일',
	REG_DATE datetime COMMENT '등록일시',
	MOD_DATE datetime COMMENT '수정일시',
	DEL_DATE datetime COMMENT '삭제일시',
	PRIMARY KEY (USR_ID)
) COMMENT = '후보자';


-- 후보자 학력
CREATE TABLE I_USER_ACADEMIC
(
	USR_ID varchar(20) COMMENT '후보자 아이디',
	USR_LEVEL varchar(20) COMMENT '후보자 학력',
	USR_SCHOOL varchar(20) COMMENT '후보자 학교',
	USR_MAJOR varchar(20) COMMENT '후보자 전공',
	USR_TYPE varchar(20) COMMENT '후보자 졸업구분',
	USR_ORDER varchar(20) COMMENT '순서'
) COMMENT = '후보자 학력';



