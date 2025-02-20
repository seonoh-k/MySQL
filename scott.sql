-- 2.17
-- 테이블 정보 조회
select * from tab;
SELECT ALL JOB, DEPTNO FROM EMP;
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
SELECT * FROM EMP WHERE DEPTNO = 30 OR JOB = 'CLERK';
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

-- 2.18
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
-- 사원 이름이 S로 끝나는 사원 데이터 조회
select * from emp where ename like '%S';

-- 30번 부서에 속한 사원 중에 직책이 SALESMAN인 사원의 사번, 이름, 직책, 급여, 부서번호를 조회
select empno, ename, job, sal, deptno from emp where deptno = 30 and job = 'SALESMAN';

-- 20,30번 부서에 속한 사원 중 급여가 2000 초과인 사원의 사번, 이름, 급여, 부서번호를 조회
-- 집합 연산자 X
select empno, ename, sal, deptno from emp where deptno in(20, 30) and sal > 2000;

-- 집합 연산자 O
select empno, ename, sal, deptno from emp where deptno in (20, 30)
intersect
select empno, ename, sal, deptno from emp where sal > 2000;

-- NOT BETWEEN A AND B 연산자 없이 급여가 2000 이상 3000 이하 범위 외인 데이터만 조회
select * from emp where sal < 2000 or sal > 3000;

-- 사원 이름에 E가 포함되어 있는 30번 부서의 사원 중 급여가 1000 ~ 2000 사이가 아닌 사원의 이름, 사번, 급여, 부서번호를 조회
select ename, empno, sal, deptno from emp where ename like '%E%' and deptno = 30
intersect
select ename, empno, sal, deptno from emp where sal < 1000 or sal > 2000;

-- 추가 수당이 없고, 상급자가 있고 직책이 MANAGER, CLERK인 사원 중 이름의 두번째 글자가 L이 아닌 사원의 정보를 조회
select * from emp where job in ('MANAGER', 'CLERK') and comm is null
minus
select * from emp where ename like '_L%';

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
select upper(ename),lower(ename), initcap(ename) from emp;

-- 문자의 대소문자 구분 없이 조회하는 방식
select * from emp where lower(ename) = 'ford';
SELECT LENGTH('한글'), LENGTHB('한글') FROM DUAL;
select ename,length(ename) from emp where length(ename) >= 5;

-- 3번째 글자부터 2글자 / 3번째 글자부터 마지막까지 / 뒤에서 두번째 글자부터 마지막까지 
select ename, substr(ename,3,2),substr(ename,3),substr(ename,-2) from emp;

-- A의 위치값 / 시작 위치에서 3번째에 위치한 A / A가 두번째로 들어간 위치값 
select ename, instr(ename,'A'), instr(ename,'A',3), instr(ename,'A',2,2) from emp;

-- 이름에 S가 포함된 사원만 조회
select * from emp where instr(ename,'S')>0;

-- dual 테스트 테이블
-- '-'를 아무것도 대체하지 않음 / '-'를 공백으로 대체
select '000-1111-1234', replace('010-1111-1234', '-'), replace('010-1111-1234','-',' ') from dual;

select lpad(ename,10,'#'),    -- 왼쪽 공백에 # 삽입
        rpad(ename, 10, '*'), -- 오른쪽 공백에 * 삽입
        lpad(ename, 10),      -- 왼쪽 공백
        rpad(ename, 10)       -- 오른쪽 공백
    from emp;

-- 같은 표현
select concat(ename,concat('는 ',concat(job,'입니다'))) as "직업정보" from emp;
select ename || '는 ' || job || '입니다' as 직업정보 from emp;

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
select * from emp where mod(empno,2) = 0;


-- 날짜 관련 함수
-- sysdate          : 현재 시스템의 날짜
-- add_month()      : 개월 수 연산
-- months_between() : 개월수 간 차이
-- next_day()       : 입력한 날짜에서 돌아오는 요일의 날짜를 반환
-- last_day()       : 달의 마지막 날짜

select sysdate-1 as 어제,
        sysdate as 오늘,
        sysdate+1 as 내일 
    from dual;

select trunc(sysdate - hiredate) as 일수,
        trunc((sysdate - hiredate)/365) as 년수 
    from emp;

-- sysdate에 + 3개월
select sysdate, add_months(sysdate,3) from dual;

-- 입사하고 10년이 된 날짜
select hiredate,add_months(hiredate,120) as "10주년" from emp;

select empno, ename, hiredate, sysdate,
        months_between(hiredate, sysdate) as month1,
        months_between(sysdate, hiredate) as month2,
        trunc(months_between(sysdate, hiredate)) as month3
    from emp;

select sysdate,
        next_day(sysdate, '월요일'), -- 다음 주 월요일
        last_day(sysdate)           -- 해당 날짜가 속한 달의 마지막 날짜
    from dual;

select sysdate,
        round(sysdate, 'cc') as cc,     -- 네자리 연도의 끝자리를 기준으로 사용 (2050년 이하는 2001년이 된다) 
        round(sysdate, 'yyyy') as yyyy, -- 해당 연,월,일의 7월 1일을 기준으로 사용 (2016년 7월 1일이면 2017년이 된다)
        round(sysdate, 'q') as q,       -- 각 분기의 두번째 달의 16일을 기준으로 사용
        round(sysdate, 'ddd') as ddd,   -- 해당 일의 정오를 기준으로 사용
        round(sysdate, 'hh') as hh      -- 해당 일의 시간을 기준으로 사용
    from dual;
    
select sysdate,
        trunc(sysdate, 'cc') as cc,
        trunc(sysdate, 'yyyy') as yyyy,
        trunc(sysdate, 'q') as q,
        trunc(sysdate, 'ddd') as ddd,
        trunc(sysdate, 'hh') as hh
    from dual;

-- 근무 기간이 40년 미만인 사원 조회
select * from emp where trunc((sysdate-hiredate)/365) < 40;
select * from emp where add_months(hiredate, 480) > sysdate;
select * from emp where months_between(sysdate, hiredate) < 480;


