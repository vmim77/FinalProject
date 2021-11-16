-----------계정테이블----------------

create table tbl_member
(hakbun           varchar2(50)  --학번
,name             varchar2(50)  --이름
,birth            varchar2(100) --생년월일     
,fk_dept_code     varchar2(100) --학과코드
,pwd              varchar2(50)  --비밀번호
,email            varchar2(100) --이메일
,address          varchar2(300) --주소
,status           number(1)     --상태
,picture          varchar2(300) --증명사진   
,phone            varchar2(50)  --전화번호
,authority        number(1)     --
,constraint PK_tbl_member_hakbun primary key(hakbun)
,constraint CK_tbl_member_fk_dept_code foreign key(fk_dept_code) references tbl_department(deptCode)
,constraint UQ_tbl_member_email unique(email)
,constraint CK_tbl_member_status check(status between 0 and 4)       --0 등록예정, 1 재학, 2 휴학, 3 자퇴, 4 졸업
,constraint CK_tbl_member_authority check(authority between 0 and 2) --0 학생, 1 교수, 2 총 관리자
);
commit;

select *
from tbl_member;

update tbl_member set picture = 'jae.png'
where picture = '없음'

alter table tbl_member rename column fk_dept_code to fk_deptCode;

-----------학과테이블----------------

create table tbl_department
(deptCode           varchar2(100) not null --학과코드
,deptName           varchar2(100) not null --학과명
,deptLocation       varchar2(300) not null --학과위치
,constraint PK_tbl_department_deptCode primary key(deptCode)
);
commit;

select *
from tbl_subject;

insert into tbl_subject(code, subject, teacher, ban, hakjum, classDate, fk_deptCode)
values('0501','인간행동과사회환경','김미선','a','3','월','05');
insert into tbl_subject(code, subject, teacher, ban, hakjum, classDate, fk_deptCode)
values('0502','자원봉사기초','유진희','b','3','화','05');
insert into tbl_subject(code, subject, teacher, ban, hakjum, classDate, fk_deptCode)
values('0503','가족복지론','임준철','c','2','수','05');
insert into tbl_subject(code, subject, teacher, ban, hakjum, classDate, fk_deptCode)
values('0504','장애인복지론','김형준','d','3','목','05');
-----------과목테이블----------------
select *
from tbl_subject
create table tbl_subject
(code           varchar2(100) --과목코드
,subject        varchar2(100) --과목명 
,teacher        varchar2(50)  --담당교수님
,ban            varchar2(50)  --반
,hakjum         number(1)     --배정학점
,classDate      varchar2(100) --수업요일
,constraint PK_tbl_subject_code primary key(code)
,constraint UQ_tbl_subject_subject unique(subject)
,constraint CK_tbl_subject_hakjum check(hakjum between 2 and 4)      
);
alter table tbl_subject
add fk_deptCode varchar2(100);
alter table tbl_subject add constraint FK_tbl_subject_fk_deptcode foreign key(fk_deptCode) references tbl_department(deptCode) on delete cascade
commit;

------------몇주차 테이블----------------
create table tbl_week
(fk_code           varchar2(100)                 --과목코드 
,week              varchar2(50)                  --몇주차인지
,startday          varchar2(100) default sysdate --시작날짜
,constraint PK_tbl_week_week primary key(week)
,constraint FK_tbl_week_fk_code foreign key(fk_code) references tbl_subject(code) on delete cascade  
);

-----------몇주차시퀸스----------------
create sequence weekSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from tbl_member

------------몇차시 테이블----------------
create table tbl_weeklesson
(fk_week           varchar2(50)  --몇주차인지
,lesson            varchar2(100) --차시 명 ( 1주차 1차시, 1주차 2차시... )
,video             varchar2(800) --비디오 명(유투브)
,savefile          varchar2(300) --저장용
,uploadfile        varchar2(300) --업로드용 
,constraint PK_tbl_weeklesson_lesson primary key(lesson)
,constraint FK_tbl_lesson_fk_week foreign key(fk_week) references tbl_week(week) on delete cascade  
);

-----------몇차시시퀸스----------------
create sequence lessonSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;



------------출석 테이블----------------
create table tbl_attend
(fk_lesson           varchar2(100) --차시 명 ( 1주차 1차시, 1주차 2차시... ) 
,fk_hakbun           varchar2(50)  --학번
,constraint FK_tbl_attend_fk_lesson foreign key(fk_lesson) references tbl_weeklesson(lesson) on delete cascade  
);








-----------자유게시판테이블----------------

create table tbl_FreeBoard
(seq         number                not null    -- 글번호
,fk_hakbun   varchar2(50)          not null    -- 사용자학번
,name        varchar2(20)          not null    -- 글쓴이 
,subject     Nvarchar2(200)        not null    -- 글제목
,content     Nvarchar2(2000)       not null    -- 글내용   -- clob (최대 4GB까지 허용) 
,pw          varchar2(20)          not null    -- 글암호
,readCount   number default 0      not null    -- 글조회수
,regDate     date default sysdate  not null    -- 글쓴시간
,status      number(1) default 1   not null    -- 글삭제여부   1:사용가능한 글,  0:삭제된글
,commentCount number(3) default 0 not null     -- 조회수
,constraint PK_tbl_FreeBoard_seq primary key(seq)
,constraint FK_tbl_FreeBoard_fk_hakbun foreign key(fk_hakbun) references tbl_member(hakbun)
,constraint CK_tbl_FreeBoard_status check( status in(0,1) )
);

