--
-- PostgreSQL database dump
--

-- Dumped from database version 15.0
-- Dumped by pg_dump version 15.0

-- Started on 2023-03-12 16:12:15

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

--
-- TOC entry 3404 (class 1262 OID 19831)
-- Name: animals_chipization; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE animals_chipization WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE animals_chipization OWNER TO postgres;

\connect animals_chipization

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

--
-- TOC entry 229 (class 1259 OID 20950)
-- Name: a_at_identity_id_a_at_identity_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.a_at_identity_id_a_at_identity_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.a_at_identity_id_a_at_identity_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 228 (class 1259 OID 19952)
-- Name: a_at_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.a_at_identity (
    id_animal integer NOT NULL,
    id_animal_type integer NOT NULL,
    id_a_at_identity integer DEFAULT nextval('public.a_at_identity_id_a_at_identity_seq'::regclass) NOT NULL
);


ALTER TABLE public.a_at_identity OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 19887)
-- Name: animal_genders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.animal_genders (
    id_animal_gender integer NOT NULL,
    gender character varying(255) NOT NULL
);


ALTER TABLE public.animal_genders OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 19886)
-- Name: animal_genders_id_animal_gender_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.animal_genders_id_animal_gender_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.animal_genders_id_animal_gender_seq OWNER TO postgres;

--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 218
-- Name: animal_genders_id_animal_gender_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.animal_genders_id_animal_gender_seq OWNED BY public.animal_genders.id_animal_gender;


--
-- TOC entry 217 (class 1259 OID 19880)
-- Name: animal_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.animal_types (
    id_animal_type integer NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE public.animal_types OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 19879)
-- Name: animal_types_id_animal_type_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.animal_types_id_animal_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.animal_types_id_animal_type_seq OWNER TO postgres;

--
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 216
-- Name: animal_types_id_animal_type_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.animal_types_id_animal_type_seq OWNED BY public.animal_types.id_animal_type;


--
-- TOC entry 225 (class 1259 OID 19908)
-- Name: animals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.animals (
    id_animal integer NOT NULL,
    weight real NOT NULL,
    length real NOT NULL,
    height real NOT NULL,
    id_animal_gender integer NOT NULL,
    id_animal_life_status integer NOT NULL,
    chipping_date_time timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id_chipper integer NOT NULL,
    id_chipping_location integer NOT NULL,
    death_date_time timestamp with time zone
);


ALTER TABLE public.animals OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 19907)
-- Name: animals_id_animal_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.animals_id_animal_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.animals_id_animal_seq OWNER TO postgres;

--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 224
-- Name: animals_id_animal_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.animals_id_animal_seq OWNED BY public.animals.id_animal;


--
-- TOC entry 221 (class 1259 OID 19894)
-- Name: animals_life_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.animals_life_status (
    id_animal_life_status integer NOT NULL,
    life_status character varying(255) NOT NULL
);


ALTER TABLE public.animals_life_status OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 19893)
-- Name: animals_life_status_id_animal_life_status_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.animals_life_status_id_animal_life_status_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.animals_life_status_id_animal_life_status_seq OWNER TO postgres;

--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 220
-- Name: animals_life_status_id_animal_life_status_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.animals_life_status_id_animal_life_status_seq OWNED BY public.animals_life_status.id_animal_life_status;


--
-- TOC entry 223 (class 1259 OID 19901)
-- Name: chipping_locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chipping_locations (
    id_chipping_location integer NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL
);


ALTER TABLE public.chipping_locations OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 19900)
-- Name: chipping_locations_id_chipping_location_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chipping_locations_id_chipping_location_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chipping_locations_id_chipping_location_seq OWNER TO postgres;

--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 222
-- Name: chipping_locations_id_chipping_location_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chipping_locations_id_chipping_location_seq OWNED BY public.chipping_locations.id_chipping_location;


--
-- TOC entry 215 (class 1259 OID 19871)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id_user integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 19870)
-- Name: users_id_user_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_user_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_user_seq OWNER TO postgres;

--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 214
-- Name: users_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_user_seq OWNED BY public.users.id_user;