-- 형 변환 함수
-- 자동 형 변환 : 숫자를 입력한 문자 데이터는 자동으로 형 변환
-- 수동 형 변환
-- to_char()   : 날짜, 숫자 데이터를 문자로 변환
-- to_number() : 문자 데이터를 숫자로 변환
-- to_date()   : 문자 데이터를 날짜로 변환

-- 숫자로 입력된 문자 데이터가 자동으로 숫자로 형 변환 된다. 그 외에는 자동 형 변환이 어려움
select empno, ename, empno + '500' from emp where ename = 'SCOTT'; 
select 'ABCD' + empno, empno from emp where ename = 'SCORR'; -- 자동 형 변환되지 않음. error

select sysdate, to_char(sysdate,'yyyy-mm-dd hh24:mm:ss') as 현재날짜시각 from dual;

select sysdate,
        to_char(sysdate, 'mm') as mm,       -- 월(두자리 숫자)
        to_char(sysdate, 'mon') as mon,     -- 월(언어별 월 이름 약자)
        to_char(sysdate, 'month') as month, -- 월(언어별 월 이름 전체)
        to_char(sysdate, 'dd') as dd,       -- 일(두자리 숫자)
        to_char(sysdate, 'dy') as dy,       -- 요일(언어별 요일 이름 약자)
        to_char(sysdate, 'day') as day      -- 요일(언어별 요일 이름 전체)
    from dual;
    
-- 날짜 출력 언어 지정
select sysdate,
        to_char(sysdate, 'mm') as mm,
        to_char(sysdate, 'mon', 'nls_date_language = korean') as mon_kor,
        to_char(sysdate, 'mon', 'nls_date_language = japanese') as mon_jpn,
        to_char(sysdate, 'mon', 'nls_date_language = english') as mon_eng,
        to_char(sysdate, 'month', 'nls_date_language = korean') as mon_kor,
        to_char(sysdate, 'month', 'nls_date_language = japanese') as month_jpn,
        to_char(sysdate, 'month', 'nls_date_language = english') as month_eng
    from dual;
    
select sysdate,
        to_char(sysdate, 'mm') as mm,
        to_char(sysdate, 'dd') as dd,
        to_char(sysdate, 'dy', 'nls_date_language = korean') as dy_kor,
        to_char(sysdate, 'dy', 'nls_date_language = japanese') as dy_jpn,
        to_char(sysdate, 'dy', 'nls_date_language = english') as dy_eng,
        to_char(sysdate, 'day', 'nls_date_language = korean') as day_kor,
        to_char(sysdate, 'day', 'nls_date_language = japanese') as day_jpn,
        to_char(sysdate, 'day', 'nls_date_language = english') as day_eng
    from dual;
    
-- 시간 형식을 지정하여 출력
select sysdate,
        to_char(sysdate, 'hh24:mi:ss') as hh24miss,
        to_char(sysdate, 'hh12:mi:ss am') as hhmiss_am, -- 둘다 오전, 오후 표시
        to_char(sysdate, 'hh:mi:ss p.m.') as hhmiss_pm
    from dual;

-- 숫자 형식을 지정하여 출력
select sal,
        to_char(sal, '$999,999') as sal_$,
        to_char(sal, 'L999,999') as sal_L,
        to_char(sal, '999,999.00') as sal_1,
        to_char(sal, '000,999,999.00') as sal_2,
        to_char(sal, '000999999.99') as sal_3,
        to_char(sal, '999,999,00') as sal_4
    from emp;
        
-- 문자 데이터와 숫자 데이터를 연산하여 출력하기 (자동 형 변환)
select 1300 - '1500', '1300' - 1500 from dual;

-- 문자 데이터끼리 연산하여 출력하기 (쉼표 때문에 숫자로 변환되지 않음)
select '1,300' - '1,500' from dual;

-- to_number 함수로 연산하여 출력하기 (인식될 숫자 형태를 입력)
select to_number('1,300', '999,999') - to_number('1,500', '999,999') from dual;

-- to_date 함수로 문자 데이터를 날짜 데이터로 변환
select to_date('2018-07-14', 'yyyy-mm-dd') as todate1,
        to_date('20180714', 'yyyy-mm-dd') as todate2
    from dual;
    
-- 1981년 6월 1일 이후에 입사한 사원 정보 출력하기
select * from emp where hiredate > to_date('1981/06/01', 'yyyy/mm/dd');

-- 여러가지 형식으로 날짜 데이터 출력하기
select to_date('49/12/10', 'yy/mm/dd') as yy_year_49,
        to_date('49/12/10', 'rr/mm/dd') as rr_year_49,
        to_date('50/12/10', 'yy/mm/dd') as yy_year_50,
        to_date('50/12/10', 'rr/mm/dd') as rr_year_50,
        to_date('51/12/10', 'yy/mm/dd') as yy_year_51,
        to_date('51/12/10', 'rr/mm/dd') as rr_year_51
    from dual;

-- nvl 함수
-- null값을 원하는 값으로 변경하는 함수
-- 사용방법 : nvl(null, 변경하고 싶은 값)
-- 주의사항 : null의 타입과 변경값의 타입이 같아야함(자동형변환 가능할 경우는 예외)

--comm없는 직원들의 연봉 구하는 방법
-- 값이 null일때만 동작하므로 comm이 있는 직원에게는 영향X
select ename,sal,comm,sal*12 + nvl(comm,0) from emp;

-- 2.19
-- mgr이 null값인 사원의 mgr을 ceo로 대체
select ename, mgr, nvl(to_char(mgr, '9999'), 'CEO') as MGR_1 from emp where mgr is null;

-- nvl2 함수
-- 데이터가 null이 아닐 때 반환할 데이터를 추가로 지정할 수 있다.
-- nvl2 (컬럼명, null이 아닐때 반환값, null일 때 반환값)
select empno, ename, comm, nvl2(comm, 'o', 'x'), nvl2(comm, sal*12+comm, sal*12) as annsal from emp;

