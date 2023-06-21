 /*
 
 함수 : 전달된 컬럼값을 읽어들여서 함수를 실행한 결과를 반환
 
 - 단일행 함수 : N개의 값을 읽어서 N개의 결과값을 리턴(매 행마다 함수 실행 결과 반환)
 
 - 그룹 함수  :  N개의 값을 읽어서 1개의 결과 값을 리턴(그룹별로 함수 실행 결과 반환)
 
 >> SELECT 절에 단일행 함수와 그룹 함수는 함께 사용하지 못함!
    -> 결과 행의 갯수가 다르기 때문에
    
>> 함수식을 기술할 수 있는 위치 : SELECT, WHERE, ORDER BY, GROUP BY, HAVING
 
    
 */
 
--  단일행 함수 --

/*

문자처리함수

LENGTH  /  LENGTHB

- LENGTH(컬럼|'문자열값') : 해당 값의 글자 수 반환

-LENGTHB ( 컬럼|'문자열값') : 해당 값의 바이트 수 반환

한글 한 글자 -> 3BYTE
영문자, 숫자, 특수문자 한 글자 -> 1BYTE
*/

SELECT LENGTH('오라클'), LENGTHB('오라클'), LENGTH('ORACLE'), LENGTHB('ORACLE')
FROM DUAL; -- DUAL : 가상테이블 

-- 사원명, 사원명의 글자수, 사원명의 바이트 수, 이메일, 이메일의 글자수, 이메일의 바이트수
SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

/*

INSTR
- INSTR('STRING','STR', [, POSITION , OCURRENCE])
- 지정한 위치부터 지정딘 숫자 번째로 나타나는 문자의 시작 위치를 반환

설명 
- STRING : 문자 타입 컬럼이나 또는 문자열
- STR : 찾으려는 문자열 
- POSITION : 찾을 위치의 시작 값 (명시하지 않으면 기본값이 1)
      ->  1 : 앞에서부터 찾는다.
         -1 : 뒤에서부터 찾는다.
- OCCURRENCE   : 찾을 문자값이 반복될 때 지정하는 빈도(명시하지 않을 시 기본 값이 1)
        -> 음수 사용 불가 
*/

SELECT INSTR('AABAACAABBAA','B') FROM DUAL;

SELECT INSTR('AABAACAABBAA','B',-1) FROM DUAL;

SELECT INSTR('AABAACAABBAA','B',1,2) FROM DUAL;

-- 'S'가 포함되어 있는 이메일 중 이메일, 이메일의 @ 위치, 이메일에서 뒤에서 2번째에 있는 's'위치 조회

SELECT EMAIL, INSTR(EMAIL,'@'), INSTR(EMAIL,'s',-1,2)
FROM EMPLOYEE
WHERE EMAIL LIKE ('%s%');

/*
    LPAD / RPAD
    - 문자열을 조회할 때 통일감있게 조회하고자 할 때 사용 
    - LPAD / RPAD(STRING, 최종적으로 반환 할 문자의 길이, [덧붙이고자 하는 문자])
    - 문자열에 덧붙이고자 하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N길이만큼의 문자열을 반환
*/

SELECT LPAD('HELLO', 10) FROM DUAL; -- 덧붙이고자 하는 문자 생략시 공백으로 채운다

SELECT LPAD('HELLO', 10, 'A') FROM DUAL; 
SELECT RPAD('HELLO', 10) FROM DUAL;
SELECT RPAD('HELLO', 11,' WORLD') FROM DUAL;

/*
    LTRIM / RTRIM
    - 문자열에서 특정 문자를 제거한 나머지를 반환
    - LTRIM / RTRIM(STRING, [제거하고자 하는 문자들])
    - 문자열의 왼쪽 또는 오른쪽에서 제거하고자 하는 문자들을 찾아서 제거한 나머지 문자열을 반환
    
*/
-- 제거하고자 하는 문자 생략 시 기본값으로 공백을 제거
SELECT LTRIM('             K    H                 ')FROM DUAL;
SELECT LTRIM('ACABACCKH','ABC') FROM DUAL; 

SELECT RTRIM('5782KH123','0123456789')FROM DUAL;


/*
    TRIM 
    - 문자열의 양쪽(앞/뒤)에 있는 지정한 문자들을 제거한 나머지 문자열 반환
    - TRIM([LEADING|TRAILING|BOTH],제거하고자 하는 문자들 FROM STRING)
*/
SELECT TRIM('    K          H     ')FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ')FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ')FROM DUAL; -- LEADING (앞에만 제거) = LTRIM
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ')FROM DUAL; -- TRAILING (뒤에만 제거) = RTRIM
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ')FROM DUAL; -- BOTH(앞/뒤 둘다 제거)


