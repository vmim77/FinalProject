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


-----------학과테이블----------------

create table tbl_department
(deptCode           varchar2(100) not null --학과코드
,deptName           varchar2(100) not null --학과명
,deptLocation       varchar2(300) not null --학과위치
,constraint PK_tbl_department_deptCode primary key(deptCode)
);
commit;




insert into tbl_subject(code, subject, teacher, ban, hakjum, classDate, )
-----------과목테이블----------------

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