--
-- TOC entry 227 (class 1259 OID 19936)
-- Name: visited_locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visited_locations (
    id_visited_location integer NOT NULL,
    date_time_of_visit_location_point timestamp with time zone NOT NULL,
    id_chipping_location integer NOT NULL,
    id_animal integer NOT NULL
);


ALTER TABLE public.visited_locations OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 19935)
-- Name: visited_locations_id_visited_location_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.visited_locations_id_visited_location_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.visited_locations_id_visited_location_seq OWNER TO postgres;

--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 226
-- Name: visited_locations_id_visited_location_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.visited_locations_id_visited_location_seq OWNED BY public.visited_locations.id_visited_location;


--
-- TOC entry 3210 (class 2604 OID 19890)
-- Name: animal_genders id_animal_gender; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animal_genders ALTER COLUMN id_animal_gender SET DEFAULT nextval('public.animal_genders_id_animal_gender_seq'::regclass);


--
-- TOC entry 3209 (class 2604 OID 19883)
-- Name: animal_types id_animal_type; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animal_types ALTER COLUMN id_animal_type SET DEFAULT nextval('public.animal_types_id_animal_type_seq'::regclass);


--
-- TOC entry 3213 (class 2604 OID 19911)
-- Name: animals id_animal; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animals ALTER COLUMN id_animal SET DEFAULT nextval('public.animals_id_animal_seq'::regclass);


--
-- TOC entry 3211 (class 2604 OID 19897)
-- Name: animals_life_status id_animal_life_status; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animals_life_status ALTER COLUMN id_animal_life_status SET DEFAULT nextval('public.animals_life_status_id_animal_life_status_seq'::regclass);


--
-- TOC entry 3212 (class 2604 OID 19904)
-- Name: chipping_locations id_chipping_location; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chipping_locations ALTER COLUMN id_chipping_location SET DEFAULT nextval('public.chipping_locations_id_chipping_location_seq'::regclass);


--
-- TOC entry 3208 (class 2604 OID 19874)
-- Name: users id_user; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id_user SET DEFAULT nextval('public.users_id_user_seq'::regclass);


--
-- TOC entry 3215 (class 2604 OID 19939)
-- Name: visited_locations id_visited_location; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visited_locations ALTER COLUMN id_visited_location SET DEFAULT nextval('public.visited_locations_id_visited_location_seq'::regclass);


--
-- TOC entry 3397 (class 0 OID 19952)
-- Dependencies: 228
-- Data for Name: a_at_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.a_at_identity (id_animal, id_animal_type, id_a_at_identity) VALUES (1, 7, 1);
INSERT INTO public.a_at_identity (id_animal, id_animal_type, id_a_at_identity) VALUES (2, 9, 2);
INSERT INTO public.a_at_identity (id_animal, id_animal_type, id_a_at_identity) VALUES (3, 10, 3);
INSERT INTO public.a_at_identity (id_animal, id_animal_type, id_a_at_identity) VALUES (4, 12, 4);
INSERT INTO public.a_at_identity (id_animal, id_animal_type, id_a_at_identity) VALUES (5, 11, 5);


--
-- TOC entry 3388 (class 0 OID 19887)
-- Dependencies: 219
-- Data for Name: animal_genders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.animal_genders (id_animal_gender, gender) VALUES (1, 'MALE');
INSERT INTO public.animal_genders (id_animal_gender, gender) VALUES (2, 'FEMALE');
INSERT INTO public.animal_genders (id_animal_gender, gender) VALUES (3, 'OTHER');