-----------자유게시판시퀸스----------------
create sequence boardSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

----- **** 댓글 테이블 생성 **** -----
create table tbl_FreeComment
(seq           number               not null   -- 댓글번호
,fk_hakbun     varchar2(50)         not null   -- 사용자학번
,name          varchar2(20)         not null   -- 성명
,content       varchar2(1000)       not null   -- 댓글내용
,regDate       date default sysdate not null   -- 작성일자
,parentSeq     number               not null   -- 원게시물 글번호
,status        number(1) default 1  not null   -- 글삭제여부
                                               -- 1 : 사용가능한 글,  0 : 삭제된 글
                                               -- 댓글은 원글이 삭제되면 자동적으로 삭제되어야 한다.
,constraint PK_tbl_FreeComment_seq primary key(seq)
,constraint FK_tbl_FreeComment_hakbun foreign key(fk_hakbun) references tbl_member(hakbun)
,constraint FK_tbl_FreeComment_parentSeq foreign key(parentSeq) references tbl_board(seq) on delete cascade
,constraint CK_tbl_FreeComment_status check( status in(1,0) ) 
);

create sequence commentSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

---------------------------------------------------------------------------------
select *
from user_constraints

alter table tbl_department add constraint PK_tbl_department_deptCode primary key(deptCode);
alter table tbl_member add constraint CK_tbl_member_fk_dept_code foreign key(fk_dept_code) references tbl_department(deptCode);
alter table tbl_FreeBoard add constraint PK_tbl_FreeBoard_seq primary key(seq);
alter table tbl_FreeBoard add constraint FK_tbl_FreeBoard_fk_hakbun foreign key(fk_hakbun) references tbl_member(hakbun);
alter table tbl_FreeBoard add constraint CK_tbl_FreeBoard_status check( status in(0,1) );
alter table tbl_FreeComment add constraint PK_tbl_FreeComment_seq primary key(seq);
alter table tbl_FreeComment add constraint FK_tbl_FreeComment_hakbun foreign key(fk_hakbun) references tbl_member(hakbun);
alter table tbl_FreeComment add constraint FK_tbl_FreeComment_parentSeq foreign key(parentSeq) references tbl_FreeBoard(seq) on delete cascade;
alter table tbl_FreeComment add constraint CK_tbl_FreeComment_status check( status in(1,0) ) ;
---------------------------------------------------------------------------------


select *
from tbl_member;

commit;


insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100001','금길영','19970921','01','qwer1234$','gill@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100002','이재성','19940501','01','qwer1234$','jae@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100003','장현걸','19961204','01','qwer1234$','jang@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100004','김민경','19950814','01','qwer1234$','min@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

---------------------------------------------------------------------------------------------------------------------------

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100005','최재영','19870921','02','qwer1234$','choi@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100006','김지훈','19840501','02','qwer1234$','hoon@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100007','김연희','19761204','02','qwer1234$','yeon@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100008','김유규','19850814','02','qwer1234$','you@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

---------------------------------------------------------------------------------------------------------------------------

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100009','손은종','19891021','03','qwer1234$','son@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100010','정미혜','19800301','03','qwer1234$','jeong@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100011','정연미','19721129','03','qwer1234$','mee@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100012','이정신','19870820','03','qwer1234$','mind@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

---------------------------------------------------------------------------------------------------------------------------

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100013','문주영','19701021','04','qwer1234$','moon@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100014','강준규','19890301','04','qwer1234$','kang@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100015','홍성옥','19760220','04','qwer1234$','okk@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100016','임제영','19600714','04','qwer1234$','jaezere@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

---------------------------------------------------------------------------------------------------------------------------

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100017','김미선','19800421','05','qwer1234$','msun@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100018','유진희','19840626','05','qwer1234$','jinhee@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100019','임준철','19780320','05','qwer1234$','junch@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('2100020','김형준','19670414','05','qwer1234$','hjun@naver.com','서울특별시 마포구 월드컵북로 21 2층 풍성빌딩','1','jae','010-1234-5678','1');

---------------------------------------------------------------------------------------------------------------------------


jsonobj.put("hakbun", mbvo.getHakbun());
				jsonobj.put("name", mbvo.getName());
				jsonobj.put("birth", mbvo.getBirth());
				jsonobj.put("fk_deptCcode", mbvo.getFk_dept_code());
				jsonobj.put("email", mbvo.getEmail());
				jsonobj.put("address", mbvo.getAddress());
				jsonobj.put("status", mbvo.getStatus());
				jsonobj.put("picture", mbvo.getPicture());
				jsonobj.put("phone", mbvo.getPhone());
				jsonobj.put("authority", mbvo.getAuthority());



