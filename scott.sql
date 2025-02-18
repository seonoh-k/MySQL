-- 테이블 정보 조회
select * from tab;

-- 테이블의 내부 컬럼 구조
--desc dept;

--desc emp;

--desc salgrade;

-- CRUD
-- SQL
-- c(Create) : insert
-- r (Read) : select
-- u (Update) : update
-- d (Delete) : delete

-- select 컬럼명1, 컬럼명2 ...
-- from 테이블명

-- 컬럼(열) 3개, 레코드(행) 4개
--select deptno,dname,loc from dept;

-- 전체 레코드 조회
--select * from dept;

--select * from emp;

-- 중복 데이터 제거
--select distinct job from emp;

select ename,sal from emp;

-- 별칭 as 생략 가능
select ename as "사원이름", sal as "급여" from emp;

select ename,sal, sal*12 from emp;

select ename 사원, sal 급여, sal*12 연봉, comm 추가수당 from emp;
select ename 사원, sal 급여, sal*12+comm 연봉, comm 추가수당 from emp;

-- 정렬 order by asc(오름차순) desc(내림차순)
-- order by 기준 컬럼명 정렬조건 asc/desc 
select * from emp order by empno;
select * from emp order by empno asc;
select * from emp order by empno desc;

select * from emp order by deptno asc, sal desc;

-- 조건절 where 컬럼명 비교연산자 값 -- 조건식(true, false)
select * from emp where empno = 7369;
select * from emp where sal >= 3000;
select * from emp where deptno = 30;

-- 논리 연산자 and or
select * from emp where sal >= 3000 and deptno = 20;
select * from emp where sal >= 3000 or deptno = 20;
select * from emp where sal >= 1000 and sal <= 2000;
select * from emp where sal < 1000 or sal > 2000;

-- 산술 연산자 + - * /(몫)
select * from emp where sal * 12 = 36000;

-- 비교 연산자 < <= > >= = [!=, <> 다르다]
-- 문자 처리 ' ' O, " " X
select * from emp where ename = 'smith'; -- 테이블 안에 저장된 값은 대소문자를 구분한다 error
select * from emp where ename = 'SMITH';

-- 날짜
select * from emp where hiredate = 801217;     -- error
select * from emp where hiredate = 80/12/17;   -- error
select * from emp where hiredate = '80/12/17'; --'19801217'

-- 문자, 날짜의 크기 비교 가능
select * from emp where ename >= 'F';
select * from emp where hiredate >= '811117';

-- 논리연산자 and or not
select * from emp where not sal > 3000;   -- 해당 조건을 제외한 나머지를 조회

-- 같은 표현
select * from emp where sal = 800 or sal = 1500 or sal = 5000;  
select * from emp where sal in(800,1500,5000);

select * from emp where sal not in (800,1500,5000);

-- 같은 표현
select * from emp where sal >=3000 and sal <=5000; 
select * from emp where sal between 3000 and 5000; 

select * from emp where sal not between 3000 and 5000;


-- LIKE 연산자 : 제공된 일부의 값으로 데이터 조회
-- 와일드카드 (_ , %)
-- % : 길이와 상관 없는(공백 포함) 모든 문자 데이터
-- _ : 한 개의 문자 데이터
-- 1.어떤 값으로 시작하는 조건
-- 2.어떤 값으로 끝나는 조건
-- 3.어떤 값을 포함하는 조건
select * from emp where ename = 'FORD';
select * from emp where ename = 'F';

select * from emp where ename like 'F%';   -- F 이후 공백
select * from emp where ename LIKE 'F___'; -- F 이후 공백 3칸
select * from emp where ename like '%D';   -- 마지막 글자 D
select * from emp where ename like '%A__'; -- 공백 A 공백 두칸

-- isnull, not isnull
-- null값은 직접 연산할 수는 없지만 isnull 연산자를 통해 연산이 가능하다
select * from emp where comm is null;
select * from emp where comm is not null;

select ename,sal,comm,sal * 12 + comm "연봉" from emp;

-- 집합연산자
-- 쿼리문(select) 과 쿼리문의 결과를 연산한다.
-- 쿼리문의 컬럼 타입과 갯수가 동일해야 함.
-- 합집합 : union(중복제거) union all(중복포함)
-- 교집합 : intersect
-- 차집합 : minus

select empno,ename,sal,deptno from emp where deptno = 10
union
select empno,ename,sal,deptno from emp where deptno = 20;

select empno,ename,sal,deptno from emp where deptno = 10
union all
select empno,ename,sal,deptno from emp where deptno = 10;

select empno,ename,sal,deptno from emp 
minus
select empno,ename,sal,deptno from emp where deptno = 10;

select empno,ename,sal,deptno from emp
intersect
select empno,ename,sal,deptno from emp where deptno = 10;

-- error
select empno,ename,sal,job from emp
minus
select empno,ename,sal,deptno from emp where deptno = 10;

select empno,ename,sal,deptno from emp where ename like 'S%'
union
select empno,ename,sal,deptno from emp where ename like '%D';

-- 책 125p 문제




