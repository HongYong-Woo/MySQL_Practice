-- A. SQL Practice
-- A.6 서브쿼리를 사용하여 해결 하세요
/*[문제 1] HR 부서의 어떤 사원은 급여정보를 조회하는 업무를 맡고 있다. 
Tucker(last_name) 사원보다 급여를 많이 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여를 출력하시오*/
SELECT salary from employees WHERE last_name = 'Tucker';

SELECT concat(first_name, ' ', last_name) Name, job_id, salary
from employees
WHERE salary > (SELECT salary from employees WHERE last_name = 'Tucker');

/*[문제 2] 사원의 급여 정보 중 업무별 최소 급여를 받고 있는 사원의 성과 이름(Name으로 별칭), 업무,
급여, 입사일을 출력하시오*/
SELECT  job_id, min(salary) from employees GROUP BY job_id ORDER BY job_id;

 SELECT concat(e1.first_name, ' ', e1.last_name) Name, e1.job_id, e1.salary, e1.hire_date
 FROM employees e1
 JOIN (SELECT job_id, min(salary) min_salary from employees GROUP BY job_id) e2 on e1.job_id = e2.job_id and e1.salary = e2.min_salary;
 

SELECT count(DISTINCT job_id) from employees;

/*[문제 3] 소속 부서의 평균 급여보다 많은 급여를 받는 사원에 대하여 사원의 성과 이름(Name으로 별칭),
급여, 부서번호, 업무를 출력하시오*/
SELECT department_id,round(avg(salary)) from employees GROUP BY department_id;

SELECT concat(first_name, ' ', last_name) Name, salary, department_id, job_id
from employees
-- GROUP BY department_id
HAVING salary > any (SELECT avg(salary) from employees GROUP BY department_id);



/*[문제 4] 사원들의 지역별 근무 현황을 조회하고자 한다. 도시 이름이 영문 'O' 로 시작하는 지역에 살고
있는 사원의 사번, 이름, 업무, 입사일을 출력하시오*/
SELECT e1.employee_id, concat(e1.first_name, ' ', e1.last_name) Name, e1.job_id, e1.hire_date, d1.location_id
From employees e1, departments d1
WHERE e1.department_id = d1.department_id and d1.location_id =  (SELECT location_id from locations WHERE locations.city like 'O%');

SELECT * from locations WHERE locations.city like 'O%';
SELECT departments.location_id from departments where location_id = 1700;

select distinct concat(e.first_name, ' ', e.last_name) 이름, e.job_id 업무, e.hire_date 입사일
from employees e, departments dept, locations loc
where e.department_id = (select d2.department_id from departments d2
	where d2.location_id = (
		select l2.location_id from locations l2 where l2.city like 'O%')) 
order by e.job_id;

/*[문제 5] 모든 사원의 소속부서 평균연봉을 계산하여 사원별로 성과 이름(Name으로 별칭), 업무, 급여, 부
서번호, 부서 평균연봉(Department Avg Salary로 별칭)을 출력하시오*/
SELECT avg(salary) from employees GROUP BY department_id;


/*[문제 6] ‘Kochhar’의 급여보다 많은 사원의 정보를 사원번호,이름,담당업무,급여를 출력하시오.*/
SELECT e1.employee_id, concat(e1.first_name, ' ', e1.last_name) name, e1.job_id, e1.salary
FROM employees e1
where e1.salary > (select e2.salary from employees e2 where e2.last_name =  'Kochhar');


/*[문제 7] 급여의 평균보다 적은 사원의 사원번호,이름,담당업무,급여,부서번호를 출력하시오*/
SELECT e1.employee_id, concat(e1.first_name, ' ', e1.last_name) name, e1.job_id, e1.salary, e1.department_id
FROM employees e1
WHERE e1.salary < (SELECT avg(e2.salary) from employees e2);