select hakbun, name, birth, fk_deptCcode, email, address, status, picture, phone, authority
from
(
select hakbun, name, birth, fk_deptCcode, email, address, status, picture, phone, authority
from tbl_member
)v
(
select ban
from tbl_subject
where 


select hakbun, name, birth, email, address, status, picture, phone, authority
       ,(select deptName
         from tbl_department
         where deptCode = '01') as fk_deptCode
from tbl_member;

select *
from tbl_member;
commit;
delete tbl_subject where subject ='테스트용테스트용';

select *
from tbl_member;

select hakbun, name, birth, email, address, status, picture, phone, authority
       		 ,(select deptName
         	   from tbl_department
         	   where deptCode = '01') as fk_deptCode
         from tbl_member
         where authority = '0' and status = '0'
         
select deptName
from tbl_department
where deptCode = '01'     


select hakbun, name, birth, (select deptName from tbl_department where deptCode = fk_deptCode) as fk_deptCode, pwd, email, address, status, picture, phone, authority
from
(
    select hakbun, name, birth, fk_deptCode, pwd, email, address, status, picture, phone, authority
    from tbl_member
) V



select deptCode, deptName
from tbl_department
order by deptCode;

select *
from tab;


select teacher, (select deptName
                 from tbl_department
                 where deptCode = fk_deptCode) as fk_deptCode
from
(
    select teacher, fk_deptCode
    from tbl_subject
) V





select *
from tbl_subject;



------------------------------------------------------------------------------------------- 이루리


select *
from tbl_FreeBoard;

--글목록보기 sql 수정하기
select seq, fk_hakbun, name, subject, readCount, regDate, commentCount, fk_code -- fk_code 추가
	from 
	(
	    select row_number() over(order by seq desc) AS rno
	         , seq, fk_hakbun, name, subject
	         , readCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
	         , commentCount
             , fk_code -- fk_code 추가
	    from tbl_FreeBoard 
	    where status = 1
	    and fk_code = 0502 -- 추가
	    and lower( subject ) like '%'|| lower( '즐거운' ) ||'%'
	    
	) V
	where rno between 1 and 10
    
    
    
    
select subject
from tbl_FreeBoard
where status = 1
and fk_code = 0502
and lower( subject ) like '%'|| lower( '즐거운' ) ||'%'
order by seq desc;


-- 총게시물 구하기 list수정하기
 select count(*)
	     from tbl_FreeBoard 
		 where status = 1
		 and fk_code = 0502
		 and lower( subject ) like '%'|| lower( '즐거운' ) ||'%'
		

------------------------------------
-- 글 1개 조회하기 수정하기 -- 학번 where에 넣기
select previousseq, previoussubject, 
		       seq, fk_hakbun, name, subject, content, readCount, regDate, nextseq, nextsubject
               , fk_code
		from 
		(
		    select   lag(seq, 1) over(order by seq desc) AS previousseq
		           , lag(subject, 1) over(order by seq desc) AS previoussubject		           
		           , seq, fk_hakbun, name, subject, content, readCount
		           , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate		    
		           , lead(seq, 1) over(order by seq desc) AS nextseq
		           , lead(subject, 1) over(order by seq desc) AS nextsubject
                   , fk_code
		    from tbl_FreeBoard
		    where status = 1
            
            and fk_code = 0502
		    and lower( subject ) like '%'|| lower( '즐거운' ) ||'%'
		    
		) V 
		where V.seq = 255
        
        
--
select *
from tbl_member;

select *
from tbl_subject;

select *
from tbl_freeBoard;

select *
from tbl_freecomment;

select *
from tbl_sugang;

insert into tbl_sugang(fk_code, fk_hakbun)
values('0202','2100021');

insert into tbl_sugang(fk_code, fk_hakbun)
values('0202','2100022');

commit;

-- code 0202 빅데이터실무에 데이터 넣기
insert into tbl_FreeBoard(seq, fk_hakbun, name, subject, content, pw, readCount, regDate, status, commentCount, fk_code)
values(boardSeq.nextval, '2100021','이루리', '빅데이터실무게시판입니다', '파이팅입니다', '1234', default, default, default, default,'0202');
rollback;

begin
   for i in 1..200 loop
     insert into tbl_FreeBoard(seq, fk_hakbun, name, subject, content, pw, readCount, regDate, status, commentCount, fk_code)
     values(boardSeq.nextval, '2100021','이루리', '빅데이터실무게시판입니다'||i, '오늘도 좋은 하루 보내세요~'||i, '1234', default, default, default, default,'0202');
   end loop;
end;

begin
   for i in 1..5 loop
     insert into tbl_FreeBoard(seq, fk_hakbun, name, subject, content, pw, readCount, regDate, status, commentCount, fk_code)
     values(boardSeq.nextval, '2100021','이루리', '빅데이터질문입니다'||i, '질문입니다'||i, '1234', default, default, default, default,'0202');
   end loop;
end;


commit;