-- decode(값1, 비교값1, 결과값1, 비교값2, 결과값2, 비교값3, 결과값3, default결과) : switch - case와 비슷함
-- 값1에 대해 비교값1이라면 결과값1을 적용, 비교값2라면 결과값2 적용, 비교값3이라면 결과값3 적용, default결과를 적용
-- 범위 표현 X
select empno, ename, job, sal,
        decode(job, 'MANAGER', sal * 1.1, 'SALESMAN', sal * 1.05, 'ANALYST', sal, sal * 1.03) as upsal
    from emp;
    
-- case : if ~ else (다중 조건문)
--  when 값 또는 조건식 then 결과 1
--  when 값 또는 조건식 then 결과 2
--  when 값 또는 조건식 then 결과 3
--  else 결과4
-- end
-- 범위 표현 O

select empno, ename, comm,
        case
         when comm is null then '해당사항없음'
         when comm = 0 then '성과급없음'
         when comm > 0 then '성과급 : ' || comm
         else '결과없음'
        end as comm_result
from emp;

-- 책 174p 실습 문제
-- 사원 이름이 5글자 이상 6글자 미만인 사원 정보를 출력하고, 사번의 앞 두글자 이후를 *로, 이름의 첫글짜 이후를 *로 출력하라
select empno, replace(empno, substr(empno, -2), '**') as masking_empno,
        ename, replace(ename, substr(ename, 2), '****') as masking_ename
    from emp where length(ename) >= 5 and length(ename) < 6;
    
select empno, rpad(substr(empno, 1, 2), length(empno), '*') as masking_empno,
        ename, rpad(substr(ename, 1, 1), length(ename), '*') as masking_ename
    from emp where length(ename) >= 5 and length(ename) < 6;

-- 사원들의 월 평균 근무일이 21.5일이고 하루 근무 시간이 8시간이라고 할때, 일급과 시급을 출력하라
select empno, ename, sal,
        trunc(sal / 21.5, 2) as day_pay,
        round((sal / 21.5) / 8, 1) as time_pay
    from emp;
    
-- 입사일 기준 3개월 뒤 첫 월요일에 정사원이 된다고 한다면, 사원이 정직원이 된 날짜를 yyyy-mm-dd 형식으로 출력하고, 추가수당이 없다면 N/A로 출력하라
select empno, ename, hiredate,
        to_char(next_day(add_months(hiredate, 3), '월요일'), 'yyyy-mm-dd') as r_job,
        case
            when comm is null then nvl(to_char(comm, '9999'), 'N/A')
            else nvl(to_char(comm, '9999'), comm)
        end as comm
    from emp;
    
-- 모든 사원을 대상으로 직속 상관의 사원 번호를 조건에 따라 변환해서 출력하라
-- 직속 상관의 사원 번호가 없다면 0000
-- 사원 번호 앞 두자리가 75일 경우 5555
-- 76일 경우 6666
-- 77일 경우 7777
-- 78일 경우 8888
-- 그 외 사원 번호인 경우 그대로 출력
select empno, ename, mgr,
        case
            when mgr like '75%' then 5555
            when mgr like '76%' then 6666
            when mgr like '77%' then 7777
            when mgr like '78%' then 8888
            when mgr is null then 0000 
            else mgr
        end as chg_mgr
    from emp;
    
-- 결과의 개수
-- 단일행 함수 : 각 행에 각각 결과를 적용한다.
-- 다중행 함수 : 각 행의 결과를 하나의 값으로 만든다.
-- 다중행 함수와 일반 컬럼은 같이 사용할 수 없다.
-- 항상 결과의 레코드의 개수가 일치해야하기 때문
-- sum()   : 조회된 행에 지정한 열 값을 모두 더한 값을 반환
-- count() : 데이터 개수 (행 개수) 반환
-- max()   : 데이터 중 최대값 반환
-- min()   : 데이터 중 최소값 반환
-- avg()   : 데이터의 평균 값 반환

select sum(sal) from emp;
select count(sal) from emp;
select max(sal) from emp;
select min(sal) from emp;
select avg(sal) from emp;

select comm from emp;
select sum(comm) from emp; -- 다중행 함수는 자동으로 null 값을 처리한다

select sum(distinct sal), -- 중복 데이터는 제외
        sum(all sal),
        sum(sal)
    from emp;
    
select ename, sum(sal) from emp; -- 행의 개수가 다르기 때문에 에러 발생

select count(*) from emp where deptno = 30; -- 30번 부서에 속한 사원의 수
select count(distinct sal), -- 중복 데이터는 제외
        count(all sal), 
        count(sal)
    from emp;
    
select count(comm) from emp;
select count(comm) from emp where comm is not null;

select max(sal) from emp where deptno = 10;
select min(sal) from emp where deptno = 10;

select max(hiredate) from emp where deptno = 20; -- 20번 부서에 속한 사원의 입사일 중 가장 최근 입사일
select min(hiredate) from emp where deptno = 20; -- 20번 부서에 속한 사원의 입사일 중 가장 오래된 입사일

select avg(sal) from emp where deptno = 30; -- 30번 부서의 평균 급여
select avg(distinct sal) from emp where deptno = 30; -- 중복 데이터를 제외한 평균

-- group by 절
-- 레코드를 특정 기준으로 묶어서 연산한다.

-- 부서 번호 별로 따로 조회
select avg(sal) from emp where deptno = 10;
select avg(sal) from emp where deptno = 20;
select avg(sal) from emp where deptno = 30;

-- 집합 연산자를 사용해 동시에 조회
select avg(sal) from emp where deptno = 10
union all
select avg(sal) from emp where deptno = 20
union all
select avg(sal) from emp where deptno = 30;

-- group by절을 사용해 부서 번호 별로 그룹화하여 조회
select avg(sal), deptno from emp group by deptno;

-- group by로 그룹화 한 뒤 order by로 정렬
select deptno, job, avg(sal) from emp group by deptno, job order by deptno, job;

-- group by절에 없는 열을 select절에 포함한 경우 에러 발생
-- deptno 그룹화 되어 한 레코드에 출력되고, avg(sal)도 한 레코드에 출력 되지만 ename은 레코드의 개수가 다르기 때문에 에러 발생
select ename, deptno, avg(sal) from emp group by deptno; 

-- having절
-- group by절이 존재할 때만 사용할 수 있다.
-- 그룹화 된 결과 값의 범위를 제한한다.

