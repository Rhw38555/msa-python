--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item (
    id bigint NOT NULL,
    name character varying NOT NULL,
    broadcaster character varying NOT NULL,
    category character varying,
    price integer NOT NULL
);


ALTER TABLE public.item OWNER TO postgres;

--
-- Name: COLUMN item.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.item.name IS '방송상품명';


--
-- Name: COLUMN item.broadcaster; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.item.broadcaster IS '방송사';


--
-- Name: COLUMN item.category; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.item.category IS '방송 상품 카테고리';


--
-- Name: COLUMN item.price; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.item.price IS '상품가격';


--
-- Name: item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_id_seq OWNER TO postgres;

--
-- Name: item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_id_seq OWNED BY public.item.id;


--
-- Name: item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item ALTER COLUMN id SET DEFAULT nextval('public.item_id_seq'::regclass);


--
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item (id, name, broadcaster, category, price) FROM stdin;
1	[17여름신상]데싱디바 매직프레스 프리미엄 라인 시즌3	cjmall	화장품·미용	79900
2	[여름한정]데싱디바 매직프레스 프리미엄 페디큐어 17최신상	cjmall	화장품·미용	69900
3	★ 유발6(일반4,기모2) + 무발2(일반1,기모1) + 수면쉐이퍼1 ★댄스킨 최여진의 모델핏 레그쉐이퍼 한정패키지	gsshop	패션·잡화	69000
4	에코글램 프리미엄 샴푸 시즌2 특별 패키지	hmall	화장품·미용	69900
5	에코글램 프리미엄 샴푸 시즌2 99 특가패키지	hmall	화장품·미용	99000
6	[24통] 팔레오 오메가 사차인치 60g*24통(총 1,440g)	lottemall	식품·건강	118000
7	[48통] 팔레오 오메가 사차인치 60g*48통(총 2,880g)	lottemall	식품·건강	237000
8	18년형 일월 더마루 온열 카페트 점보형	cjmall	가전·디지털	378000
9	18년형 일월 더마루 온열 카페트 대형	cjmall	가전·디지털	278000
10	[Yu&More] 유앤모어 핸드메이드 하프코트	gsshop	패션·잡화	89000
11	팔레오 오메가 사차인치	hmall	식품·건강	218000
12	팔레오 오메가 사차인치	hmall	식품·건강	119000
13	알롱제 바디 브러쉬 세트	hmall	화장품·미용	79000
14	COMPAGNA 꼼빠니아 맥시 에어울 블랜디드 코트	hmall	패션·잡화	89000
15	휴플러스 소프트플란넬 차렵이불 3장 + 베개커버 5장 (Q)	hmall	생활·주방	59900
16	휴플러스 소프트플란넬 차렵이불 3장 + 베개커버 5장 (K)	hmall	생활·주방	69900
17	휴플러스 소프트플란넬 차렵이불 3장 + 베개커버 3장 (SS)	hmall	생활·주방	49900
18	2017FW최신상Baggallini 베가리니 헬싱키백 2종 세트	hmall	패션·잡화	79900
19	여성용 랜드마스터 소가죽 윈터 부츠 1종	hmall	패션·잡화	88000
20	남성용 랜드마스터 소가죽 윈터 부츠 1종	hmall	패션·잡화	88000
21	아니베F 핸드메이드 롱베스트+ 2피스 	lottemall	패션·잡화	98000
22	[지엔느홈] 윈터 벨벳 착번아웃극세사 침구세트 SS	gsshop	생활·주방	69900
23	[지엔느홈] 윈터 벨벳 착번아웃극세사 침구세트 Q	gsshop	생활·주방	79900
24	[지엔느홈] 윈터 벨벳 착번아웃극세사 침구세트 K	gsshop	생활·주방	99900
25	[MAY CHIC] 메이시크 FORK-4 아이브로우 틴트 스페셜 패키지	lottemall	화장품·미용	68900
26	[심야] 밸런스 핏 온열밸런스 운동기	cjmall	여행·레저	336400
27	[태그] 2017 FW 페미닌 스웨트셔츠 4종	cjmall	패션·잡화	78900
28	샤피의 건강생활 정보	gsshop	\N	0
29	라이브센스	gsshop	\N	0
30	[KG당 20~25마리 600세트 한정물량]100% 자연산 프리미엄 대하 1kg	gsshop	식품·건강	68900
31	10~11월 오직 이시기에만제주 햇 레드키위 50입 1박스 3.5kg	gsshop	식품·건강	39900
32	곳간 마떡갈비(80g*30장)＋청양열무물김치(1kg)+생강쌀엿장(280g*1병)+우슬한우곰탕(500g*1팩)	lottemall	식품·건강	68900
33	● 곳간 마떡갈비 80g*30팩 + 생강쌀엿장 280g 1병	lottemall	식품·건강	73900
34	● 곳간 우슬한우곰탕 (500g) X 10팩	lottemall	식품·건강	78900
35	[단품]곳간 우슬한우곰탕 (500g) 1팩	lottemall	식품·건강	15000
36	세실엔느 로맨틱 프리컷 브라팬티	gsshop	패션·잡화	139000
37	더케이 예다함상조 장례 서비스	lottemall	보험	0
38	무명식당 엄마밥상 400g13봉	cjmall	식품·건강	26900
39	아름다운 감귤주스 1박스 총 20병	gsshop	식품·건강	50000
40	아름다운 감귤주스 2박스 총 40병	gsshop	식품·건강	90000
41	[must.be] 17 WINTER 머스트비 울블렌디드 코트	lottemall	패션·잡화	88000
42	라이나생명 플러스 암보험	cjmall	보험	0
43	라이나생명 THE간편한4080건강보험	cjmall	보험	0
44	★HOT★ 보이차다이어트 12주분+ 보이차 추출분말 3박스	gsshop	식품·건강	167000
45	특허받은 만능요리 가마솥 시즌2 	hmall	생활·주방	89100
46	특허받은 만능요리 21cm 가마솥	hmall	생활·주방	69000
47	특허받은 만능요리 16cm 가마솥	hmall	생활·주방	49000
48	[단품]특허받은 만능요리 쿠커(30cm 특대전골팬)	hmall	생활·주방	99000
49	KB손보 전국민안심통합보험	lottemall	보험	0
50	[역대최다-13종]17WINTER 레그미인 더블레이어 레그쉐이퍼	cjmall	패션·잡화	78900
51	[지난방송]2017NEW 레그미인 더블레이어 레그쉐이퍼 5종	cjmall	가전·디지털	79900
52	[동양]암-실속암보험(2배체증형)	gsshop	보험	0
53	J by 실크 블렌디드 롱니트1종	hmall	패션·잡화	69000
54	J by 시그니처 구스롱코트+구스머플러	hmall	패션·잡화	138000
55	J by 로사 울블렌딩코트	hmall	패션·잡화	98000
56	J by 폰테 기모팬츠2종	hmall	패션·잡화	99000
57	J by 사가폭스 이태리 양가죽 구스다운코트	hmall	패션·잡화	698000
58	[PIERRE CARDIN] 피에르가르뎅 트라페즈 트위스트 본딩 팬츠 3종	lottemall	패션·잡화	58000
59	[PIERRE CARDIN] 피에르가르뎅 벨로아 블라우스 3종	lottemall	패션·잡화	48000
60	[A+G]엣지 2017F/W 폭스퍼 야상 콜렉션_뉴칼라 추가	cjmall	패션·잡화	798000
61	[A+G]엣지 WINTER17 라이크라 본딩 기모 데님 3종	cjmall	패션·잡화	98000
62	[A+G]엣지 2017F/W 모더니크 체크코트	cjmall	패션·잡화	139000
63	샬라얀 퓨어 화이트 캐시미어100	cjmall	패션·잡화	78900
64	[A+G]엣지 MADE IN ITALY 울캐시 빅스톨	cjmall	패션·잡화	78000
65	[A+G]엣지 MADE IN ITALY 알파카 니트코트	cjmall	패션·잡화	78000
66	[A+G]엣지 FRANCE 르네 솔리드 울코트	cjmall	패션·잡화	298000
67	[A+G]엣지 MADE IN FRANCE 르네 알파카코트	cjmall	패션·잡화	898000
68	[A+G]엣지 2017F/W 밍크퍼 베스트 콜렉션_뉴 칼라추가	cjmall	패션·잡화	598000
69	[A+G]엣지 MADE IN ITALY 판초 니트 풀오버	cjmall	패션·잡화	68000
70	[A+G]엣지 핀란드 사가폭스 풀스킨 머플러	cjmall	패션·잡화	128000
71	2만원 세일!! 초특가 찬스★17FW 신상★ 꾸즈 아트웍 밀라노 니트 4종	gsshop	패션·잡화	49000
72	핸드메이드 기법, 울함유 소재로 고급스러운 코트!!17FW 무니베이직 내추럴 울코트 1종	gsshop	패션·잡화	78000
73	★17FW 신상!★ 꾸즈 웜기모 컴포트 슬랙스 3종	gsshop	패션·잡화	78000
74	올리비에 캐시미어 혼방 니트3종(여성)	gsshop	패션·잡화	59900
75	보니알렉스 17FW 피코트	gsshop	패션·잡화	138000
76	올리비에 캐시미어 혼방 니트3종(남성)	gsshop	패션·잡화	69900
77	[일동제약 퍼스트랩] 퍼스트랩 프로바이오틱 마스크 25g×72매 + 무료체험분 25g×1매	lottemall	화장품·미용	78000
78	[일동제약 퍼스트랩] 퍼스트랩 프로바이오틱 마스크 25gx62매 + 무료체험분 25gx1매 + 쇼핑백	lottemall	화장품·미용	78000
79	[일동제약 퍼스트랩] 퍼스트랩 프로바이오틱 마스크 25g×62매 + 무료체험분 25g×1매	lottemall	화장품·미용	78000
80	[일동제약 퍼스트랩] 퍼스트랩 프로바이오틱 마스크 25g×60매 + 무료체험분 25g×3매	lottemall	화장품·미용	78000
81	2018년형 최신상 [일월] 프리미엄 3D 온수매트 (퀸+싱글)	hmall	가전·디지털	229000
82	2018년형 최신상 [일월] 프리미엄 3D 온수매트 (퀸)	hmall	가전·디지털	143000
83	2018년형 최신상 [일월] 프리미엄 3D 온수매트 (싱글)	hmall	가전·디지털	109000
84	이사벨라G SAGA 폭스 퓨어캐시미어 숄	lottemall	패션·잡화	158000
85	[Lienge] 리엔제 풀 레이스 하이웨이스트 거들팬티 패키지 	lottemall	패션·잡화	48900
86	□[V&A][K]헝가리구스 듀벳 풀세트+스프레드 세트	lottemall	생활·주방	198000
87	□[V&A][Q]헝가리구스 듀벳 풀세트+스프레드 세트	lottemall	생활·주방	178000
88	□[V&A][S]헝가리구스 듀벳 풀세트+스프레드 세트	lottemall	생활·주방	148000
89	□[V&A][SK]헝가리구스 듀벳 풀세트+스프레드 세트	lottemall	생활·주방	228000
90	미래엔 아이세움 논술 명작 100권	cjmall	유아·아동	320000
91	미래엔 아이세움 명작 논술 100권 + 고전문학 20권	cjmall	유아·아동	349000
92	미래엔 브리태니커 만화백과 50권 + 워크북 50권	cjmall	유아·아동	398000
93	미래엔 통합세트 총 200권 브리태니커 만화백과 50권 + 워크북 50권 + 논술명작 100권	cjmall	유아·아동	699000
94	★유네스코 자연유산★★2017년 마지막방송★시베리아 황금산 차가버섯 2박스(30g*8병)	gsshop	식품·건강	159000
95	더마큐어 보툴이펙트 패키지	hmall	화장품·미용	159000
96	정품7병구성]100%직수입원료 아우라 극강 트리트먼트 구성	cjmall	화장품·미용	78800
97	연속매진]100%일본 직수입원료 아우라 극강 트리트먼트	cjmall	화장품·미용	78800
98	명품헤어관리]100%직수입원료 아우라 극강 트리트먼트 선물기획	cjmall	화장품·미용	78800
99	■ 10인용 ■ 쿠쿠 풀스텐 고화력 압력밥솥 (열판) [CRP-QW105FG/FS]	lottemall	가전·디지털	217000
100	■ 6인용 ■ 쿠쿠 풀스텐 고화력 압력밥솥 (열판) [CRP-P067FR/FD]	lottemall	가전·디지털	197000
\.


--
-- Name: item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_id_seq', 100, true);


--
-- Name: item item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