/*
    SUBSTR
    - 문자열에서 특정 문자열을 추출해서 반환
    - SUBSTR(STRING, POSITION, [LENGTH])
        STRING : 문자타입 컬럼 또는 '문자열 값'
        POSITION : 문자열을 추출할 시작위치값 (음수값도 가능)
        LEGTH : 추출할 문자 개수 (생략시 끝까지)
*/
SELECT SUBSTR('PROGRAMMING',5,2) FROM DUAL;
SELECT SUBSTR('PROGRAMMING',-8,3) FROM DUAL;

-- 여자사원들의 이름만 조회

SELECT  EMP_NAME 
FROM EMPLOYEE
WHERE  SUBSTR(EMP_NO,8,1) IN(2,4);
-- 남자사원들의 이름만 조회

SELECT  EMP_NAME 
FROM EMPLOYEE
WHERE  SUBSTR(EMP_NO,8,1) IN(1,3);
-- 사원명과 주민등록번호(991212-1*******)
SELECT EMP_NAME, EMP_NO, RPAD(RTRIM(EMP_NO, '0123456789'),14,'*')
FROM EMPLOYEE;

-- 직원명, 이메일 , 아이디(이메일에서 '@'앞의 문자)조회
SELECT EMP_NAME, EMAIL,RTRIM(EMAIL,'@kh.or.kr') 아이디
FROM EMPLOYEE;
-- 사원명과 주민등록번호(991212-1*******)
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14,'*')
FROM EMPLOYEE;

-- 직원명, 이메일 , 아이디(이메일에서 '@'앞의 문자)조회

SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1, INSTR(EMAIL,'@')-1)
FROM EMPLOYEE;

/*
LOWER / UPPER / INITCAP 

- LOWER / UPPER / INITCAP(STRING)

LOWER : 다 소문자로 변경한 문자열 반환
UPPER : 다 대문자로 변경한 문자열 반환
INITCAP : 단어 앞글자 마다 대문자로 변경한 문자열 반환
*/

SELECT LOWER('Welcome To My World!') from DUAL;
SELECT UPPER('Welcome To My World!') FROM DUAL;
SELECT INITCAP('welcome to my world!') FROM DUAL;


/*
CONCAT
- 문자열 두개를 전달 받아 하나로 합친 후 결과 반환
- CONCAT(STRING, STRING)
*/
SELECT CONCAT('GR',' DR ')FROM DUAL;
SELECT '가나다라'||'ABCD'FROM DUAL; -- 연결 연산자와 동일!

SELECT '가나다라' || 'ABCD' ||'1234' FROM DUAL;
SELECT CONCAT (CONCAT('GD','RR'),'1234') FROM DUAL;


/*
    REPLACE
    - REPLACE (STRING, STR1,STR2)
    STRING : 컬럼 또는 문자열 값
    STR1 : 변경시킬 문자열
    STR2 : STR1을 변경할 문자열
*/

SELECT REPLACE('장미르','미르','밥두비두밥') FROM DUAL;

-- 이메일의 kh.or.kr를 gmail.com으로 변경해서 조회
SELECT EMP_NAME,EMAIL, REPLACE(EMAIL,'kh.or.kr','gmail.com') 
FROM EMPLOYEE;


/*
    숫자 처리 함수
    ABS(NUMBER) : 숫자의 절대 값을 구해주는 함수
*/
SELECT ABS(-130) FROM DUAL;

/*
    MOD(NUMBER, NUMBER) :  두 수를 나눈 나머지 값을 반환해주는 함수
*/
SELECT MOD(12,5) FROM DUAL;

/*
    ROUND(NUMBER, [위치]) : 반올림한 결과를 반환하는 함수
    
*/
SELECT ROUND(123.456) FROM DUAL; -- 위치 생략시 0
SELECT ROUND(123.456,1) FROM DUAL; -- 123.5
SELECT ROUND(123.456,-2) FROM DUAL; -- 100
/*
    CEIL(NUMBER) : 올림처리해주는 함수
*/
SELECT CEIL(123.152) FROM DUAL; --124

/*
    FLOOR(NUMBER)  : 소수점 아래 버림 처리해주는 함수
*/
SELECT FLOOR(123.952) FROM DUAL;
/*
    TRUNC (NUMBER,[위치]) : 위치 지정 가능한 버림처리해주는 함수
*/
SELECT TRUNC(123.952) FROM DUAL; --123
SELECT TRUNC(123.952,1) FROM DUAL;
SELECT TRUNC(123.952,-1) FROM DUAL;

/*
    날짜 처리 함수
    SYSDATE : 시스템의 날짜를 반환 (현재 날짜)
    
*/
SELECT SYSDATE FROM DUAL;

-- 날짜 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD'; -- 원래 포맷으로 변경

/*
    MONTHS_BETWEEN(DATE,DATE) : 입력받은 두 날짜 사이의 개월 수를 봔한
*/
SELECT MONTHS_BETWEEN(SYSDATE,'20230521') FROM DUAL;

-- 직원명, 입사일, 근무 개월 수 조회
SELECT EMP_NAME, FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE))
FROM EMPLOYEE;

