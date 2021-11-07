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

select * 
from tbl_member;

insert into tbl_member(hakbun, name, birth, fk_dept_code, pwd, email, address, status, picture, phone, authority)
values('0000001', '관리자', '19950929', '01', 'qwer1234$', 'vmim88@gmail.com', '길영대학교 용현캠퍼스 대학본부 2층', '1', '없음', '01027973149', '2');
-- 1 행 이(가) 삽입되었습니다.

commit;
-- 커밋 완료.

insert into tbl_department(deptCode, deptName, deptLocation)
values('01', '학사관리과', '대학본부 2층');
-- 1 행 이(가) 삽입되었습니다.
commit;
-- 커밋 완료.

-----------학과테이블----------------

create table tbl_department
(deptCode           varchar2(100) not null --학과코드
,deptName           varchar2(100) not null --학과명
,deptLocation       varchar2(300) not null --학과위치
,constraint PK_tbl_department_deptCode primary key(deptCode)
);



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

select *
from tbl_subject

-- 과목 페이지 표시용 SQL
select code, subject, teacher, ban, hakjum, classdate, fk_deptcode AS deptcode, B.deptName AS deptName, B.deptLocation AS deptLocation
from tbl_subject A
JOIN tbl_department B
on A.fk_deptcode = B.deptCode
where A.code = 0202


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


select *
from tbl_freeboard;
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