/*[문제 8] 100번 부서의 최소 급여보다 최소 급여가 많은 다른 모든 부서를 출력하시오*/
SELECT d1.department_id, d1.department_name 
from departments d1, employees e1
where d1.department_id = e1.department_id
GROUP BY d1.department_id
HAVING min(e1.salary) > (SELECT min(salary) from departments d2, employees e2 WHERE d2.department_id= e2.department_id and d2.department_id =100);

SELECT d2.department_id, min(salary) from departments d2, employees e2 WHERE d2.department_id= e2.department_id GROUP BY d2.department_id;

/*[문제 9] 업무별로 최소 급여를 받는 사원의 정보를 사원번호,이름,업무,부서번호를 출력하시오
		출력시 업무별로 정렬하시오*/
SELECT min(salary) from employees GROUP BY job_id;

SELECT e1.employee_id, concat(e1.first_name, ' ', e1.last_name) name, e1.job_id, e1.department_id
FROM employees e1
	JOIN (SELECT min(salary), job_id from employees GROUP BY job_id) e2 on e1.salary = e2.salary and e1.job_id, e2.job_id;
        
/*[문제 10] 100번 부서의 최소 급여보다 최소 급여가 많은 다른 모든 부서를 출력하시오*/


/*[문제 11] 업무가 SA_MAN 사원의 정보를 이름,업무,부서명,근무지를 출력하시오.*/
SELECT concat(e1.first_name, ' ', e1.last_name) name, e1.job_id, d1.department_name, l1.city
FROM employees e1
	JOIN departments d1 on e1.department_id = d1.department_id
	JOIN locations l1 on d1.location_id = l1.location_id
WHERE e1.job_id = ANY (SELECT 'SA_MAN' FROM jobs);

SELECT concat(e1.first_name, ' ', e1.last_name) name, e1.job_id, d1.department_name, l1.city
FROM (SELECT first_name, last_name, job_id, department_id from employees where job_id ='SA_MAN') e1,
	(SELECT department_id, department_name, location_id from departments) d1,
    (SELECT location_id, city from locations) l1
where e1.department_id = d1.department_id and d1.location_id = l1.location_id;



/*[문제 12] 가장 많은 부하직원을 갖는 MANAGER의 사원번호와 이름을 출력하시오*/
SELECT manager_id from employees GROUP BY manager_id ORDER BY count(manager_id) DESC;

SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) Name
FROM
    employees e
WHERE
    e.employee_id = (SELECT 
            manager_id
        FROM
            employees e
        GROUP BY manager_id
        ORDER BY COUNT(manager_id) DESC
        LIMIT 1);


/*[문제 13] 사원번호가 123인 사원의 업무가 같고 사원번호가 192인 사원의 급여(SAL))보다 많은 사원의 사원번호,이름,직업,급여를 출력하시오*/
SELECT job_id from employees where employee_id = 123;
SELECT salary from employees where employee_id = 192;

SELECT employee_id, concat(first_name, ' ', last_name) name, job_id, salary
from employees
WHERE job_id = (SELECT job_id from employees where employee_id = 123) and salary > (SELECT salary from employees where employee_id = 192);

/*[문제 14] 50번 부서에서 최소 급여를 받는 사원보다 많은 급여를 받는 사원의 사원번호,이름,업무,입사일
자,급여,부서번호를 출력하시오. 단 50번 부서의 사원은 제외합니다.*/
SELECT min(salary) from employees where department_id = 50;

SELECT employee_id, concat(first_name, ' ', last_name) name, job_id, hire_date, salary, department_id
FROM employees
WHERE salary > (SELECT min(salary) from employees where department_id = 50) and  not department_id =50;


/*[문제 15] (50번 부서의 최고 급여)를 받는 사원 보다 많은 급여를 받는 사원의 사원번호,이름,업무,입사일
자,급여,부서번호를 출력하시오. 단 50번 부서의 사원은 제외합니다.*/
SELECT max(salary) from employees WHERE department_id = 50;

SELECT concat(first_name, ' ', last_name) name, job_id, hire_date, salary, department_id
from employees
where salary > (SELECT max(salary) from employees WHERE department_id = 50) and not department_id = 50;