-- 그룹화한 뒤 having절의 조건에 맞는 레코드만을 조회
select deptno, job, avg(sal) from emp
    group by deptno, job having avg(sal) >= 2000
    order by deptno, job;
    
-- where절은 출력 대상 행을 제한하고, having절은 그룹화 된 대상을 출력에서 제한한다.
select deptno, job, avg(sal) from emp where avg(sal) >= 2000
    group by deptno, job order by deptno, job;
    
-- having절만 사용한 경우
select deptno, job, avg(sal) from emp
    group by deptno, job having avg(sal) >= 2000
    order by deptno, job;
    
-- where절과 having절을 모두 사용한 경우
-- where절이 먼저 실행되어 조건에 맞는 데이터만 group by, having절에서 사용할 수 있다.
select deptno, job, avg(sal) from emp where sal <= 3000
    group by deptno, job having avg(sal) >= 2000
    order by deptno, job;

-- 동작 순서
-- select 5
-- from 1
-- where 2
-- group by 3
-- having 4
-- order by 6

-- 그룹화와 관련된 함수
-- group by 절에 지정할 수 있는 특수 함수
-- rollup        : 그룹화 데이터의 합계를 함께 출력
-- cube          : 그룹화 데이터의 합계를 함께 출력
-- grouping sets : 같은 수준의 그룹화 열이 여러 개일 때 각 열별 그룹화를 통해 결과값을 출력

-- group by절만 사용한 그룹화
select deptno, job, count(*), max(sal), sum(sal), avg(sal) from emp
    group by deptno, job order by deptno, job;
    
-- rollup 함수를 적용한 그룹화
-- 그룹화하여 연산된 데이터를 대상으로 같은 연산을 수행해 새로운 열에 출력한다.
-- rollup 함수에는 그룹 함수(다중행 함수)를 지정할 수 없다.
select deptno, job, count(*), max(sal), sum(sal), avg(sal) from emp
    group by rollup(deptno, job);
    
-- cube 함수를 적용한 그룹화
-- rollup 함수와 비슷한 결과를 출력하지만 좀 더 많은 결과를 출력한다.
-- 지정한 모든 열에서 가능한 조합의 결과를 모두 출력한다.
select deptno, job, count(*), max(sal), sum(sal), avg(sal) from emp
    group by cube(deptno, job) order by deptno, job;
    
-- ROLLUP(A, B, C)
-- 1. A 그룹별 B 그룹별 C 그룹에 해당하는 결과 출력
-- 2. A 그룹별 B 그룹에 해당하는 결과 출력
-- 3. A 그룹에 해당하는 결과 출력
-- 4. 전체 데이처 결과 출력

-- CUBE(A, B, C)
-- 1. A 그룹별 B 그룹별 C 그룹에 해당하는 결과 출력
-- 2. A 그룹별 B 그룹의 결과 출력
-- 3. B 그룹별 C 그룹의 결과 출력
-- 4. A 그룹별 C 그룹의 결과 출력
-- 5. A 그룹 결과
-- 6. B 그룹 결과
-- 7. C 그룹 결과
-- 8. 전체 데이터 결과

-- deptno를 먼저 그룹화 한 후 rollup 함수에 job 지정
select deptno, job, count(*) from emp
    group by deptno, rollup(job);
-- job을 먼저 그룹화 한 후 rollup 함수에 deptno 지정
select deptno, job, count(*) from emp
    group by job, rollup(deptno);
    
-- grouping sets 함수를 사용하여 열별로 그룹으로 묶어 출력
-- 그룹화을 위해 지정된 열이 각각 따로 그룹화 한 후에 연산을 수행한다.
select deptno, job, count(*) from emp
    group by grouping sets(deptno, job) order by deptno, job;
    
-- 그룹화 함수
-- grouping
-- rollup 또는 cube 함수를 사용한 group by절에 그룹화 대상으로 지정한 열이 그룹화된 상태로 결과가 집계되었는지를 확인
-- group by절에 명시된 열 중 하나를 지정할 수 있다.

-- 그룹화된 열은 0, 그렇지 않으면 1을 출력
select deptno, job, count(*), max(sal), sum(sal), avg(sal),
        grouping(deptno), grouping(job) from emp
    group by cube(deptno, job) order by deptno, job;
    
-- decode문으로 grouping 함수를 적용하여 결과 출력
select decode(grouping(deptno), 1, 'all_dept', deptno) as deptno,
        decode(grouping(job), 1, 'all_job', job) as job,
        count(*), max(sal), sum(sal), avg(sal) from emp
    group by cube(deptno, job) order by deptno,job;

-- grouping_id
-- rollup 또는 cube 함수로 연산할 때 특정 열이 그룹화 되었는지 확인
-- 한번에 여러 열을 지정할 수 있다.
-- 지정한 열의 순서에 따라 0,1이 출력되고, 이를  0과 1로 구성된 그룹화 비트 벡터값으로 표현한다.
-- 그룹화 비트 벡터 값을 2진수로 보고 10진수로 바꾼 값이 최종 결과로 출력된다.
select deptno, job, count(*), sum(sal),
        grouping(deptno), grouping(job), grouping_id(deptno, job)
    from emp group by cube(deptno, job) order by deptno, job;
    
-- listagg 함수 (oracle 11g 이후)
-- listagg (나열할 열, 구분자) within group(order by 나열할 열의 정렬 기준 열)
-- 그룹에 속해 있는 데이터를 가로로 나열할 때 사용한다.

-- 10번 부서에 속한 사원 이름 조회
select ename from emp where deptno = 10;

-- group by절로 그룹화하여 부서 번호와 사원 이름 출력
select deptno, ename from emp group by deptno, ename;

-- 부서별 사원 이름을 나란히 나열하여 출력
select deptno, listagg(ename, ',') within group(order by sal desc) as enames
    from emp group by deptno;

-- pivot, unpivot 함수 (oracle 11g 이후)
-- pivot   : 기존 테이블 행을 열로 바꿔서 출력
-- unpivot : 기존 테이블 열을 행으로 바꿔서 출력

