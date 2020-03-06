drop table enrollments;
drop table classes;
drop table tas;
drop table prerequisites;
drop table courses;
drop table students;
drop table logs;
drop table prerequisites_temp;

drop trigger students_delete_enroll;
drop trigger delete_enrollment_logs;
drop trigger insert_enrollment_logs;
drop trigger insert_student_logs;
drop trigger delete_student_logs;
drop trigger enrollment_insert;
drop trigger enrollment_delete;
drop trigger trigger_student_insert;

drop sequence log#_seq;

create table prerequisites_temp(dept_code varchar2(4) not null,course# number(3) not null);

create table students (B# char(4) primary key check (B# like 'B%'),
first_name varchar2(15) not null, last_name varchar2(15) not null, status varchar2(10) 
check (status in ('freshman', 'sophomore', 'junior', 'senior', 'MS', 'PhD')), 
gpa number(3,2) check (gpa between 0 and 4.0), email varchar2(20) unique,
bdate date, deptname varchar2(4) not null);

create table tas (B# char(4) primary key references students,
ta_level varchar2(3) not null check (ta_level in ('MS', 'PhD')), 
office varchar2(10));  

create table courses (dept_code varchar2(4), course# number(3)
check (course# between 100 and 799), title varchar2(20) not null,
primary key (dept_code, course#));

create table classes (classid char(5) primary key check (classid like 'c%'), 
dept_code varchar2(4) not null, course# number(3) not null, 
sect# number(2), year number(4), semester varchar2(8) 
check (semester in ('Spring', 'Fall', 'Summer 1', 'Summer 2')), limit number(3), 
class_size number(3), room varchar2(10), ta_B# char(4) references tas,
foreign key (dept_code, course#) references courses on delete cascade, 
unique(dept_code, course#, sect#, year, semester), check (class_size <= limit));

create table enrollments (B# char(4) references students, classid char(5) references classes, 
lgrade varchar2(2) check (lgrade in ('A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-','D', 
'F', 'I')), primary key (B#, classid));

create table prerequisites (dept_code varchar2(4) not null,
course# number(3) not null, pre_dept_code varchar2(4) not null,
pre_course# number(3) not null,
primary key (dept_code, course#, pre_dept_code, pre_course#),
foreign key (dept_code, course#) references courses on delete cascade,
foreign key (pre_dept_code, pre_course#) references courses on delete cascade);

create table logs (log# number(4) primary key, op_name varchar2(10) not null, op_time date not null,
table_name varchar2(12) not null, operation varchar2(6) not null, key_value varchar2(10));

insert into students values ('B001', 'Anne', 'Broder', 'junior', 3.17, 'broder@bu.edu', '17-JAN-90', 'CS');
insert into students values ('B002', 'Terry', 'Buttler', 'senior', 3.0, 'buttler@bu.edu', '28-MAY-89', 'Math');
insert into students values ('B003', 'Tracy', 'Wang', 'senior', 4.0, 'wang@bu.edu','06-AUG-93', 'CS');
insert into students values ('B004', 'Barbara', 'Callan', 'junior', 2.5, 'callan@bu.edu', '18-OCT-91', 'Math');
insert into students values ('B005', 'Jack', 'Smith', 'MS', 3.2, 'smith@bu.edu', '18-OCT-91', 'CS');
insert into students values ('B006', 'Terry', 'Zillman', 'PhD', 4.0, 'zillman@bu.edu', '15-JUN-88', 'Biol');
insert into students values ('B007', 'Becky', 'Lee', 'senior', 4.0, 'lee@bu.edu', '12-NOV-92', 'CS');
insert into students values ('B008', 'Tom', 'Baker', 'freshman', null, 'baker@bu.edu', '23-DEC-96', 'CS');
insert into students values ('B009', 'Ben', 'Liu', 'MS', 3.8, 'liu@bu.edu', '18-MAR-92', 'Math');
insert into students values ('B010', 'Sata', 'Patel', 'MS', 3.9, 'patel@bu.edu', '12-OCT-90', 'CS');
insert into students values ('B011', 'Art', 'Chang', 'PhD', 4.0, 'chang@bu.edu', '08-JUN-89', 'CS');
insert into students values ('B012', 'Tara', 'Ramesh', 'PhD', 3.98, 'ramesh@bu.edu', '29-JUL-91', 'Math');

insert into tas values ('B005', 'MS', 'EB G26');
insert into tas values ('B009', 'MS', 'WH 112');
insert into tas values ('B010', 'MS', 'EB G26');
insert into tas values ('B011', 'PhD','EB P85');
insert into tas values ('B012', 'PhD','WH 112');

insert into courses values ('CS', 432, 'database systems');
insert into courses values ('Math', 314, 'discrete math');
insert into courses values ('CS', 240, 'data structure');
insert into courses values ('Math', 221, 'calculus I');
insert into courses values ('CS', 532, 'database systems');
insert into courses values ('CS', 552, 'operating systems');
insert into courses values ('Biol', 425, 'molecular biology');

insert into classes values ('c0001', 'CS', 432, 1, 2018, 'Fall', 2, 1, 'LH 005', 'B005');
insert into classes values ('c0002', 'Math', 314, 1, 2018, 'Spring', 4, 4, 'LH 009', 'B012');
insert into classes values ('c0003', 'Math', 314, 2, 2018, 'Spring', 4, 2, 'LH 009', 'B009');
insert into classes values ('c0004', 'CS', 432, 2, 2018, 'Fall', 2, 2, 'SW 222', 'B005');
insert into classes values ('c0005', 'CS', 240, 1, 2017, 'Spring', 3, 2, 'LH 003', 'B010');
insert into classes values ('c0006', 'CS', 532, 1, 2018, 'Fall', 3, 2, 'LH 005', 'B011');
insert into classes values ('c0007', 'Math', 221, 1, 2017, 'Fall', 7, 6, 'WH 155', null);
insert into classes values ('c0008', 'CS', 552, 1, 2018, 'Fall', 1, 0, 'EB R15', null);
insert into classes values ('c0009', 'CS', 240, 1, 2018, 'Fall', 2, 1, 'EB R15', null);

insert into prerequisites values ('Math', '314', 'Math', '221');
insert into prerequisites values ('CS', '432', 'Math', '314');
insert into prerequisites values ('CS', '532', 'Math', '314');
insert into prerequisites values ('CS', '552', 'CS', '240');

insert into enrollments values ('B001', 'c0001', null);
insert into enrollments values ('B001', 'c0003', 'B');
insert into enrollments values ('B001', 'c0007', 'B+');
insert into enrollments values ('B002', 'c0002', 'B');
insert into enrollments values ('B002', 'c0007', 'B');
insert into enrollments values ('B003', 'c0004', null);
insert into enrollments values ('B003', 'c0002', 'A-');
insert into enrollments values ('B003', 'c0007', 'B');
insert into enrollments values ('B004', 'c0004', null);
insert into enrollments values ('B004', 'c0005', 'B+');
insert into enrollments values ('B004', 'c0003', 'A');
insert into enrollments values ('B004', 'c0007', 'A');
insert into enrollments values ('B005', 'c0006', null);
insert into enrollments values ('B005', 'c0002', 'B');
insert into enrollments values ('B005', 'c0007', 'B');
insert into enrollments values ('B006', 'c0006', null);
insert into enrollments values ('B006', 'c0002', 'A');
insert into enrollments values ('B006', 'c0007', 'A-');
insert into enrollments values ('B007', 'c0005', 'C');
insert into enrollments values ('B008', 'c0009', null);

create sequence log#_seq start with 100 increment by 1;

create or replace trigger students_delete_enroll
before delete on Students
for each row
begin
delete from enrollments where B#=:old.B#;
update classes set ta_B# = null where ta_B#=:old.B#;
delete from tas where B#=:old.B#;
end;
/
show errors



create or replace trigger enrollment_delete
after delete on enrollments
for each row
begin
 update classes set class_size=class_size-1
  where classid=:new.classid;
end;
/
show errors

create or replace trigger enrollment_insert
after insert on enrollments
for each row 
begin
 update classes set class_size=class_size+1 where 
 classid=:new.classid;
end;
/
show errors


create or replace trigger trigger_student_insert
after delete on enrollments
for each row
DECLARE
    cl_id VARCHAR2(150);
begin
cl_id := :new.classid;
update classes set class_size=class_size-1
where
classid = :OLD.classid;
end;
/
show errors




create or replace trigger delete_enrollment_logs
after delete on Enrollments
for each row
declare
name varchar2(20);
begin
select user into name from dual;
insert into Logs values
(log#_seq.nextval,name,sysdate,'Enrollments','delete',:old.B#||','||:old.classid);
end;
/
show errors

create or replace trigger insert_enrollment_logs
after insert on Enrollments
for each row
declare
name varchar2(20);
begin
select user into name from dual;
insert into Logs values
(log#_seq.nextval,name,sysdate,'Enrollments','insert',:new.B#||','||:new.classid);
end;
/
show errors

create or replace trigger insert_student_logs
after insert on Students
for each row
declare
name varchar2(20);
begin
select user into name from dual;
insert into Logs values
(log#_seq.nextval,name,sysdate,'Students','insert',:new.B#);
end;
/
show errors

create or replace trigger delete_student_logs
after delete on Students
for each row
declare
name varchar2(20);
begin
select user into name from dual;
insert into Logs values
(log#_seq.nextval,name,sysdate,'Students','delete',:old.B#);
end;
/
show errors




SET SERVEROUTPUT ON

create or replace package database as
procedure show_students(studc out sys_refcursor);
procedure show_tas(tasc out sys_refcursor);
procedure show_courses(coursesc out sys_refcursor);
procedure show_classes(classesc out sys_refcursor);
procedure show_enrollments(enrollmentsc out sys_refcursor);
procedure show_prerequisites(prerequisitesc out sys_refcursor);
procedure student_tas(p_classid in classes.classid%type, s_cursor out sys_refcursor);
procedure drop_student(s_B# in Students.B#%type,s_classid in Classes.classid%type,message out varchar2);
procedure delete_stud(given_B# in Students.B#%type);
procedure Students_enrollments(b in enrollments.B#%type,class_no in enrollments.classid%type, message3 out varchar2);
procedure show_logs(logsc out sys_refcursor);
procedure p_prerequisites(p_dept_code in prerequisites.dept_code%type, p_course# in prerequisites.course#%type, p_cursor out sys_refcursor );
end database;
/

create or replace package body database as 
procedure show_students(studc out sys_refcursor) is
begin
OPEN studc FOR
SELECT * FROM students;
end show_students;

procedure show_tas(tasc out sys_refcursor) is
begin
OPEN tasc FOR
SELECT * FROM TAs;
end show_tas;

procedure show_courses(coursesc out sys_refcursor) is
begin
OPEN coursesc FOR
SELECT * FROM courses;
end show_courses;

procedure show_classes(classesc out sys_refcursor) is
begin
OPEN classesc FOR
SELECT * FROM classes;
end show_classes;

procedure show_enrollments(enrollmentsc out sys_refcursor) is
begin
OPEN enrollmentsc FOR
SELECT * FROM enrollments;
end show_enrollments;

procedure show_prerequisites(prerequisitesc out sys_refcursor) is
begin
OPEN prerequisitesc FOR
SELECT * FROM prerequisites;
end show_prerequisites;

procedure show_logs(logsc out sys_refcursor) is
begin
OPEN logsc FOR
SELECT * FROM logs;
end show_logs;



procedure student_tas(p_classid in classes.classid%type, s_cursor out sys_refcursor) as
   s_TaBNo classes.TA_B#%type;
   count_ta classes.TA_B#%type;
   Ta_error Exception;
   Taclass_error Exception;
begin
    select count(*) into s_TaBNo from classes where classid = p_classid;
    select count(*) into count_ta from classes c, TAs t where c.classid = p_classid and t.B# = c.ta_B#;
    if (s_TaBNo = 0) then
      raise Ta_error;
    end if;

    if(count_ta = 0) then
        raise Taclass_error;
    end if;
        
        open s_cursor FOR
        select s.B#,s.first_name,s.last_name from students s,classes c,TAs t where s.B# = t.B# and t.B# = c.ta_B# and c.classid = p_classid;
      
exception
when Ta_error then
raise_application_error(-20001,'The class is invalid');
when Taclass_error then
raise_application_error(-20002,'The class has no ta');
when others then
raise_application_error(-20002,sqlcode||' : ' || sqlerrm);
end student_tas;




procedure delete_stud(given_B# in Students.B#%type) is
student_count number;
bn Exception;
begin
SELECT count(*) into student_count FROM students WHERE B#=given_B#;
if(student_count=0) then
raise bn;
end if;

DELETE FROM students WHERE B#=given_B#;
commit;
exception
when bn then
raise_application_error(-20003,'The B number inserted is invalid');
when others then
raise_application_error(-20002,sqlcode||' : ' || sqlerrm);
end delete_stud;



procedure p_prerequisites(p_dept_code in prerequisites.dept_code%type, p_course# in prerequisites.course#%type, p_cursor out sys_refcursor ) is
    cursor p_req_cursor is
    select pre_dept_code, pre_course# from prerequisites
    where dept_code = p_dept_code
    and course#=p_course#;
   p_req_record p_req_cursor%rowtype; 
   count_prereq number;
   exp Exception;
   
   begin
    insert into prerequisites_temp select pre_dept_code,pre_course# from prerequisites where dept_code=p_dept_code and course#=p_course#;
    open p_req_cursor;
    loop 
      fetch p_req_cursor into p_req_record;
      exit when p_req_cursor%notfound;
    p_prerequisites(p_req_record.pre_dept_code,p_req_record.pre_course#,p_cursor);
    end loop; 
    open p_cursor for select * from prerequisites_temp;
    select count(*) into count_prereq from prerequisites_temp;
    if(count_prereq < 1) then
      raise exp;
    end if;
    close p_req_cursor;

    exception
    when exp then
    raise_application_error(-20005,  p_dept_code || p_course# || ' does not exist.');
      when others then
    raise_application_error(-200010,sqlcode||' : ' || sqlerrm);
    end p_prerequisites;



procedure Students_enrollments(b in enrollments.B#%type,class_no in enrollments.classid%type, message3 out varchar2) is
a1 number;
a2 number;
a3 number;
a4 number;
a5 number;
a6 number;
a7 varchar2(8);
a12 number;
p_dept prerequisites.pre_dept_code%type;
p_code prerequisites.pre_course#%type;
dpt_code classes.dept_code%type;
class_num classes.course#%type;
c_pre classes.classid%type;
req_p number;
	
	begin
		select count(*) into a1 from students where B#=b;
		select count(*) into a2 from classes where classid=class_no;
		if(a2=0) then
			message3:='The classid is invalid';
			return;
		end if;	
		
		
		select limit into a3 from classes where classid=class_no;
		select class_size into a4 from classes where classid=class_no;
		select count(*) into a5 from enrollments where B#=b and classid=class_no;
		select year into a6 from classes where classid=class_no;
		select semester into a7 from classes where classid=class_no;
		select count(B#) into a12 from enrollments e,classes c where B#=b and c.year=2018 and c.semester='Fall' and e.classid=c.classid;
		/*select distinct dept_code,course# into d_code,c_no from classes where classid=cid;
		select distinct pre_dept_code,pre_course# into pre_dept,pre_c from prerequisites where dept_code=d_code and c_no=course#;
		select distinct classid into c_pre_id from classes where dept_code=pre_dept and course#=pre_c;
		select count(*) into c_prereq from enrollments where B#=bno and classid=c_pre_id;*/
		
		if(a1=0) then
			message3:='B# is invalid';
			return;
		
		/*elsif(c=0) then
			message3:=('The classid is invalid');*/
		
		elsif(a3=a4) then
			message3:='The class is already full';
			return;
			
		elsif(a5=1) then
			message3:='The students is already in the class';
			return;
			
		/*elsif(req_p=0) then
			message3:='Prerequisite not satisfied';
			return;*/
			
		elsif(a6!=2018 or a7!='Fall') then
			message3:='Student cannot enroll into a class from a previous semester';
			return;
			
		elsif(a12=4) then
			message3:='The student will be overloaded with the new enrollment';
			INSERT into enrollments values(b,class_no,null);
			return;
			
		elsif(a12=5) then
			message3:='Students cannot be enrolled in more than five classes in the same semester';
			return;
		
		else
			INSERT into enrollments values(b,class_no,null);
		end if;
	
	end Students_enrollments;

procedure drop_student(s_B# in Students.B#%type,s_classid in Classes.classid%type,message out varchar2) is
s_enrollment number;
v_classid number;
v_B# number;
s_valid number;
last number;
nop number;


BEGIN
SELECT count(*) into v_B# FROM students g  where g.B#=s_B#;
SELECT count(*) into v_classid FROM classes c WHERE s_classid=c.classid;
SELECT count(*) into s_enrollment FROM enrollments  e WHERE e.B#=s_B#;
SELECT count(*) into s_valid FROM classes c  WHERE s_classid=c.classid and year=2018 and semester='Fall';

if(v_B#=0) then
message:='The B# is invalid';

elsif(v_classid=0) then
message:='The classid is invalid';

elsif(s_enrollment=0 AND v_B#=1) then
message:='The student is not enrolled in the class';

elsif(s_valid=0) then
message:='Only enrollment in the current semester can be dropped';

else 

DELETE FROM enrollments where B#=s_B# and classid=s_classid;
SELECT count(*) into last FROM enrollments h WHERE h.B#=s_B#;
SELECT count(*) into nop FROM enrollments WHERE classid=s_classid;

END IF;

if(last=0) then
message:='This student is not enrolled in any other  classes';
END IF;

if(nop=0) then
message:='The class now has no students';
end IF;

end drop_student;

   

end database;
/
show errors



