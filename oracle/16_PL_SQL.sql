 /*
    PL/SQL (PROCEDURE LANGUAGE EXTESION TO SQL)
    - 오라클에서 제공하는 절차적인 프로그래밍 언어
    - SQL 문장 내에서 변수의 정의, 조건처리(IF), 반복처리(LOOP,FOR,WHILE)
    등을 지원하여 SQL의 단점을 보안
    - 다수의 SQL문을 한번에 실행 가능 (BLOCK 구조)
    
    * 블록(Block) : 명령어를 모아 둔 PL/SQL 프로그램의 기본 단위
    
    * PL/SQL 구조
    - [선언부(DECLARE SECTION)] : DECLARE 로 시작. 변수나 상수를 선언
    및 초기화하는 부분
    
    - 실행부 (EXECUTABLE SECTION) : BEGIN으로 시작, SQL문 또는 제어문
    (조건문, 반복문)등의 로직을 기술하는 부분
    
    - [예외처리부(EXCEPTION SECTION)] : EXCEPTION으로 시작. 
    예외 발생 시 해결하기 위한 구문을 미리 기술 해둘 수 있는 부분
    
 */

 -- 출력 기능 활성화
 
 SET SERVEROUTPUT ON;
 
 -- HELLO ORACLE 출력
 BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
    END;
    /
/*
    1. DECLARE 선언부
    - 변수 및 상수를 선언하는 공간 (선언과 동시에 초기화도 가능)
    - 일반 타입 변수, 레퍼런스 타입 변수, ROW 타입 변수
*/
/*
    1-1) 일반 타입 변수 선언 및 초기화
            [표현식]
            변수명 [CONSTANT] 자료형 [:=값];
*/
DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    EID := &번호;
    ENAME := '&이름';
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
     /
/*
    1-2) 레퍼런스 타입 변수 선언 및 초기화
        (어떤 테이블의 어떤 컬럼의 데이터타입을 참조해서 그 타입으로 지정)
        
        [표현식]
        변수명 테이블명.컬럼명%TYPE;
*/
-- 박나라 사원의 사번,직원명,급여 정보를 조회해서 출력
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN 
    SELECT EMP_ID,EMP_NAME,SALARY
    INTO EID,ENAME,SAL
    FROM EMPLOYEE
    WHERE EMP_NAME = '&이름';
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
    END;
    /

-- 문제로 풀어보기!
-- 레퍼런스 타입으 ㅣ변수로 EID,ENAME,JCODE,DTITLE,SAL를 선언하고
-- 각 변수의 자료형은 EMPLOYEE 테이블의 EMP_ID,EMP_NAME,JOB_CODE
-- SALARY 컬럼과 DEPARTMENT 테이블의 DEPT_TITLE 컬럼의 자료형을 참조
-- 사용자가 입력한 사번과 일치하는 사원을 조회한 후 조회 결과를 출력

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
SELECT EMP_ID,EMP_NAME,JOB_CODE,DEPT_TITLE,SALARY
INTO EID,ENAME,JCODE,DTITLE,SAL
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
WHERE EMP_ID = '&사번';
DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
DBMS_OUTPUT.PUT_LINE('JCODE : ' || JCODE);
DBMS_OUTPUT.PUT_LINE('DTITLE : ' || DTITLE);
DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/

-- 3) ROW 타입 변수 선언 및 초기화
DECLARE 
EMP EMPLOYEE%ROWTYPE;
BEGIN
SELECT * INTO EMP FROM EMPLOYEE
WHERE EMP_NAME = '&직원명';
DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP.EMP_ID);
DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP.EMP_NAME);
DBMS_OUTPUT.PUT_LINE('입사일 : ' || TO_CHAR(EMP.HIRE_DATE,'YYYY"년" MM "월" DD"일"'));
END;
/


/*
    2. 실행부
        제어문, 반복문, 쿼리문 등의 로직을 기술하는 영역
    
    1) 선택문
    1-1) IF 구문
    
        [표현식]
        IF 조건식 THEN 실행내용 END IF;
      
    
*/


-- 사번을 입력받은 후 해당 사원의 사번, 이름, 급여, 보너스를 출력
-- 단, 보너스를 받지 않는 사원은 보너스 출력 전에 
-- '보너스를 지급받지 않는 사원입니다' 라는 문구를 출력
DECLARE 
EID EMPLOYEE.EMP_ID%TYPE;
ENAME EMPLOYEE.EMP_NAME%TYPE;
SAL EMPLOYEE.SALARY%TYPE;
BONUS EMPLOYEE.BONUS%TYPE;

BEGIN
SELECT EMP_ID,EMP_NAME,SALARY,NVL(BONUS,0)
INTO EID,ENAME,SAL,BONUS
FROM EMPLOYEE
WHERE EMP_ID ='&사번';


DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
DBMS_OUTPUT.PUT_LINE('급여 : '|| SAL);


IF(BONUS =0 ) THEN 
DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
END IF;
DBMS_OUTPUT.PUT_LINE('보너스 : '|| BONUS);
END;
/


/*
    1-2) IF ~ ELSE 구문
        [표현식]
        IF 조건식 THEN 실행내용
        ELSE 실행내용
        END IF;
*/
SET SERVEROUTPUT ON;
DECLARE 
EID EMPLOYEE.EMP_ID%TYPE;
ENAME EMPLOYEE.EMP_NAME%TYPE;
SAL EMPLOYEE.SALARY%TYPE;
BONUS EMPLOYEE.BONUS%TYPE;

BEGIN
SELECT EMP_ID,EMP_NAME,SALARY,NVL(BONUS,0)
INTO EID,ENAME,SAL,BONUS
FROM EMPLOYEE
WHERE EMP_ID ='&사번';


DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
DBMS_OUTPUT.PUT_LINE('급여 : '|| SAL);


IF(BONUS =0 ) THEN 
DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
ELSE 
DBMS_OUTPUT.PUT_LINE('보너스 : '|| BONUS);
END IF;
END;
/

-- 사용자가 입력핝 사원의 사번(EID), 이름(ENAME), 부서명(DTITLE)M
-- 근무국가코드(NCODE)조회 후 각 변수에 대입
-- 일반타입변수 TEAM을 데이터 타입 VARCHAR2(10)으로 선언하고
-- NCODE 값이 KO 일경우 -> TEAM에 '국내팀' 대입
-- 그게 아닐 경우 -> TEAM에 '해외팀'대입
-- 사번, 이름, 부서 , 소속에 대해 출력
DECLARE
TEAM VARHCHAR2(10);
EID EMPLOYEE.EMP_ID%TYPE;
ENAME EMPLOYEE.EMP_NAME%TYPE;
DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
NCODE LOCATION.NATIONAL_CODE%TYPE;

BEGIN
SELECT EMP_ID, EMP_NAME, DEPT_TITLE,NATIONAL_CODE
INTO EID,ENAME,DTITLE,NCODE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE)
JOIN LOCATION ON (LOCAL_CODE = LOCATION_ID)
WHERE EMP_ID = '&사번';

DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
DBMS_OUTPUT.PUT_LINE('부서명 : ' || DTITLE);
DBMS_OUTPUT.PUT_LINE('근무 국가 코드 : ' || NCODE);
IF (NCODE IN 'KO')  THEN DBMS_OUTPUT.PUT_LINE('국내팀' || TEAM );
END IF DBMS_OUTPUT.PUT_LINE('해외팀' || TEAM ); 
END
/



