-- 회원(MEMBER)
CREATE TABLE MEMBER(
    MEMBER_NO NUMBER PRIMARY KEY, -- 회원번호
    MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL, -- 회원 아이디
    MEMBER_PWD VARCHAR2(20) NOT NULL, -- 회원 비밀번호
    MEMBER_NICK VARCHAR2(20) UNIQUE NOT NULL, -- 회원 닉네임
    MEMBER_NAME VARCHAR2(20) NOT NULL, -- 회원 이름
    MEMBER_BIRTHDAY DATE NOT NULL, -- 회원 생년월일
    MEMBER_GENDER CHAR(1), -- 회원 성별
    MEMBER_PHONE VARCHAR2(15) NOT NULL, -- 회원 전화번호
    MEMBER_SPHONE VARCHAR2(20) NOT NULL, -- 회원 안심번호
    MEMBER_EMAIL VARCHAR2(50), -- 회원 이메일 
    MEMBER_ADDR VARCHAR2(200) NOT NULL, -- 회원 주소
    MEMBER_SIGNUP_DATE DATE DEFAULT SYSDATE, -- 회원 가입일
    MEMBER_AUTHORITY NUMBER DEFAULT 1 -- 회원 권한 
); 

CREATE SEQUENCE SEQ_MEMBER;

COMMENT ON COLUMN MEMBER.MEMBER_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NICK IS '닉네임';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '이름';
COMMENT ON COLUMN MEMBER.MEMBER_BIRTHDAY IS '생년월일';
COMMENT ON COLUMN MEMBER.MEMBER_GENDER IS '성별';
COMMENT ON COLUMN MEMBER.MEMBER_PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.MEMBER_SPHONE IS '안심번호';
COMMENT ON COLUMN MEMBER.MEMBER_EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.MEMBER_ADDR IS '주소';
COMMENT ON COLUMN MEMBER.MEMBER_SIGNUP_DATE IS '가입일';
COMMENT ON COLUMN MEMBER.MEMBER_AUTHORITY IS '권한';


-- AUCTION_BOARD 경매 게시판
CREATE TABLE AUCTION_BOARD(
    AUCTION_NO NUMBER PRIMARY KEY, -- 경매 번호
    AUCTION_TITLE VARCHAR2(20) NOT NULL, -- 경매 제목
    AUCTION_IMG VARCHAR2(500) NOT NULL, -- 경매 이미지
    AUCTION_DATE DATE DEFAULT SYSDATE, -- 경매 등록일
     ITEM_NAME VARCHAR2(100), -- 상품 이름
    ITEM_DESC VARCHAR2(2000), -- 상품 설명
    CURRENT_PRICE NUMBER(100), -- 현재 가격
    AUCTION_EMONEY NUMBER(100) NOT NULL, -- 경매 최소 입찰가
    AUCTION_GMONEY NUMBER(100) NOT NULL, -- 경매 즉시 구매가
    AUCTION_NOWBUY_Y_N CHAR DEFAULT 'N' CHECK(AUCTION_NOWBUY_Y_N IN ('Y', 'N')), -- 경매 즉시 구매 여부
    AUCTION_END_DATE DATE DEFAULT (SYSDATE + 30), -- 경매 마감일
    MEMBER_NO VARCHAR2(20) NOT NULL, -- 회원 번호 (외래키)
    CONSTRAINT FK_MEMBER_AUCTION FOREIGN KEY (MEMBER_NO) REFERENCES MEMBER(MEMBER_NO)
);

   








COMMENT ON COLUMN AUCTION_BOARD.AUCTION_NO IS '경매글 번호';
COMMENT ON COLUMN AUCTION_BOARD.AUCTION_TITLE IS '경매글 제목';
COMMENT ON COLUMN AUCTION_BOARD.AUCTION_IMG IS '상품 이미지';
COMMENT ON COLUMN AUCTION_BOARD.AUCTION_DATE IS '경매 등록일';
COMMENT ON COLUMN AUCTION_BOARD.AUCTION_EMONEY IS '경매 최소입찰가';
COMMENT ON COLUMN AUCTION_BOARD.AUCTION_GMONEY IS '경매 즉시구매가';
COMMENT ON COLUMN AUCTION_BOARD.AUCTION_NOWBUY_Y_N IS '즉시구매 가능여부';
COMMENT ON COLUMN AUCTION_BOARD.AUCTION_END_DATE IS '경매 마감일';
COMMENT ON COLUMN AUCTION_BOARD.MEMBER_ID IS '회원 아이디(외래키)';


