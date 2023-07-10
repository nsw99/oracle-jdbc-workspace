/*
    JOIN
    - 두개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문
    - 조회 결과는 하나의 결과물(RESULT SET)으로 나옴

     - 관계형 데이터베이스는 최소한의 데이터로 각각의 테이블에 담고 있음
        (중복을 최소화하기 위해 최대한 쪼개서 관리)
        부서 데이터는 부서 테이블, 사원에 대한 데이터는 사원 테이블, 직급테이블 ....
        만약 어떤 사원이 어떤 부서에 속해있는지 부서명과 같이 조회하고 싶다면 ?
        만약 어떤 사원이 어떤 직급인지 직급명과 같이 조회하고 싶다면??
        
        => 즉, 관계형 데이터베이스에서 SQL 문을 이용한 테이블 간에 
        "관계"를 맺어 원하는 데이터를 조회하는 방법
    
        - 크게 "오라클 구문"과 "ANSI 구문"
        - ANSI(미국국립표준협회 = 산업 표준을 제정하는 단체) : 다른 DBMS에서도 사용 가능
        
*/ 


/*
     1. 오라클 - 등가 조인(EQUAL JOIN) / 
         ANSI - 내부 조인(INNER JOIN / NATUARL JOIN)
         
        - 연결시키는 컬럼의 값이 일치하는 행들만 조인되서 조회
        (일치하는 값이 없는 행은 조회 X)
        
    1) 오라클 전용 구문
        SELECT 컬럼, 컬럼, 컬럼.......
        FROM 테이블1,테이블2
        WHERE 테이블1.컬럼명 = 테이블2.컬러명;
        
        - FROM 절에 조회하고자 하는 테이블들을 콤마로 구분하여 나열
        - WHERE 절에 매칭 시킬 컬럼명에 대한 조건 제시
    
    2) ANSI 표준 구문
        SELECT 컬럼,컬럼,......
        FROM 테이블1
        JOIN 테이블2 ON(테이블1.컬럼명 = 테이블2.컬럼명);
        
        - FROM 절에서 기준이 되는 테이블을 기술 
        - JOIN 절에서 같이 조회하고자 하는 테이블을 기술 후 
            컬럼에 대한 조건을 기술 (USING 구문과 ON 구문 사용)
        - 연결에 사용하려는 컬럼명이 같은 경우 ON구문 대신에 USING(컬럼명) 구문사용
    
*/


-- 1) 연결할 두 컬럼명이 다른 경우
--사번 , 사원명, 부서코드 , 부서명을 같이 조회


-- 오라클 구문
SELECT
    emp_id,
    emp_name,
    dept_code,
    dept_title
FROM
    employee,
    department
WHERE
    dept_code = dept_id;

-- ANSI 구문
SELECT
    emp_id,
    emp_name,
    dept_code,
    dept_title
FROM
         employee
    JOIN department ON ( dept_code = dept_id );


-- 2) 연결할 두 컬럼명이 같은 경우
-- 사번,사원명,직급코드,직원명 조회
SELECT
    emp_id,
    emp_name,
    job.job_code,
    job_name
FROM
    job,
    employee
WHERE
    employee.job_code = job.job_code;


-- 테이블에 별칭을 부여해서 이용하는 방법
SELECT
    emp_id,
    emp_name,
    j.job_code,
    job_name
FROM
    employee e,
    job      j
WHERE
    e.job_code = j.job_code;

-- ANSI
SELECT
    emp_id,
    emp_name,
    job_code,
    job_name
FROM
         employee
--JOIN JOB J ON (E.JOB_CODE=J.JOB_CODE);
    JOIN job USING ( job_code );

-- 자연 조인(NATURAL JOIN) : 각 테이블마다 동일한 컬럼이 한 개만 존재 할 경우
SELECT
    emp_id,
    emp_name,
    job_code,
    job_name
FROM
         employee
    NATURAL JOIN job;
-- 직급이 대리인 사원의 사번, 이름, 직급명, 급여를 조회
SELECT
    emp_id,
    emp_name,
    job_name,
    salary
FROM
         employee
    JOIN job USING ( job_code )
WHERE
    job_name = '대리';

-- 오라클
SELECT
    emp_id,
    emp_name,
    job_name,
    salary
FROM
    employee e,
    job      j