--
-- TOC entry 3386 (class 0 OID 19880)
-- Dependencies: 217
-- Data for Name: animal_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.animal_types (id_animal_type, type) VALUES (1, 'amphibian');
INSERT INTO public.animal_types (id_animal_type, type) VALUES (2, 'reptile');
INSERT INTO public.animal_types (id_animal_type, type) VALUES (3, 'half-mammal');
INSERT INTO public.animal_types (id_animal_type, type) VALUES (5, 'half-reptile');
INSERT INTO public.animal_types (id_animal_type, type) VALUES (6, 'half-amphibian');
INSERT INTO public.animal_types (id_animal_type, type) VALUES (7, '0bbcd398-1c42-4663-afad-82a2069c828c');
INSERT INTO public.animal_types (id_animal_type, type) VALUES (8, '61b66bf2-8744-4c62-b7ab-279b76772aac');
INSERT INTO public.animal_types (id_animal_type, type) VALUES (9, '3d1c5778-a2d2-4a44-b4c2-bd861be3cb73');
INSERT INTO public.animal_types (id_animal_type, type) VALUES (10, 'f8acfdeb-8ff3-4c9d-bc00-8309285c9d1b');
INSERT INTO public.animal_types (id_animal_type, type) VALUES (11, 'd3aa7c97-2a5f-4272-8249-d88a3bc588af');
INSERT INTO public.animal_types (id_animal_type, type) VALUES (12, '3550ba3f-d00b-44ec-b7d9-36af8a23a080');


--
-- TOC entry 3394 (class 0 OID 19908)
-- Dependencies: 225
-- Data for Name: animals; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.animals (id_animal, weight, length, height, id_animal_gender, id_animal_life_status, chipping_date_time, id_chipper, id_chipping_location, death_date_time) VALUES (1, 4154.8022, 5.919786, 2.4066324, 2, 2, '2023-03-09 22:19:15.075894+07', 3, 1, NULL);
INSERT INTO public.animals (id_animal, weight, length, height, id_animal_gender, id_animal_life_status, chipping_date_time, id_chipper, id_chipping_location, death_date_time) VALUES (2, 5728.416, 4.0901475, 2.7181778, 1, 2, '2023-03-09 22:33:21.137829+07', 4, 3, NULL);
INSERT INTO public.animals (id_animal, weight, length, height, id_animal_gender, id_animal_life_status, chipping_date_time, id_chipper, id_chipping_location, death_date_time) VALUES (3, 712.97266, 15.527499, 2.7799182, 3, 2, '2023-03-09 22:36:35.305554+07', 5, 5, NULL);
INSERT INTO public.animals (id_animal, weight, length, height, id_animal_gender, id_animal_life_status, chipping_date_time, id_chipper, id_chipping_location, death_date_time) VALUES (4, 3143.3545, 10.315561, 3.237343, 1, 2, '2023-03-09 22:40:10.28191+07', 6, 7, NULL);
INSERT INTO public.animals (id_animal, weight, length, height, id_animal_gender, id_animal_life_status, chipping_date_time, id_chipper, id_chipping_location, death_date_time) VALUES (5, 3143.3545, 10.315561, 3.237343, 1, 2, '2023-03-12 15:55:03.905073+07', 3, 7, NULL);


--
-- TOC entry 3390 (class 0 OID 19894)
-- Dependencies: 221
-- Data for Name: animals_life_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.animals_life_status (id_animal_life_status, life_status) VALUES (1, 'DEAD');
INSERT INTO public.animals_life_status (id_animal_life_status, life_status) VALUES (2, 'ALIVE');


--
-- TOC entry 3392 (class 0 OID 19901)
-- Dependencies: 223
-- Data for Name: chipping_locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.chipping_locations (id_chipping_location, latitude, longitude) VALUES (1, -48.068267822012466, -117.18512099464294);
INSERT INTO public.chipping_locations (id_chipping_location, latitude, longitude) VALUES (2, 86.25311468693093, 54.945580113763754);
INSERT INTO public.chipping_locations (id_chipping_location, latitude, longitude) VALUES (3, -8.0233276633125, 74.67387261759586);
INSERT INTO public.chipping_locations (id_chipping_location, latitude, longitude) VALUES (4, 19.81221557507523, 89.51214719555412);
INSERT INTO public.chipping_locations (id_chipping_location, latitude, longitude) VALUES (5, -74.56934503483967, 122.71483226717527);
INSERT INTO public.chipping_locations (id_chipping_location, latitude, longitude) VALUES (6, 79.25307656368096, 133.29366703307443);
INSERT INTO public.chipping_locations (id_chipping_location, latitude, longitude) VALUES (7, 53.20756427802232, 174.89325833462914);
INSERT INTO public.chipping_locations (id_chipping_location, latitude, longitude) VALUES (9, 20.190807936074776, -94.20897344509189);
INSERT INTO public.chipping_locations (id_chipping_location, latitude, longitude) VALUES (10, -35.24162021730281, 46.6398843798882);
INSERT INTO public.chipping_locations (id_chipping_location, latitude, longitude) VALUES (11, 34.186297364148004, -102.6616004769531);
INSERT INTO public.chipping_locations (id_chipping_location, latitude, longitude) VALUES (12, 25.820302796182077, -174.51235207444526);


