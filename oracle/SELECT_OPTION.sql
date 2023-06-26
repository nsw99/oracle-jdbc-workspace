--1번 문제

SELECT
    student_name    AS "학생 이름",
    student_address "주소지"
FROM
    tb_student
ORDER BY
    1;


-- 2번 문제
SELECT
    student_name,
    student_ssn
FROM
    tb_student
WHERE
    absence_yn = 'Y'
ORDER BY
    2 DESC;

--3번 문제

SELECT
    student_name    학생이름,
    student_no      학번,
    student_address "거주지 주소"
FROM
    tb_student
WHERE
        substr(student_no, 0, 1) = '9'
    AND substr(student_address, 0, 3) IN ( '경기도', '강원도' )
ORDER BY
    1;
    
--4번 문제 
SELECT
    professor_name,
    professor_ssn
FROM
    tb_professor
WHERE
    department_no = '005'
ORDER BY
    2;


--5번 문제
SELECT
    student_no,
    point
FROM
         tb_student
    JOIN tb_grade USING ( student_no )
WHERE
        class_no = 'C3118100'
    AND term_no = '200402'
ORDER BY
    2 DESC;
--6번 문제
SELECT
    student_no,
    student_name,
    department_name
FROM
         tb_student
    JOIN tb_department USING ( department_no )
ORDER BY
    2;
--7번문제
SELECT
    class_name,
    department_name
FROM
         tb_class
    JOIN tb_department USING ( department_no )
ORDER BY
    2;   
--8번 문제
SELECT
    class_name,
    professor_name
FROM
         tb_class
    JOIN tb_professor USING ( department_no )
ORDER BY
    2 ASC;
--9번 문제
SELECT
    student_no,
    student_name,
    round(AVG(point),
          1)
FROM
         tb_student
    JOIN tb_grade USING ( student_no )
WHERE
    department_no IN '059'
GROUP BY
    student_no,
    student_name
ORDER BY
    1;
--10번 문제
SELECT
    department_name,
    student_name,
    professor_name
FROM
         tb_student
    JOIN tb_department USING ( department_no )
    JOIN tb_professor USING ( department_no )
WHERE
    student_no = 'A313047';
-- 11번문제
SELECT STUDENT_NAME, TERM_NO
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
WHERE SUBSTR(TERM_NO,1,4) IN 2007 AND CLASS_NO IN 'C2604100';

--12번 문제 모르겠어요 
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS 
JOIN TB_DEPARTMENT D USING(DEPARTMENT_NO)
JOIN TB_CLASS_PROFESSOR P USING(CLASS_NO)
WHERE CATEGORY = '예체능'; AND D.PROFESSOR_NO = P.PROFESSOR_NO;
--13번 문제