WHERE
        e.job_code = j.job_code
    AND job_name = '대리';


-- 실습 문제 --
--1. 부서가 인사관리부인 사원들의 사번,이름,보너스 조회
SELECT
    dept_title,
    emp_id,
    emp_name,
    bonus
FROM
         employee e
    JOIN department d ON ( d.dept_id = e.dept_code )
WHERE
    dept_title = '인사관리부'; 
--2. DEPARTMENT와 LOACATION을 참고해서 전체 부서의 부서코드,부서명,지역코드
--지역명 조회
SELECT
    dept_id,
    dept_title,
    location_id,
    local_name
FROM
         department d
    JOIN location l ON ( d.location_id = l.local_code );
--3. 보너스를 받는 사원들의 사번, 사원명, 보너스,부서명 조회
SELECT
    emp_id,
    emp_name,
    bonus,
    dept_title
FROM
         employee e
    JOIN department d ON ( e.dept_code = d.dept_id )
WHERE
    bonus IS NOT NULL;
--4 . 부서가 총무부가 아닌 사원들의 사원명 급여 조회
SELECT
    emp_name,
    salary,
    dept_title
FROM
         employee e
    JOIN department d ON ( e.dept_code = d.dept_id )
WHERE
    dept_title NOT IN '총무부';
    
    /*
        2. 오라클 - 포괄 조인 / ANSI - 외부조인(OUTER JOIN)
            - 두 테이블 간의 JOIN 시 일치하지 않는 행도 포함시켜서 조회가 가능
            - 단, 반드시 기준이 되는 테이블(컬럼)을 지정해야 한다
                (LEFT,RIGHT,FULL,(+))
    */
--사원명, 부서명 , 급여, 연봉조회
-- 부서 배치가 아직 안된 사원 2명에 대한 정보는 조회 X
SELECT
    emp_name,
    dept_title,
    salary,
    salary * 12
FROM
         employee e
    JOIN department d ON ( e.dept_code = d.dept_id );

-- 1) LEFT [OUTER] JOIN : 두 테이블 중 왼편에 기술된 테이블을 기준으로 JOIN
-- 부서 배치가 아직 안된 사원 2명에 대한 정보도 조회됨
-- >> ANSI 구문

SELECT
    emp_name,
    dept_title,
    salary,
    salary * 12
FROM
    employee   e
    LEFT JOIN department d ON ( e.dept_code = d.dept_id );

--> 오라클 구문

SELECT
    emp_name,
    dept_title,
    salary,
    salary * 12
FROM
    employee,
    department
WHERE
    dept_code = dept_id (+); -- 기준으로 삼고자하는 테이블의 반대편
                                    -- 테이블의 컬럼 뒤에 (+) 붙이기

--2) RIGHT [OUTER] JOIN : 두 테이블 중 오른쪽에 기술된 테이블을 기준으로 JOIN
-->> ANSI 구문
SELECT
    emp_name,
    dept_title,
    salary,
    salary * 12
FROM
    employee   e
    RIGHT JOIN department d ON ( e.dept_code = d.dept_id );

--> 오라클 구문
SELECT
    emp_name,
    dept_title,
    salary,
    salary * 12
FROM
    employee,
    department
WHERE
    dept_code (+) = dept_id;
    
    --3) FULL [OUTER] JOIN : 두 테이블이 가진 모든 행을 조회할 수 있음
    -- 오라클 구문으로는 사용 불가
    -->> ANSI 구문
SELECT
    emp_name,
    dept_title,
    salary,
    salary * 12
FROM
    employee   e
    FULL JOIN department d ON ( e.dept_code = d.dept_id );

--> 오라클 구문 (에러 발생! 오라클 구문으로는 FULL JOIN 안됨!)
SELECT
    emp_name,
    dept_title,
    salary,
    salary * 12
FROM
    employee,
    department
WHERE
    dept_code = dept_id;
    
    
/*
    3. 비등가 조인(NON EQUAL JOIN)
    매칭시킬 컬럼에 대한 조건 작성시 '='(등호)를 사용하지 않는 조인문
    값의 범위에 포함되는 행들을 연결하는 방식 
    ANSI 구문으로는 JOIN ON으로만 사용가능! (USING 사용 불가)
*/
-- 사원명, 급여, 급여레벨 조회
SELECT
    emp_name,
    salary
FROM
    employee;