-- AUCTION_ITEM_DETAILS 경매등록된물품 상세정보 테이블
CREATE TABLE AUCTION_ITEM_DETAILS(
    ITEM_NO NUMBER PRIMARY KEY, -- 상품 번호
    AUCTION_NO NUMBER REFERENCES AUCTION_BOARD(AUCTION_NO), -- 경매 번호 (외래키)
    ITEM_NAME VARCHAR2(100), -- 상품 이름
    ITEM_DESC VARCHAR2(2000), -- 상품 설명
    STARTING_PRICE NUMBER(100), -- 시작 가격
    CURRENT_PRICE NUMBER(100), -- 현재 가격
    ITEM_IMG VARCHAR2(500), -- 상품 이미지
    CONSTRAINT FK_AUCTION_ITEM_DETAILS FOREIGN KEY (AUCTION_NO) REFERENCES AUCTION_BOARD(AUCTION_NO)
);

COMMENT ON COLUMN AUCTION_ITEM_DETAILS.ITEM_NO IS '상품 번호';
COMMENT ON COLUMN AUCTION_ITEM_DETAILS.AUCTION_NO IS '경매 번호(외래키)';
COMMENT ON COLUMN AUCTION_ITEM_DETAILS.ITEM_NAME IS '상품이름';
COMMENT ON COLUMN AUCTION_ITEM_DETAILS.ITEM_DESC IS '상품설명';
COMMENT ON COLUMN AUCTION_ITEM_DETAILS.STARTING_PRICE IS '시작가격';
COMMENT ON COLUMN AUCTION_ITEM_DETAILS.CURRENT_PRICE IS '현재가격';
COMMENT ON COLUMN AUCTION_ITEM_DETAILS.ITEM_IMG IS '상품이미지';


-- CATEGORY 카테고리
CREATE TABLE CATEGORY(
    CATEGORY_SEQ NUMBER PRIMARY KEY, -- 카테고리 번호
    AUCTION_NO NUMBER, -- 경매 번호(외래키)
    CATEGORY_NAME VARCHAR2(50), -- 카테고리 이름 
    CONSTRAINT FK_AUCTION_CATEGORY FOREIGN KEY (AUCTION_NO) REFERENCES AUCTION_BOARD(AUCTION_NO)
);

COMMENT ON COLUMN CATEGORY.CATEGORY_SEQ IS '카테고리 번호';
COMMENT ON COLUMN CATEGORY.AUCTION_NO IS '경매 번호(외래키)';
COMMENT ON COLUMN CATEGORY.ITEM_TYPE IS '카테고리 이름';


-- SEARCH 검색
CREATE TABLE SEARCH(
    SEARCH_SEQ NUMBER PRIMARY KEY, -- 검색 번호
    CATEGORY_SEQ NUMBER, -- 카테고리 번호(외래키)
    CONSTRAINT FK_SEARCH_CATEGORY FOREIGN KEY (CATEGORY_SEQ) REFERENCES CATEGORY(CATEGORY_SEQ)
);

COMMENT ON COLUMN SEARCH.SEARCH_SEQ IS '검색 번호';
COMMENT ON COLUMN SEARCH.CATEGORY_SEQ IS '카테고리 번호(외래키)';