-- 부서별.직책별로 그룹화하여 최고 급여 데이터 출력
select deptno, job, max(sal) from emp
    group by deptno, job order by deptno, job;
    
-- pivot 함수를 사용하여 직책별.부서별 최고 급여를 2차원 표 형태로 출력하기
select * from(select deptno, job, sal from emp)
    pivot(max(sal) for deptno in (10, 20, 30)) order by job;
    
-- pivot 함수를 사용하여 부서별.직책별 최고 금여를 2차원 표 형태로 출력하기
select * from(select deptno, job, sal from emp) 
    pivot(max(sal) for job in ('CLERK' as CLERK,
                                'SALESMAN' as SALESMAN,
                                'PRESIDENT' as PRESIDENT,
                                'MANAGER' as MANAGER,
                                'ANALYST' as ANALYST))
    order by deptno;
    
-- decode문을 활용하여 pivot 함수와 같은 출력 구현하기
select deptno,
        max(decode(job, 'CLERK', sal)) as CLERK,
        max(decode(job, 'SALESMAN', sal)) as SALESMAN,
        max(decode(job, 'PRESIDENT', sal)) as PRESIDENT,
        max(decode(job, 'MANAGER', sal)) as MANAGER,
        max(decode(job, 'ANALYST', sal)) as ANALYST
    from emp group by deptno order by deptno;
    
-- unpivot 함수를 사용하여 열로 구분된 그룹을 행으로 출력하기
select * from(select deptno,
                max(decode(job, 'CLERK', sal)) as CLERK,
                max(decode(job, 'SALESMAN', sal)) as SALESMAN,
                max(decode(job, 'PRESIDENT', sal)) as PRESIDENT,
                max(decode(job, 'MANAGER', sal)) as MANAGER,
                max(decode(job, 'ANALYST', sal)) as ANALYST
            from emp group by deptno order by deptno)
        unpivot (sal for job in (CLERK, SALESMAN, PRESIDENT, MANAGER, ANALYST))
        order by deptno, job;
   
-- 책 212p 실습 문제

-- 부서 번호, 평균 급여, 최고 급여, 최저 급여, 사원수를 출력하라. 단 평균 급여를 출력할 때 소수점을 제외하고 각 부서 별로 출력하라
select deptno, trunc(avg(sal), 0) as avg_sal, max(sal) as max_sal, min(sal) as min_sal, count(*)
    from emp group by deptno;
    
-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수를 출력하라
select job, count(*) from emp group by job having count(*) >= 3;

-- 사원들의 입사 연도를 기준으로 부서별로 몇명이 입사했는지 출력하라
select to_char(hiredate, 'yyyy') as hire_year, deptno, count(*) from emp
    group by to_char(hiredate, 'yyyy'), deptno;
    
-- 추가 수당을 받는 사원 수와 받지 못하는 사원 수를 출력하라
select case when comm is null then 'X' when comm is not null then 'O' end as exist_comm, count(*) as cnt from emp
    group by case when comm is null then 'X' when comm is not null then 'O' end;

select nvl2(comm, 'O', 'X') as exist_comm, count(*) as cnt from emp
    group by nvl2(comm, 'O', 'X');

-- 각 부서의 입사 연도별 사원 수, 최고 급여, 급여 합, 평균 급여를 출력하고 각 부서별 소계와 총계를 출력하라
select deptno, to_char(hiredate, 'yyyy') as hire_year, count(*) as cnt, max(sal) as max_sal, sum(sal) as sum_sal, avg(sal) as avg_sal
    from emp group by rollup(deptno, to_char(hiredate, 'yyyy'));

-- 조인
-- 두개 이상의 테이블을 사용하여 데이터를 조회
-- 일반조인, 안시조인(표준조인)
-- 두 개의 테이블이 관계를 가지고 있어야 한다

select * from emp;
select * from dept; -- 부서 정보가 다른 테이블에 저장 되어 있다.

-- from절에 여러 테이블 선언하기
select * from emp, dept order by empno;

-- 열 이름을 비교하는 조건식으로 조인하기
select * from emp, dept where emp.deptno = dept.deptno order by empno;

-- 테이블 별칭 설정
select * from emp e, dept d where e.deptno = d.deptno order by empno;

-- 일반 조인
-- inner join 내부 조인
-- cross join
select * from emp, dept;

-- equi join = inner join = simple join 등가 조인
-- 두 개의 테이블의 공통컬럼을 등가 비교

-- 두 테이블에 부서 번호가 똑같은 열 이름으로 포함되어 있을때 에러 발생
select empno, ename, deptno, dname, loc from emp e, dept d where e.deptno = d.deptno;
-- 열 이름에 각각의 테이블 이름도 함께 명시할 때
select e.empno, e.ename, d.deptno, d.dname, d.loc from emp e, dept d
    where e.deptno = d.deptno order by d.deptno, e.empno;
    
-- where절에 추가로 조건식을 넣어 출력하기
select e.empno, e.ename, e.sal, d.deptno, d.dname, d.loc
    from emp e,dept d where e.deptno = d.deptno and sal >= 3000;
    
-- non-equi join 비등가 조인
-- 등가 조인 방식 외의 방식. 범위 비교

select * from emp;
select * from salgrade;

-- 급여 범위를 지정하는 조건식으로 조인하기
select * from emp e, salgrade s where e.sal between s.losal and s.hisal;

-- self join 자체 조인
-- 하나의 테이블을 여러 개의 테이블처럼 활용하여 조인하는 방식
-- 같은 테이블을 여러번 명시하되 별칭만 다르게 지정한다.
-- 큰 범위에서는 등가 조인으로 볼 수 있다

-- 같은 테이블을 두번 사용하여 자체 조인하기
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
    from emp e1, emp e2 where e1.mgr = e2.empno;
    
-- outer join 외부 조인
-- 조인 기준 열의 어느 한 쪽이 null이어도 강제로 출력하는 방식
-- where절에 조인 기준 열 중 한 쪽에 + 기호를 붙여준다.

-- 왼쪽 외부 조인
-- 왼쪽 열을 기준으로 오른쪽 열의 데이터 존재 여부에 상관없이 출력
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
    from emp e1, emp e2 where e1.mgr = e2.empno(+) order by e1.empno;
    
