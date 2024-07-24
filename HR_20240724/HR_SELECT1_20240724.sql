-- 연습문제
-- 1. 모든 사원의 이름, 부서번호, 부서 이름을 조회하세요.
select concat(employees.first_name, ' ', employees.last_name) 이름, employees.department_id 부서번호, departments.department_name 부서이름
from employees, departments
where employees.department_id = departments.department_id;

-- 2. 부서번호80에 속하는 모든 업무의 고유 목록을 작성하고 출력결과에 부서의 위치를 출력
select departments.department_name 부서이름, locations.city
from departments, locations
where departments.location_id = locations.location_id and departments.department_id = 80;

-- 3.커미션을 받는 사원의 이름, 부서이름, 위치번호와 도시명을 조회하세요.
select concat(employees.first_name, ' ', employees.last_name) 사원이름, departments.department_name 부서이름, locations.location_id 지역번호,locations.city 지역명
from employees, departments, locations
where employees.department_id = departments.department_id and departments.location_id = locations.location_id and employees.commission_pct is not  null;

-- 4.이름에 a(소문자)가 포함된 모든 사원의 이름과 부서명을 조회하세요.
select concat(employees.first_name, ' ', employees.last_name) 사원이름,departments.department_name 부서이름
from employees, departments
where employees.department_id = departments.department_id and employees.last_name like '%a%';

-- 5. 'Toronto'에서 근무하는 모든 사원의 이름, 업무, 부서 번호와 부서명을 조회하세요.
select concat(employees.first_name, ' ', employees.last_name) 사원이름, jobs.job_title 업무, departments.department_id 부서번호, departments.department_name 부서명
from employees, jobs, departments, locations
where employees.job_id = jobs.job_id and employees.department_id = departments.department_id and departments.location_id = locations.location_id and locations.city = 'Toronto';

-- 6. 사원의 이름과 사원번호를 관리자의 이름과 관리자 아이디와 함께 표시하고 각각의 칼럼명을 Employee, Emp#. Manager, mgr#으로 지정하세요.
select concat(e.first_name, ' ', e.last_name) Employee,  e.employee_id 'Emp#', concat(m.first_name, ' ', m.last_name) Manager,  m.employee_id 'Mgr#'
from employees e, employees m
where e.manager_id = m.employee_id;

-- 7. 사장인'King'을 포함하여 관리자가 없는 모든 사원을 조회하세요 (사원번호를 기준으로 정렬하세요)
select e1.employee_id 사원번호,concat(e1.first_name, ' ', e1.last_name) 이름
from employees e1 left outer join employees as e2 
on e1.manager_id = e2.employee_id
where e1.manager_id is null;

-- 8. 지정한 사원의 이름, 부서 번호 와 지정한 사원과 동일한 부서에서 근무하는 모든 사원을 조회하세요
select concat(e1.first_name, ' ', e1.last_name) 사원이름, d1.department_id 부서번호, concat(e2.first_name, ' ', e2.last_name) 사원이름
from employees e1, departments d1, employees e2
where e1.department_id = d1.department_id and e2.department_id = e1.department_id and e1.last_name = 'Fox';

select last_name from employees;

-- 9. JOB_GRADRES 테이블을 생성하고 모든 사원의 이름, 업무,부서이름, 급여 , 급여등급을 조회하세요
select concat(e.first_name, ' ', e.last_name) 사원이름, j.job_title 엄무명, d.department_name 부서이름, e.salary 급여, g.grade_level 급여등급
from employees e
inner join departments d on e.department_id = d.department_id 
inner join jobs j on e.job_id = j.job_id
left join job_grades g on e.salary between g.lowest_sal and g.highest_sal;



select * from job_grades;
