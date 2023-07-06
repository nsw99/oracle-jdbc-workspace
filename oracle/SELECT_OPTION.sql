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
    LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
    LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
 WHERE CATEGORY = '예체능' AND PROFESSOR_NO is NULL;
--13번 문제
SELECT STUDENT_NAME, NVL(PROFESSOR_NAME,'지도교수 미지정')
FROM TB_STUDENT S
LEFT JOIN TB_PROFESSOR ON (PROFESSOR_NO = COACH_PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME IN '서반아어학과' 
ORDER BY STUDENT_NO;
--14번문제
SELECT STUDENT_NO AS "학번",
          STUDENT_NAME AS "이름",
    DEPARTMENT_NAME AS "학과 이름",
    ROUND(AVG(POINT), 1) AS "평점"
 FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
    JOIN TB_GRADE USING (STUDENT_NO)
 WHERE ABSENCE_YN = 'N' --AND POINT >= 4.0
 GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
 ORDER BY STUDENT_NO;