-- 오른쪽 외부 조인
-- 오른쪽 열을 기준으로 왼쪽 열의 데이터 존재 여부에 상관없이 출력
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
    from emp e1, emp e2 where e1.mgr(+) = e2.empno order by e1.empno;

-- emp에 존재하지 않는 40번 부서 출력하기
select empno, ename, sal, e.deptno, d.deptno, d.dname, d.loc
    from emp e, dept d where e.deptno(+) = d.deptno;
    
-- 안시 조인 (표준 조인)
-- SQL-99 표준 문법을 사용한 조인 방식
-- from절에 조인 키워드를 작성한다.
-- 다른 DBMS에서도 사용할 수 있다.

-- natural join
-- 등가 조인을 대신해 사용할 수 있는 조인 방식
-- 두 테이블에 이름과 자료형이 같은 열을 찬은 후 그 열을 기준으로 등가 조인한다.

-- natural join을 사용하여 조인하기
-- 두 테이블이 공통 열 deptno를 가지고 있기 때문에 natural join을 사용할 때 deptno열을 기준으로 등가 조인된다.
-- 등가 조인과 다르게 조인 기준 열인 deptno에 테이블 이름을 붙이면 안된다.
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, deptno, d.dname, d.loc
    from emp e natural join dept d order by deptno, e.empno;
    
-- join ~ using
-- 등가 조인을 대신해 사용할 수 있는 조인 방식
-- using 키워드에 조인 기준으로 사용할 열을 명시하여 사용한다.
-- 기준 열로 명시되는 열에 테이블 이름을 붙이지 않는다.
-- 다른 조인 방식과 마찬가지로 조인된 결과 행을 추가로 제한할 때 where절에 조건식을 추가하여 사용할 수 있다.

-- join ~ using을 사용하여 조인하기
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, deptno, d.dname, d.loc
    from emp e join dept d using (deptno) where sal >= 3000 order by deptno, e.empno;
    
-- join ~ on
-- 가장 범용성 있는 조인 방식
-- 조인 기준 조건식은 on 키워드에 작성하고 그 밖의 출력 행을 걸러 내기 위해 where 조건식을 따로 사용하는 방식
-- 기존 조인 방식과 크게 차이가 나지 않는다.

-- join ~ on으로 등가 조인하기
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno, d.dname, d.loc
    from emp e join dept d on (e.deptno = d.deptno) where sal >= 3000 order by deptno, e.empno;
    
-- outer join 외부 조인
-- 왼쪽 외부 조인
-- where e1.mgr = e2.empno(+)
-- from table1 left outer join table2 on (조인 조건식)
-- 오른쪽 외부 조인
-- where e1.mgr(+) = e2.empno
-- form table1 right outer join table2 on (조인 조건식)
-- 전체 외부 조인
-- 기존 문법 없음 (union 집합 연산자 활용)
-- from table1 full outer join table2 on (조인 조건식)

-- 왼쪽 외부 조인을 SQL-99로 작성하기
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
    from emp e1 left outer join emp e2 on (e1.mgr = e2.empno) order by e1.empno;
    
-- 오른쪽 외부 조인을 SQL-99로 작성하기
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
    from emp e1 right outer join emp e2 on (e1.mgr = e2.empno) order by e1.empno;
    
-- 전체 외부 조인을 SQL-99로 작성하기
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
    from emp e1 full outer join emp e2 on (e1.mgr = e2.empno) order by e1.empno;
    
-- SQL-99 조인 방식에서 세 개 이상의 테이블을 조인할 때
-- 기존 조인 방식
-- from table1, table2, table3 where table1.col = table2.col and table2.col = table3.col
-- SQL-99 조인 방식에서는 조인 내용을 추가로 작성
-- from table1 join table2 on (조건식) join table3 on (조건식)

-- 책 239p 실습 문제
-- 급여가 2000 초과인 사원들의 부서 정보, 사원 정보를 출력하라 (일반 조인과 표준 조인으로 각각 작성)
select e.deptno, d.dname, e.empno, e.ename, e.sal 
    from emp e, dept d where e.deptno = d.deptno and e.sal > 2000 order by deptno;
    
select deptno, d.dname, e.empno, e.ename, e.sal
    from emp e natural join dept d where e.sal > 2000 order by deptno;
    
select deptno, d.dname, e.empno, e.ename, e.sal
    from emp e join dept d using (deptno) where e.sal > 2000 order by deptno;
    
select e.deptno, d.dname, e.empno, e.ename, e.sal
     from emp e join dept d on (e.deptno = d.deptno) where e.sal > 2000 order by deptno;

-- 각 부서별 평균 급여, 최대 급여, 최소 급여, 사원 수를 출력하라 (일반 조인과 표준 조인으로 각각 작성)
select e.deptno, d.dname, trunc(avg(sal)) as avg_sal, max(sal) as max_sal, min(sal) as min_sal, count(*) as cnt
    from emp e, dept d where e.deptno = d.deptno group by e.deptno, d.dname;

select deptno, d.dname, trunc(avg(sal)) as avg_sal, max(sal) as max_sal, min(sal) as min_sal, count(*) as cnt
    from emp e natural join dept d group by deptno, d.dname;
    
select deptno, d.dname, trunc(avg(sal)) as avg_sal, max(sal) as max_sal, min(sal) as min_sal, count(*) as cnt
    from emp e join dept d using (deptno) group by deptno, d.dname;
    
select e.deptno, d.dname, trunc(avg(sal)) as avg_sal, max(sal) as max_sal, min(sal) as min_sal, count(*) as cnt
    from emp e join dept d on (e.deptno = d.deptno) group by e.deptno, d.dname;
-- 모든 부서 정보와 사원 정보를 부서 정보, 사원 이름 순으로 정렬하여 출력하라 (일반 조인과 표준 조인으로 각각 작성)
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
    from emp e, dept d where e.deptno(+) = d.deptno order by d.deptno; 

select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
    from emp e right outer join dept d on (e.deptno = d.deptno) order by d.deptno;