/*

    ADD_MONTHS(DATE, NUMBER)
    
    -특정 날짜에 입력받는 숫자만큼의 개월 수를 더한 날짜를 반환
    
*/
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- 직원명, 입사일, 입사 후 6개월이 된 날짜를 조회

SELECT EMP_NAME, HIRE_DATE,ADD_MONTHS(HIRE_DATE,6)
FROM EMPLOYEE;
/*
    NEXT_DAY(DATE,요일(문자 또는 숫자))     
    - 특정 날짜에서 구하려는 요일의 가장 가까운 날짜를 리턴
    - 요일 : 1- 일요일, 2-월요일,...,7-토요일
*/
SELECT SYSDATE, NEXT_DAY(SYSDATE,'월요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'금') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,4)FROM DUAL;

-- 현재 언어가 한국어이기 때문에 
SELECT SYSDATE, NEXT_DAY(SYSDATE,'THURSDAY') FROM DUAL;

-- 언어 변경
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

/*
    LAST_DAY(DATE)
    - 해당 월의 마지막 날짜를 반환
*/
SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY('20230215') FROM DUAL;
SELECT LAST_DAY('23/11/01') FROM DUAL;


-- 직원명, 입사일, 입사월의 마지막 날짜 조회 , 입사한 월에 근무한 일수 조회?
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE)-HIRE_DATE +1  "근무일"
FROM EMPLOYEE;

/*
    EXTRACT(YEAR|MONTH|DAY FROM DATE)
    - 특정 날짜에서 연도, 월, 일 정보를 추출해서 반환
        YEAR : 연도만 추출
        MONTH : 월만 추출
        DAY : 일만 추출
*/
-- 직원명, 입사년도, 입사월, 입사일 조회
SELECT EMP_NAME,EXTRACT(YEAR FROM HIRE_DATE) ||'년'||EXTRACT(MONTH FROM HIRE_DATE)||'월'||EXTRACT(DAY FROM HIRE_DATE) ||'일' "입사일"
FROM EMPLOYEE
ORDER BY HIRE_DATE;

-- 직원명, 입사년도, 입사월, 입사일 조회 2
SELECT EMP_NAME,EXTRACT(YEAR FROM HIRE_DATE),EXTRACT(MONTH FROM HIRE_DATE),EXTRACT(DAY FROM HIRE_DATE) 
FROM EMPLOYEE
ORDER BY 2,3ASC,4 ASC;

/*
    형 변환 함수
    
    TO_CHAR(날짜|숫자,[포맷])
    - 날짜 또는 숫자형 데이터를 문자 타입으로 변환해서 반환
*/

SELECT TO_CHAR(1234,'L99999') FROM DUAL; -- 현재 설정된 나라의 화폐 단위
SELECT TO_CHAR(1234,'$99999') FROM DUAL;
SELECT TO_CHAR(1234,'L99') FROM DUAL;-- 포맷 자리수가 안맞아서
SELECT TO_CHAR(123451,'L999,999') FROM DUAL;


-- 직원명, 급여, 연봉 조회
SELECT EMP_NAME, SALARY, TO_CHAR(SALARY*12,'L99,999,999') AS "연봉"
FROM EMPLOYEE
ORDER BY "연봉" DESC;

-- 날짜 -> 문자

SELECT TO_CHAR(SYSDATE,'PM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'AM HH24:MI:SS') FROM DUAL;
-- DY, DAY : 요일 / DD : 일
SELECT TO_CHAR(SYSDATE,'MON DD, DAY, YYYY') FROM DUAL;

--년도와 관련된 포맷
SELECT TO_CHAR(SYSDATE, 'YYYY'),
            TO_CHAR(SYSDATE,'YY'),
            TO_CHAR(SYSDATE,'RRRR'),
            TO_CHAR(SYSDATE,'RR'),
            TO_CHAR(SYSDATE,'YEAR')
FROM DUAL;

-- 월과 관련된 포맷
 SELECT
            TO_CHAR(SYSDATE, 'MM'),
            TO_CHAR(SYSDATE,'MON'),
            TO_CHAR(SYSDATE,'MONTH'),
            TO_CHAR(SYSDATE,'RM')
FROM DUAL;

-- 일과 관련된 포맷
SELECT
        TO_CHAR(SYSDATE,'D'),-- 주 기준 
        TO_CHAR(SYSDATE,'DD'),-- 월 기준
        TO_CHAR(SYSDATE,'DDD')-- 년 기준
FROM DUAL;


-- 요일과 관련된 포맷
SELECT
    TO_CHAR(SYSDATE,'DAY'),
    TO_CHAR(SYSDATE,'DY')
    FROM DUAL;
    
    
-- 직원명, 입사일 조회
-- 단 입사일은 포맷을 조회!

SELECT EMP_NAME, TO_CHAR(HIRE_DATE,'YYYY"년" MONTH DD"일" (DY)')
FROM EMPLOYEE
ORDER BY 2;'ㅂㅈ