--
-- TOC entry 3384 (class 0 OID 19871)
-- Dependencies: 215
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id_user, first_name, last_name, email, password) VALUES (1, 'Golda', 'Yundt', 'admin@mail.ru', '$2a$12$nnhmlHIKjsW88EFp5Nz8cuIcYyaBdzS20WhxAXZ19okYYz0vUHDYi');
INSERT INTO public.users (id_user, first_name, last_name, email, password) VALUES (2, 'Bernie', 'Stark', 'rene.barrows@yahoo.com', '$2a$12$3q0B6sRExXDR7E9LCgIq.u9Nd5ptWDnKFKXlODHvxys7fRvM41D16');
INSERT INTO public.users (id_user, first_name, last_name, email, password) VALUES (3, 'Lida', 'Bashirian', 'robert.macgyver@hotmail.com', '$2a$12$YOO6HI8bYiKu15Zd1tuhQO1wEeHKRdXTGaTNbmTDbsGPKgW5/JiZW');
INSERT INTO public.users (id_user, first_name, last_name, email, password) VALUES (4, 'Johnnie', 'Runte', 'bao.waters@hotmail.com', '$2a$12$tUIqLS6AuFnFyXy7a5bgG.DbSA1BSsw983QsToUgm/R34xfK5ptyq');
INSERT INTO public.users (id_user, first_name, last_name, email, password) VALUES (5, 'Cecile', 'Walter', 'sana.kirlin@hotmail.com', '$2a$12$c3fkC2rkaB.2B7Ss1SSGbuVLCRoJCdDIWc9TPTWXqalGlIoHdEmyi');
INSERT INTO public.users (id_user, first_name, last_name, email, password) VALUES (6, 'Maybelle', 'Heaney', 'scarlet.gulgowski@gmail.com', '$2a$12$gczCGSLFXtPQu9KSbtx2P..YyFm3EHWS3a7MCtvMOlwUA3qGPvu/2');


--
-- TOC entry 3396 (class 0 OID 19936)
-- Dependencies: 227
-- Data for Name: visited_locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.visited_locations (id_visited_location, date_time_of_visit_location_point, id_chipping_location, id_animal) VALUES (4, '2023-03-09 22:44:22.495241+07', 11, 4);
INSERT INTO public.visited_locations (id_visited_location, date_time_of_visit_location_point, id_chipping_location, id_animal) VALUES (5, '2023-03-09 22:44:57.133493+07', 12, 4);
INSERT INTO public.visited_locations (id_visited_location, date_time_of_visit_location_point, id_chipping_location, id_animal) VALUES (6, '2023-03-12 12:47:56.984208+07', 9, 1);


--
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 229
-- Name: a_at_identity_id_a_at_identity_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.a_at_identity_id_a_at_identity_seq', 5, true);


--
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 218
-- Name: animal_genders_id_animal_gender_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.animal_genders_id_animal_gender_seq', 3, true);


--
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 216
-- Name: animal_types_id_animal_type_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.animal_types_id_animal_type_seq', 12, true);


--
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 224
-- Name: animals_id_animal_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.animals_id_animal_seq', 5, true);


--
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 220
-- Name: animals_life_status_id_animal_life_status_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.animals_life_status_id_animal_life_status_seq', 2, true);


--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 222
-- Name: chipping_locations_id_chipping_location_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chipping_locations_id_chipping_location_seq', 12, true);