-- 모든 부서 정보, 사원 정보, 급여 등급 정보, 각 사원의 직속 상관의 정보를 부서 번호, 사원 번호 순서로 정렬하여 출력하라 (일반 조인과 표준 조인으로 각각 작성)
select d.deptno, d.dname, e1.empno, e1.ename, e1.mgr, e1.sal, e1.deptno, s.losal, s.hisal, s.grade, e2.empno as mgr_empno, e2.ename as mgr_ename
 from emp e1, emp e2, dept d, salgrade s where d.deptno = e1.deptno(+) and e1.sal between s.losal(+) and s.hisal(+) and e1.mgr = e2.empno(+) 
 order by d.deptno, e1.empno;
 
select d.deptno, d.dname, e1.empno, e1.ename, e1.mgr, e1.sal, e1.deptno, s.losal, s.hisal, s.grade, e2.empno as mgr_empno, e2.ename as mgr_ename
    from emp e1 right outer join dept d on (e1.deptno = d.deptno) left outer join salgrade s on (e1.sal between s.losal and s.hisal)
    left outer join emp e2 on (e1.mgr = e2.empno) order by d.deptno, e1.empno;
------------------------------------------------------------------------------
-- 급여를 가장 많이 받는 사원의 이름과 금액 조회
select ename, max(sal) from emp;

select max(sal) from emp;
select ename, sal from emp where sal >= 5000;

-- 서브쿼리 사용
select ename, sal from emp where sal >= (select max(sal) from emp);

-- 해당 부서별 평균 급여 보다 해당 부서의 급여가 높은 사람
select deptno, avg(sal) from emp group by deptno;

-- 서브쿼리 사용
select deptno, sal from emp where sal > (select avg(sal) from emp) order by deptno;

-- 서브쿼리 sub query
-- 하나의 Query Select  구문을 여러번 정의하는 것
-- SQL문을 실행하는 데 필요한 데이터를 추가로 조회하기 위해 SQL문 내부에서 사용하는 select문
-- 대부분의 서브쿼리에서는 order by절을 사용할 수 없다
-- 스칼라 서브쿼리 : select절에서 사용
-- 인라인 뷰      : form절에서 사용 
-- 중첩 서브쿼리   : where절, having절에서 사용

-- 결과의 개수
-- 단일행 서브쿼리 < > = != <= >=
-- 다중행 서브쿼리 in any some all exists
-- 다중열 서브쿼리

-- 동작 방식
-- 비연관 서브쿼리
-- 연관 서브쿼리


-- 사원 이름이 JONES인 사원의 급여 출력하기
select sal from emp where ename = 'JONES';
-- 급여가 2975 보다 높은 사원 정보 출력하기
select * from emp where sal > 2975;
-- 서브쿼리로 JONES의 급여보다 높은 급여를 받는 사원 정보 출력하기
select * from emp where sal > (select sal from emp where ename = 'JONES');


--- 비연관 서브쿼리 ---

-- 결과의 개수에 따라
-- 단일행 서브쿼리
-- 단일행 서브쿼리는 서브쿼리 결과값이 날자 자료형일 때도 사용할 수 있다.
-- 특정 함수를 사용한 겱과값이 하나일 때 사용

-- 서브쿼리의 결과 값이 날짜형인 경우
select * from emp where hiredate < (select hiredate from emp where ename = 'SCOTT');

-- 서브쿼리 안에서 함수를 사용한 경우 (조인과 서브쿼리를 함께 사용)
select e.empno, e.ename, e.job, e.sal, d.deptno, d.dname, d.loc from emp e, dept d
    where e.deptno = d.deptno and e.deptno = 20 and e.sal > (select avg(sal) from emp);

select empno, ename, job, sal, dname, loc
    from emp e inner join dept d on e.deptno = d.deptno
    where e.deptno = 20 and sal > (select avg(sal) from emp);
    
-- 다중행 서브쿼리
-- 실행 결과 행이 여러개로 나오는 서브쿼리
-- 결과가 여러 개이므로 다중행 연산자를 사용해야 한다.

-- 다중행 연산자
-- in        : 메인쿼리의 데이터가 서브쿼리의 결과 중 하나라도 일치한 데이터가 있다면 true
-- any, some : 메인쿼리의 조건식을 만족하는 서브쿼리의 결과가 하나 이상이면 true
-- all       : 메인쿼리의 조건식을 서브쿼리의 결과 모두가 만족하면 true
-- exists    : 서브쿼리의 결과가 존재하면 (행이 1개 이상일 경우) true

-- in 연산자 사용하기
select * from emp where deptno in (20, 30);

-- 각 부서별 최고 급여와 동일한 급여를 받는 사원 정보 출력하기
select * from emp where sal in (select max(sal) from emp group by deptno);

-- any 연산자 사용하기
select * from emp where sal = any (select max(sal) from emp group by deptno);

-- some 연산자 사용하기
select * from emp where sal = some (select max(sal) from emp group by deptno);

-- 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 정보 출력하기
-- max(sal) 없이 부등기호의 조건에 맞는 행이 전부 출력된다
select * from emp where sal < any (select sal from emp where deptno = 30) order by sal, empno;
-- 30번 부서 사원들의 최소 급여보다 많은 급여를 받는 사원 정보 출력하기
select * from emp where sal > any (select sal from emp where deptno = 30) order by sal, empno;

-- all 연산자 사용하기
-- 부서 번호가 30번인 사원들의 최소 급여보다 더 적은 급여를 받는 사원 출력하기
-- 서브쿼리의 모든 결과값보다 작은 값을 가진 메인쿼리의 행만 출력된다
select * from emp where sal < all (select sal from emp where deptno = 30);
-- 부서 번호가 30번인 사원들의 최대 급여보다 더 많은 급여를 받는 사원 출력하기
select * from emp where sal > all (select sal from emp where deptno = 30);

-- exists 연산자
-- 서브쿼리에 결과값이 하나 이상 존재하면 true

-- 서브쿼리 결과값이 존재하는 경우
select * from emp where exists (select dname from dept where deptno = 10);
-- 서브쿼리 결과값이 존재하지 않는 경우
select * from emp where exists (select dname from dept where deptno = 50);

