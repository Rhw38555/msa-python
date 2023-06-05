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
-- Name: alarm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alarm (
    id integer NOT NULL,
    item_id integer,
    user_id integer,
    created timestamp without time zone
);


ALTER TABLE public.alarm OWNER TO postgres;

--
-- Name: COLUMN alarm.item_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.alarm.item_id IS '알람설정한 아이템';


--
-- Name: COLUMN alarm.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.alarm.user_id IS '알람설정한 유저';


--
-- Name: alarm_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alarm_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alarm_id_seq OWNER TO postgres;

--
-- Name: alarm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alarm_id_seq OWNED BY public.alarm.id;


--
-- Name: alarm id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alarm ALTER COLUMN id SET DEFAULT nextval('public.alarm_id_seq'::regclass);


--
-- Data for Name: alarm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alarm (id, item_id, user_id, created) FROM stdin;
\.


--
-- Name: alarm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alarm_id_seq', 1, false);


--
-- Name: alarm alarm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alarm
    ADD CONSTRAINT alarm_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

