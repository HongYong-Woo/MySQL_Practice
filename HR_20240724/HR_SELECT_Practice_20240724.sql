--  A.1 데이터 검색 : SELECT

-- [문제 0]사원정보(EMPLOYEE) 테이블에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호, 상사명(last_name)를 출력하시오. 
-- 이때 이름은 성과 이름을 연결하여 Name이라는 별칭으로 출력하시오
select e.employee_id 사원번호, concat(e.first_name, ' ' ,e.last_name) Name, e.salary 급여, j.job_title 업무명,  e.hire_date 입사일,e.manager_id 상사의사원번호, e2.last_name 상사명
from employees e, jobs j, employees e2
where e.job_id = j.job_id and e.manager_id = e2.employee_id;

-- [문제 1] 사원정보(EMPLOYEES) 테이블에서 사원의 성과 이름은 Name, 업무는 Job, 급여는 Salary, 
-- 연봉에 $100 보너스를 추가하여 계산한 값은 Increased Ann_Salary, 
-- 급여에 $100 보너스를 추가하여 계산한 연봉은 Increased Salary라는 별칭으로 출력하시오
select concat(first_name, ' ' ,last_name) Name, job_id Job, salary Salary, (salary*12)+100 "Increased Ann_Salary",
(salary +100) *12 "Increased Salary"
from employees ;

-- [문제 2] 사원정보(EMPLOYEE) 테이블에서 모든 사원의 이름(last_name)과 연봉을 “이름: 1 Year Salary = $연봉” 형식으로 출력하고, 
-- 1 Year Salary라는 별칭을 붙여 출력하시오
select concat(last_name, ' : 1 Year Salary = $', salary*12) as "1 Year Salary" from employees;

-- [문제 3] 부서별로 담당하는 업무를 한 번씩만 출력하시오
select distinct department_id, department_name From departments;




-- A.2 데이터 자힌 및 정렬 : WHERE, ORDER BY
-- [문제 0] HR 부서에서 예산 편성 문제로 급여 정보 보고서를 작성하려고 한다. 
-- 사원정보(EMPLOYEES) 테이블에서 급여가 $7,000~$10,000 범위 이외인 사람의 성과 이름(Name으로 별칭) 및 급여를 급여가 작은순서로 출력하시오(75행).
select concat(first_name, ' ', last_name) as "Name", salary from employees where salary between 7000 and 10000 order by salary asc;

-- [문제 1] 사원의 이름(last_name) 중에 ‘e’ 및 ‘o’ 글자가 포함된 사원을 출력하시오. 이때 머리글은 ‘e and o Name’라고 출력하시오
select last_name as "e and o Name" from employees where last_name like '%e%' and last_name like '%e%';

-- [문제 2] 현재 날짜 타입을 날짜 함수를 통해 확인하고, 1996년 05월 20일부터 1997년 05월 20일 사이에 (*2000년도 이후가 없어 문제 수정)
-- 고용된 사원들의 성과 이름(Name으로 별칭), 사원번호, 고용일자를 출력하시오. 단, 입사일이 빠른 순으로 정렬하시오
select now(); -- 연/월/일 시:분:초
select current_date(); -- 연/월/일

select concat(employees.first_name, ' ', employees.last_name) Name, employees.employee_id 사원번호, employees.hire_date
from employees
where employees.hire_date between date('1996-05--20') and date('1997-05-20')
order by employees.hire_date asc;

-- [문제 3] HR 부서에서는 급여(salary)와 수당율(commission_pct)에 대한 지출 보고서를 작성하려고 한다.
-- 이에 수당을 받는 모든 사원의 성과 이름(Name으로 별칭), 급여, 업무, 수당율을 출력하시오. 이때 급여가
-- 큰 순서대로 정렬하되, 급여가 같으면 수당율이 큰 순서대로 정렬하시오
select concat(employees.first_name, ' ', employees.last_name) Name, employees.salary 급여, employees.job_id 업무, employees.commission_pct
from employees
where employees.commission_pct is not null
order by employees.salary desc, employees.commission_pct desc;




-- A.3 단일 행 함수 및 변환 함수
-- [문제 0] 이번 분기에 60번 IT 부서에서는 신규 프로그램을 개발하고 보급하여 회사에 공헌하였다. 
-- 이에 해당 부서의 사원 급여를 12.3% 인상하기로 하였다. 60번 IT 부서 사원의 급여를 12.3% 인상하여 정수만(반올림) 표시하는 보고서를 작성하시오. 
-- 출력 형식은 사번, 이름과 성(Name으로 별칭), 급여, 인상된 급여(Increased Salary로 별칭)순으로 출력한다
SELECT employee_id, job_id, CONCAT(first_name, ' ', last_name) Name, salary, ROUND(salary + (salary * 0.123)) 'Increased Salary'
FROM employees
WHERE job_id LIKE '%IT%';