-- 다중열 서브쿼리 (복수열 서브쿼리)
-- select절에 비교할 데이터를 여러 개 지정하는 방식
-- 메인쿼리에 비교할 열을 괄호로 묶어 명시하고 서브쿼리에서 괄호로 묶은 데이터와 같은 자료형 데이터를 select 절에 명시

-- 다중열 서브쿼리 사용하기
select * from emp where (deptno, sal) in (select deptno, max(sal) from emp group by deptno);

-- 인라인 뷰
-- 특정 테이블 전체 데이터가 아닌 select문을 통해 일부 데이터를 먼저 추출해 온 후 별칭을 주어 사용
select e10.empno, e10.ename, e10.deptno, d.dname, d.loc
    from (select * from emp where deptno = 10) e10, (select * from dept) d
    where e10.deptno = d.deptno;
    
-- with 절
-- 메인쿼리가 될 select문 안에서 사용할 서브쿼리와 별칭을 먼저 지정한 후 메인쿼리에서 사용
with e10 as (select * from emp where deptno = 10), d as (select * from dept)
    select e10.empno, e10.ename, e10.deptno, d.dname, d.loc
    from e10, d where e10.deptno = d.deptno;
    
-- 스칼라 서브쿼리
-- select절에 하나의 열 영역으로서 결과를 출력할 수 있다.
-- select절에 명시하는 서브쿼리는 반드시 하나의 결과만 반환하도록 작성해야한다.

-- select절에 서브쿼리 사용하기
select empno, ename, job, sal, (select grade from salgrade where e.sal between losal and hisal) as salgrade,
    deptno, (select dname from dept where e.deptno = dept.deptno) as dname from emp e;


--- 연관 서브쿼리 ---

-- 책 262p 실습 문제
-- 전체 사원 중 ALLEN과 같은 직책인 사원들의 사원 정보, 부서 정보를 출력하라
select job, empno, ename, sal, deptno, dname from emp join dept
    using (deptno) where job = all (select job from emp where ename = 'ALLEN');

-- 전체 사원의 평균 급여보다 높은 급여를 받는 사원들의 사원 정보, 부서 정보, 급여 등급 정보를 출력하라 (급여가 많은 순, 사원 번호 오름차순)
select empno, ename, dname, hiredate, loc, sal, (select grade from salgrade where sal between losal and hisal) as salgrade
    from emp join dept using (deptno) where sal > any (select avg(sal) from emp) order by sal desc, empno;

-- 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의 사원 정보, 부서 정보를 출력하라
select empno, ename, job, deptno, dname, loc from emp join dept using (deptno)
    where deptno = 10 and job != all (select job from emp where deptno = 30);

-- 직책이 SALESMAN인 사원들의 최고 급여보다 높은 급여를 받는 사원들의 사원 정보, 급여 등급 정보를 출력하라 (다중행 함수를 사용하는 방법과 사용하지 않는 방법, 사원 번호 오름차순)
-- 다중행 함수 미사용
select empno, ename, sal, (select grade from salgrade where sal between losal and hisal) as salgrade
    from emp where sal > all (select sal from emp where job = 'SALESMAN') order by empno;

-- 다중행 함수 사용
select empno, ename, sal, (select grade from salgrade where sal between losal and hisal) as salgrade
    from emp where sal > any (select max(sal) from emp where job = 'SALESMAN') order by empno;

----------------------------
-- 테이블 생성
CREATE TABLE DEPT_COPY AS SELECT * FROM DEPT;

-- 테이블 삭제
-- DROP TABLE DEPT_COPY;

-- 테이블에 데이터 추가하기
-- INSERT
-- INSERT INTO [열1, 열2,... 열N] VALUES (열1에 들어갈 데이터, 열2에 들어갈 데이터...열N에 들어갈 데이터);
-- 지정한 열 개수와 각 열에 입력할 데이터 개수가 일치하지 않거나 자료형이 맞지 않는 경우 또는 열 길이를 초과하는 데이터를 지정하는 경우 에러
INSERT INTO DEPT_COPY (DEPTNO, DNAME, LOC) VALUES (50, 'DATABASE', 'SEOUL');

SELECT * FROM DEPT_COPY;

-- INSERT문에 열 지정 없이 데이터 추가하기
INSERT INTO DEPT_COPY VALUES(60, 'NETWORK', 'BUSAN');

-- NULL 데이터 입력하기
INSERT INTO DEPT_COPY (DEPTNO, DNAME, LOC) VALUES (70, 'WEB', NULL);
-- 빈 공백 문자열로 NULL 입력하기
INSERT INTO DEPT_COPY (DEPTNO, DNAME, LOC) VALUES (80, 'MOBILE', ' ');
-- 열 데이터를 넣지 않는 방식으로 NULL 데이터 입력하기
INSERT INTO DEPT_COPY (DEPTNO, LOC) VALUES (90, 'INCHEON');

-- 날짜 데이터 입력하기
CREATE TABLE EMP_COPY AS SELECT * FROM EMP WHERE 1 <> 1;
DROP TABLE EMP_COPY;
SELECT * FROM EMP_COPY;

-- 날짜 사이에 / 입력
INSERT INTO EMP_COPY (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES (9999, 'HONG', 'PRESIDENT', NULL, '2001/01/01', 5000, 1000, 10);
-- 날짜 사이에 - 입력
INSERT INTO EMP_COPY (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES (1111, 'SUNG', 'MANAGER', 9999, '2001-01-05', 4000, NULL, 20);

-- TO_DATE 함수를 사용하여 날짜 데이터 입력하기
INSERT INTO EMP_COPY (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES (2111, 'LEE', 'MANAGER', 9999, TO_DATE('07/01/2001', 'DD/MM/YYYY'), 4000, NULL, 20);
-- SYSDATE를 사용하여 날짜 데이터 입력하기
INSERT INTO EMP_COPY (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES (3111, 'SIM', 'MANAGER', 9999, SYSDATE, 4000, NULL, 30);
        
-- 서브쿼리로 여러 데이터 추가하기
INSERT INTO EMP_COPY (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
        FROM EMP E, SALGRADE S
        WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL AND S.GRADE = 1;
        