--
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 214
-- Name: users_id_user_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_user_seq', 6, true);


--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 226
-- Name: visited_locations_id_visited_location_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.visited_locations_id_visited_location_seq', 6, true);


--
-- TOC entry 3232 (class 2606 OID 20949)
-- Name: a_at_identity a_at_identity_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.a_at_identity
    ADD CONSTRAINT a_at_identity_pk PRIMARY KEY (id_a_at_identity);


--
-- TOC entry 3222 (class 2606 OID 19892)
-- Name: animal_genders animal_genders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animal_genders
    ADD CONSTRAINT animal_genders_pkey PRIMARY KEY (id_animal_gender);


--
-- TOC entry 3220 (class 2606 OID 19885)
-- Name: animal_types animal_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animal_types
    ADD CONSTRAINT animal_types_pkey PRIMARY KEY (id_animal_type);


--
-- TOC entry 3224 (class 2606 OID 19899)
-- Name: animals_life_status animals_life_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animals_life_status
    ADD CONSTRAINT animals_life_status_pkey PRIMARY KEY (id_animal_life_status);


--
-- TOC entry 3228 (class 2606 OID 19914)
-- Name: animals animals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animals
    ADD CONSTRAINT animals_pkey PRIMARY KEY (id_animal);


--
-- TOC entry 3226 (class 2606 OID 19906)
-- Name: chipping_locations chipping_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chipping_locations
    ADD CONSTRAINT chipping_locations_pkey PRIMARY KEY (id_chipping_location);


--
-- TOC entry 3218 (class 2606 OID 19878)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id_user);


--
-- TOC entry 3230 (class 2606 OID 19941)
-- Name: visited_locations visited_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visited_locations
    ADD CONSTRAINT visited_locations_pkey PRIMARY KEY (id_visited_location);


--
-- TOC entry 3239 (class 2606 OID 19955)
-- Name: a_at_identity a_at_identity_id_animal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.a_at_identity
    ADD CONSTRAINT a_at_identity_id_animal_fkey FOREIGN KEY (id_animal) REFERENCES public.animals(id_animal) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3240 (class 2606 OID 19960)
-- Name: a_at_identity a_at_identity_id_animal_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.a_at_identity
    ADD CONSTRAINT a_at_identity_id_animal_type_fkey FOREIGN KEY (id_animal_type) REFERENCES public.animal_types(id_animal_type) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3233 (class 2606 OID 19930)
-- Name: animals animals_id_animal_gender_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animals
    ADD CONSTRAINT animals_id_animal_gender_fkey FOREIGN KEY (id_animal_gender) REFERENCES public.animal_genders(id_animal_gender) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3234 (class 2606 OID 19925)
-- Name: animals animals_id_animal_life_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animals
    ADD CONSTRAINT animals_id_animal_life_status_fkey FOREIGN KEY (id_animal_life_status) REFERENCES public.animals_life_status(id_animal_life_status) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3235 (class 2606 OID 19920)
-- Name: animals animals_id_chipper_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animals
    ADD CONSTRAINT animals_id_chipper_fkey FOREIGN KEY (id_chipper) REFERENCES public.users(id_user) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3236 (class 2606 OID 19915)
-- Name: animals animals_id_chipping_location_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animals
    ADD CONSTRAINT animals_id_chipping_location_fkey FOREIGN KEY (id_chipping_location) REFERENCES public.chipping_locations(id_chipping_location) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3237 (class 2606 OID 19942)
-- Name: visited_locations visited_locations_id_animal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visited_locations
    ADD CONSTRAINT visited_locations_id_animal_fkey FOREIGN KEY (id_animal) REFERENCES public.animals(id_animal) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3238 (class 2606 OID 19947)
-- Name: visited_locations visited_locations_id_chipping_location_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visited_locations
    ADD CONSTRAINT visited_locations_id_chipping_location_fkey FOREIGN KEY (id_chipping_location) REFERENCES public.chipping_locations(id_chipping_location) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2023-03-12 16:12:15

--
-- PostgreSQL database dump complete
--

