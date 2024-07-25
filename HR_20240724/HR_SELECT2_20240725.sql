-- A. SQL Practice 2
-- A.5 여러 테이블의 데이터 표시 : JOIN
-- [문제 0] hr 스키마에 존재하는 Employees, Departments, Locations 테이블의 구조를 파악한 후
-- Oxford에 근무하는 사원의 성과 이름(Name으로 별칭), 업무, 부서명, 도시명을 출력하시오. 
-- 이때 첫 번째 열은 회사명인 ‘Han-Bit’이라는 상수값이 출력되도록 하시오
select concat('Han-Bit') as 회사명, concat(employees.first_name, ' ', employees.last_name) Name, employees.job_id 업무, departments.department_name 부서명, locations.city 도시명
from employees, departments, locations
where employees.department_id = departments.department_id and departments.location_id = locations.location_id and locations.city = 'Oxford';



-- [문제 1] HR 스키마에 있는 Employees, Departments 테이블의 구조를 파악한 후 
-- 사원수가 5명 이상인부서의 부서명과 사원수를 출력하시오. 이때 사원수가 많은 순으로 정렬하시오.
select departments.department_name, count(employees.department_id)
from employees, departments
where employees.department_id = departments.department_id
group by employees.department_id
having count(employees.department_id) >=5;



-- [문제 2] 각 사원의 급여에 따른 급여 등급을 보고하려고 한다. 
-- 급여 등급은 JOB_GRADES 테이블에 표시된다. 
-- 해당 테이블의 구조를 살펴본 후 사원의 성과 이름(Name으로 별칭), 업무, 부서명, 입사일, 급여,급여등급을 출력하시오
select concat(employees.first_name, ' ', employees.last_name), employees.job_id, departments.department_name, employees.hire_date, employees.salary, job_grades.grade_level
from employees, departments, job_grades
where employees.department_id = departments.department_id and employees.salary BETWEEN job_grades.lowest_sal and job_grades.highest_sal
ORDER BY job_grades.grade_level desc; 




-- [문제 3] 각 사원과 직속 상사와의 관계를 이용하여 다음과 같은 형식의 보고서를 작성하고자 한다.
-- □예 홍길동은 허균에게 보고한다 → Eleni Zlotkey report to Steven King
-- 어떤 사원이 어떤 사원에서 보고하는지를 위 예를 참고하여 출력하시오. 단, 보고할 상사가 없는 사원이
-- 있다면 그 정보도 포함하여 출력하고, 상사의 이름은 대문자로 출력하시오.
SELECT IF(e.manager_id IS NOT NULL, CONCAT(e.first_name, ' ', e.last_name, ' report to ', UPPER(m.first_name), ' ', UPPER(m.last_name))
           , CONCAT(e.first_name, ' ', e.last_name, ' report to NULL')) 'report to'
FROM employees e LEFT JOIN employees m on e.manager_id = m.employee_id