-- [문제 1] 각 사원의 성(last_name)이 ‘s’로 끝나는 사원의 이름과 업무를 아래의 예와 같이 출력하고자 한다. 
-- 출력 시 성과 이름은 첫 글자가 대문자, 업무는 모두 대문자로 출력하고 머리글은 Employee JOBs로 표시하시오(18행).
-- 예) James Landry is a ST_CLERK
-- (hint) INITCAP, UPPER, SUBSTR 함수를 사용하며 SUBSTR 함수의 경우 뒤에서부터 첫글자는 두 번째인자에 –1을 사용한다.
select CONCAT(first_name, ' ', last_name, ' is a ', job_id) "Employee JOBs"
from employees
where last_name like '%s';



/*[문제 2] 모든 사원의 연봉을 표시하는 보고서를 작성하려고 한다. 보고서에 사원의 성과 이름(Name으로
	별칭), 급여, 수당여부에 따른 연봉을 포함하여 출력하시오. 수당여부는 수당이 있으면 “Salary +
	Commission”, 수당이 없으면 “Salary only”라고 표시하고, 별칭은 적절히 붙인다. 또한 출력 시 연봉이
	높은 순으로 정렬한다(107행). */
select CONCAT(first_name, ' ', last_name, ' is a ', job_id), salary, 
case
when commission_pct is not null then "Salary + Commission"
else "Salary only" end commission
, salary + (salary *  ifnull(commission_pct,0)) "Increased Salary"
from employees
order by "Increased Salary" desc;
    


/*[문제 3] 모든 사원들 성과 이름(Name으로 별칭), 입사일 그리고 입사일이 어떤 요일이였는지 출력하시오.
	이때 주(week)의 시작인 일요일부터 출력되도록 정렬하시오(107행).*/
select CONCAT(first_name, ' ', last_name, ' is a ', job_id) Name, hire_date, dayname(hire_date)
from employees
order by dayofweek(hire_date);




-- A.4 집계된 데이터 보고 : 집계 함수
/*[문제 0] 모든 사원은 직속 상사 및 직속 직원을 갖는다. 
	단, 최상위 또는 최하위 직원은 직속 상사 및 직원이 없다. 
	소속된 사원들 중 어떤 사원의 상사로 근무 중인 사원의 총 수를 출력하시오*/
SELECT count(DISTINCT e2.employee_id)
FROM employees e1, employees e2
WhERE e1.manager_id = e2.employee_id;

/*[문제 1] 각 사원이 소속된 부서별로 급여 합계, 급여 평균, 급여 최대값, 급여 최소값을 집계하고자 한다.
	계산된 출력값은 6자리와 세 자리 구분기호, $ 표시와 함께 출력하고 부서번호의 오름차순 정렬하시오.
	단, 부서에 소속되지 않은 사원에 대한 정보는 제외하고 출력시 머리글은 아래 예시처럼 별칭(alias) 처리하시오
	(hint) 출력 양식 정하는 방법 - TO_CHAR(SUM(salary), '$999,999.00')*/
SELECT  concat('$', format(sum(salary), '#, #')) 급여합계, concat('$', format(avg(salary), '#, #')) 급여평균, concat('$', format(max(salary), '#, #')) 급여최대값, concat('$', format(min(salary), '@, @')) 급여최소값
FROM employees, departments
WHERE employees.department_id is not null and employees.department_id = departments.department_id
GROUP by employees.department_id
ORDER BY employees.department_id;

/*[문제 2] 사원들의 업무별 전체 급여 평균이 $10,000보다 큰 경우를 조회하여 업무, 급여 평균을 출력하시오. 
	단 업무에 사원(CLERK)이 포함된 경우는 제외하고 전체 급여 평균이 높은 순서대로 출력하시오*/
SELECT jobs.job_title 업무, avg(salary) '급여 평균'
FROM employees, jobs
WHERE employees.job_id = jobs.job_id and not jobs.job_id like '%CLERK'
GROUP BY employees.job_id
HAVING avg(salary) >= 10000
ORDER BY avg(salary) desc;
    

select* from employees;