-----------계정테이블----------------

create table tbl_member
(hakbun           varchar2(50)  --학번
,name             varchar2(50)  --이름
,birth            varchar2(100) --생년월일     
,fk_deptcode     varchar2(100) --학과코드
,pwd              varchar2(50)  --비밀번호
,email            varchar2(100) --이메일
,address          varchar2(300) --주소
,status           number(1)     --상태
,picture          varchar2(300) --증명사진   
,phone            varchar2(50)  --전화번호
,authority        number(1)     -- 권한(0: 학생, 1: 교수, 2: 총 관리자)
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



------------주차 테이블----------------
create table tbl_week
(fk_code           varchar2(100)                 --과목코드 
,week              varchar2(50)                  --몇주차인지
,startday          varchar2(100) default sysdate --시작날짜
,weekseq           number   not null
,constraint pk_tbl_week_weekseq primary key(weekseq)
,constraint FK_tbl_week_fk_code foreign key(fk_code) references tbl_subject(code) on delete cascade  
);


-----------주차시퀸스----------------
create sequence weekSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-----------수업차시 테이블----------------
create table tbl_weeklesson
(lessonseq            varchar2(50)  -- seq
,fk_weekseq           number        --몇주차인지
,lesson            varchar2(100)    --차시 명 ( 1주차 1차시, 1주차 2차시... )
,video             varchar2(800)    --비디오 명(유투브)
,savefile          varchar2(300)    --저장용
,uploadfile        varchar2(300)    --업로드용 
,constraint PK_tbl_weeklesson_seq primary key(lessonseq  )
,constraint FK_tbl_lesson_fk_weekseq foreign key(fk_weekseq) references tbl_week(weekseq) on delete cascade  
);


-----------수업차시 시퀸스----------------
create sequence lessonSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


------------출석 테이블----------------
create table tbl_attend
(fk_lessonSeq        varchar2(50)  -- 수업차시테이블의 lessonseq (이를 통해서 어느과목의 몇주차 / 몆차시인지 알 수 있다)
,fk_hakbun           varchar2(50)  -- 학번
,constraint FK_tbl_attend_fk_lessonSeq foreign key(fk_lessonSeq) references tbl_weeklesson(lessonseq) on delete cascade  
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



----- **** 자유게시판 댓글 테이블 생성 **** -----
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



----- **** 자유게시판 댓글 시퀀스 생성 **** -----
create sequence commentSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;





----- **** 강의자료실 테이블 생성 **** -----
create table tbl_lessonBoard
(seq            number                not null    -- 글번호
,fk_hakbun      varchar2(50)          not null    -- 사용자학번
,fk_code        varchar2(100)         not null    -- 과목코드
,name           varchar2(20)          not null    -- 글쓴이 
,subject        Nvarchar2(200)        not null    -- 글제목
,content        Nvarchar2(2000)       not null    -- 글내용   -- clob (최대 4GB까지 허용) 
,pw             varchar2(20)          not null    -- 글암호
,regDate        date default sysdate  not null    -- 글쓴시간
,status         number(1) default 1   not null    -- 글삭제여부   1:사용가능한 글,  0:삭제된글
,commentCount   number(3) default 0 not null      -- 조회수
,fileName       varchar2(255)                     -- WAS(톰캣)에 저장될 파일명(2021110809271535243254235235234.png)                                       
,orgFilename    varchar2(255)                     -- 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
,fileSize       number           
,constraint PK_tbl_lessonBoard_seq primary key(seq)
,constraint FK_tbl_lessonBoard_fk_hakbun foreign key(fk_hakbun) references tbl_member(hakbun) on delete cascade
,constraint FK_tbl_lessonBoard_fk_code foreign key(fk_code) references tbl_subject(code) on delete cascade
,constraint CK_tbl_lessonBoard_status check( status in(0,1) )
);
-- Table TBL_LESSONBOARD이(가) 생성되었습니다.



----- **** 강의자료실 시퀀스 생성 **** -----
create sequence lessonBoardSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence LESSONBOARDSEQ이(가) 생성되었습니다.





----- **** 수강(학생) 테이블 생성 **** -----
create table tbl_sugang(
fk_code  varchar2(100)
,fk_hakbun varchar2(50)
,constraint FK_TBL_SUGANG_FK_CODE foreign key(fk_code) references tbl_subject(code) on delete cascade
,constraint FK_TBL_SUGANG_FK_HAKBUN foreign key(fk_hakbun) references tbl_member(hakbun) on delete cascade
)
-- Table TBL_SUGANG이(가) 생성되었습니다.




----- **** 수업계획서 테이블 생성 **** -----
create table tbl_lessonplan(
lessonplanseq                 number                -- 수업계획서 SEQ
,fk_weekseq         number                          -- 주차 SEQ
,fk_hakbun          varchar2(50)                    -- 학번(글쓴이, 교수)
,subject        Nvarchar2(200)        not null      -- 글제목
,content        Nvarchar2(2000)       not null      -- 글내용   -- clob (최대 4GB까지 허용) 
,regDate        date default sysdate  not null      -- 글쓴시간
,status         number(1) default 1   not null      -- 글삭제여부   1:사용가능한 글,  0:삭제된글
,fileName       varchar2(255)                       -- WAS(톰캣)에 저장될 파일명(2021110809271535243254235235234.png)                                       
,orgFilename    varchar2(255)                       -- 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
,fileSize       number                              -- 파일사이즈
,constraint PK_TBL_LESSONPLAN_LPSEQ primary key(lessonplanSeq)
,constraint FK_TBL_LESSONPLAN_FK_WEEKSEQ foreign key(fk_weekseq) references tbl_week(weekseq) on delete cascade
,constraint FK_TBL_LESSONPLAN_FK_HAKBUN foreign key(fk_hakbun) references tbl_member(hakbun) on delete cascade
);



----- **** 수업계획서 시퀀스 생성 **** -----
create sequence lessonplanSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


----- **** 성적 테이블 생성 **** -----
create table tbl_grade(
fk_code  varchar2(100)
,fk_hakbun varchar2(50)
,grade     varchar2(10)
,constraint FK_TBL_GRADE_FK_CODE foreign key(fk_code) references tbl_subject(code) on delete cascade
,constraint FK_TBL_GRADE_FK_HAKBUN foreign key(fk_hakbun) references tbl_member(hakbun) on delete cascade
,constraint CK_TBL_GRADE_GRADE check (grade in('A+', 'A', 'B+', 'B', 'C+', 'C', 'D+', 'D', 'F' ))
)



select A.code AS code, A.subject AS subject, A.fk_hakbun AS fk_hakbun, C.name AS name, A.hakjum AS hakjum, A.classdate AS classdate, A.fk_deptcode AS deptcode, B.deptName AS deptName, B.deptLocation AS deptLocation
from tbl_subject A
JOIN tbl_department B
on A.fk_deptcode = B.deptCode
JOIN tbl_member C
on A.fk_hakbun = C.hakbun


insert into tbl_sugang(fk_code, fk_hakbun)
values('0528', '2100022');

commit;

select *
from tbl_member

select *
from tbl_subject;

select * 
from tbl_sugang;


select hakbun, code, subject, teacher, hakjum, classdate, location
from
(
select B.hakbun AS hakbun ,C.code AS code, C.subject AS subject, D.name AS teacher, C.hakjum AS hakjum, C.classdate AS classdate, E.deptlocation || ' ' || E.deptname AS location
from tbl_sugang A
JOIN tbl_member B
on A.fk_hakbun = B.hakbun
JOIN tbl_subject C
on A.fk_code = C.code
JOIN tbl_member D
ON C.fk_hakbun = D.hakbun
JOIN tbl_department E
ON c.fk_deptcode = E.deptcode
)
where hakbun = '2100022'


select count(*)
from tbl_sugang
where fk_hakbun = '2100022' and fk_code='0103'

select * 
from tbl_member;

select code, subject, hakjum, classdate, deptcode, deptname, deptlocation
from tbl_subject A
JOIN tbl_department B
ON A.fk_deptcode = B.deptcode
where fk_hakbun = '2100001';

select * 
from tbl_subject
where fk_hakbun = '2100001';

select distinct m.hakbun, m.name
from tbl_member m 
join tbl_sugang s
on m.hakbun = s.fk_hakbun
where m.authority = 0 and m.status = 1 and s.fk_deptCode = #{fk_deptCode}




select *
from tbl_subject
where fk_hakbun = '210달러0022' and code = '0102'
오라클

select * 
from tbl_member;




select lead(seq, 1) over (order by seq desc) AS previousSeq, lead(subject, 1) over (order by seq desc) AS previousSubject, lag(seq, 1) over (order by seq desc) AS nextSeq, lag(subject, 1) over (order by seq desc) AS nextSubject
from tbl_lessonBoard
order by seq desc;

delete tbl_lessonBoard;

commit;

desc tbl_lessonBoard;

select seq, fk_hakbun, fk_code, name, subject, content, pw, regDate, status, commentCount
     , fileName, orgFilename, fileSize
     , previousSeq, previousSubject
     , nextSeq, nextSubject
from
(
    select seq, fk_hakbun, fk_code, name, subject, content, pw, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate, status, commentCount
              , fileName, orgFilename, fileSize
              , lead(seq, 1) over (order by seq desc) AS previousSeq, lead(subject, 1) over (order by seq desc) AS previousSubject
              , lag(seq, 1) over (order by seq desc) AS nextSeq, lag(subject, 1) over (order by seq desc) AS nextSubject
    from tbl_lessonboard
    where status = 1 and fk_code = '0101'
) A
where seq = 20
order by seq desc


select distinct fk_hakbun
from tbl_sugang;

select *
from tbl_sugang;

select *

select B.name
from
(
select hakbun
from tbl_member
where authority = 0
MINUS
select fk_hakbun
from tbl_sugang
) A
JOIN tbl_member B
on A.hakbun = B.hakbun


select *
from tbl_subject;

create table tbl_lessonBoard_comment(
seq             number                  not null
,fk_hakbun       varchar2(50)            not null
,name            varchar2(50)            not null
,content         varchar2(1000)          not null
,parentSeq       number                  not null
,regDate         date    default sysdate not null
,constraint PK_TBL_LB_COMMENT_SEQ primary key(seq)
,constraint FK_TBL_LB_COMMENT_HAKBUN foreign key(fk_hakbun) references tbl_member(hakbun) on delete cascade
)
-- Table TBL_LESSONBOARD_COMMENT이(가) 생성되었습니다.

create sequence lessonboard_commentSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence LESSONBOARD_COMMENTSEQ이(가) 생성되었습니다.


select A.seq AS seq, A.fk_hakbun AS fk_hakbun, A.name || case B.authority when 0 then ' 학생' when 1 then ' 교수' end AS name, A.content AS content, to_char(A.regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
from tbl_lessonBoard_comment A
JOIN tbl_member B
on A.fk_hakbun = B.hakbun
where parentSeq = 18
order by seq desc

select *
from tbl_lessonboard
order by seq desc;

update tbl_lessonboard set commentcount = 0;
commit;

select * 
from tbl_lessonboard_comment;

delete from tbl_lessonboard_comment;


select * 
from tab;

desc tbl_lessonboard;

create table tbl_homework(
seq             number,
fk_hakbun       varchar2(50)   NOT NULL,
fk_code         varchar2(100)  NOT NULL,
name            varchar2(20)   NOT NULL,
subject         varchar2(200)  NOT NULL,
content         varchar2(2000) NOT NULL,
regDate         date    default sysdate    NOT NULL,
commentCount    number(3) default 0,
fileName        varchar2(255),
orgFilename     varchar2(255),
fileSize        number,
constraint  PK_TBL_HOMEWORK_SEQ primary key(seq),
constraint  FK_TBL_HOMEWORK_FK_HAKBUN foreign key(fk_hakbun) references tbl_member(hakbun) on delete cascade,
constraint  FK_TBL_HOMEWORK_FK_CODE foreign key(fk_code) references tbl_subject(code) on delete cascade
)
-- Table TBL_HOMEWORK이(가) 생성되었습니다.

insert into tbl_homework(seq, fk_hakbun, fk_code, name, subject, content, regDate, commentCount)
values(homeworkSeq.nextval, '2100001', '5041', '금길영', '테스트222', '테스트222 내용', default, default);

commit;

insert into tbl_homework_comment(seq, parentSeq, fk_code, fk_hakbun, content)
values(homeworkCommentSeq.nextval, 3, '5041', '2100001', '댓글테스트1');

commit;

select * 
from tbl_homework;

drop table tbl_homework purge;

create sequence homeworkSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence HOMEWORKSEQ이(가) 생성되었습니다.


create table tbl_homework_comment(
seq             number,
parentSeq       number  not null,
fk_hakbun       varchar2(50)    not null,
content         varchar2(500)   not null,
fileName        varchar2(255),
orgFilename     varchar2(255),
fileSize        number,
constraint  PK_TBL_HW_COMMENT primary key(seq),
constraint FK_TBL_HW_COMMENT_PARENTSEQ  foreign key(parentSeq) references tbl_homework(seq) on delete cascade,
constraint FK_TBL_HW_COMMENT_FKHAKBUN foreign key(fk_hakbun) references tbl_member(hakbun) on delete cascade
)
-- Table TBL_HOMEWORK_COMMENT이(가) 생성되었습니다.


drop table tbl_homework_comment purge;

create sequence homeworkCommentSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence HOMEWORKCOMMENTSEQ이(가) 생성되었습니다.


select seq, fk_hakbun, fk_code, name, subject, content, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate, commentCount, fileName, orgFilename, fileSize
from tbl_homework


select seq, parentSeq, fk_hakbun, name, content, fileName, orgFilename, FileSize
from tbl_homework_comment
JOIN tbl_member
on fk_hakbun = hakbun

select *
from tbl_homework_comment

insert into tbl_homework_comment(seq, parentSeq, fk_hakbun, content)
values(homeworkCommentSeq.nextval, 2, '2100001', '댓글테스트1');

commit;

alter table tbl_homework_comment
add fk_code varchar2(100)

update tbl_homework_comment set fk_code = '0101'

alter table tbl_homework_comment
add constraint FK_TBL_HW_COMMENT_FK_CODE foreign key(fk_code) references tbl_subject(code);

alter table tbl_homework_comment
add regDate date default sysdate;

		select seq, parentSeq, fk_hakbun, name, content, fileName, orgFilename, FileSize,
		to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate
		from tbl_homework_comment
		JOIN tbl_member
		on fk_hakbun = hakbun
		where fk_code = '0101'

alter table tbl_homework
add status number(1) default 0;

select * 
from tbl_homework;

alter table tbl_homework
add constraint CK_TBL_HW_COMMENT_ST check(status in(0, 1));

select *
from tbl_homework;

delete from tbl_homework_comment;

commit;

update tbl_homework set status = 0
where seq = 2;


select * 
from tbl_member;

update tbl_member set picture = 'kakao.png'
where hakbun = '2100036';

commit;


delete from tbl_homework_comment;

select *
from tbl_homework;

update tbl_homework set status = 0
where seq = 2;

alter table tbl_homework
add deadline date default sysdate+7;

update tbl_homework set deadline = '21/11/22'
where seq = 2

select * 
from tbl_homework
order by seq desc;

update tbl_homework set deadline = sysdate+7
where seq = 1;

commit;


select * 
from tbl_homework;

delete from tbl_homework_comment;
commit;

update tbl_homework set commentCount = 0;

update tbl_homework set status = 0, deadline = sysdate +7
where seq = 2;


select A.seq, A.parentSeq, A.fk_hakbun, B.name, A.content, A.fileName, A.orgFilename, A.FileSize, 
to_char(A.regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate,
C.commentCount
from tbl_homework_comment A
JOIN tbl_member B
on A.fk_hakbun = B.hakbun
JOIN tbl_homework C
on A.parentSeq = C.seq
where A.fk_code = '0101'
order by seq desc


select to_number(status)
from tbl_homework;

desc tbl_homework;

update tbl_homework set status = '0';

commit;

alter table tbl_homework 
rename column status to acceptance;

select * 
from tab;


desc TBL_JJOKJI;

drop table TBL_LESSONPLAN purge;
-- Table TBL_LESSONPLAN이(가) 삭제되었습니다.

select * 
from tab;

select * 
from TBL_SERVEY;

desc TBL_DEPARTMENT;

select *
from user_constraintS
where table_name = 'TBL_DEPARTMENT';

select COLUMN_NAME, DATA_TYPE, DATA_LENGTH, NULLABLE, DATA_DEFAULT
from USER_TAB_COLS
where table_name = 'TBL_SERVEYRESULT';

select *
from tbl_homework_comment;

select A.fk_hakbun, B.name 
from tbl_sugang A
JOIN tbl_member B
on A.fk_hakbun = B.hakbun
where A.fk_code = '0101';

select * 
from tbl_sugang
where fk_hakbun='2100022' and fk_code ='1231231231232'

select *
from tbl_qna

select A.fk_hakbun AS hakbun, B.name AS name 
from tbl_sugang A
JOIN tbl_member B
on A.fk_hakbun = B.hakbun
where A.fk_code = '0101'

select *
from tbl_homework_comment;


select distinct fk_hakbun, name, ((select count(*) from tbl_homework_comment) / cnt * 100) AS percentage, cnt
from
(
select parentSeq, fk_hakbun, name, (select count(*) from tbl_homework where fk_code = '0101') AS cnt
from tbl_homework_comment A
JOIN tbl_member B
on A.fk_hakbun = B.hakbun
where fk_code = '0101'
)


select *
from tbl_member
where authority = 0

select distinct A.fk_hakbun, A.fk_code, B.name, C.orgFilename, C.fileName, C.regDate
from tbl_sugang A
JOIN tbl_member B
on A.fk_hakbun = B.hakbun
LEFT JOIN tbl_homework_comment C
on A.fk_hakbun = C.fk_hakbun
where A.fk_code = '0101'


select code, C.hakbun, D.name, StudentCnt, totalCnt
from 
(
    select B.fk_code AS code, B.fk_hakbun AS hakbun, NVL(StudentHomeworkCnt, 0) AS StudentCnt, NVL(totalHomeworkCnt, (select count(*) from tbl_homework where fk_code = '0103')) AS totalCnt
    from 
(
        select fk_code, fk_hakbun, count(*) AS StudentHomeworkCnt, (select count(*) from tbl_homework where fk_code = '0103') AS totalHomeworkCnt
        from tbl_homework_comment A
        group by fk_code, fk_hakbun
        having fk_code = '0103'
) A
RIGHT JOIN
(
        select fk_code, fk_hakbun
        from tbl_sugang
        where fk_code = '0103'
) B
    ON A.fk_hakbun = B.fk_hakbun
) C
JOIN tbl_member D 
ON C.hakbun = D.hakbun


select *
from tbl_sugang
where fk_code = '0103';