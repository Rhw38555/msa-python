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
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id bigint NOT NULL,
    name character varying NOT NULL,
    access_token character varying NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: COLUMN "user".name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."user".name IS '방송상품명';


--
-- Name: COLUMN "user".access_token; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."user".access_token IS '엑세스 토큰';


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, name, access_token) FROM stdin;
1	이태린	32032dc6-a528-4f2d-b450-0908e07eac5f
2	조지현	50029b66-6c0c-4167-abab-af34841b7462
3	박호인	f4d7fd70-5fbf-4e0d-be6e-eacd378c0314
4	공다예	cb33f1f1-cda5-49d5-a9d4-3d75fb8693bf
5	박가주	70f2548b-a084-46fa-8e1b-d02635966439
6	최두영	d7005cfa-6a8f-482f-bd67-950078b5ab68
7	임태윤	444a7f7d-478d-4507-8877-fb32f3319513
8	전기민	b7eab58f-9fc4-45a7-9b7f-f04b9736b005
9	함국만	651f7676-5e75-4893-a8d8-a8cae1f01d01
10	박규경	ae0d863d-6963-41a2-919e-66e0695be7d7
11	소선규	cd22da52-20fe-45c5-afe2-8c894307658d
12	진두혁	0f5bec1e-cb8d-4cb2-a6ba-9193f4e8c992
13	강희오	7a1f12d8-321b-4793-b8b6-3607bbec0076
14	노인오	baab0769-5e2b-46ff-a546-8f5dd008cc8a
15	이남기	f831ee67-7dc8-47c2-b28b-193c2cae081b
16	김성일	c5b6ed70-6d84-4022-a5c4-f8ed1751d882
17	강남선	9ec49bae-ddf8-4af5-80e7-6de70fda7da3
18	권시진	7d917744-442f-42bf-830e-9b89915a5ff7
19	최정윤	ad583fb4-92b6-4dc5-9e3f-5ffab25bef87
20	한내경	f42a6eb4-2c40-44cc-84f2-e58031fd4e67
21	임다혜	f0f08ffd-ee71-4370-a918-5041b83841eb
22	송희라	07d9a7a4-8a38-4065-901e-0ddf61db44c1
23	정어선	fa61c002-8bbf-4147-96c7-c0a8ecb8205e
24	연채민	d9cc9e78-aa62-413c-af9c-53da34620471
25	채호영	836c1093-59ef-4990-bcdf-3543441dc2f8
26	박영윤	b0fd7480-d7ef-4d16-8a0b-bd5a62f42d7e
27	이동주	c9821920-27a0-49ec-aa14-d83bf88cde79
28	한다숙	ef7a8bc7-345e-4eda-8a1d-c9a5f5eb6fd8
29	최순빈	277d1843-3dd3-4724-84ff-18f4b5241f6d
30	은효민	68faf1f8-c433-4773-87dd-fef81b31af75
31	이규련	33f12803-4056-4e6f-b2c6-a2fb421f3746
32	박조윤	bb2bba4f-0624-4703-b380-3bf229ac1c42
33	윤이경	94cbb5c1-075b-4da6-97d1-567811389a78
34	전정화	6c1ad226-9745-41ad-9b35-7ccba296f476
35	김은혜	c2fa4c66-f9d6-4765-bbf1-cca30e5d3bf3
36	안숙형	678e0c01-dba7-41cc-8a9d-47318d85edba
37	민성진	79750345-2f70-46fd-a291-520d5ddc5271
38	박석찬	decb4069-3ecc-4f1b-a4c4-d9b51b2743b2
39	박병민	754f5d03-31cb-4f0f-a428-ed2b7d9eb04a
40	안인혁	415fae3d-4d76-43a5-97c8-ec3cb5e615c6
41	강대화	7214f9d8-8d14-4b4d-a982-d46aeee24523
42	박서혜	1e3a7a81-e0de-4804-9bf0-0562b0f85b35
43	설라윤	c40fc150-d05b-482d-8514-86493ccf803e
44	상민경	5598cc81-1aa7-4edd-94df-0dda3e8fc506
45	김근정	5aed812d-dd48-401f-916f-b095623ff91b
46	민가연	ac614f45-9cf1-4a97-8274-b0eab11c3fc8
47	김덕윤	cd43d5ae-75fe-4e33-be9d-4979bc877906
48	박혜원	462b3804-7b16-4577-a40c-3c07f166672b
49	정국영	0b3e6ee9-0b06-426f-82d2-dbeb9e5ed22e
50	안시형	508b5b58-b0f2-4d04-b365-68c588dbf51f
\.


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 50, true);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