SELECT
    sal_level,
    min_sal,
    max_sal
FROM
    sal_grade;
   
   
   --사원명, 급여, 급여레벨 조회
   --> ANSI 구문
SELECT
    emp_name,
    salary,
    sal_level
FROM
         employee
    JOIN sal_grade ON ( salary BETWEEN min_sal AND max_sal );
    --> 오라클 구문

SELECT
    emp_name,
    salary,
    sal_level
FROM
    employee,
    sal_grade
WHERE
    salary BETWEEN min_sal AND max_sal;

/*
    4. 자체 조인(SELF JOIN)
    - 같은 테이블을 다시 한번 조인하는 경우(자기 자신과 조인)
*/
-- 사원사번, 사원명, 사원부서코드, 사수사번, 사수명, 사수부서코드 저회
-- ansi구문
SELECT
    e.emp_id,
    e.emp_name,
    e.dept_code,
    d.manager_id,
    d.emp_name,
    d.dept_code
FROM
         employee e
    JOIN employee d ON ( e.emp_id = d.manager_id );
    -- 오라클 구문
SELECT
    e.emp_id,
    e.emp_name,
    e.dept_code,
    d.manager_id,
    d.emp_name,
    d.dept_code
FROM
    employee e,
    employee d
WHERE
    e.emp_id = d.manager_id
ORDER BY
    3 DESC;



/*
    5. 카테시안곱(CARTESIAN PRODUCT) / 교차 조인(CROSS JOIN)
    - 조인되는 모든 테이블의 각 행들이 서로서로 모두 매핑된 데이터가 검색된다
    (곱집합)
    - 두 테이블의 행들이 모두 곱해진 행들의 조합이출력
    -> 방대한 데이터 출력 -> 과부화의 위험
*/

--> ANSI 구문
SELECT
    emp_name,
    dept_title
FROM
         employee
    CROSS JOIN department;
--> 오라클 구문
SELECT
    emp_name,
    dept_title
FROM
    employee,
    department;

/*
    6. 다중 JOIN
    - 여러 개의 테이블을 조인하는 경우
*/
-- 사번,사원명,부서명,직급명 조회
-->> ANSI 구문

SELECT
    emp_id,
    emp_name,
    dept_title,
    job_name
FROM
         employee
    JOIN department ON ( dept_code = dept_id )
    JOIN job USING ( job_code );

-- >> 오라클 구문
SELECT
    emp_id,
    emp_name,
    dept_title,
    job_name
FROM
    employee e,
    department,
    job      j
WHERE
        dept_code = dept_id
    AND j.job_code = e.job_code;


-- 사번, 사원명, 부서명, 지역명 조회
--오라클구문
SELECT
    emp_id,
    emp_name,
    dept_title,
    local_name
FROM
    employee e,
    department,
    location l
WHERE
        dept_code = dept_id
    AND l.local_code = location_id;

--   ANSI 구문
SELECT
    emp_id,
    emp_name,
    dept_title,
    local_name
FROM
         employee
    JOIN department ON ( dept_code = dept_id )
    JOIN location ON ( local_code = location_id );
    
-- 사번, 사원명, 부서명, 직급명, 지역명, 국가명, 급여등급 조회
-- ANSI 구문

SELECT
    emp_id,
    emp_name,
    dept_title,
    job_name,
    local_name,
    national_name,
    sal_level
FROM
         employee
    JOIN department ON ( dept_code = dept_id )
    JOIN job USING ( job_code )
    JOIN location ON ( local_code = location_id )
    JOIN national USING ( national_code )
    JOIN sal_grade ON ( salary BETWEEN min_sal AND max_sal );

--> 오라클 구문
SELECT
    emp_id,
    emp_name,
    dept_title,
    job_name,
    local_name,
    national_name sal_level
FROM
    employee   e,
    department d,
    job        j,
    location   l,
    national   n,
    sal_grade  s
WHERE
        e.dept_code = d.dept_id
    AND e.job_code = j.job_code
    AND d.location_id = l.local_code
    AND l.national_code = n.national_code
    AND e.salary BETWEEN s.min_sal AND s.max_sal;
--종합 실습 문제--
--1. 직급이 대리이면서 asia 지역에서 근무하는 직원들의 사번, 직원명
-- 직급명, 부서명, 근무지역, 급여를 조회하세요.
SELECT
    emp_id,
    emp_name,
    job_name,
    dept_title,
    local_name,
    salary
