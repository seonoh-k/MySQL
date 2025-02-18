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
select * from emp where hiredate = 801217; -- error
select * from emp where hiredate = 80/12/17; -- error
select * from emp where hiredate = '80/12/17'; --'19801217'

