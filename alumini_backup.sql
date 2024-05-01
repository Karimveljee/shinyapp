--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

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
-- Name: alumni; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alumni (
    constituentid integer NOT NULL,
    name character varying(100),
    graduationyear integer,
    degree character varying(50),
    currentposition character varying(100),
    organization character varying(100),
    industry character varying(100),
    location character varying(100)
);


--
-- Name: alumni_constituentid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.alumni_constituentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: alumni_constituentid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.alumni_constituentid_seq OWNED BY public.alumni.constituentid;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events (
    actionid integer NOT NULL,
    eventname character varying(1000),
    description text,
    location character varying(1000),
    datetime timestamp without time zone,
    register character varying(1000),
    organizedby character varying(1000),
    latedate timestamp without time zone
);


--
-- Name: events_actionid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.events_actionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_actionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.events_actionid_seq OWNED BY public.events.actionid;


--
-- Name: jobpostings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobpostings (
    postingid integer NOT NULL,
    constituentid integer,
    company character varying(1000),
    title character varying(1000),
    description text,
    location character varying(1000),
    posteddate date,
    apply character varying(1000),
    lastdatetoapply date
);


--
-- Name: jobpostings_postingid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jobpostings_postingid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobpostings_postingid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jobpostings_postingid_seq OWNED BY public.jobpostings.postingid;


--
-- Name: mentorship; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mentorship (
    mentorshipid integer NOT NULL,
    mentorid integer,
    menteeid integer,
    startyear integer,
    endyear integer,
    feedback text
);


--
-- Name: mentorship_mentorshipid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mentorship_mentorshipid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mentorship_mentorshipid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mentorship_mentorshipid_seq OWNED BY public.mentorship.mentorshipid;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    username character varying(50) NOT NULL,
    password character varying(50),
    role character varying(10)
);


--
-- Name: alumni constituentid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alumni ALTER COLUMN constituentid SET DEFAULT nextval('public.alumni_constituentid_seq'::regclass);


--
-- Name: events actionid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events ALTER COLUMN actionid SET DEFAULT nextval('public.events_actionid_seq'::regclass);


--
-- Name: jobpostings postingid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobpostings ALTER COLUMN postingid SET DEFAULT nextval('public.jobpostings_postingid_seq'::regclass);


--
-- Name: mentorship mentorshipid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mentorship ALTER COLUMN mentorshipid SET DEFAULT nextval('public.mentorship_mentorshipid_seq'::regclass);


--
-- Data for Name: alumni; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.alumni (constituentid, name, graduationyear, degree, currentposition, organization, industry, location) FROM stdin;
7	ali	2022	Computer Science	Software Engineer	Green3b	Karachi	Karachi
8	123	2022	123	123	123	123	123
9	123	2022	123	123	123	123	123
10	kingpin	2022	kingpin	kingpin	kingpin	kingpin	kingpin
11	Adam	2010	Business	Director	Tesla		Austin
12	Jiang	2022	Business Analytics	Unemployed	NA	NA	NA
13	Munir	2024	ATEC	Consultant	Crow Museum		Dallas
14	Bill Gates	2022	Microsoft	Microsoft	Microsoft	Microsoft	Microsoft
15	Jason	2015	MS Political Science	Consultant	Niata		Washington DC
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.events (actionid, eventname, description, location, datetime, register, organizedby, latedate) FROM stdin;
3	ll	ppJJjj	jj	2024-05-01 16:47:38.209564	\N	\N	\N
4	Public Event	Dinner for public	Georgia	2024-05-07 00:00:00	\N	President	2024-05-30 00:00:00
5	Alumni Gala	Gala	Alumni Center	2024-05-09 00:00:00	\N	Office of Alumni Relations	2024-05-08 00:00:00
6	Man	man	man	2024-05-21 00:00:00	\N	man	2024-05-15 00:00:00
7	NIATA meet n greet	xya	Richardson	2024-05-23 00:00:00	\N	NIATA	2024-05-13 00:00:00
\.


--
-- Data for Name: jobpostings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.jobpostings (postingid, constituentid, company, title, description, location, posteddate, apply, lastdatetoapply) FROM stdin;
2	8	Sindh	Software Engineering	Karachi	Kara	2024-05-01	\N	\N
3	10	123	Software Engineer	Test	123	2024-05-01	\N	\N
4	11	Tesla	Senior Manager	xyz	Remote	2024-05-01	\N	\N
5	13	Crow Museum	Architect	xyz	Dallas	2024-05-01	\N	\N
6	7	lastdate	lastdate	lastdate	lastedate	2024-05-01	\N	2024-05-31
7	12	MunichRe	Data Engineer	absd	Remote	2024-05-01	\N	2024-05-09
8	12	united	annssss	mmmman	richardson	2024-05-01	\N	2024-05-17
\.


--
-- Data for Name: mentorship; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.mentorship (mentorshipid, mentorid, menteeid, startyear, endyear, feedback) FROM stdin;
2	7	8	2022	2023	123
3	13	12	2022	2025	
4	11	10	2022	2023	
5	11	7	2022	2023	I have given good feedback
6	8	10	2022	2023	I have not given bad feedback
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (username, password, role) FROM stdin;
admin	123	admin
king	123	user
kingpin	123	user
Adam	1234	user
Jiang	123	user
Munir	12345	user
BillGates	123	user
Jasontan	1234	user
\.


--
-- Name: alumni_constituentid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.alumni_constituentid_seq', 15, true);


--
-- Name: events_actionid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.events_actionid_seq', 7, true);


--
-- Name: jobpostings_postingid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.jobpostings_postingid_seq', 9, true);


--
-- Name: mentorship_mentorshipid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.mentorship_mentorshipid_seq', 6, true);


--
-- Name: alumni alumni_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alumni
    ADD CONSTRAINT alumni_pkey PRIMARY KEY (constituentid);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (actionid);


--
-- Name: jobpostings jobpostings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobpostings
    ADD CONSTRAINT jobpostings_pkey PRIMARY KEY (postingid);


--
-- Name: mentorship mentorship_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mentorship
    ADD CONSTRAINT mentorship_pkey PRIMARY KEY (mentorshipid);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);


--
-- Name: jobpostings jobpostings_constituentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobpostings
    ADD CONSTRAINT jobpostings_constituentid_fkey FOREIGN KEY (constituentid) REFERENCES public.alumni(constituentid);


--
-- Name: mentorship mentorship_menteeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mentorship
    ADD CONSTRAINT mentorship_menteeid_fkey FOREIGN KEY (menteeid) REFERENCES public.alumni(constituentid);


--
-- Name: mentorship mentorship_mentorid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mentorship
    ADD CONSTRAINT mentorship_mentorid_fkey FOREIGN KEY (mentorid) REFERENCES public.alumni(constituentid);


--
-- PostgreSQL database dump complete
--