FROM

         employee
    JOIN job USING ( job_code )
    JOIN department ON ( dept_code = dept_id )
    JOIN location ON ( location_id = local_code )
WHERE
        job_name = '대리'
    AND substr(local_name, 1, 4) = 'ASIA';

--2. 70년대생 이면서 여자이고, 성이 전 씨인 직원들의 직원명,주민번호
-- 부서명,직급명을 조회하세요.
SELECT
    emp_name,
    emp_no,
    dept_title,
    job_name
FROM
         employee
    JOIN department ON ( dept_code = dept_id )
    JOIN job USING ( job_code )
WHERE
        substr(emp_no, 1, 2) >= 70
    AND substr(emp_no, 1, 2) < 80
    AND substr(emp_no, 8, 1) = 2
-- EMP_NO LIKE '%7%'    
    AND substr(emp_name, 1, 1) = '전';

--3. 보너스를 받는 직원들의 직원명, 보너스,연봉,부서명,근무지역을 조회
SELECT
    emp_name,
    bonus,
    salary * 12,
    dept_title,
    local_name
FROM
         employee full
    JOIN department ON ( dept_code = dept_id )
    FULL JOIN location ON ( location_id = local_code )
WHERE
    bonus IS NOT NULL
ORDER BY
    5;

--4. 한국과 일본에서 근무하는 직원들의 직원명, 부서명, 근무지역, 근무국가 조회
SELECT
    emp_name,
    dept_title,
    local_name,
    n.national_name
FROM
         employee
    JOIN department ON ( dept_code = dept_id )
    JOIN location l ON ( location_id = l.local_code )
    JOIN national n ON ( n.national_code = l.national_code )
WHERE
    n.national_name = '한국'
    OR n.national_name = '일본';
        


--5. 각 부서별 평균 급여를 조회하여 부서명, 평균 급여(정수 처리)를 조회
SELECT
    nvl(dept_title, '부서 없음'),
    to_char(round(AVG(salary)),
            '9,999,999')
FROM
    employee
    LEFT JOIN department ON ( dept_code = dept_id )
GROUP BY
    dept_title
ORDER BY
    dept_title DESC NULLS LAST;

--6. 각 부서별 총 급여의 합이 1000만원 이상인 부서명, 급여의 합을 조회

SELECT
    dept_title,
    to_char(SUM(salary),
            '999,999,999')
FROM
         employee
    JOIN department ON ( dept_code = dept_id )
HAVING
    SUM(salary) >= '10000000'
GROUP BY
    dept_title;


--7.
SELECT
    emp_id,
    emp_name,
    job_name,
    sal_level,
    CASE
        WHEN sal_level = 'S1'
             OR sal_level = 'S2' THEN
            '고급'
        WHEN sal_level = 'S3'
             OR sal_level = 'S4' THEN
            '중급'
        WHEN sal_level = 'S5'
             OR sal_level = 'S6' THEN
            '초급'
    END AS 구분
FROM
         employee
    JOIN job USING ( job_code )
    JOIN sal_grade ON ( salary BETWEEN min_sal AND max_sal );


--8.
SELECT
    emp_name,
    job_name,
    salary
FROM
         employee
    JOIN job USING ( job_code )
WHERE
    bonus IS NULL
    AND job_code = 'J4' 
    OR job_code = 'J7';

--9.
SELECT
    emp_name,
    job_name,
    dept_title,
    local_name
FROM
         employee
    JOIN department ON ( dept_code = dept_id )
    JOIN job USING ( job_code )
    JOIN location ON ( local_code = location_id );
--10.
SELECT
    emp_name,
    job_name,
    dept_code,
    dept_title
FROM
         employee
    JOIN department ON ( dept_id = dept_code )
    JOIN job USING ( job_code )
WHERE
    substr(dept_title, 1, 4) = '해외영업'
ORDER BY
    1;
--11.
SELECT
    emp_id,
    emp_name,
    job_name
FROM
         employee
    JOIN department ON ( dept_id = dept_code )
    JOIN job USING ( job_code )
WHERE
    substr(emp_name, 1, 1) IN '형'
    OR substr(emp_name, 2, 1) IN '형'
       OR substr(emp_name, 3, 1) IN '형'