-- 문자 관련 함수
-- upper()   : 대문자로 변경
-- lower()   : 소문자로 변경
-- length()  : 문자 길이
-- substr()  : 일부 문자 추출(시작위치는 1부터)
-- instr()   : 특정문자 위치값 찾기
-- replace() : 다른문자로 대체
-- rpad()    : 패딩. 오른쪽 공백에 삽입
-- lpad()    : 패딩. 왼쪽 공백에 삽입
-- concat()  : 문자열 연결
select upper(ename),lower(ename) from emp;

select * from emp where lower(ename) = 'ford';

select ename,length(ename) from emp where length(ename) >= 5;

select ename, substr(ename,3,2),substr(ename,3),substr(ename,-2) from emp;

select ename, instr(ename,'A'),instr(ename,'A',3) from emp;

select ename, instr(ename,'A'), instr(ename,'A',3), instr(ename,'A',2,2) from emp;

select * from emp where instr(ename,'S')>0;

-- dual 테스트 테이블
select '000-1111-1234', replace('010-1111-1234','-','') from dual;

select lpad(ename,10,'#'),
        rpad(ename, 10, '*'),
        lpad(ename, 10),
        rpad(ename, 10)
    from emp;

-- 같은 표현
select concat(ename,concat('는 ',concat(job,' 입니다'))) as "직업정보" from emp;
select ename || '는 ' || job || ' 입니다' as 직업정보 from emp;

-- 숫자 관련 함수
-- round()  : 반올림
-- trunck() : 버리기
-- ceil()   : 강제 반올림
-- floor()  : 강제 버리기
-- mod()    : 나머지 구하기

select round(1234.5678),
        round(1234.5678, 0),  -- 소수점 첫째자리 반올림
        round(1234.5678, 1),  -- 자연수 첫째자리 반올림
        round(1234.5678, 2),  -- 자연수 둘째자리 반올림
        round(1234.5678, -1), -- 소수점 둘째자리 반올림
        round(1234.5678, -2)  -- 소수점 셋째자리 반올림
    from dual;

select trunc(1234.5678),
        trunc(1234.5678, 0),  -- 소수점 첫째자리 이후 버림
        trunc(1234.5678, 1),  -- 소수점 둘째자리 이후 버림
        trunc(1234.5678, 2),  -- 소수점 셋째자리 이후 버림
        trunc(1234.5678, -1), -- 자연수 첫째자리 이후 버림
        trunc(1234.5678, -2)  -- 자연수 둘째자리 이후 버림
    from dual;

select ceil(3.14),   -- 3.14 보다 큰 정수 중 가장 작은 정수
        floor(3.14), -- 3.14 보다 작은 정수 중 가장 큰 정수
        ceil(-3.14), -- -3.14 보다 큰 정수 중  가장 작은 정수
        floor(-3.14) -- -3.14 보다 작은 정수 중 가장 큰 정수
    from dual;

select mod(15, 6),
        mod(10, 2),
        mod(11, 2)
    from dual;

-- 사번이 짝수인 사원 조회
select * from emp where mod(empno,2)=0;


-- 날짜 관련 함수
-- sysdate          : 현재 시스템의 날짜
-- add_month()      : 개월 수 연산
-- months_between() : 개월수 간 차이
-- next_day()       :
-- last_day()       : 달의 마지막 날짜

select sysdate-1 어제,sysdate 오늘,sysdate+1 내일 from dual;

select trunc(sysdate - hiredate) as 일수,trunc((sysdate - hiredate)/365) as 년수 from emp;

-- sysdate 기준 월 + 3개월
select sysdate,add_months(sysdate,3) from dual;

select hiredate,add_months(hiredate,120) as "10주년" from emp;

-- 입사 40년 미만
select * from emp where trunc((sysdate-hiredate)/365) < 40;
select * from emp where add_months(hiredate, 480) > sysdate;
select * from emp where months_between(sysdate, hiredate) < 480;


-- 형 변환 함수
-- 자동 형 변환 : 숫자를 입력한 문자 데이터는 자동으로 형 변환
-- 수동 형 변환
-- to_char()   : 날짜, 숫자 데이터를 문자로 변환
-- to_number() : 문자 데이터를 숫자로 변환
-- to_date()   : 문자 데이터를 날짜로 변환

select sysdate, to_char(sysdate,'yyyy-mm-dd hh24:mm:ss') 현재날짜시각 from dual;

select 100000000, to_char(100000000,'999,999,999,999') from dual;

select sal, to_char(sal,'L999,999') from emp;

select 1300 - 1500 from dual;

select to_number('1,300','999,999') - to_number('1,500','999,999') 뺄셈 from dual;

select to_date('2025/02/18','yyyy/mm/dd') from dual;

select * from emp where hiredate >= '811117'; --자동형변환

select * from emp where hiredate >= to_date('1981,11,17','yyyy/mm/dd');   --형식 문자의 자릿수에 맞게 정의한다.

-- 기타함수
-- nvl() : null값을 원하는 값으로 변경하는 함수
-- 사용방법 : nvl(null, 변경하고 싶은 값)
-- 주의사항 : null의 타입과 변경값의 타입이 같아야함(자동형변환 가능할 경우는 예외)

--comm없는 직원들의 연봉 구하는 방법
-- 값이 null일때만 동작하므로 comm이 있는 직원에게는 영향X
select ename,sal,comm,sal*12 + nvl(comm,0) from emp;