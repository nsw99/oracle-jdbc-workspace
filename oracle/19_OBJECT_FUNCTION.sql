 /*
    함수(FUNCTION)
    - 프로시저와 거의 유사한 용도로 사용하지만
    실행 결과를 되돌려 받을 수 있다는 점이 다르다.
    
    [표현식]
    
    CREATE [OR REPLACE] FUNCTION 함수명
    (
        매개변수 1 데이터타입,
        매개변수 2 데이터타입,
        ....
        
    )
    RETURN 데이터 타입
    IS [AS]
        선언부
    BEGIN
        실행부
        RETURN 반환값;
    [EXCEPTION 예외처리부]
    END [함수명];
    
    *실행
    EXECUTE(또는 EXEC) 함수명[(매개값1,...)]
    
    *삭제
    DROP FUNCTION 함수명;
 */
 --사번을 입력받아 해당 사원의 보너스를 포함하는 연봉을 계산하고 리턴하는 함수 생성
 -- 급여 : V_SALARY, 보너스 : V_BONUS
CREATE FUNCTION EM
(
    V_EMP_ID EMPLOYEE.EMP_ID%TYPE
)
RETURN NUMBER
IS V_SALARY EMPLOYEE.SALARY%TYPE;
    V_BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT SALARY,NVL(BONUS,0)
    INTO V_SALARY,V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
    
    RETURN (V_SALARY+V_SALARY*V_BONUS)*12;
    END;
/

DROP FUNCTION EM;
-- 함수 호출
-- 함수를 SELECT 문에서 사용하기
SELECT EM('200') FROM DUAL;
-- 함수 호출 결과를 반환받아 저장할 바인드 변수 선언
VAR VAR_EM NUMBER;
EXECUTE :VAR_EM :=EM(200);
PRINT VAR_EM;
--EMPLOYEE 테이블에서 방금 만든 함수를 이용해서
--보너스를 포함한 연봉이 4000만원 이상인 사원의 
--사번,직원명,급여,보너스,보너스를 포함한 연봉 조회

SELECT EMP_ID,EMP_NAME,SALARY,BONUS,EM(EMP_ID)
FROM EMPLOYEE
WHERE EM(EMP_ID) >= 40000000 AND BONUS IS NOT NULL;