-- DELIVERY 배송
CREATE TABLE DELIVERY(
    DELIVERY_NO NUMBER PRIMARY KEY, -- 배송 번호
    AUCTION_NO NUMBER, -- 경매 번호 (외래키)
    DELIVERY_COMPANY VARCHAR2(50), -- 배송 업체
    START_DATE DATE, -- 배송 시작일
    COMPLETE_DATE DATE, -- 배송 완료일
    MEMBER_ID VARCHAR2(20), -- 회원 아이디 (외래키)
    CONSTRAINT FK_MEMBER_DELIVERY FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID),
    CONSTRAINT FK_AUCTION_DELIVERY FOREIGN KEY (AUCTION_NO) REFERENCES AUCTION_BOARD(AUCTION_NO)
);

COMMENT ON COLUMN DELIVERY.DELIVERY_NO IS '배송 번호';
COMMENT ON COLUMN DELIVERY.AUCTION_NO IS '경매 번호(외래키)';
COMMENT ON COLUMN DELIVERY.DELIVERY_COMPANY IS '배송 업체';
COMMENT ON COLUMN DELIVERY.START_DATE IS '배송 시작일';
COMMENT ON COLUMN DELIVERY.COMPLETE_DATE IS '배송 완료일';
COMMENT ON COLUMN DELIVERY.MEMBER_ID IS '회원 아이디(외래키)';



-- INTEREST 관심등록 
CREATE TABLE INTEREST(
    INTEREST_NO NUMBER PRIMARY KEY, -- 관심등록 번호
    MEMBER_ID VARCHAR2(20), -- 회원 아이디(외래키)
    AUCTION_NO NUMBER, -- 경매 번호(외래키)
    CONSTRAINT FK_MEMBER_INTEREST FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID),
    CONSTRAINT FK_AUCTION_INTEREST FOREIGN KEY (AUCTION_NO) REFERENCES AUCTION_BOARD(AUCTION_NO)
);

COMMENT ON COLUMN INTEREST.MEMBER_ID IS '회원 아이디(외래키)';
COMMENT ON COLUMN INTEREST.AUCTION_NO IS '경매 번호(외래키)';
COMMENT ON COLUMN INTEREST.POST_NO IS '게시글 번호';



-- COMMENTS 댓글 테이블
CREATE TABLE COMMENTS (
    COMMENT_NO NUMBER PRIMARY KEY, -- 댓글 번호
    AUCTION_NO NUMBER REFERENCES AUCTION_BOARD(AUCTION_NO), -- 경매 번호(외래키)
    MEMBER_ID VARCHAR2(20) REFERENCES MEMBER(MEMBER_ID), -- 회원 아이디(외래키)
    CONTENT VARCHAR2(1000), -- 댓글 내용
    COMMENT_DATE DATE -- 댓글 작성일
);

COMMENT ON COLUMN COMMENTS.COMMENT_ID IS '댓글 번호';
COMMENT ON COLUMN COMMENTS.AUCTION_NO IS '경매 번호(외래키)';
COMMENT ON COLUMN COMMENTS.MEMBER_ID IS '회원 아이디(외래키)';
COMMENT ON COLUMN COMMENTS.CONTENT IS '댓글 내용';
COMMENT ON COLUMN COMMENTS.COMMENT_DATE IS '댓글 작성일';


-- REPLIES 대댓글 테이블
CREATE TABLE io (
    REPLY_ID NUMBER PRIMARY KEY, -- 대댓글 번호
    COMMENT_ID NUMBER REFERENCES COMMENTS(COMMENT_ID), -- 댓글 번호(외래키)
    MEMBER_ID VARCHAR2(20) REFERENCES MEMBER(MEMBER_ID), -- 회원 아이디(외래키)
    CONTENT VARCHAR2(1000), -- 대댓글 내용
    REPLY_DATE DATE  -- 대댓글 작성일
); 

COMMENT ON COLUMN REPLIES.REPLY_ID IS '대댓글 번호';
COMMENT ON COLUMN REPLIES.COMMENT_ID IS '댓글 번호(외래키)';
COMMENT ON COLUMN REPLIES.MEMBER_ID IS '회원 아이디(외래키)';
COMMENT ON COLUMN REPLIES.CONTENT IS '대댓글 내용';
COMMENT ON COLUMN REPLIES.REPLY_DATE IS '대댓글 작성일';